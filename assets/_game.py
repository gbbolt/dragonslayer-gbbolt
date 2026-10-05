"""Shared helpers for Dragon Slayer's asset plugins: run the whole game from Boot, frame by frame.

The game never halts: its main loop polls flags that the VBlank interrupt sets. The machine here
runs a fixed number of instructions per frame (about what fits in the 70224 cycles of a frame),
lets rLY count along with them, and runs the VBlank interrupt at the end of each frame when the
game has interrupts enabled - and the LCD interrupt where rLYC matches, if the game uses it.
"""
from gamerun import GameRunner

FRAME_HZ = 4194304 / 70224
STEPS = 17000                                              # instructions per frame (~4 cycles each)
VBLANK, LCDSTAT, TIMER, SERIAL = 0x0040, 0x0048, 0x0050, 0x0058
SHADOW_OAM = 0xD000                                        # what the OAM DMA copies


class Machine:
    def __init__(self, ctx):
        self.ctx = ctx
        self.run = GameRunner(ctx.project, stack=0xDFFF)
        self.mem, self.cpu = self.run.mem, self.run.cpu
        self.cpu.pc, self.cpu.sp = ctx.syms['Boot'], 0xFFFE
        self.buttons = 0                                   # A $01 B $02 Select $04 Start $08, d-pad high nibble
        self.step_no = 0
        self.frames = 0
        plain = self.cpu.rd

        def rd(a):
            a &= 0xFFFF
            if a == 0xFF44:
                return self.ly()
            if a == 0xFF41:
                ly = self.ly()
                mode = 1 if ly >= 144 else (0 if self.step_no % 110 > 60 else 3)
                return 0x80 | (self.mem[0xFF41] & 0x78) | (0x04 if ly == self.mem[0xFF45] else 0) | mode
            if a == 0xFF00:
                sel = self.mem[0xFF00]
                v = 0x0F
                if not sel & 0x10:
                    v &= ~(self.buttons >> 4)
                if not sel & 0x20:
                    v &= ~self.buttons
                return 0xC0 | (sel & 0x30) | (v & 0x0F)
            return plain(a)
        self.cpu.rd = rd

    def ly(self):
        return self.step_no * 154 // STEPS % 154

    def get(self, name):
        return self.run.get(name)

    def set(self, name, value):
        self.run.set(name, value)

    def frame(self):
        """One frame: the game's code for a frame's worth of instructions, then VBlank."""
        cpu, mem = self.cpu, self.mem
        last_ly = -1
        for self.step_no in range(STEPS):
            ly = self.ly()
            if ly != last_ly:
                last_ly = ly
                if ly == 144 and cpu.ime and mem[0xFFFF] & 0x01:
                    self.interrupt(VBLANK)
                elif ly < 144 and ly == mem[0xFF45] and mem[0xFF41] & 0x40 and cpu.ime and mem[0xFFFF] & 0x02:
                    self.interrupt(LCDSTAT)
            if mem[cpu.pc] == 0x76:                        # halt: wait for the next interrupt
                continue
            cpu.step()
        self.frames += 1

    def interrupt(self, vec):
        cpu = self.cpu
        pc, sp = cpu.pc, cpu.sp
        if self.mem[pc] == 0x76:
            pc += 1
        cpu.ime = False
        cpu.call(vec, max_steps=500000)
        cpu.pc, cpu.sp = pc, sp
        cpu.ime = True

    def play(self, schedule, frames):
        """Run frames with button presses: schedule = [(first frame, buttons, frames held)]."""
        for f in range(frames):
            self.buttons = 0
            for a, b, h in schedule:
                if a <= f < a + h:
                    self.buttons = b
            self.frame()

    def screen(self):
        return self.run.screen(oam=SHADOW_OAM)
