; Disassembly of "dragonslayer.gb"
; This file was created with:
; mgbdis v3.0 - Game Boy ROM disassembler by Matt Currie and contributors.
; https://github.com/mattcurrie/mgbdis

SECTION "ROM Bank $000", ROM0[$0]

;@ def RST_00()
;@ path: system/vectors
;@ Restart vector $00 (never used): restarts the game from Init.
;@ test: skip never returns
;@ sig: 7982a5af
RST_00::
;> return Init()
	jp Init


	db $00, $00, $00, $00, $00

;@ def RST_08()
;@ path: system/vectors
;@ Restart vector $08 (never used): restarts the game from Init.
;@ test: skip never returns
;@ sig: 056f8df8
RST_08::
;> return Init()
	jp Init


	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

;@ path: system/vectors
;@ Restart vectors $28 and $30: not used, the bytes are just $FF filler.
RST_28::
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

;@ def RST_38()
;@ path: system/vectors
;@ Restart vector $38 (never used). Its $FF filler is `rst $38` itself, so a stray jump here would hang the game.
;@ test: skip never returns
;@ sig: 2144df1c
RST_38::
;> for _ in forever(): pass               # rst $38 calls itself over and over
	rst $38

; more $FF filler up to $0040
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff

;@ def VBlankInterrupt()
;@ path: system/vectors
;@ VBlank interrupt vector.
;@ test: skip interrupt vector
;@ sig: a4e98652
VBlankInterrupt::
;> return VBlankHandler()
	jp VBlankHandler


	db $ff, $ff, $ff, $ff, $ff

;@ def LCDCInterrupt()
;@ path: system/vectors
;@ LCD STAT interrupt vector (used for the LY=LYC interrupt).
;@ test: skip interrupt vector
;@ sig: c81cd9d9
LCDCInterrupt::
;> return LCDStatHandler()
	jp LCDStatHandler


	db $ff, $ff, $ff, $ff, $ff

;@ def TimerOverflowInterrupt()
;@ path: system/vectors
;@ Timer interrupt vector: not enabled, it would just return.
;@ test: skip interrupt vector
;@ sig: 1e5db4cd
TimerOverflowInterrupt::
;> return                                 # reti
	reti


	db $ff, $ff, $ff, $ff, $ff, $ff, $ff

;@ def SerialTransferCompleteInterrupt()
;@ path: system/vectors
;@ Serial interrupt vector: not enabled (the game has no link mode), it would just return.
;@ test: skip interrupt vector
;@ sig: bf9f757e
SerialTransferCompleteInterrupt::
;> return                                 # reti
	reti


	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $d9, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff

;@ def Boot()
;@ path: system/vectors
;@ Cartridge entry point: the boot ROM jumps here after the logo.
;@ test: skip never returns
;@ sig: 7f119ac7
Boot::
;> return Init()                          # hop over the cartridge header
	nop
	jp Init


;@ asset: logo
;@ The Nintendo logo. The boot ROM refuses to start the cartridge unless these 48 bytes match its own copy.
;@ path: system/header
HeaderLogo::
	db $ce, $ed, $66, $66, $cc, $0d, $00, $0b, $03, $73, $00, $83, $00, $0c, $00, $0d
	db $00, $08, $11, $1f, $88, $89, $00, $0e, $dc, $cc, $6e, $e6, $dd, $dd, $d9, $99
	db $bb, $bb, $67, $63, $6e, $0e, $ec, $cc, $dd, $dc, $99, $9f, $bb, $b9, $33, $3e

;@ asset: header range=$0100-$014F
;@ The cartridge header: entry point, logo, title, hardware and checksums. A plain 32 KiB cartridge without
;@ banking or RAM.
;@ path: system/header
HeaderTitle::
	db "DRAGON SLAYER 1", $00

;@ path: system/header
;@ New licensee code (unused: the old code below is not $33).
HeaderNewLicenseeCode::
	db $00, $00

;@ path: system/header
;@ No Super Game Boy functions.
HeaderSGBFlag::
	db $00

;@ path: system/header
;@ Cartridge type 0: ROM only.
HeaderCartridgeType::
	db $00

;@ path: system/header
;@ ROM size 0: 32 KiB.
HeaderROMSize::
	db $00

;@ path: system/header
;@ RAM size 0: no cartridge RAM (nothing is saved).
HeaderRAMSize::
	db $00

;@ path: system/header
;@ Destination 0: Japan.
HeaderDestinationCode::
	db $00

;@ path: system/header
;@ Old licensee code $E5: Epoch.
HeaderOldLicenseeCode::
	db $e5

;@ path: system/header
;@ Mask ROM version 0.
HeaderMaskROMVersion::
	db $00

;@ path: system/header
;@ Header checksum over $0134-$014C (checked by the boot ROM).
HeaderComplementCheck::
	db $06

;@ path: system/header
;@ Checksum of the whole ROM (big-endian; not checked by the hardware).
HeaderGlobalChecksum::
	db $67, $66

;@ def Init()
;@ path: system/boot
;@ First code after the header: sets the stack, copies the OAM DMA routine to HRAM and starts the game.
;@ test: skip never returns
;@ sig: 40449dbf
Init::
;> reset_stack(0xDFFF)
	ld sp, $dfff
;>@dma for i in range(10):                # DMA blocks the ROM, so the routine has to run from HRAM
	ld c, LOW(hOAMDMA)
	ld b, $0a
	ld hl, OAMDMARoutine

.copy
;>     hOAMDMA[i] = mem[OAMDMARoutine + i]
	ld a, [hli]
	ldh [c], a
	inc c
;=@dma
	dec b
	jr nz, .copy

;> return Start()
	jp Start


;@ path: system/boot
;@ The OAM DMA routine, copied to hOAMDMA by Init: `ld a, HIGH(wOAMBuffer)` / `ldh [rDMA], a` starts the copy of
;@ wOAMBuffer to OAM, `ld a, $28` / `dec a` / `jr nz` waits the 160 microseconds it takes, then `ret`.
OAMDMARoutine::
	db $3e, $d0, $e0, $46, $3e, $28, $3d, $20, $fd, $c9

;@ def VBlankHandler()
;@ path: system/interrupts
;@ The VBlank interrupt: copies the sprite buffer to OAM when asked, runs the screen flashing, the frame delay
;@ and the long timer, and reads the joypad. hSysFlags bit 0 holds the long timer and the joypad still.
;@ writes: hButtonsHeld, hButtonsNew, hDelayFrames, hFlashRounds, hFlashTimer, hSysFlags, hTimerHi, hTimerLo
;@ reads: hButtonsHeld, hButtonsNew, hDelayFrames, hFlashRounds, hFlashTimer, hSysFlags, hTimerHi, hTimerLo
;@ test: skip interrupt handler (calls the DMA routine in HRAM, ends with reti)
;@ sig: be7e3430
VBlankHandler::
;> # (all registers are saved and restored)
	push af
	push bc
	push de
	push hl
;> if hSysFlags & 0x80:                   # the main code filled wOAMBuffer: copy it now
	ldh a, [hSysFlags]
	bit 7, a
	jr z, .noDMA

;>     hSysFlags &= ~0x80
	res 7, a
	ldh [hSysFlags], a
;>     hOAMDMA()
	call hOAMDMA

.noDMA
;> if hFlashTimer:                        # the screen is flashing
	ldh a, [hFlashTimer]
	or a
	jr z, .flashDone

;>     hFlashTimer -= 1
	dec a
	ldh [hFlashTimer], a
;>     if hFlashTimer == 0:
	or a
	jr nz, .flashing

;>         if hFlashRounds == 0:
	ldh a, [hFlashRounds]
	or a
	jr nz, .nextRound

;>             SetHPPalette()             # flashing over: back to the normal palette
	call SetHPPalette
	jr .flashDone

.nextRound
;>         else:
;>             hFlashRounds -= 1          # another 256 frames
	dec a
	ldh [hFlashRounds], a
;>             hFlashTimer = 0xFF
	ld a, $ff
	ldh [hFlashTimer], a
;>             InvertBGPalette()
	jr .invert

.flashing
;>     elif hFlashTimer & 7 == 7:         # every 8 frames
	and $07
	cp $07
	jr nz, .flashDone

.invert
;>         InvertBGPalette()
	call InvertBGPalette

.flashDone
;> if hDelayFrames:                       # DelayFrames waits for this to reach 0
	ldh a, [hDelayFrames]
	or a
	jr z, .delayDone

;>     hDelayFrames -= 1
	dec a
	ldh [hDelayFrames], a

.delayDone
;> if hSysFlags & 0x01: return            # long timer and joypad on hold
	ldh a, [hSysFlags]
	bit 0, a
	jp nz, PopAndReti

;> if hTimerLo:
	ldh a, [hTimerLo]
	or a
	jr z, .timerHi

;>     hTimerLo -= 1
	dec a
	ldh [hTimerLo], a
	jr .joypad

.timerHi
;> elif hTimerHi:
	ldh a, [hTimerHi]
	or a
	jr z, .joypad

;>     hTimerHi -= 1; hTimerLo = 0xFF
	dec a
	ldh [hTimerHi], a
	ld a, $ff
	ldh [hTimerLo], a

.joypad
;> dpad = read_buttons(0x20)              # P1 bit 5 low selects the D-pad (read twice to let it settle)
	ld a, $20
	ldh [rP1], a
	ldh a, [rP1]
	ldh a, [rP1]
	cpl
	and $0f
;> dpad = swap(dpad)                      # into the high nibble
	swap a
	ld b, a
;>@btn buttons = read_buttons(0x10)       # P1 bit 4 low: A, B, Select, Start (read six times)
	ld a, $10
	ldh [rP1], a
	ldh a, [rP1]
	ldh a, [rP1]
	ldh a, [rP1]
	ldh a, [rP1]
;=@btn
	ldh a, [rP1]
	ldh a, [rP1]
	cpl
	and $0f
;> held = dpad | buttons
	or b
	ld c, a
;>@new hButtonsNew |= held & ~hButtonsHeld   # buttons that went down since the last frame
	ldh a, [hButtonsHeld]
	xor c
	and c
	ld b, a
	ldh a, [hButtonsNew]
	or b
;=@new
	ldh [hButtonsNew], a
;> hButtonsHeld = held
	ld a, c
	ldh [hButtonsHeld], a
;> rP1 = 0x30                             # deselect both groups
	ld a, $30
	ldh [rP1], a
;> return
	jr PopAndReti

;@ def LCDStatHandler()
;@ path: system/interrupts
;@ The LY=LYC interrupt. With the status bar split on (hSysFlags bit 4) it comes twice a frame: at line 0 it
;@ selects the tiles at $8000 and runs the sound engine, at line 95 it selects the tiles at $8800 for the
;@ lines below. Without the split it only comes at line 0 and runs the sound engine. PopAndReti at its end is
;@ also the VBlank handler's exit.
;@ reads: hSysFlags
;@ test: skip interrupt handler (ends with reti)
;@ sig: 90737155
LCDStatHandler::
;> # (all registers are saved and restored)
	push af
	push bc
	push de
	push hl
;> if not hSysFlags & 0x10:               # no split
	ldh a, [hSysFlags]
	bit 4, a
	jr nz, .split

;>     rLYC = 0
	xor a
	ldh [rLYC], a
	jr .sound

.split
;> elif rLYC == 0:                        # top of the frame
	ldh a, [rLYC]
	or a
	jr nz, .bottom

;>     rLYC = 95                          # next interrupt at line 95
	ld a, $5f
	ldh [rLYC], a
;>@wait     for _ in range(16): pass      # a short delay
	ld a, $10

.wait
;=@wait
	dec a
	jr nz, .wait

;>     lcdc = rLCDC | 0x10                # tiles at $8000
	ldh a, [rLCDC]
	or $10
	jr .setLCDC

.bottom
;> else:
;>     rLYC = 0                           # line 95: next interrupt at line 0 again
	xor a
	ldh [rLYC], a
;>     lcdc = rLCDC & ~0x10               # tiles at $8800
	ldh a, [rLCDC]
	and $ef

.setLCDC
;>     rLCDC = lcdc
	ldh [rLCDC], a
;>     if not lcdc & 0x10: return         # only the top-of-frame interrupt runs the sound
	bit 4, a
	jr z, PopAndReti

	jr .sound

; unreachable: ldh a, [rLY] / or a / jr nz, @+8
	db $f0, $45, $b7, $20, $06

.sound
;> UpdateSoundRegisters()
	call UpdateSoundRegisters
;> TickSound()
	call TickSound

PopAndReti:
;> return
	pop hl
	pop de
	pop bc
	pop af
	reti


;@ def Start()
;@ path: system/boot
;@ Sets up the hardware and a fresh game, then shows the title screen. A reset (Select + A, see TakeButtons)
;@ and the end of a game come back here.
;@ writes: hPhase
;@ test: skip initialises the hardware and never returns
;@ sig: 88696a61
Start::
;> rSC = 0; rTAC = 0                      # no link, no timer
	xor a
	ldh [rSC], a
	ldh [rTAC], a
;> rIE = 0x03                             # VBlank and LCD STAT interrupts
	ld a, $03
	ldh [rIE], a
;> enable_interrupts()
	ei
;> WaitFrameIfLCDOn()                     # the LCD may only be turned off in VBlank
	call WaitFrameIfLCDOn
;> rLCDC = 0x04                           # LCD off, 8x16 sprites
	ld a, $04
	ldh [rLCDC], a
;> rSTAT = 0x40                           # interrupt on LY == LYC
	ld a, $40
	ldh [rSTAT], a
;> rOBP0 = 0xE4
	ld a, $e4
	ldh [rOBP0], a
;> hPhase = 0; rLYC = 0
	xor a
	ldh [hPhase], a
	ldh [rLYC], a
;> NewGame()
	call NewGame
;> InitSound()
	call InitSound
;> StopSong()
	call StopSong
;> hModeFlags = 0x40
	ld c, LOW(hModeFlags)
	ld a, $40
	ldh [c], a
;> return TitleScreen()                   # falls through

;@ def TitleScreen()
;@ path: title
;@ Draws the title screen into the window map ($9C00) and runs its menu: GAME START, and after a game over
;@ also CONTINUE (hModeFlags bit 4). Without CONTINUE, TitleNoContinue waits for A and watches for the
;@ phase 2 cheat.
;@ writes: hButtonsHeld, hButtonsNew, hMenuCursor, hModeFlags, wMenuLast
;@ reads: hMenuCursor, hModeFlags, wMenuLast
;@ test: skip never returns
;@ sig: a291002f
TitleScreen::
;> InitSound()
	call InitSound
;> ClearWindowMap()
	call ClearWindowMap
;> SaveScroll()
	call SaveScroll
;> src = TitleTiles; dest = 0x8800
	ld de, TitleTiles
	ld hl, $8800
;>@tiles for _ in range(22):              # 88 tiles, 4 of them a frame
	ld c, $17

.tileLoop
;=@tiles
	dec c
	jr z, .tilesDone

;>     WaitFrame()
	ld b, $40
	call WaitFrame
;>     src, dest = CopyB(0x40, src, dest)
	call CopyB
;=@tiles
	jr .tileLoop

.tilesDone
;> src = TitleTilemap; dest = 0x9C00
	ld de, TitleTilemap
	ld hl, $9c00
	push de
	push hl
;>@rows for _ in range(18):               # one row of 20 tiles a frame
	ld c, $13

.rowLoop
;=@rows
	dec c
	jr z, .rowsDone

;>     WaitFrame()
	pop hl
	pop de
	ld b, $14
	call WaitFrame
;>     src, dest = CopyB(20, src, dest)
	call CopyB
;>     dest += 12                         # to the start of the next row of the 32-tile map
	push de
	ld d, $00
	ld e, $0c
	add hl, de
	push hl
;=@rows
	jr .rowLoop

.rowsDone
;> if hModeFlags & 0x10:                  # after a game over
	pop hl
	pop de
	ldh a, [hModeFlags]
	bit 4, a
	jr z, .noContinue

;>     CopyBC(TextContinue, 0x9DA0, 14)   # second menu line, row 13
	ld de, TextContinue
	ld hl, $9da0
	ld bc, $000e
	call CopyBC

.noContinue
;> rSCY = 0; rSCX = 0
	xor a
	ldh [rSCY], a
	ldh [rSCX], a
;> rLCDC = 0x8D                           # LCD on, BG map $9C00, 8x16 sprites, BG on
	ld a, $8d
	ldh [rLCDC], a
;> wMenuLast = 2
	ld a, $02
	ld [wMenuLast], a
;> if not hModeFlags & 0x10:
	ldh a, [hModeFlags]
	bit 4, a
	jr nz, .onContinue

;>     cursor, row = 0, 11                # GAME START
	xor a
	ld bc, $0b04
	jr .setCursor

.onContinue
;> else:
;>     cursor, row = 2, 13                # CONTINUE is preselected
	ld a, $02
	ld bc, $0d04

.setCursor
;> hMenuCursor = cursor
	ldh [hMenuCursor], a
;> addr = WindowMapAddr(row, 4)
	call WindowMapAddr
;> WaitFrame()
	call WaitFrame
;> mem[addr] = 0x2F                       # the cursor dot
	ld a, $2f
	ld [hl], a
;> hButtonsNew = 0; hButtonsHeld = 0
	xor a
	ldh [hButtonsNew], a
	ldh [hButtonsHeld], a
;> if not hModeFlags & 0x10: return TitleNoContinue()
	ldh a, [hModeFlags]
	bit 4, a
	jp z, TitleNoContinue

.menuLoop
;> for _ in forever():
;>     held, new, reset = TakeButtons()
	call TakeButtons
;>     if reset: return Start()
	jp c, Start

;>     if held & 0x01:                    # A
	bit 0, b
	jp z, .notA

;>         WaitNoActionButtons()
	call WaitNoActionButtons
;>         if hMenuCursor == 0: return StartGame()
	ldh a, [hMenuCursor]
	or a
	jp z, StartGame

;>         hModeFlags = hMenuCursor & ~0x10   # (meant to clear bit 4; EnterPhase clears it anyway)
	res 4, a
	ldh [hModeFlags], a
;>         return ContinueGame()
	jp ContinueGame


.notA
;>     old = hMenuCursor
	ldh a, [hMenuCursor]
	ld d, a
;>     if new & 0x80:                     # Down: next line, wrapping round
	bit 7, c
	jr z, .notDown

;>         cursor = old + 2
	inc a
	inc a
	ld e, a
;>         if cursor != wMenuLast: cursor = 0
	ld hl, wMenuLast
	sub [hl]
	jr z, .move

	ld e, $00
	jr .move

.notDown
;>     elif not new & 0x40: continue      # neither Down nor Up
	bit 6, c
	jr z, .menuLoop

;>     else:                              # Up: previous line, wrapping round
;>         cursor = old - 2
	dec a
	dec a
	ld e, a
;>         if cursor != 0: cursor = wMenuLast
	jr z, .move

	ld a, [wMenuLast]
	ld e, a

.move
;>     hMenuCursor = cursor
	ld a, e
	ldh [hMenuCursor], a
;>     row = 11 + old
	ld a, $0b
	add d
	ld b, a
	ld c, $04
;>     oldAddr = WindowMapAddr(row, 4)
	push de
	call WindowMapAddr
	pop de
	push hl
;>     newAddr = WindowMapAddr(11 + cursor, 4)
	ld a, $0b
	add e
	ld b, a
	ld c, $04
	call WindowMapAddr
;>     WaitFrame()
	call WaitFrame
;>     mem[newAddr] = 0x2F                # move the dot
	ld a, $2f
	ld [hl], a
;>     mem[oldAddr] = 0x3E                # blank
	pop hl
	ld a, $3e
	ld [hl], a
	jr .menuLoop

;@ def StartGame()
;@ path: game/phase
;@ Starts a new game in phase hPhase: shows "PHASE n / START !" with its jingle, unpacks that phase's map
;@ and goes on to EnterPhase. Also the way into phase 2 after phase 1 is cleared.
;@ reads: hPhase
;@ test: skip never returns
;@ sig: a3599308
StartGame::
;> WaitFrameIfLCDOn()
	call WaitFrameIfLCDOn
;> rLCDC = 0x04                           # LCD off
	ld a, $04
	ldh [rLCDC], a
;> NewGame()
	call NewGame
;> hModeFlags = 0x80
	ld c, LOW(hModeFlags)
	ld a, $80
	ldh [c], a
;> ShowPhaseScreen()
	call ShowPhaseScreen
;> CopyBC(TextStart, 0x9920, 14)          # "START !" under "PHASE n"
	ld de, TextStart
	ld hl, $9920
	ld bc, $000e
	call CopyBC
;> rLCDC = 0x85                           # LCD on, 8x16 sprites, BG on
	ld a, $85
	ldh [rLCDC], a
;> PlaySong(0x0B)                         # the phase jingle
	ld a, $0b
	call PlaySong
;> WaitSongEnd()
	call WaitSongEnd
;> if hPhase != 0:
	ldh a, [hPhase]
	or a
	jr z, .phase1

;>     map = Phase2Map
	ld de, Phase2Map
	jr .unpack

.phase1
;> else:
;>     map = Phase1Map
	ld de, Phase1Map

.unpack
;> UnpackMap(map)
	call UnpackMap
;> return EnterPhase()
	jp EnterPhase


;@ def TitleNoContinue()
;@ path: title
;@ The title menu when there is only GAME START: waits for A. Pressing Up, Down, Left, Right and then A
;@ starts in phase 2 instead (the cheat the end of phase 1 shows as "U.D.L.R.A"). Any other order just waits
;@ for A as usual.
;@ writes: hPhase
;@ test: skip never returns
;@ sig: 965f73ae
TitleNoContinue::
;> held, new, reset = WaitButton()
	call WaitButton
;> if reset: return Start()
	jr c, .reset

;> if new & 0x40:                         # Up
	bit 6, c
	jr z, .checkA

;>     held, new, reset = WaitButton()
	call WaitButton
;>     if reset: return Start()
	jr c, .reset

;>     if new & 0x80:                     # Down
	bit 7, c
	jr z, .checkA

;>         held, new, reset = WaitButton()
	call WaitButton
;>         if reset: return Start()
	jr c, .reset

;>         if new & 0x20:                 # Left
	bit 5, c
	jr z, .checkA

;>             held, new, reset = WaitButton()
	call WaitButton
;>             if reset: return Start()
	jr c, .reset

;>             if new & 0x10:             # Right
	bit 4, c
	jr z, .checkA

;>                 held, new, reset = WaitButton()
	call WaitButton
;>                 if reset: return Start()
	jr c, .reset

;>                 if new & 0x01:         # A: the cheat is complete
	bit 0, c
	jr z, .waitA

;>                     hPhase = 1; return StartGame()
	ld a, $01
	jr .setPhase

.waitA
;>@w while not new & 0x01:                # wait for A (a wrong button in the sequence also ends up here)
;>     held, new, reset = TakeButtons()
	call TakeButtons
;>     if reset: return Start()
	jr nc, .checkA

.reset
	jp Start


.checkA
;=@w
	bit 0, c
	jr z, .waitA

;> hPhase = 0
	xor a

.setPhase
	ldh [hPhase], a
;> return StartGame()
	jp StartGame


;@ def ContinueGame()
;@ path: game/phase
;@ CONTINUE after a game over: the home moves back to its starting place, the maximum hit points are halved,
;@ and the hero starts next to the home again (one cell further in if the dragon was beaten before).
;@ reads: hDragonKills, hHomePosHi, hHomePosLo
;@ test: skip never returns
;@ sig: fad78767
ContinueGame::
;> WaitFrameIfLCDOn()
	call WaitFrameIfLCDOn
;> rLCDC = 0x04                           # LCD off
	ld a, $04
	ldh [rLCDC], a
;> cell = GetCell(0xC195)                 # what lies at the home's starting place
	ld hl, $c195
	call GetCell
;> home = hHomePosHi << 8 | hHomePosLo
	push af
	ldh a, [hHomePosHi]
	ld h, a
	ldh a, [hHomePosLo]
	ld l, a
;> SetCellNibble(home, cell)              # ... goes to where the home is now
	pop af
	call SetCellNibble
;> SetCellNibble(0xC195, 2)               # and the home (cell type 2) back to its start
	ld a, $02
	ld hl, $c195
	call SetCellNibble
;> hHomePosHi = 0xC1; hHomePosLo = 0x95
	ld de, $c195
	ld hl, hHomePosHi
	ld [hl], d
	inc hl
	ld [hl], e
;> LoadTiles()
	call LoadTiles
;> hMaxHPLo = (hMaxHPHi & 1) << 7 | hMaxHPLo >> 1; hMaxHPHi >>= 1   # halve the maximum hit points
	ld hl, hMaxHPHi
	srl [hl]
	inc hl
	rr [hl]
;> ResetObjectStates()
	call ResetObjectStates
;> pos = 0xC1E6                           # start position of the hero
	ld de, $c1e6
;> if hDragonKills:
	ldh a, [hDragonKills]
	or a
	jr z, .draw

;>     pos += 0x10
	ld hl, $0010
	call AddDE

.draw
;> DrawViewAt(pos)
	call DrawViewAt
;> ShowPhaseScreen()
	call ShowPhaseScreen
;> CopyBC(TextContinue, 0x9920, 14)       # "CONTINUE" under "PHASE n"
	ld de, TextContinue
	ld hl, $9920
	ld bc, $000e
	call CopyBC
;> PutBGTile(9, 14, 0x7C)                 # "!" after it
	ld c, $7c
	ld de, $090e
	call PutBGTile
;> rLCDC = 0x85                           # LCD on
	ld a, $85
	ldh [rLCDC], a
;> PlaySong(0x0B)                         # the phase jingle
	ld a, $0b
	call PlaySong
;> WaitSongEnd()
	call WaitSongEnd
;> if hSysFlags & 0x40:                   # the dragon is awake
	ld hl, hSysFlags
	bit 6, [hl]
	jr z, .notAwake

;>     LoadAltTiles()
	call LoadAltTiles

.notAwake
;> if hDragonKills == 3:
	ldh a, [hDragonKills]
	cp $03
	jr nz, EnterPhase

;>     LoadTile3E()
	call LoadTile3E
;> return EnterPhase()                    # falls through

;@ def EnterPhase()
;@ path: game/phase
;@ Puts the hero on screen, starts the field music and enters the main loop.
;@ writes: hModeFlags
;@ test: skip never returns
;@ sig: e1166e3b
EnterPhase::
;> hModeFlags = 0
	xor a
	ldh [hModeFlags], a
;> InitHeroSprite()
	call InitHeroSprite
;> hSysFlags |= 0x80                      # copy the sprites at the next VBlank
	ld hl, hSysFlags
	set 7, [hl]
;> rLCDC = 0x87                           # LCD on, sprites on
	ld a, $87
	ldh [rLCDC], a
;> ScrollView()
	call ScrollView
;> PlayFieldMusic()
	call PlayFieldMusic
;> WaitNoActionButtons()
	call WaitNoActionButtons
;> return MainLoop()                      # falls through

;@ def MainLoop()
;@ path: game/turn
;@ The hero's half of a turn. Reads the joypad: B against a wall breaks or kicks it (with the right power),
;@ Start pauses, B alone opens the magic menu, A takes or drops an item. A direction steps the hero: a monster
;@ or the dragon ahead is attacked (AttackObject), any other cell is handled by its type (CellAction). Every
;@ step ends in TurnEnd, the monsters' half, which comes back here. No hit points left, or A+Select: GameOver.
;@ writes: hHeroDir, hHeroFlags
;@ reads: hHeroFlags, hSysFlags
;@ test: skip never returns
;@ sig: 25a63c31
MainLoop::
.loop
;> for _ in forever():
;>     if TestU16Zero(hHPHi): return GameOver()   # out of hit points
	ld hl, hHPHi
	call TestU16Zero
	jp z, GameOver

;>     held, new, reset = TakeButtons()
	call TakeButtons
;>     if reset: return GameOver()
	jp c, GameOver

;>     hHeroDir = held & (UP | DOWN | LEFT | RIGHT)
	ld a, b
	and UP | DOWN | LEFT | RIGHT
	ldh [hHeroDir], a
;>     if hHeroDir:
	jr z, .noWallPower

;>         cell, off_map = GetCellAhead()
	push bc
	call GetCellAhead
	pop bc
;>         if not off_map and cell == 0x01 and held & B_BUTTON:   # B against a wall
	jr c, .noWallPower

	cp $01
	jr nz, .noWallPower

	bit 1, b
	jr z, .noWallPower

;>             if hHeroFlags & 0x02:
	ld hl, hHeroFlags
	bit 1, [hl]
	jr z, .notBreak

;>                 RedrawMonsters()
	call RedrawMonsters
;>                 BreakWallAhead()
	call BreakWallAhead
;>                 continue
	jr .loop

.notBreak
;>             elif hHeroFlags & 0x01:
	bit 0, [hl]
	jr z, .noWallPower

;>                 RedrawMonsters()
	call RedrawMonsters
;>                 KickWallAhead()
	call KickWallAhead
;>                 continue
	jr .loop

.noWallPower
;>     if PauseGame(new): continue        # Start
	call PauseGame
	jr c, .loop

;>     if new & B_BUTTON:
	bit 1, c
	jr z, .notB

;>         MagicMenu()
	call MagicMenu
;>         continue
	jr .loop

.notB
;>     if held & A_BUTTON:
	push bc
	bit 0, b
	jr z, .notA

;>         TakeOrDropItem()
	call TakeOrDropItem

.notA
;>     if not held & (UP | DOWN | LEFT | RIGHT): return TurnEnd()   # no step this turn
	pop bc
	ld a, b
	and UP | DOWN | LEFT | RIGHT
	jp z, TurnEnd

;>     if DiagonalBlocked(): return EndMove()
	call DiagonalBlocked
	jp c, EndMove

;>     SetHeroSpriteDir()
	call SetHeroSpriteDir
;>     pos = GetPosAhead()
	call GetPosAhead
;>     found, p = FindObjectAt(pos)       # p: the monster's position field (record + 4)
	push hl
	pop de
	call FindObjectAt
;>     if found:
	xor a
	cp b
	jr z, .noMonster

;>         state = mem[p - 1]
	dec hl
	ld a, [hli]
;>         if state != 0: return EndMove()   # (e.g. $66) it cannot be attacked now
	cp $66
	jr z, .cannot

	or a
	jr z, .monster

.cannot
	jp EndMove

;>@mon         if CannotAttack(): return EndMove()
;>         return AttackObject(p)

.noMonster
;>     cell, off_map = GetCellAhead()
	call GetCellAhead
;>     if cell == 0x10:                   # the dragon's four cells
	cp $10
	jr nz, .not10

;>         p = wDragon + 4                # position field of its first record
	ld hl, wDragon + 4
	jr .dragon

.not10
;>     elif cell == 0x11:
	cp $11
	jr nz, .not11

;>         p = wDragon + 14 + 4
	ld hl, wDragon + 14 + 4
	jr .dragon

.not11
;>     elif cell == 0x12:
	cp $12
	jr nz, .not12

;>         p = wDragon + 2 * 14 + 4
	ld hl, wDragon + 2 * 14 + 4
	jr .dragon

.not12
;>     elif cell != 0x13:
;>         return CellAction()            # any other cell: by its type
	cp $13
	jp nz, CellAction

;>     else:
;>         p = wDragon + 3 * 14 + 4
	ld hl, wDragon + 3 * 14 + 4
	jr .dragonFight

.dragon
;>     if cell == 0x13 or hSysFlags & 0x40:   # a real dragon fight (powered up, or its fourth cell)
	ldh a, [hSysFlags]
	bit 6, a
	jr z, .attack

;>         if cell != 0x13 and CannotAttack(): return EndMove()
	call CannotAttack
	jr c, .attack

.dragonFight
;>         hHeroFlags |= 0x08             # fighting the dragon
	ldh a, [hHeroFlags]
	set 3, a
	ldh [hHeroFlags], a
;>         return AttackObject(p)
	jr AttackObject

.monster
;=@mon
	call CannotAttack

.attack
	jp c, EndMove

;>     return AttackObject(p)             # falls through

;@ def AttackObject(p: hl)
;@ path: combat/hero
;@ The hero strikes the object whose position field is at p (record + 4). He swings his sword towards it and
;@ takes hit points off it: once he is powered up (hSysFlags bit 6) his strength minus its defence, otherwise
;@ (or if that is not above 0) just 1. A monster brought to 0 vanishes and raises the maximum hit points. The
;@ dragon brought to 0 counts as beaten (hDragonKills): the first time the home moves back to its starting
;@ place, the second time all monsters vanish, the third time the dragon music starts. Then EndMove.
;@ writes: hCount, hCurObjHi, hCurObjLo, hDragonKills, hPictureOverride
;@ reads: hCount, hDragonKills, hHeroDir, hHeroFlags, hStrHi, hStrLo, hSysFlags
;@ test: skip waits for frames
;@ sig: 97c914e7
AttackObject::
;> obj = p - 3                            # the record's kind byte (record + 1)
	dec hl
	dec hl
	dec hl
;> hCurObjHi = hi(obj); hCurObjLo = lo(obj)
	ld a, h
	ldh [hCurObjHi], a
	ld a, l
	ldh [hCurObjLo], a
;> hPictureOverride = 0
	push hl
	xor a
	ldh [hPictureOverride], a
;> hHeroFlags |= 0x04                     # in a fight
	ld hl, hHeroFlags
	set 2, [hl]
;> ShowWindows()
	call ShowWindows
;> if hHeroDir & 0x80:                    # sprite 0 tile, attributes, sprite 1 tile, attributes
	pop hl
	ldh a, [hHeroDir]
	bit 7, a
	jr z, .notDown

;>     stand = [0x00, 0x00, 0x10, 0x00]   # facing down
	ld de, $1000
	push de
	ld bc, $0000
	push bc
;>     swing = [0x0A, 0x00, 0x10, 0x00]   # the sword thrust down
	ld b, $0a
	jr .pose

.notDown
;> elif hHeroDir & 0x40:
	bit 6, a
	jr z, .notUp

;>     stand = [0x04, 0x00, 0x16, 0x00]   # facing up
	ld de, $1600
	push de
	ld bc, $0400
	push bc
;>     swing = [0x04, 0x00, 0x1A, 0x00]
	ld d, $1a
	jr .pose

.notUp
;> elif hHeroDir & 0x20:
	bit 5, a
	jr z, .right

;>     stand = [0x38, 0x20, 0x28, 0x20]   # facing left (both sprites mirrored)
	ld de, $2820
	push de
	ld bc, $3820
	push bc
;>     swing = [0x0C, 0x20, 0x28, 0x20]
	ld b, $0c
	jr .pose

.right
;> else:
;>     stand = [0x28, 0x00, 0x38, 0x00]   # facing right
	ld de, $3800
	push de
	ld bc, $2800
	push bc
;>     swing = [0x28, 0x00, 0x0C, 0x00]
	ld d, $0c

.pose
;> wOAMBuffer[2:4] = swing[0:2]           # the hero's two sprites
	push hl
	ld hl, wOAMBuffer + 2
	ld [hl], b
	inc hl
	ld [hl], c
;> wOAMBuffer[6:8] = swing[2:4]
	inc hl
	inc hl
	inc hl
	ld [hl], d
	inc hl
	ld [hl], e
;> CopyOAMAndDelay(10)
	ld a, $0a
	call CopyOAMAndDelay
;> defence = obj + 11                     # record + 12: its defence, big-endian
	pop hl
	push hl
	ld de, $000b
	add hl, de
	push hl
;> if hSysFlags & 0x40:                   # powered up
	ldh a, [hSysFlags]
	bit 6, a
	jr z, .weak

;>     strength = hStrHi << 8 | hStrLo
	ldh a, [hStrHi]
	ld d, a
	ldh a, [hStrLo]
	ld e, a
;>     damage = strength - (mem[defence] << 8 | mem[defence + 1])
	pop hl
	push hl
	call SubVarFromDE
;> else:
;>     damage = 0
;> if damage > 0:
	jr c, .weak

	ld a, d
	or e
	jr z, .weak

;>     sfx = 0x0B                         # a strong hit
	ld a, $0b
	jr .hit

.weak
;> else:
;>     damage, sfx = 1, 0x0A              # at least 1
	ld de, $0001
	ld a, $0a

.hit
;> PlaySfx(sfx)
	push de
	call PlaySfx
	pop de
;> field = defence - 4                    # record + 8: its hit points, big-endian
	pop hl
	dec hl
	dec hl
	dec hl
	ld c, [hl]
	dec hl
;> hp = mem[field] << 8 | mem[field + 1]
	ld b, [hl]
;> hp = hp - damage
	push hl
	push de
	pop hl
	push bc
	pop de
	call SubDE
;> if hp < 0: hp = 0
	jr nc, .store

	ld de, $0000

.store
;> mem[field] = hi(hp); mem[field + 1] = lo(hp)
	pop hl
	ld [hl], d
	inc hl
	ld [hl], e
;> # (obj and hp are kept on the stack)
	pop hl
	push hl
	push de
;> if not hHeroFlags & 0x08 and hp == 0:  # a monster killed
	ldh a, [hHeroFlags]
	bit 3, a
	jr nz, .noRaise

	ld a, d
	or e
	jr nz, .noRaise

;>     RaiseMaxHP(obj)
	call RaiseMaxHP

.noRaise
;> ShowWindows()
	call ShowWindows
;>@blink for _ in range(4):
	ld a, $04
	ldh [hCount], a

.blink
;>     DragonBlinkOn()                    # (the dragon blinks while it is being hit)
	call DragonBlinkOn
;>     CopyOAMAndDelay(6)
	ld a, $06
	call CopyOAMAndDelay
;>     DragonBlinkOff()
	call DragonBlinkOff
;>     CopyOAMAndDelay(6)
	ld a, $06
	call CopyOAMAndDelay
;=@blink
	ldh a, [hCount]
	dec a
	jr z, .blinkDone

	ldh [hCount], a
	jr .blink

.blinkDone
;> hSysFlags |= 0x02                      # a hit was dealt
	pop de
	ld hl, hSysFlags
	set 1, [hl]
;> waitTimer = True
;> if hp == 0 and hHeroFlags & 0x08:      # the dragon is beaten
	ld a, d
	or e
	jp nz, .alive

	ldh a, [hHeroFlags]
	bit 3, a
	jp z, .monsterDead

;>     mem[obj - 1] = 0; mem[obj] = 0     # its record is cleared
	pop hl
	dec hl
	xor a
	ld [hli], a
	ld [hli], a
;>     if mem[obj + 1] == 0x21:           # the head
	ld a, [hl]
	cp $21
	jr nz, .notHead

;>         ClearBytes(GetCurObjPos(), 8)
	call GetCurObjPos
	ld c, $08
	call ClearBytes

.notHead
;>     SetCellAndDraw(GetPosAhead(), 0x00)   # its cell becomes ground
	call GetPosAhead
	ld a, $00
	call SetCellAndDraw
;>     PlaySfx(0x0E)
	ld a, $0e
	call PlaySfx
;>     hDragonKills += 1
	ldh a, [hDragonKills]
	inc a
	ldh [hDragonKills], a
;>     if hDragonKills == 1:              # the home goes back to where it started
	cp $01
	jr nz, .not1

;>         cell = GetCell(0xC195)
	ld hl, $c195
	call GetCell
	push hl
	push af
;>         oldHi = hHomePosHi; hHomePosHi = 0xC1
	ld c, LOW(hHomePosHi)
	ldh a, [c]
	ld d, a
	ld a, h
	ldh [c], a
;>         oldLo = hHomePosLo; hHomePosLo = 0x95
	inc c
	ldh a, [c]
	ld e, a
	ld a, l
	ldh [c], a
;>         SetCell(oldHi << 8 | oldLo, cell)   # what lay at the start goes where the home was
	pop af
	call SetCell
;>         SetCellNibble(0xC195, 0x02)    # and the home back to its start
	ld a, $02
	pop hl
	call SetCellNibble
	jr .wait

.not1
;>     elif hDragonKills == 2:            # all monsters vanish
	cp $02
	jr nz, .not2

;>         rec = wObjects
	ld hl, wObjects
	ld de, $000d
	ld c, $40
	xor a

.clear
;>@clr         for _ in range(64):
;>             mem[rec] = 0; mem[rec + 1] = 0
	ld [hli], a
	ld [hl], a
;>             rec += 14
	add hl, de
;=@clr
	dec c
	jr nz, .clear

	jr .wait

.not2
;>     elif hDragonKills == 3:            # the third time: the dragon music
	cp $03
	jr nz, .wait

;>         CloseWindows()
	call CloseWindows
;>         DragonFlash(0xDBC4)
	ld hl, $dbc4
	call DragonFlash
;>         DragonFlash(0xDBC6)
	ld hl, $dbc6
	call DragonFlash
;>         DragonFlash(0xDC66)
	ld hl, $dc66
	call DragonFlash
;>         DragonFlash(0xDC64)
	ld hl, $dc64
	call DragonFlash
;>         UpdateThieves()
	call UpdateThieves
;>         BuildSprites()
	call BuildSprites
;>         AnimateStep()
	call AnimateStep
;>         UpdateThieves()
	call UpdateThieves
;>         PlaySong(0x06)
	ld a, $06
	call PlaySong
;>         ShowWindows()
	call ShowWindows
;>         LoadTile3E()
	call LoadTile3E
;>         waitTimer = False
	jr .restore

.monsterDead
;> elif hp == 0:                          # a monster: it vanishes
;>     yx = AddFacingStep(0x5058)         # screen position of the cell ahead (the hero is at Y $50, X $58)
	ld de, $5058
	call AddFacingStep
;>     RemoveObject(obj, yx)
	pop hl
	call RemoveObject
	jr .wait

.alive
;> else:
;>     pass                               # it lives on
	pop hl

.wait
;> if waitTimer:
;>     while TimerRunning(): wait_vblank_flag()
	call TimerRunning
	jr nz, .wait

.restore
;> wOAMBuffer[2:4] = stand[0:2]           # the hero stands again
	ld hl, wOAMBuffer + 2
	pop bc
	ld [hl], b
	inc hl
	ld [hl], c
	inc hl
;> wOAMBuffer[6:8] = stand[2:4]
	inc hl
	inc hl
	pop de
	ld [hl], d
	inc hl
	ld [hl], e
;> hSysFlags |= 0x80
	ld hl, hSysFlags
	set 7, [hl]
;> hHeroFlags &= ~0x0C                    # the fight is over
	ld hl, hHeroFlags
	res 3, [hl]
	res 2, [hl]
;> if hSysFlags & 0x02:                   # (always: set above)
	ld hl, hSysFlags
	bit 1, [hl]
	jr z, jr_000_06e1

;>     hSysFlags &= ~0x02
	res 1, [hl]
;>     return EndMove()                   # falls through
;> return TurnEnd() if hHeroDir == 0 else CellAction()

;@ def EndMove()
;@ path: game/turn
;@ Cancels the hero's step (hHeroDir = 0) and goes on with the monsters' half of the turn.
;@ writes: hHeroDir
;@ reads: hHeroDir
;@ test: skip never returns
;@ sig: e305d449
EndMove::
;> hHeroDir = 0
	xor a
	ldh [hHeroDir], a

jr_000_06e1:
;> if hHeroDir == 0: return TurnEnd()
	ldh a, [hHeroDir]
	or a
	jp z, TurnEnd

;> return CellAction()                    # falls through (not from here: the step was cancelled)

;@ def CellAction()
;@ path: game/turn
;@ The hero steps towards the cell ahead: its type picks the handler in CellActionTable (walk on, push a
;@ rock, enter the home, a warp, a pit, ...). Off the map nothing happens.
;@ test: skip never returns
;@ sig: e69ad2e1
CellAction::
;> cell, off_map = GetCellAhead()
	call GetCellAhead
;> if off_map: return TurnEnd()
	jr c, TurnEnd

;> entry = CellActionTable + 3 * cell     # 3-byte `jp` entries
	ld hl, CellActionTable
	ld c, a
	sla c
	add c
	ld c, a
	ld b, $00
;> return CellActionTable[cell]()
	add hl, bc
	jp hl


;@ def CellActionTable()
;@ path: game/turn
;@ What a step towards each cell type does, indexed by the type (CellAction jumps to entry
;@ 3 * type). Entry 0, empty ground: the hero walks onto it.
;@ test: skip never returns
;@ sig: 9f4e85cb
CellActionTable::
;> return WalkOn()
	jp WalkOn


;@ def CellAction01()
;@ path: game/turn
;@ Cell type $01: a rock: pushed on when the hero carries item $F8.
;@ test: skip never returns
;@ sig: fa08e52b
CellAction01::
;> return BumpRock()
	jp BumpRock


;@ def CellAction02()
;@ path: game/turn
;@ Cell type $02: the home: the hero goes home (or pushes it, carrying item $F8).
;@ test: skip never returns
;@ sig: cc2cad9c
CellAction02::
;> return EnterHome()
	jp EnterHome


;@ def CellAction03()
;@ path: game/turn
;@ Cell type $03: the hero walks onto it.
;@ test: skip never returns
;@ sig: 9f4e85cb
CellAction03::
;> return WalkOn()
	jp WalkOn


;@ def CellAction04()
;@ path: game/turn
;@ Cell type $04: a warp: the hero is carried to the next warp.
;@ test: skip never returns
;@ sig: c914224d
CellAction04::
;> return EnterWarp()
	jp EnterWarp


;@ def CellAction05()
;@ path: game/turn
;@ Cell type $05: the hero walks onto it.
;@ test: skip never returns
;@ sig: 9f4e85cb
CellAction05::
;> return WalkOn()
	jp WalkOn


;@ def CellAction06()
;@ path: game/turn
;@ Cell type $06: the hero walks onto it.
;@ test: skip never returns
;@ sig: 9f4e85cb
CellAction06::
;> return WalkOn()
	jp WalkOn


;@ def CellAction07()
;@ path: game/turn
;@ Cell type $07: the hero walks onto it.
;@ test: skip never returns
;@ sig: 9f4e85cb
CellAction07::
;> return WalkOn()
	jp WalkOn


;@ def CellAction08()
;@ path: game/turn
;@ Cell type $08: the hero walks onto it.
;@ test: skip never returns
;@ sig: 9f4e85cb
CellAction08::
;> return WalkOn()
	jp WalkOn


;@ def CellAction09()
;@ path: game/turn
;@ Cell type $09: the hero walks onto it.
;@ test: skip never returns
;@ sig: 9f4e85cb
CellAction09::
;> return WalkOn()
	jp WalkOn


;@ def CellAction0A()
;@ path: game/turn
;@ Cell type $0A: the hero walks onto it.
;@ test: skip never returns
;@ sig: 9f4e85cb
CellAction0A::
;> return WalkOn()
	jp WalkOn


;@ def CellAction0B()
;@ path: game/turn
;@ Cell type $0B: the hero walks onto it.
;@ test: skip never returns
;@ sig: 9f4e85cb
CellAction0B::
;> return WalkOn()
	jp WalkOn


;@ def CellAction0C()
;@ path: game/turn
;@ Cell type $0C: the hero walks onto it.
;@ test: skip never returns
;@ sig: 9f4e85cb
CellAction0C::
;> return WalkOn()
	jp WalkOn


;@ def CellAction0D()
;@ path: game/turn
;@ Cell type $0D: the hero walks onto it.
;@ test: skip never returns
;@ sig: 9f4e85cb
CellAction0D::
;> return WalkOn()
	jp WalkOn


;@ def CellAction0E()
;@ path: game/turn
;@ Cell type $0E: the hero walks onto it.
;@ test: skip never returns
;@ sig: 9f4e85cb
CellAction0E::
;> return WalkOn()
	jp WalkOn


;@ def CellAction0F()
;@ path: game/turn
;@ Cell type $0F: the hero walks onto it.
;@ test: skip never returns
;@ sig: 9f4e85cb
CellAction0F::
;> return WalkOn()
	jp WalkOn


;@ def CellAction10()
;@ path: game/turn
;@ Cell type $10: blocked: the step does not happen, the turn ends.
;@ test: skip never returns
;@ sig: 78167d25
CellAction10::
;> return TurnEndHome()
	jp TurnEndHome


;@ def CellAction11()
;@ path: game/turn
;@ Cell type $11: blocked: the step does not happen, the turn ends.
;@ test: skip never returns
;@ sig: 78167d25
CellAction11::
;> return TurnEndHome()
	jp TurnEndHome


;@ def CellAction12()
;@ path: game/turn
;@ Cell type $12: blocked: the step does not happen, the turn ends.
;@ test: skip never returns
;@ sig: 78167d25
CellAction12::
;> return TurnEndHome()
	jp TurnEndHome


;@ def CellAction13()
;@ path: game/turn
;@ Cell type $13: blocked: the step does not happen, the turn ends.
;@ test: skip never returns
;@ sig: 78167d25
CellAction13::
;> return TurnEndHome()
	jp TurnEndHome


;@ def CellAction14()
;@ path: game/turn
;@ Cell type $14: a pit: the hero falls through.
;@ test: skip never returns
;@ sig: afca14ac
CellAction14::
;> return StepOnPit()
	jp StepOnPit


;@ def CellAction15()
;@ path: game/turn
;@ Cell type $15: blocked: the step does not happen, the turn ends.
;@ test: skip never returns
;@ sig: 78167d25
CellAction15::
;> return TurnEndHome()
	jp TurnEndHome


;@ def CellAction16()
;@ path: game/turn
;@ Cell type $16: blocked: the step does not happen, the turn ends.
;@ test: skip never returns
;@ sig: 78167d25
CellAction16::
;> return TurnEndHome()
	jp TurnEndHome


;@ def CellAction17()
;@ path: game/turn
;@ Cell type $17: the hero walks onto it.
;@ test: skip never returns
;@ sig: 9f4e85cb
CellAction17::
;> return WalkOn()
	jp WalkOn


;@ def TurnEnd()
;@ path: game/turn
;@ The monsters' half of a turn: the hero's step is animated, the thieves and monsters move, and then every
;@ object that ended up attacking the hero gets its attack (ObjectTurn), the dragon's four parts first.
;@ Once enough pieces are home (hModeFlags bit 0) the monsters stay still.
;@ writes: hCount
;@ reads: hHPHi, hHPLo, hModeFlags, hTurnWait
;@ test: skip never returns
;@ sig: 48fa4685
TurnEnd::
;> BuildSprites()
	call BuildSprites
;> AnimateStep()
	call AnimateStep
;> if hModeFlags & 0x01: return TurnEndCheckHome()   # the phase is won: no more monsters
	ldh a, [hModeFlags]
	bit 0, a
	jp nz, TurnEndCheckHome

;> UpdateThieves()
	call UpdateThieves
;> UpdateMonsters()
	call UpdateMonsters

.wait
;> while hTurnWait: wait_vblank_flag()   # (nothing sets it: no wait)
	ldh a, [hTurnWait]
	or a
	jr nz, .wait

;> if hHPHi == 0 and hHPLo == 0: return NextObject()   # (NextObject then pops a pointer never pushed)
	ldh a, [hHPHi]
	ld b, a
	ldh a, [hHPLo]
	or b
	jp z, NextObject

;> hCount = 0x44                          # 4 dragon records, then the 64 monsters
	ld a, $44
	ldh [hCount], a
;> return ObjectTurn(wDragon + 1)         # falls through
	ld hl, wDragon + 1

;@ def ObjectTurn(obj: hl)
;@ path: game/turn
;@ One object's attack in the monsters' half of the turn; obj points at its record's flag byte (record + 1).
;@ Only an object with bit 6 set attacks (it ran into the hero this turn), the dragon (hCount $41-$44) only
;@ once the hero is powered up (hSysFlags bit 6). The dragon breathes fire, a monster just strikes.
;@ writes: hCurObjHi, hCurObjLo, hPictureOverride, hVisibleObjects
;@ reads: hCount, hSysFlags, hVisibleObjects
;@ test: skip never returns
;@ sig: 88739fc2
ObjectTurn::
;> # (obj stays on the stack for NextObject)
	push hl
;> if not mem[obj] & 0x40: return NextObject()
	bit 6, [hl]
	jp z, NextObject

;> mem[obj] &= ~0x40
	res 6, [hl]
;> hVisibleObjects += 1
	ldh a, [hVisibleObjects]
	inc a
	ldh [hVisibleObjects], a
;> if hCount >= 0x41 and not hSysFlags & 0x40: return NextObject()
	ldh a, [hCount]
	cp $41
	jr c, .attack

	ldh a, [hSysFlags]
	bit 6, a
	jp z, NextObject

.attack
;> hCurObjHi = hi(obj); hCurObjLo = lo(obj)
	ld a, h
	ldh [hCurObjHi], a
	ld a, l
	ldh [hCurObjLo], a
;> hPictureOverride = 0
	xor a
	ldh [hPictureOverride], a
;> ShowWindows()
	call ShowWindows
;> if hCount >= 0x41: return DragonFire()
	ldh a, [hCount]
	cp $41
	jr nc, DragonFire

;> wOAMBuffer[2] = 0x0E; wOAMBuffer[3] = 0x00     # the hero flinches
	ld hl, wOAMBuffer + 2
	ld a, $0e
	ld [hli], a
	ld [hl], $00
;> wOAMBuffer[6] = 0x1E; wOAMBuffer[7] = 0x00
	ld hl, wOAMBuffer + 6
	ld a, $1e
	ld [hli], a
	ld [hl], $00
;> return MonsterAttack()
	jp MonsterAttack


;@ def DragonFire()
;@ path: monsters/dragon
;@ The dragon breathes fire at the hero: a fireball sprite pair (tiles $AE/$AA) appears in a new sprite slot
;@ beside him, he vanishes, flames (tile $BE) flicker over his place three times, then he is back, burnt
;@ (hHeroFlags bit 5, LoadFireHitTiles), and MonsterAttack works out the damage.
;@ writes: hOAMCount
;@ reads: hOAMCount
;@ test: skip waits for frames
;@ sig: ce727292
DragonFire::
;> if hOAMCount != 20: hOAMCount += 1     # one more sprite pair, if there is room
	ldh a, [hOAMCount]
	cp $14
	jr z, .full

	inc a
	ldh [hOAMCount], a

.full
;> slot = hOAMCount - 1
	dec a
;> motion = wScrollDY + 2 * slot          # the pair's motion entry
	sla a
	ld e, a
	ld d, $00
	ld hl, wScrollDY
	add hl, de
;> mem[motion] = 0; mem[motion + 1] = 0   # it does not move
	push de
	xor a
	ld [hli], a
	ld [hli], a
	pop de
;> frame = wSpriteFrame2 + 4 * slot
	sla e
	push de
	ld hl, wSpriteFrame2
	add hl, de
;> fill(frame, 0, 4)
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
;> pair = wOAMBuffer + 8 * slot
	pop bc
	sla c
	ld hl, wOAMBuffer
	add hl, bc
	push hl
;> mem[pair] = 0x54; mem[pair + 1] = 0x5C      # the fireball beside the hero
	ld [hl], $54
	inc hl
	ld [hl], $5c
	inc hl
;> mem[pair + 2] = 0xAE; mem[pair + 3] = 0x00
	ld [hl], $ae
	inc hl
	ld [hl], $00
	inc hl
;> mem[pair + 4] = 0x54; mem[pair + 5] = 0x64
	ld [hl], $54
	inc hl
	ld [hl], $64
	inc hl
;> mem[pair + 6] = 0xAA
	ld [hl], $aa
;> wOAMBuffer[0] = 0xE0; wOAMBuffer[1] = 0xE0   # the hero vanishes
	ld a, $e0
	ld hl, wOAMBuffer
	ld [hli], a
	ld [hli], a
	inc hl
	inc hl
;> wOAMBuffer[4] = 0xE0; wOAMBuffer[5] = 0xE0
	ld [hli], a
	ld [hl], a
;> PlaySfx(0x09)
	ld a, $09
	push de
	call PlaySfx
	pop de
;> CopyOAMAndDelay(11)
	ld a, $0b
	call CopyOAMAndDelay
;>@fl for _ in range(3):
	ld b, $03

.flames
;>     mem[pair] = 0x50; mem[pair + 1] = 0x58   # flames where the hero stood
	pop hl
	push hl
	ld [hl], $50
	inc hl
	ld [hl], $58
	inc hl
;>     mem[pair + 2] = 0xBE; mem[pair + 3] = 0x00
	ld [hl], $be
	inc hl
	ld [hl], $00
	inc hl
;>     mem[pair + 4] = 0x50; mem[pair + 5] = 0x60
	ld [hl], $50
	inc hl
	ld [hl], $60
	inc hl
;>     mem[pair + 6] = 0xBE; mem[pair + 7] = 0x20   # the right half mirrored
	ld [hl], $be
	inc hl
	ld [hl], $20
;>     CopyOAMAndDelay(4)
	ld a, $04
	call CopyOAMAndDelay
;>     mem[pair] = 0x4D                   # they flicker 3 pixels up
	pop hl
	push hl
	ld [hl], $4d
	inc hl
	inc hl
	inc hl
;>     mem[pair + 4] = 0x4D
	inc hl
	ld [hl], $4d
;>     CopyOAMAndDelay(4)
	ld a, $04
	call CopyOAMAndDelay
;=@fl
	dec b
	jr nz, .flames

;> mem[pair] = 0x50; mem[pair + 1] = 0x5C
	pop hl
	push hl
	ld [hl], $50
	inc hl
	ld [hl], $5c
	inc hl
;> mem[pair + 2] = 0xAE
	ld [hl], $ae
	inc hl
	inc hl
;> mem[pair + 4] = 0x50; mem[pair + 5] = 0x64
	ld [hl], $50
	inc hl
	ld [hl], $64
	inc hl
;> mem[pair + 6] = 0xAA
	ld [hl], $aa
;> CopyOAMAndDelay(4)
	ld a, $04
	call CopyOAMAndDelay
;> mem[pair + 2] = 0xAA
	pop hl
	inc hl
	inc hl
	ld [hl], $aa
;> wOAMBuffer[0] = 0x50; wOAMBuffer[1] = 0x58   # the hero is back
	ld a, $50
	ld hl, wOAMBuffer
	ld [hli], a
	ld [hl], $58
;> wOAMBuffer[4] = 0x50; wOAMBuffer[5] = 0x60
	inc hl
	inc hl
	inc hl
	ld [hli], a
	ld [hl], $60
;> hHeroFlags |= 0x20                     # burnt
	ld hl, hHeroFlags
	set 5, [hl]
;> LoadFireHitTiles()
	call LoadFireHitTiles
;> return MonsterAttack()                 # falls through

;@ def MonsterAttack()
;@ path: combat/monster
;@ The current object (hCurObj) attacks the hero. A third of the time it takes a gold piece instead, if he has
;@ one. Another third of the time its kind may decide: kind 4 is fended off by a potion, kinds 8 and $0C drain
;@ 300 strength and kinds 9 and $14 300 maximum hit points (when there are more than 299). Otherwise it hits:
;@ its attack power minus the hero's maximum hit points, at least 1 and at most 3/4 of his hit points + 1,
;@ taken off 100 at a time with a sound each. At 0 hit points the hero dies.
;@ writes: hHPHi, hHPLo
;@ reads: hCurObjHi, hCurObjLo, hHPHi, hHPLo
;@ test: skip waits for frames
;@ sig: bf2ba117
MonsterAttack::
;> CopyOAMAndDelay(60)
	ld a, $3c
	call CopyOAMAndDelay
;> r = Random(hl, af & 0xFF)
	call Random
;> stat = 0
;> if r < 0x56:                           # a third: it grabs a gold piece
	sub $56
	jr nc, .notGold

;>     if not DecCounter16(addr(hGoldHi)):   # (carry: he had none)
	ld hl, hGoldHi
	call DecCounter16
	jr c, .hit

;>         PlaySfx(0x0C); return AttackDone()
	jr .fendedOff

.notGold
;> elif r >= 0x56 + 0x55:                 # a third: the monster's special attack
	sub $55
	jr c, .hit

;>     kind = mem[(hCurObjHi << 8 | hCurObjLo) + 1]
	ldh a, [hCurObjHi]
	ld h, a
	ldh a, [hCurObjLo]
	ld l, a
	inc hl
	ld a, [hli]
;>     if kind == 0x04:                   # fended off by a potion
	cp $04
	jr nz, .notPotion

;>         if not DecCounter16(addr(hPotionsHi)):
	ld hl, hPotionsHi
	call DecCounter16
	jr c, .hit

.fendedOff
;>             PlaySfx(0x0C); return AttackDone()
	ld a, $0c
	call PlaySfx
	jp AttackDone


.notPotion
;>     elif kind == 0x08 or kind == 0x0C:
	cp $08
	jr z, .strength

	cp $0c
	jr nz, .notStrength

.strength
;>         stat = addr(hStrHi)            # drains strength
	ld hl, hStrHi
	jr .drain

.notStrength
;>     elif kind == 0x09 or kind == 0x14:
	cp $09
	jr z, .maxHP

	cp $14
	jr nz, .hit

.maxHP
;>         stat = addr(hMaxHPHi)          # drains maximum hit points
	ld hl, hMaxHPHi

.drain
;>     if stat and CompareDEWithU16(299, stat)[1]:   # more than 299 of it
	ld de, $012b
	call CompareDEWithU16
	jr nc, .hit

;>@dr         for _ in range(30):        # 300 drained, 10 at a time
	push hl
	pop de
	ld hl, $000a
	ld b, $1e

.drainLoop
;>             SubFromVar(stat, 10)
	call SubFromVar
	push bc
	push de
	push hl
;>             PlaySfx(0x0D)
	ld a, $0d
	call PlaySfx
;>             OpenStatusWindow()
	call OpenStatusWindow
	pop hl
	pop de
	pop bc
;=@dr
	dec b
	jr nz, .drainLoop

;>         return AttackDone()
	jp AttackDone


.hit
;> hp = hHPHi << 8 | hHPLo
	ldh a, [hHPHi]
	ld b, a
	ldh a, [hHPLo]
	ld c, a
	push bc
;> rec = hCurObjHi << 8 | hCurObjLo
	ldh a, [hCurObjHi]
	ld h, a
	ldh a, [hCurObjLo]
	ld l, a
;> power = mem[rec + 9] << 8 | mem[rec + 10]   # its attack power
	ld de, $0009
	add hl, de
	ld a, [hli]
	ld d, a
	ld a, [hl]
	ld e, a
;> damage = power - (hMaxHPHi << 8 | hMaxHPLo)
	ld hl, hMaxHPHi
	call SubVarFromDE
;> if damage > 0:
	jr c, .weak

	ld a, d
	or e
	jr z, .weak

;>     sfx = 0x0D
	ld a, $0d
	jr .sound

.weak
;> else:
;>     damage, sfx = 1, 0x0C
	ld de, $0001
	ld a, $0c

.sound
;> PlaySfx(sfx)
	push de
	call PlaySfx
	pop de
;> quarter = hp >> 2
	pop bc
	push bc
	srl b
	rr c
	srl b
	rr c
;> cap = quarter * 3                      # at most 3/4 of his hit points (+ 1)
	push bc
	pop hl
	add hl, bc
	add hl, bc
;> over = damage > cap
	push de
	push hl
	pop de
	pop hl
	push de
	call SubDE
;> if over: damage = cap + 1
	pop de
	jr nc, .countDown

	inc de
	push de
	pop hl

.countDown
;>@h while damage >= 100:                 # the hit points run down 100 at a time
	push hl
	pop de
	ld hl, $0064
	call SubDE
	jr c, .last

;>     damage -= 100
	pop hl
	push de
;>     if hp < 100:
	push hl
	pop de
	ld hl, $0064
	call SubDE
	jr c, .zero

;>@z         hp = 0; break
;>     hp -= 100
;>     hHPHi = hi(hp); hHPLo = lo(hp)
	ld a, d
	ldh [hHPHi], a
	ld a, e
	ldh [hHPLo], a
;>     PlaySfx(0x0D)
	push de
	ld a, $0d
	call PlaySfx
;>     OpenStatusWindow()
	call OpenStatusWindow
	pop de
	pop hl
	push de
;=@h
	jr .countDown

.zero
;=@z
	pop hl
	jr .hpZero

.last
;> else:
;>     hp -= damage
	call AddDE
	push de
	pop hl
	pop de
	call SubDE
;>     if hp <= 0: hp = 0
	jr c, .hpZero

	ld a, d
	or e
	jr nz, .store

.hpZero
	ld de, $0000

.store
;> hHPHi = hi(hp); hHPLo = lo(hp)
	ld a, d
	ldh [hHPHi], a
	ld a, e
	ldh [hHPLo], a
;> OpenStatusWindow()
	push de
	call OpenStatusWindow
;> SetHPPalette()
	call SetHPPalette
	pop de
;> if hp == 0: return HeroDies()
	ld a, d
	or e
	jr z, HeroDies

;> return AttackDone()                    # falls through

;@ def AttackDone()
;@ path: combat/monster
;@ After an attack: redraws the status window, waits for the long timer and (after a monster's attack) lets
;@ the hero stand normally again, then goes on with the next object.
;@ writes: wOAMBuffer
;@ reads: hCount
;@ test: skip never returns
;@ sig: 317bf1d7
AttackDone::
;> OpenStatusWindow()
	call OpenStatusWindow

.wait
;> while TimerRunning(): wait_vblank_flag()
	call TimerRunning
	jr nz, .wait

;> if hCount < 0x41:                      # a monster, not the dragon
	ldh a, [hCount]
	cp $41
	jr nc, .next

;>     wOAMBuffer[2] = 0x00; wOAMBuffer[6] = 0x10   # standing tiles again
	xor a
	ld [wOAMBuffer + 2], a
	ld a, $10
	ld [wOAMBuffer + 6], a
;>     hSysFlags |= 0x80
	ld hl, hSysFlags
	set 7, [hl]

.next
;> return NextObject()
	jp NextObject


;@ def HeroDies()
;@ path: combat/death
;@ The hero's death: he turns round, drops to his knees and falls, then lies there blinking three times
;@ (tiles $2E/$3E). After a long pause the game is over.
;@ writes: wOAMBuffer
;@ test: skip waits for frames
;@ sig: bdfbdf9e
HeroDies::
;> wOAMBuffer[2] = 0x2A; wOAMBuffer[6] = 0x3A
	ld a, $2a
	ld [wOAMBuffer + 2], a
	ld a, $3a
	ld [wOAMBuffer + 6], a
;> CopyOAMAndDelay(11)
	ld a, $0b
	call CopyOAMAndDelay
;> wOAMBuffer[2] = 0x2C; wOAMBuffer[6] = 0x1C
	ld a, $2c
	ld [wOAMBuffer + 2], a
	ld a, $1c
	ld [wOAMBuffer + 6], a
;> CopyOAMAndDelay(64)
	ld a, $40
	call CopyOAMAndDelay
;> wOAMBuffer[0] = 0x55; wOAMBuffer[4] = 0x53   # he sinks
	ld a, $55
	ld [wOAMBuffer], a
	ld a, $53
	ld [wOAMBuffer + 4], a
;> CopyOAMAndDelay(11)
	ld a, $0b
	call CopyOAMAndDelay
;> wOAMBuffer[0] = 0x50; wOAMBuffer[2] = 0x3C     # falls over
	ld hl, wOAMBuffer
	ld [hl], $50
	inc hl
	inc hl
	ld [hl], $3c
;> wOAMBuffer[4] = 0x51
	inc hl
	inc hl
	ld [hl], $51
;> CopyOAMAndDelay(10)
	ld a, $0a
	call CopyOAMAndDelay
;> wOAMBuffer[0] = 0x50; wOAMBuffer[2] = 0x3C
	ld hl, wOAMBuffer
	ld [hl], $50
	inc hl
	inc hl
	ld [hl], $3c
;> wOAMBuffer[4] = 0x51
	inc hl
	inc hl
	ld [hl], $51
;> CopyOAMAndDelay(10)
	ld a, $0a
	call CopyOAMAndDelay
;>@b for i in range(3):
	ld b, $03

.blink
;>     wOAMBuffer[0] = 0x50; wOAMBuffer[2] = 0x2E   # lying on the ground
	ld hl, wOAMBuffer
	ld [hl], $50
	inc hl
	inc hl
	ld [hl], $2e
;>     wOAMBuffer[4] = 0x50; wOAMBuffer[6] = 0x3E
	inc hl
	inc hl
	ld [hl], $50
	inc hl
	inc hl
	ld [hl], $3e
;>     hSysFlags |= 0x80
	ld hl, hSysFlags
	set 7, [hl]
;>     if i == 2: break
	dec b
	jr z, .dead

;>     DelayFrames(6)
	ld a, $06
	call DelayFrames
;>     wOAMBuffer[0] = 0x51; wOAMBuffer[4] = 0x51
	ld a, $51
	ld [wOAMBuffer], a
	ld [wOAMBuffer + 4], a
;>     CopyOAMAndDelay(6)
	ld a, $06
	call CopyOAMAndDelay
;=@b
	jr .blink

.dead
;> DelayFrames(0x90)
	ld a, $90
	call DelayFrames
;> return GameOver()                      # (drops the record pointer ObjectTurn pushed)
	pop hl
	jp GameOver


;@ def NextObject(obj)
;@ path: game/turn
;@ Goes on with the next object of the monsters' half of the turn: after the dragon's 4 records come the 64
;@ monsters of wObjects. After the last one: TurnEndHome.
;@ writes: hCount
;@ reads: hCount
;@ test: skip never returns
;@ sig: c9bc65f8
NextObject::
;> # (obj comes off the stack: ObjectTurn pushed it)
	pop hl
;> count = hCount - 1
	ldh a, [hCount]
	dec a
;> if count == 0: return TurnEndHome()
	jr z, TurnEndHome

;> hCount = count
	ldh [hCount], a
;> if count == 0x40:                      # the dragon is done: on to the monsters
	cp $40
	jr nz, .next

;>     obj = wObjects + 1
	ld hl, wObjects + 1
	jr .go

.next
;> else:
;>     obj += 14
	ld bc, $000e
	add hl, bc

.go
;> return ObjectTurn(obj)
	jp ObjectTurn


;@ def TurnEndHome()
;@ path: game/home
;@ The end of every turn. A hero who has just stepped into his home is put onto the home cell; at home he
;@ rests: every gold piece he carries becomes 50 hit points. With all pieces home the phase is cleared.
;@ Then the next turn (MainLoop), or GameOver at 0 hit points. TurnEndCheckHome is a second entry that skips
;@ the "already resting" test (TurnEnd uses it once the phase is won).
;@ writes: hHPHi, hHPLo, hStatusWinLeft, hStatusWinRight
;@ reads: hHPHi, hHPLo, hHomePosHi, hHomePosLo, hModeFlags
;@ test: skip never returns
;@ sig: 898ee227
TurnEndHome::
;> rested = hHeroFlags & 0x40             # already resting at home
;> if not rested:                         # (TurnEndCheckHome enters here)
	ld hl, hHeroFlags
	bit 6, [hl]
	jr nz, TurnEndCheckHome.rested

TurnEndCheckHome:
;>     if hHeroFlags & 0x10:              # he stepped into the home this turn
	ld hl, hHeroFlags
	bit 4, [hl]
	jr z, .notCame

;>         hHeroFlags &= ~0x10
	res 4, [hl]
;>         home = hHomePosHi << 8 | hHomePosLo
	ldh a, [hHomePosHi]
	ld d, a
	ldh a, [hHomePosLo]
	ld e, a
;>         if not CompareDEWithU16(home, addr(hHeroPosHi))[0]:
	ld hl, hHeroPosHi
	call CompareDEWithU16
	jr z, .notCame

;>             DrawViewAt(home)           # he goes onto the home cell
	call DrawViewAt

.notCame
;>     if hModeFlags & 0x01: return PhaseClear()   # all pieces are home
	ldh a, [hModeFlags]
	bit 0, a
	jp nz, PhaseClear

;>     if CompareDEWithU16(GetHeroPos(), addr(hHomePosHi))[0]:   # standing at home
	call GetHeroPos
	push hl
	pop de
	ld hl, hHomePosHi
	call CompareDEWithU16
	jr nz, .check

;>         OpenStatusWindow()
	call OpenStatusWindow
;>         hHeroFlags |= 0x40             # resting
	ld hl, hHeroFlags
	set 6, [hl]
;>         hStatusWinLeft = d; hStatusWinRight = e   # (as OpenStatusWindow left them)
	ld a, d
	ldh [hStatusWinLeft], a
	ld a, e
	ldh [hStatusWinRight], a
;>         hSysFlags |= 0x80
	ld hl, hSysFlags
	set 7, [hl]

.goldLoop
;>@g         while not DecCounter16(addr(hGoldHi)):   # each gold piece ...
	ld hl, hGoldHi
	call DecCounter16
	jr c, .rested

;>             hp = (hHPHi << 8 | hHPLo) + 50   # ... becomes 50 hit points
	ldh a, [hHPHi]
	ld d, a
	ldh a, [hHPLo]
	ld e, a
	ld hl, $0032
	call AddDE
;>             if hp > 0xFFFF: hp = 0xFFFF
	jr nc, .noCap

	ld de, $ffff

.noCap
;>             hHPHi = hi(hp); hHPLo = lo(hp)
	ld a, d
	ldh [hHPHi], a
	ld a, e
	ldh [hHPLo], a
;>             OpenStatusWindow()
	call OpenStatusWindow
;=@g
	jr .goldLoop

;>         rested = True

.rested
;> if rested: OpenStatusWindow()
	call OpenStatusWindow

.check
;> if not TestU16Zero(hHPHi): return MainLoop()   # the next turn
	ld hl, hHPHi
	call TestU16Zero
	jp nz, MainLoop

;> return GameOver()                      # falls through

;@ def GameOver()
;@ path: game/over
;@ The hero is dead (or A+Select was pressed): "YOU ARE DEAD !" under a grave. A or Start goes back to the
;@ title screen, which now offers CONTINUE.
;@ writes: hFlashRounds, hFlashTimer, hFlyTime, hModeFlags
;@ reads: hModeFlags
;@ test: skip never returns
;@ sig: 35a15772
GameOver::
;> hFlyTime = 0; hFlashRounds = 0
	xor a
	ldh [hFlyTime], a
	ldh [hFlashRounds], a
;> hFlashTimer = 0
	ldh [hFlashTimer], a
;> HideObjects()
	call HideObjects
;> WaitFrameIfLCDOn()
	call WaitFrameIfLCDOn
;> rLCDC = 0x04                           # LCD off
	ld a, $04
	ldh [rLCDC], a
;> ClearBytes(0x93E0, 16)                 # tile $3E (BG tile numbers are signed): blank
	ld hl, $93e0
	ld c, $10
	call ClearBytes
;> ClearBGMap()
	call ClearBGMap
;> CopyBC(GravePicTop, 0x98C0, 11)        # the grave, rows 6 and 7
	ld de, GravePicTop
	ld hl, $98c0
	ld bc, $000b
	call CopyBC
;> CopyBC(GravePicBottom, 0x98E0, 11)
	ld de, GravePicBottom
	ld hl, $98e0
	ld bc, $000b
	call CopyBC
;> CopyBC(TextYouAreDead, 0x9920, 17)     # row 9
	ld de, TextYouAreDead
	ld hl, $9920
	ld bc, $0011
	call CopyBC
;> SaveScroll()
	call SaveScroll
;> rBGP = 0xE4; rOBP0 = 0xE4
	ld a, $e4
	ldh [rBGP], a
	ldh [rOBP0], a
;> rLCDC = 0x85                           # LCD on
	ld a, $85
	ldh [rLCDC], a
;> StopSong()
	call StopSong
;> WaitNoActionButtons()
	call WaitNoActionButtons

.wait
;> while not TakeButtons()[1] & 0x09: wait_vblank_flag()   # A or Start
	call TakeButtons
	ld a, c
	and $09
	jr z, .wait

;> hHeroFlags &= ~0x20                    # not burnt any more
	ld hl, hHeroFlags
	res 5, [hl]
;> hModeFlags |= 0x10                     # the title offers CONTINUE
	ldh a, [hModeFlags]
	set 4, a
	ldh [hModeFlags], a
;> return TitleScreen()
	jp TitleScreen


;@ def PhaseClear()
;@ path: game/phase
;@ All pieces are home: the monsters on screen vanish one after another, "PHASE n / CLEAR !" and the fanfare
;@ follow (after phase 1 also the hint "U.D.L.R.A" for starting in phase 2) until A or Start. Phase 1 goes on
;@ with phase 2; after phase 2 comes the ending: "YOU ARE THE GREATEST DRAGON SLAYER !", for ever.
;@ writes: hHeroDir, hPhase, hVisibleObjects
;@ reads: hOAMCount, hPhase, hSpriteSlot, wSongId
;@ test: skip never returns
;@ sig: ac4cb991
PhaseClear::
;> RedrawObjectsInView()
	call RedrawObjectsInView
;> obj = wObjects + 1
	ld b, $40
	ld hl, wObjects + 1

.objLoop
;>@o for _ in range(64):
;>     kind = mem[obj] & 0x3F
	push bc
	push hl
	ld a, [hl]
	and $3f
;>     if 0x10 <= kind < 0x20:
	sub $10
	jr c, .skip

	cp $10
	jr nc, .skip

;>         mem[obj] = 0x02
	ld [hl], $02

.skip
;>     obj += 14
	pop hl
	pop bc
;=@o
	dec b
	jr z, .objsDone

	ld de, $000e
	add hl, de
	jr .objLoop

.objsDone
;> InitThieves()
	call InitThieves
;> hHeroDir = 0
	xor a
	ldh [hHeroDir], a
;> hVisibleObjects = 0
	xor a
	ldh [hVisibleObjects], a
;> UpdateMonsters()                       # work out who is on screen
	call UpdateMonsters
;> UndoObjectSteps()
	call UndoObjectSteps
;> BuildSprites()
	call BuildSprites
;> CopyOAMAndDelay(a)
	call CopyOAMAndDelay
;> first = hSpriteSlot
	ldh a, [hSpriteSlot]
	ld b, a
;> n = first + 1
	ldh a, [hSpriteSlot]
	inc a
	ld d, $00
	ld e, a
;> x = wOAMBuffer + 8 * n + 1             # X of the first monster sprite pair
	sla e
	sla e
	sla e
	ld hl, wOAMBuffer
	add hl, de
	inc hl
;> left = hOAMCount - first
	ld de, $0008
	ldh a, [hOAMCount]
	sub b

.vanish
;>@v while True:
;>     left -= 1
;>     if left == 0: break
	dec a
	jr z, .clearText

;>     PlaySfx(0x0E)
	push af
	push de
	push hl
	ld a, $0e
	call PlaySfx
;>     AnimateVanish(x)                   # the monster disappears in a puff
	pop hl
	push hl
	call AnimateVanish
;>     x += 8
	pop hl
	pop de
	pop af
	add hl, de
;=@v
	jr .vanish

.clearText
;> ShowPhaseScreen()
	call ShowPhaseScreen
;> CopyBC(TextClear, 0x9920, 14)          # "CLEAR !"
	ld de, TextClear
	ld hl, $9920
	ld bc, $000e
	call CopyBC
;> hPhase += 1
	ldh a, [hPhase]
	inc a
	ldh [hPhase], a
;> if hPhase == 1:
	cp $01
	jr nz, .noHint

;>     CopyBC(TextCheatHint, 0x99A0, 16)  # the phase 2 cheat, row 13
	ld de, TextCheatHint
	ld hl, $99a0
	ld bc, $0010
	call CopyBC

.noHint
;> SaveScroll()
	call SaveScroll
;> rLCDC = 0x85
	ld a, $85
	ldh [rLCDC], a

.fanfare
;> PlaySong(0x0C)                         # the fanfare
	ld a, $0c
	call PlaySong

.waitKey
;>@k for _ in forever():
;>     held, new, reset = TakeButtons()
	call TakeButtons
;>     if new & 0x09: break               # A or Start
	bit 0, c
	jr nz, .next

	bit 3, c
	jr nz, .next

;>     if wSongId == 0xFF: PlaySong(0x0C) # over again
	ld a, [wSongId]
	cp $ff
	jr z, .fanfare

;=@k
	jr .waitKey

.next
;> if hPhase == 1: return StartGame()     # on to phase 2
	ldh a, [hPhase]
	cp $01
	jp z, StartGame

;> WaitFrameIfLCDOn()                     # the ending
	call WaitFrameIfLCDOn
;> rLCDC = 0x04
	ld a, $04
	ldh [rLCDC], a
;> ClearBGMap()
	call ClearBGMap
;> CopyBC(TextGreatest, 0x9880, 20)       # row 4
	ld de, TextGreatest
	ld hl, $9880
	ld bc, $0014
	call CopyBC
;> CopyBC(TextDragonSlayer, 0x98C0, 18)   # row 6
	ld de, TextDragonSlayer
	ld hl, $98c0
	ld bc, $0012
	call CopyBC
;> CopyBC(EndingPicTop, 0x9940, 11)       # a picture, rows 10 and 11
	ld de, EndingPicTop
	ld hl, $9940
	ld bc, $000b
	call CopyBC
;> CopyBC(EndingPicBottom, 0x9960, 11)
	ld de, EndingPicBottom
	ld hl, $9960
	ld bc, $000b
	call CopyBC
;> CopyBC(TextSeeYou, 0x99C0, 19)         # row 14
	ld de, TextSeeYou
	ld hl, $99c0
	ld bc, $0013
	call CopyBC
;> SaveScroll()
	call SaveScroll
;> rLCDC = 0x85
	ld a, $85
	ldh [rLCDC], a

.end
;>@e for _ in forever():
;>     while wSongId != 0xFF: wait_vblank_flag()
	ld a, [wSongId]
	cp $ff
	jr nz, .end

;>     PlaySong(0x0C)                     # the fanfare, over and over
	ld a, $0c
	call PlaySong
;=@e
	jr .end

;@ def DragonBlinkOn()
;@ path: monsters/dragon
;@ First half of the dragon's blink while the hero hits it (only in a dragon fight, hHeroFlags bit 3): the
;@ head (kind $21) is a sprite pair, which goes behind the background (attribute bit 7); a body part is a
;@ map cell, which is drawn as empty ground.
;@ reads: hHeroFlags
;@ test: skip redraws a map cell (waits for VBlank)
;@ sig: a445fcc3
DragonBlinkOn::
;> if not hHeroFlags & 0x08: return
	ldh a, [hHeroFlags]
	bit 3, a
	ret z

;> kind = mem[GetCurObj() + 1]
	call GetCurObj
	inc hl
	ld a, [hl]
;>@b if kind != 0x21: return DrawCellAt(GetPosAhead(), 0x00)   # a body part: blank cell
	sub $11
	cp $10
	jr nz, .body

;> spr = GetCurObjPos()                   # the head
	call GetCurObjPos
;> mem[spr] |= 0x80
	set 7, [hl]
;> mem[spr + 4] |= 0x80
	inc hl
	inc hl
	inc hl
	inc hl
	set 7, [hl]
	ret


.body
;=@b
	ld a, $00
	jr DragonBlinkOff.draw

;@ def DragonBlinkOff()
;@ path: monsters/dragon
;@ Second half of the dragon's blink: the head comes back in front of the background, a body part's cell is
;@ drawn again (picture kind - $11).
;@ reads: hHeroFlags
;@ test: skip redraws a map cell (waits for VBlank)
;@ sig: 6361b93b
DragonBlinkOff::
;> if not hHeroFlags & 0x08: return
	ldh a, [hHeroFlags]
	bit 3, a
	ret z

;> kind = mem[GetCurObj() + 1]
	call GetCurObj
	inc hl
	ld a, [hl]
;>@d if kind != 0x21: return DrawCellAt(GetPosAhead(), kind - 0x11)   # the body part's picture
	sub $11
	cp $10
	jr nz, .draw

;> spr = GetCurObjPos()
	call GetCurObjPos
;> mem[spr] &= ~0x80
	res 7, [hl]
;> mem[spr + 4] &= ~0x80
	inc hl
	inc hl
	inc hl
	inc hl
	res 7, [hl]
	ret


.draw
;=@d
	push af
	call GetPosAhead
	pop af
	call DrawCellAt
	ret


;@ def DragonFlash(pos: hl)
;@ path: monsters/dragon
;@ Flashes the screen three times and turns the cell at pos into type $0C, with a sound (used when the dragon
;@ is beaten the third time).
;@ test: skip waits for frames
;@ sig: 2e50aa6b
DragonFlash::
;> FlashScreen(3)
	ld b, $03
	call FlashScreen
;> SetCellAndDraw(pos, 0x0C)
	ld a, $0c
	call SetCellAndDraw
;> PlaySfx(0x05)
	ld a, $05
	call PlaySfx
	ret


;@ def WindowMapAddr(row: b, col: c) -> hl
;@ path: gfx/bgmap
;@ Address of a tile in the window map at $9C00 (32 tiles a row).
;@ sig: 85e4802b
WindowMapAddr::
;> addr = 0x9C00
	push bc
	push de
	ld d, b
	ld e, c
	ld bc, $0020
	ld hl, $9c00
;>@r for _ in range(row):
	inc d

.rows
;=@r
	dec d
	jr z, .done

;>     addr += 32
	add hl, bc
	jr .rows

.done
;> return addr + col
	add hl, de
	pop de
	pop bc
	ret


;@ def ShowPhaseScreen()
;@ path: game/phase
;@ Turns the LCD off and draws "PHASE n" (n = hPhase + 1) on an empty background, row 7. The caller adds the
;@ line below it and turns the LCD back on.
;@ reads: hPhase
;@ test: skip waits for VBlank
;@ sig: 21c2f261
ShowPhaseScreen::
;> WaitFrameIfLCDOn()
	call WaitFrameIfLCDOn
;> rLCDC = 0x04                           # LCD off
	ld a, $04
	ldh [rLCDC], a
;> ClearBytes(0x93E0, 16)                 # tile $3E: blank
	ld hl, $93e0
	ld c, $10
	call ClearBytes
;> ClearBGMap()
	call ClearBGMap
;> CopyBC(TextPhase, 0x98E0, 14)
	ld de, TextPhase
	ld hl, $98e0
	ld bc, $000e
	call CopyBC
;> digit = 0x50 + hPhase + 1              # the digits start at tile $50
	ldh a, [hPhase]
	inc a
	ld c, $50
	add c
	ld c, a
;> PutBGTile(7, 13, digit)                # right after "PHASE "
	ld de, $070d
	call PutBGTile
	ret


;@ path: gfx/bgmap
;@ Unused code: `push bc` / `ld hl, $9C00` / `ld bc, 32` / `inc d` / (`dec d` / `jr z` / `add hl, bc` / `jr`) /
;@ `add hl, de` / `pop bc` / `ld [hl], c` / `ret` - would put tile c at row d, column e of the window map.
UnusedPutWindowTile::
	db $c5, $21, $00, $9c, $01, $20, $00, $14, $15, $28, $03, $09, $18, $fa, $19, $c1
	db $71, $c9

;@ def NewGame()
;@ path: game/phase
;@ Clears the map, the object tables and HRAM, places the home and the hero at their starting cells, sets up
;@ the monsters, thieves and dragon and the starting strength (50) and maximum hit points (20), then goes on
;@ into LoadTiles.
;@ test: skip initialises the whole game
;@ sig: 6be241e6
NewGame::
;> fill(wMap, 0, 0x1100)                  # $C000-$D0FF: the map and the sprite buffer
	ld hl, wMap
	ld bc, $1100
	call ClearMem
;> fill(wBigCellTable, 0, 0x0D80)         # $D200-$DF7F
	ld hl, wBigCellTable
	ld bc, $0d80
	call ClearMem
;> fill(addr(hButtonsNew), 0, 0x73)       # HRAM $FF8B-$FFFD
	ld hl, hButtonsNew
	ld bc, $0073
	call ClearMem
;> hHomePosHi = 0xC1; hHomePosLo = 0x95   # the home's starting cell
	ld de, $c195
	ld hl, hHomePosHi
	ld [hl], d
	inc hl
	ld [hl], e
;> hHeroPosHi = 0xC1; hHeroPosLo = 0xE6   # the hero's, one row below
	ld de, $c1e6
	ld hl, hHeroPosHi
	ld [hl], d
	inc hl
	ld [hl], e
;> hJumpPosHi = 0xC1; hJumpPosLo = 0xE8
	ld hl, hJumpPosHi
	ld [hl], d
	inc e
	inc e
	inc hl
	ld [hl], e
;> InitObjects()
	call InitObjects
;> InitThieves()
	call InitThieves
;> InitDragon()
	call InitDragon
;> hStrHi = 0; hStrLo = 50
	ld hl, hStrHi
	ld [hl], $00
	inc hl
	ld [hl], $32
;> hMaxHPHi = 0; hMaxHPLo = 20
	inc hl
	ld [hl], $00
	inc hl
	ld [hl], $14
;> return LoadTiles()                     # falls through

;@ def LoadTiles()
;@ path: gfx/tiles
;@ Loads the game's tiles (GameTiles, $1800 bytes to $8000), puts the view at the map's top-left corner,
;@ sets the hit points to 100 and turns the LCD on with the background off.
;@ test: skip turns on the LCD
;@ sig: 8a6856a3
LoadTiles::
;> CopyBC(GameTiles, 0x8000, 0x1800)
	ld de, GameTiles
	ld hl, $8000
	ld bc, $1800
	call CopyBC
;> hViewPosHi = hi(wMap); hViewPosLo = lo(wMap)
	ld de, wMap
	ld hl, hViewPosHi
	ld [hl], d
	inc hl
	ld [hl], e
;> hOldViewPosHi = hi(wMap); hOldViewPosLo = lo(wMap)
	ld hl, hOldViewPosHi
	ld [hl], d
	inc hl
	ld [hl], e
;> hHPHi = 0; hHPLo = 100
	xor a
	ld hl, hHPHi
	ld [hl], $00
	inc hl
	ld [hl], $64
;> rSCY = 0; rSCX = 0
	ldh [rSCY], a
	ldh [rSCX], a
;> rLCDC = 0x84                           # LCD on, 8x16 sprites
	ld a, $84
	ldh [rLCDC], a
;> enable_interrupts()
	ei
;> rBGP = 0xE4; rOBP0 = 0xE4
	ld a, $e4
	ldh [rBGP], a
	ldh [rOBP0], a
	ret


;@ def SaveScroll()
;@ path: gfx/bgmap
;@ Saves the scroll position (hSavedSCY/hSavedSCX) and scrolls back to 0, for a full-screen picture.
;@ writes: hSavedSCX, hSavedSCY
;@ sig: 55947e29
SaveScroll::
;> hSavedSCY = rSCY
	ldh a, [rSCY]
	ldh [hSavedSCY], a
;> hSavedSCX = rSCX
	ldh a, [rSCX]
	ldh [hSavedSCX], a
;> rSCY = 0; rSCX = 0
	xor a
	ldh [rSCY], a
	ldh [rSCX], a
	ret


;@ def PlayFieldMusic()
;@ path: sound/music
;@ Starts the music of the field: song 1, or song 6 once the dragon has been beaten three times.
;@ reads: hDragonKills
;@ sig: 5d3bd2ff
PlayFieldMusic::
;> if hDragonKills == 3:
	ldh a, [hDragonKills]
	cp $03
	jr nz, .normal

;>     song = 0x06
	ld a, $06
	jr .play

.normal
;> else:
;>     song = 0x01
	ld a, $01

.play
;> PlaySong(song)
	call PlaySong
	ret


;@ def WaitButton() -> (b, c, carry)
;@ path: system/joypad
;@ Waits until all buttons are released and then until one is pressed; returns like TakeButtons (held, new,
;@ carry for the reset combination).
;@ test: skip waits for the joypad
;@ sig: 922a79ca
WaitButton::
;> WaitNoButtons()
	call WaitNoButtons

.wait
;> while True:
;>     held, new, reset = TakeButtons()
	call TakeButtons
;>     if reset: return held, new, True
	ret c

;>     if held: return held, new, False
	ld a, b
	or a
	jr z, .wait

	ret


;@ path: system/joypad
;@ Unused code, two fragments: `ld hl, $D480` / `ldh a, [hMenuCursor]` / (`dec a` / `ret z` / `inc hl` / `jr`)
;@ and `ld de, $0D07` / `ldh a, [hMenuCursor]` / (`dec a` / `ret z` / `inc e` / `jr`): an address and a screen
;@ position stepped forward by the menu cursor.
UnusedCursorOffsets::
	db $21, $80, $d4, $f0, $fd, $3d, $c8, $23, $18, $fb, $11, $07, $0d, $f0, $fd, $3d
	db $c8, $1c, $18, $fb

;@ def SetTimer(frames: hl)
;@ path: system/timer
;@ Starts the long countdown hTimerHi/hTimerLo, which the VBlank handler runs down (hl = frames, roughly).
;@ sig: cd22cb7e
SetTimer::
;> disable_interrupts()
	di
;> hTimerHi = hi(frames); hTimerLo = lo(frames)
	ld c, LOW(hTimerHi)
	ld a, h
	ldh [c], a
	inc c
	ld a, l
	ldh [c], a
;> hSysFlags &= ~0x01                     # let the VBlank handler count
	ld hl, hSysFlags
	res 0, [hl]
;> enable_interrupts()
	ei
	ret


;@ def TimerRunning() -> zero
;@ path: system/timer
;@ Not zero while the long countdown runs. Also lets the VBlank handler count again (hSysFlags bit 0).
;@ reads: hTimerHi, hTimerLo
;@ sig: 367a5b2b
TimerRunning::
;> hSysFlags &= ~0x01
	push hl
	ld hl, hSysFlags
	res 0, [hl]
	pop hl
;> if hTimerLo: return False
	ldh a, [hTimerLo]
	or a
	ret nz

;> return hTimerHi == 0
	ldh a, [hTimerHi]
	or a
	ret


;@ def IsOffMap(pos: hl) -> carry
;@ path: map/cells
;@ Carry when pos is not a map position ($C000-$DF3F).
;@ sig: aa1cf09f
IsOffMap::
;> if hi(pos) < 0xC0: return True
	push de
	ld a, h
	cp $c0
	jr c, .done

;> return pos > 0xDF3F
	ld de, $df3f
	call SubDE

.done
	pop de
	ret


;@ def ScrolledLastStep() -> carry
;@ path: map/scroll
;@ Carry when the view moved in the last step (wScrollDY or wScrollDX not 0).
;@ reads: wScrollDX, wScrollDY
;@ sig: 28ce6b53
ScrolledLastStep::
;> moved = wScrollDY | wScrollDX
	push hl
	ld a, [wScrollDY]
	ld h, a
	ld a, [wScrollDX]
	or h
	pop hl
;> return moved != 0
	jr nz, CannotAttack.yes

	jr CannotAttack.no

;@ def CannotAttack() -> carry
;@ path: combat/hero
;@ Carry when the hero may not attack: standing on a cell of type 9, or carrying item $EA.
;@ reads: hCarriedItem
;@ sig: 51f6070e
CannotAttack::
;> if GetCellUnderHero() == 0x09: return True
	call GetCellUnderHero
	cp $09
	jp z, .yes

;> if hCarriedItem == 0xEA: return True
	ldh a, [hCarriedItem]
	cp $ea
	jp z, .yes

.no
;> return False
	scf
	ccf
	ret


.yes
	scf
	ret


;@ def DiagonalBlocked() -> carry
;@ path: player/move
;@ Carry when the hero tries a diagonal step but his maximum hit points are still below 3000: only then can he
;@ walk diagonally.
;@ reads: hHeroDir
;@ sig: d1e621c1
DiagonalBlocked::
;> if hHeroDir & (UP | DOWN) and hHeroDir & (LEFT | RIGHT):   # a diagonal step
	ldh a, [hHeroDir]
	and UP | DOWN
	jr z, .no

	ldh a, [hHeroDir]
	and LEFT | RIGHT
	jr z, .no

;>     maxHP = hMaxHPHi << 8 | hMaxHPLo
	ld hl, hMaxHPHi
	ld d, [hl]
	inc hl
	ld e, [hl]
;>     if maxHP < 3000: return True
	ld hl, $0bb8
	call SubDE
	ret c

.no
;> return False
	scf
	ccf
	ret


;@ def MapPosUnderWindow(pos: de) -> a
;@ path: status/window
;@ Whether map position pos is on screen under an open window: puts its screen cell into hCellYX and returns
;@ ScreenCellUnderWindow's answer ($F0) or 0.
;@ writes: hCellYX
;@ sig: 0733082e
MapPosUnderWindow::
;> found, row, col = GetViewCell(pos)
	push hl
	call GetViewCell
;>@yx hCellYX = (row + 1) << 4 | (col & 0x0F) + 1
	ld a, b
	swap a
	and $f0
	add $10
	ld b, a
;=@yx
	ld a, c
	and $0f
	inc a
	or b
	ldh [hCellYX], a
;> return ScreenCellUnderWindow()
	call ScreenCellUnderWindow
	pop hl
	ret


;@ def ScreenCellUnderWindow() -> a
;@ path: status/window
;@ Whether the screen cell hCellYX is covered by an open window: $F0 (not zero) or 0. With the status window
;@ open (hSysFlags bit 3) its corner (row and column + 1 below 7) is covered, and with the monster window also
;@ open (bit 2) the cells from row 8, column 8 on (+ 1: 9).
;@ reads: hCellYX
;@ sig: 43d3778e
ScreenCellUnderWindow::
;> if not hSysFlags & 0x08: return 0
	ld hl, hSysFlags
	bit 3, [hl]
	jr z, .no

;> if hCellYX & 0xF0 < 0x70:               # the status window
	ldh a, [hCellYX]
	and $f0
	cp $70
	jr nc, .notStatus

;>     if hCellYX & 0x0F < 0x07: return 0xF0
	ldh a, [hCellYX]
	and $0f
	cp $07
	jr c, .yes

.notStatus
;> if not hSysFlags & 0x04: return 0
	ld hl, hSysFlags
	bit 2, [hl]
	jr z, .no

;> if hCellYX & 0xF0 >= 0x90:              # the monster window
	ldh a, [hCellYX]
	and $f0
	cp $90
	jr c, .no

;>     if hCellYX & 0x0F >= 0x09: return 0xF0
	ldh a, [hCellYX]
	and $0f
	cp $09
	jr nc, .yes

.no
;> return 0
	xor a
	ret


.yes
	ld a, $f0
	or a
	ret


;@ def WaitOAMCopy()
;@ path: system/vblank
;@ Asks for the sprite buffer to be copied to OAM and waits until the VBlank handler has done it.
;@ test: skip waits for the VBlank interrupt
;@ sig: 17a1abaa
WaitOAMCopy::
;> hSysFlags |= 0x80
	ld hl, hSysFlags
	set 7, [hl]

.wait
;> while hSysFlags & 0x80: wait_vblank_flag()
	bit 7, [hl]
	jr nz, .wait

	ret


;@ def WaitFrameIfLCDOn()
;@ path: system/vblank
;@ Waits for the next VBlank, but only if the LCD is on (so that it can then be turned off safely).
;@ test: skip waits for the VBlank interrupt
;@ sig: b5e0a967
WaitFrameIfLCDOn::
;> if not rLCDC & 0x80: return
	ldh a, [rLCDC]
	bit 7, a
	ret z

;> return WaitFrame()                     # falls through

;@ def WaitFrame()
;@ path: system/vblank
;@ Waits for the next VBlank.
;@ test: skip waits for the VBlank interrupt
;@ sig: 2c0d3743
WaitFrame::
;> return DelayFrames(1)
	ld a, $01
	jr DelayFrames

;@ def CopyOAMAndDelay(frames: a)
;@ path: system/vblank
;@ Has the sprite buffer copied to OAM at the next VBlank and waits the given number of frames.
;@ test: skip waits for the VBlank interrupt
;@ sig: 6eee7e46
CopyOAMAndDelay::
;> hSysFlags |= 0x80
	push hl
	ld hl, hSysFlags
	set 7, [hl]
	pop hl
;> return DelayFrames(frames)             # falls through

;@ def DelayFrames(frames: a)
;@ path: system/vblank
;@ Waits the given number of frames (the VBlank handler counts hDelayFrames down).
;@ writes: hDelayFrames
;@ reads: hDelayFrames
;@ test: skip waits for the VBlank interrupt
;@ sig: 13902ce8
DelayFrames::
;> hDelayFrames = frames
	ldh [hDelayFrames], a

.wait
;> while hDelayFrames: wait_vblank_flag()
	ldh a, [hDelayFrames]
	or a
	jr nz, .wait

	ret


;@ def WaitSongEnd()
;@ path: sound/music
;@ Waits until the song playing has ended.
;@ reads: wSongId
;@ test: skip waits for the sound engine (run from the LCD interrupt)
;@ sig: e46196ac
WaitSongEnd::
;> while wSongId != 0xFF: wait_vblank_flag()
	ld a, [wSongId]
	cp $ff
	jr nz, WaitSongEnd

	ret


;@ def ClearBGMap()
;@ path: gfx/bgmap
;@ Fills the background map at $9800 with tile $3E (blank).
;@ sig: de5a60bf
ClearBGMap::
;> return FillMem(0x9800, 0x0400, 0x3E)
	ld d, $3e
	ld hl, $9800
	ld bc, $0400
	jr FillMem

;@ def ClearScrollState()
;@ path: map/scroll
;@ Clears wScrollDY, wScrollDX and the sprite motions after them (40 bytes).
;@ sig: d932fc88
ClearScrollState::
;> ClearMem(addr(wScrollDY), 40)
	ld hl, wScrollDY
	ld bc, $0028
	call ClearMem
	ret


;@ def HideObjects()
;@ path: gfx/sprites
;@ Closes the windows and takes every sprite but the hero's off the screen.
;@ writes: hPictureOverride
;@ test: skip waits for the VBlank interrupt
;@ sig: bb700f8a
HideObjects::
;> hPictureOverride = 0
	push de
	xor a
	ldh [hPictureOverride], a
;> CloseWindows()
	call CloseWindows
;> ClearObjectSprites()
	call ClearObjectSprites
	pop de
	ret


;@ path: system/memory
;@ Unused code: `ld [hl], c` / `inc hl` / `ld a, l` / `cp b` / `jr nz` / `ret` - would fill memory with c until
;@ the low byte of hl reaches b.
UnusedFillToL::
	db $71, $23, $7d, $b8, $20, $fa, $c9

;@ def ClearMem(dest: hl, count: bc) -> hl
;@ path: system/memory
;@ Sets count bytes from dest to 0 (count 0 means 65536). Returns the address after them.
;@ test: count = rand(1, 0x100); dest = rand(0xC000, 0xDD00)
;@ sig: 5d41a728
ClearMem::
;> return FillMem(dest, count, 0)         # falls through
	ld d, $00

;@ def FillMem(dest: hl, count: bc, value: d) -> hl
;@ path: system/memory
;@ Sets count bytes from dest to value (count 0 means 65536). Returns the address after them.
;@ test: count = rand(1, 0x100); dest = rand(0xC000, 0xDD00)
;@ sig: 6c227eb7
FillMem::
;>@f while True:
;>     mem[dest] = value; dest += 1
	ld [hl], d
	inc hl
;>     count -= 1
	dec bc
;>     if count == 0: return dest
	ld a, b
	or c
;=@f
	jr nz, FillMem

	ret


;@ def ClearBytes(dest: hl, count: c) -> hl
;@ path: system/memory
;@ Sets count bytes (0-255) from dest to 0. Returns the address after them.
;@ test: dest = rand(0xC000, 0xDD00)
;@ sig: 83999f99
ClearBytes::
;> for _ in range(count):
	xor a
	inc c

.loop
	dec c
	ret z

;>     mem[dest] = 0; dest += 1
	ld [hli], a
	jr .loop

;> return dest

;@ def ClearWindowMap()
;@ path: gfx/bgmap
;@ Fills the first 18 rows of the window map at $9C00 with tile $FF, 2 rows a frame.
;@ test: skip waits for VBlank frames
;@ sig: 880c3eda
ClearWindowMap::
;> dest = 0x9C00
	ld hl, $9c00
	ld d, $ff
	ld e, $0a

.loop
;>@r for _ in range(9):
	dec e
	ret z

;>     WaitFrame()
	ld bc, $0040
	call WaitFrame
;>     dest = FillMem(dest, 0x40, 0xFF)
	call FillMem
;=@r
	jr .loop

;@ def ZeroHP()
;@ path: player/stats
;@ Sets the hero's hit points to 0.
;@ writes: hHPHi, hHPLo
;@ sig: ed9b9fa0
ZeroHP::
;> hHPHi = 0; hHPLo = 0
	xor a
	ldh [hHPHi], a
	ldh [hHPLo], a
	ret


;@ def Random(seed: hl, flags: f) -> a
;@ path: system/math
;@ A new random byte (also kept in hRandom): starting from flags (the CPU's flag byte F as the caller left it), it counts
;@ down to the old hRandom, adding $0E5D to hl at each step; the low byte of the sum is the result.
;@ writes: hRandom
;@ reads: hRandom
;@ test: flags = rand(0, 15) << 4
;@ sig: 11fe1707
Random::
;> count = flags                         # the flags register F
	push bc
	push hl
	push af
	pop bc
;> x = seed
	ld de, $0e5d
	ldh a, [hRandom]

.loop
;>@l while count != hRandom:
	cp c
	jr z, .done

;>     x += 0x0E5D; count = u8(count - 1)
	add hl, de
	dec c
;=@l
	jr .loop

.done
;> hRandom = lo(x)
	ld a, l
	ldh [hRandom], a
;> return hRandom
	pop hl
	pop bc
	ret


;@ def AddDE(de: de, value: hl) -> (de, carry)
;@ path: system/math
;@ de + value, carry on overflow past $FFFF.
;@ sig: 7cd29545
AddDE::
;> r = de + value
	ld a, e
	add l
	ld e, a
	ld a, d
	adc h
	ld d, a
;> return u16(r), r > 0xFFFF
	ret


;@ def SubVarFromDE(de: de, ptr: hl) -> (de, carry)
;@ path: system/math
;@ de minus the big-endian 16-bit number at ptr, carry when that goes below 0.
;@ sig: 8fd3a4ba
SubVarFromDE::
;>@r r = de - (mem[ptr] << 8 | mem[ptr + 1])
	inc hl
	ld a, e
	sub [hl]
	ld e, a
	dec hl
	ld a, d
;=@r
	sbc [hl]
	ld d, a
;> return u16(r), r < 0
	ret


;@ def SubFromVar(ptr: de, value: hl) -> carry
;@ path: system/math
;@ Subtracts value from the big-endian 16-bit number at ptr (wrapping), carry when it went below 0.
;@ test: ptr = rand(0xC000, 0xDD00)
;@ sig: 2b00e7c9
SubFromVar::
;>@r r = (mem[ptr] << 8 | mem[ptr + 1]) - value
	inc de
	ld a, [de]
	sub l
	ld [de], a
	dec de
	ld a, [de]
;=@r
	sbc h
;> mem[ptr] = hi(u16(r)); mem[ptr + 1] = lo(u16(r))
	ld [de], a
;> return r < 0
	ret


;@ def SubDE(de: de, value: hl) -> (de, carry)
;@ path: system/math
;@ de - value, carry when that goes below 0.
;@ sig: 632234ae
SubDE::
;> r = de - value
	ld a, e
	sub l
	ld e, a
	ld a, d
	sbc h
	ld d, a
;> return u16(r), r < 0
	ret


;@ def IncVar(ptr: hl, cy: carry) -> carry
;@ path: system/math
;@ Counts the big-endian 16-bit number at ptr up by one, stopping at $FFFF; carry when it was $FFFF already
;@ (otherwise the carry flag stays as it was).
;@ test: ptr = rand(0xC000, 0xDD00)
;@ sig: d01ea947
IncVar::
;> lo_ = u8(mem[ptr + 1] + 1); mem[ptr + 1] = lo_
	inc hl
	inc [hl]
;> if lo_ != 0: return cy      # carry untouched
	ret nz

;> hi_ = u8(mem[ptr] + 1); mem[ptr] = hi_
	dec hl
	inc [hl]
;> if hi_ != 0: return cy
	ret nz

;> mem[ptr] = 0xFF; mem[ptr + 1] = 0xFF   # it was $FFFF: keep it there
	ld a, $ff
;> return True
	jr FillCounter16

;@ def DecCounter16(counter: hl) -> carry
;@ path: system/math
;@ Counts a big-endian 16-bit counter (high byte first) down by one, stopping at 0.
;@ Returns carry when it was 0 already.
;@ test: counter = rand(0xC000, 0xDFF0)
;@ sig: ec8904e4
DecCounter16::
;> mem[counter + 1] = u8(mem[counter + 1] - 1)
	inc hl
	ld a, [hl]
	sub $01
	ld [hld], a
;> if mem[counter + 1] != 0xFF: return False          # no borrow from the high byte
	ret nc

;> mem[counter] = u8(mem[counter] - 1)
	ld a, [hl]
	sub $01
	ld [hl], a
;> if mem[counter] != 0xFF: return False
	ret nc

;> mem[counter] = 0                                  # it was 0: keep it at 0
	xor a

FillCounter16:
	ld [hli], a
;> mem[counter + 1] = 0
	ld [hl], a
;> return True
	scf
	ret


;@ def CompareDEWithU16(value: de, ptr: hl) -> (zero, carry)
;@ path: system/math
;@ Compares value with the big-endian 16-bit number at ptr: zero when equal, carry when
;@ value is the smaller.
;@ sig: d27a6e29
CompareDEWithU16::
;> low = u8(value - mem[ptr + 1])
	push bc
	ld a, e
	inc hl
	sub [hl]
	ld c, a
;> number = mem[ptr] << 8 | mem[ptr + 1]
	ld a, d
	dec hl
;> high_differs = hi(u16(value - number)) != 0
	sbc [hl]
;> return not high_differs and low == 0, value < number
	jr nz, .done

	or c

.done
	pop bc
	ret


;@ def TestU16Zero(ptr: hl) -> zero
;@ path: system/math
;@ Zero when the 16-bit number at ptr is 0.
;@ sig: 9abc690e
TestU16Zero::
;> return mem[ptr] | mem[ptr + 1] == 0
	ld a, [hli]
	or [hl]
	ret


;@ def DrawNumber(src: bc, dest: hl)
;@ path: status/numbers
;@ Writes the big-endian 16-bit number at src as decimal tiles, right-aligned so that its
;@ last digit lands at dest; 0 is written as "00". Used for the status figures.
;@ test: skip collects the digits on the stack
;@ sig: 5c67c3cc
DrawNumber::
;> DrawNumberStyled(1, src, dest)
	ld a, $01
	jr jr_000_0f1f

;@ def DrawNumberStyled(style: a, src: bc, dest: hl)
;@ path: status/numbers
;@ Writes the big-endian 16-bit number at src (high byte first) as decimal tiles ($50 =
;@ digit 0, $51 = 1, ...) from dest leftwards: the last digit at dest, no leading zeros.
;@ With style 1 the number 0 is written as two zeros.
;@ writes: hTemp1, hTemp2, hTemp3
;@ reads: hTemp1, hTemp2, hTemp3
;@ test: skip collects the digits on the stack
;@ sig: f3d5df3d
DrawNumberStyled::
;> hTemp3 = style
	xor $00

jr_000_0f1f:
	ldh [hTemp3], a
;> hTemp1 = hi(dest); hTemp2 = lo(dest)
	ld a, h
	ldh [hTemp1], a
	ld a, l
	ldh [hTemp2], a
;> value = mem[src] << 8 | mem[src + 1]
	ld a, [bc]
	ld d, a
	inc bc
	ld a, [bc]
	ld e, a
;> digits = []                                # count = len(digits), digits go on the stack
	ld c, $00
;> q, value, count, more = NextDigit(value, 10000, 0)
	ld hl, $2710
	call NextDigit
;> if more: digits.append(q)
	jr nc, .thousands

	push bc

.thousands
;> q, value, count, more = NextDigit(value, 1000, count)
	ld hl, $03e8
	call NextDigit
;> if more: digits.append(q)
	jr nc, .hundreds

	push bc

.hundreds
;> q, value, count, more = NextDigit(value, 100, count)
	ld hl, $0064
	call NextDigit
;> if more: digits.append(q)
	jr nc, .tens

	push bc

.tens
;> q, value, count, more = NextDigit(value, 10, count)
	ld hl, $000a
	call NextDigit
;> if more: digits.append(q)
	jr nc, .write

	push bc

.write
;> pos = hTemp1 << 8 | hTemp2
	ldh a, [hTemp1]
	ld h, a
	ldh a, [hTemp2]
	ld l, a
;> if hTemp3 == 1 and value == 0 and not digits:
	ldh a, [hTemp3]
	dec a
	jr nz, .units

	ld a, e
	or c
	jr z, .units

;>     mem[pos] = 0x50; pos -= 1               # an extra zero
	ld [hl], $50
	dec hl

.units
;> mem[pos] = 0x50 + value; pos -= 1           # the units digit
	ld a, e
	add $50
	ld [hld], a
;>@more for d in reversed(digits):              # tens first, leftwards
	inc c

.more
	dec c
	ret z

;>     mem[pos] = 0x50 + d; pos -= 1
	pop af
	add $50
	ld [hld], a
;=@more
	jr .more

;@ def NextDigit(value: de, power: hl, count: c) -> (b, de, c, carry)
;@ path: status/numbers
;@ One decimal digit for DrawNumberStyled: divides value by power (a power of ten) by
;@ repeated subtraction. Returns the quotient and the remainder; carry (and count + 1)
;@ when the digit is to be shown: it is not 0, or digits came before it.
;@ sig: 65c570d8
NextDigit::
;> q = value // power                          # counted by subtracting
	ld b, $00

.subtract
	call SubDE
	jr c, .went_below

	inc b
	jr .subtract

.went_below
;> value = value % power                       # add the last subtraction back
	call AddDE
;> if q == 0 and count == 0:                  # a leading zero
	ld a, b
	or a
	jr nz, .show

	ld a, c
	or a
	jr nz, .show

;>     return q, value, count, False
	scf
	ccf
	ret


	db $20, $00

.show
;> return q, value, count + 1, True
	inc c
	scf
	ret


;@ def HighNibbleSigned(x: a) -> a
;@ path: system/math
;@ The high nibble of x as a signed number -8..7.
;@ sig: d16ab975
HighNibbleSigned::
;> return NibbleSigned(swap(x))
	swap a

;@ def NibbleSigned(x: a) -> a
;@ path: system/math
;@ The low nibble of x as a signed byte: 0-7 stay, 8-15 become $F8-$FF (-8..-1).
;@ sig: e30d6729
NibbleSigned::
;> n = x & 0x0F
	and $0f
;> if not n & 8: return n
	bit 3, a
	ret z

;> return n | 0xF0
	or $f0
	ret


;@ def WaitNoButtons()
;@ path: system/joypad
;@ Waits until no button at all is held.
;@ test: skip waits for the joypad
;@ sig: f16812ca
WaitNoButtons::
;> while TakeButtons()[0] != 0: wait_vblank_flag()
	call TakeButtons
	ld a, b
	or a
	jr nz, WaitNoButtons

	ret


;@ def WaitNoActionButtons()
;@ path: system/joypad
;@ Waits until A, B, Select and Start are all released (the direction pad may stay held).
;@ test: skip waits for the joypad
;@ sig: 1b10c3b7
WaitNoActionButtons::
;> while TakeButtons()[0] & 0x0F: wait_vblank_flag()
	call TakeButtons
	ld a, $0f
	and b
	jr nz, WaitNoActionButtons

	ret


;@ def TakeButtons() -> (b, c, carry)
;@ path: system/joypad
;@ Returns the held buttons and the new presses (and clears the new presses). Of two
;@ opposite directions pressed together, Up and Right are dropped. Carry when A and
;@ Select are held together: the game then restarts.
;@ writes: hButtonsNew
;@ reads: hButtonsHeld, hButtonsNew
;@ sig: 4c39cc72
TakeButtons::
;> hSysFlags &= ~0x01                          # the VBlank handler reads the joypad again
	ld hl, hSysFlags
	res 0, [hl]
;> held = hButtonsHeld
	di
	ldh a, [hButtonsHeld]
	ld b, a
;> new = hButtonsNew; hButtonsNew = 0
	ldh a, [hButtonsNew]
	ld c, a
	xor a
	ldh [hButtonsNew], a
	ei
;> if new & (UP | DOWN) == UP | DOWN: new &= ~UP          # both: keep Down
	ld a, c
	and UP | DOWN
	cp UP | DOWN
	jr nz, .horizontal

	res 6, c

.horizontal
;> if new & (LEFT | RIGHT) == LEFT | RIGHT: new &= ~RIGHT  # both: keep Left
	ld a, c
	and LEFT | RIGHT
	cp LEFT | RIGHT
	jr nz, .reset_combo

	res 4, c

.reset_combo
;> if not held & SELECT: return held, new, False
	scf
	ccf
	bit 2, b
	ret z

;> if not held & A_BUTTON: return held, new, False
	bit 0, b
	ret z

;> return held, new, True                      # A + Select
	scf
	ret


;@ def ScrollView()
;@ path: map/scroll
;@ Moves the hero one cell in hHeroDir and scrolls the view with him: the background
;@ map is a ring of 16x16 cells, so only the row and the column of cells that come into
;@ view are built and written into it (wrapping round its edges); the scroll registers
;@ follow later. The first call after a reset draws the whole view at the hero instead.
;@ writes: hOldScrollCol, hOldScrollRow, hOldViewPosHi, hOldViewPosLo, hScrollCol, hScrollRow
;@ reads: hScrollCol, hScrollRow, wScrollDX, wScrollDY
;@ test: skip waits for VBlank frames
;@ sig: a9c48000
ScrollView::
;> if not hModeFlags & 0x80:                   # the view is not drawn yet
	ld hl, hModeFlags
	bit 7, [hl]
	jr nz, .step

;>     hModeFlags |= 0x80
	set 7, [hl]
;>     rSCY = 0; rSCX = 0
	xor a
	ldh [rSCY], a
	ldh [rSCX], a
;>     hScrollRow = 0; hScrollCol = 0
	ldh [hScrollRow], a
	ldh [hScrollCol], a
;>     DrawViewAt(GetHeroPos())
	call GetHeroPos
	push hl
	pop de
	call DrawViewAt
;>     dy, dx, delta = 0, 0, 0
	ld bc, $0000
	ld de, $0000
	jr .move

;> else:
.step
;>     pos, off_map = GetPosAhead()            # (taken even when off the map)
	call GetPosAhead
;>     hHeroPosHi = hi(pos); hHeroPosLo = lo(pos)
	ld bc, hHeroPosHi
	ld a, h
	ld [bc], a
	inc bc
	ld a, l
	ld [bc], a
;>     dy, dx, delta = GetDirStep()
	call GetDirStep

.move
;> wScrollDY = dy; wScrollDX = dx
	ld hl, wScrollDY
	ld [hl], b
	inc hl
	ld [hl], c
;> hOldScrollRow = hScrollRow; hScrollRow = (hScrollRow + dy) & 0x0F
	ldh a, [hScrollRow]
	ldh [hOldScrollRow], a
	add b
	and $0f
	ldh [hScrollRow], a
;> hOldScrollCol = hScrollCol; hScrollCol = (hScrollCol + dx) & 0x0F
	ldh a, [hScrollCol]
	ldh [hOldScrollCol], a
	add c
	and $0f
	ldh [hScrollCol], a
;> hOldViewPosHi = hViewPosHi; hOldViewPosLo = hViewPosLo
	call GetViewPos
	ld a, h
	ldh [hOldViewPosHi], a
	ld a, l
	ldh [hOldViewPosLo], a
;> view = u16(GetViewPos() + delta)
	add hl, de
;> hViewPosHi = hi(view); hViewPosLo = lo(view)
	ld de, hViewPosHi
	ld a, h
	ld [de], a
	inc de
	ld a, l
	ld [de], a
;> if dy == 0 and dx == 0: return
	ld a, b
	or c
	ret z

;> # build the new row of cells (11 wide) into wNewRowTop / wNewRowBottom
;> if wScrollDY == 0xFF:                       # up: the new top row
	push hl
	ld a, [wScrollDY]
	cp $ff
	jr nz, .row_down

;>     pos = view
	pop hl
	push hl
	jr .build_row

;> elif wScrollDY == 1:                    # down: the new bottom row
.row_down
	cp $01
	jr nz, .column

;>     pos = view + 8 * 80
	pop hl
	push hl
	ld de, $0280
	add hl, de

.build_row
;> if wScrollDY != 0:
;>     if wScrollDX == 1: pos -= 1             # moving right too: start one cell left
	ld a, [wScrollDX]
	cp $01
	jr nz, .row_go

	dec hl

.row_go
;>     BuildViewRow(pos, wNewRowTop)
	ld de, wNewRowTop
	call BuildViewRow

.column
;> # build the new column of cells (9 high) into wNewColumn
;> if wScrollDX == 0xFF:                       # left: the new left column
	ld a, [wScrollDX]
	cp $ff
	jr nz, .column_right

;>     pos = view
	pop hl
	push hl
	jr .build_column

;> elif wScrollDX == 1:                    # right: the new right column
.column_right
	cp $01
	jr nz, .dest

;>     pos = view + 9
	pop hl
	push hl
	ld de, $0009
	add hl, de

.build_column
;> if wScrollDX != 0:
;>     if wScrollDY == 0xFF: pos += 80         # the row drawn above covers one end
	ld a, [wScrollDY]
	cp $ff
	jr nz, .col_down

	ld de, $0050
	jr .col_add

.col_down
;>     elif wScrollDY == 1: pos -= 80
	cp $01
	jr nz, .col_go

	ld de, $ffb0

.col_add
	add hl, de

.col_go
;>     BuildViewColumn(pos, wNewColumn)
	ld de, wNewColumn
	call BuildViewColumn

.dest
;> # where the row goes in the background map
;> row = hScrollRow
	pop hl
	ldh a, [hScrollRow]
	ld d, a
;> if wScrollDY == 1:
	ld a, [wScrollDY]
	cp $01
	jr nz, .row_addr

;>     row = (row + 8) & 0x0F
	ld a, $08
	add d
	and $0f
	ld d, a

.row_addr
;> dest = 0x9800
	ld bc, $0040
	ld hl, $9800
;> dest += row * 0x40                     # two tile rows per cell
	inc d

.row_mul
	dec d
	jr z, .row_col

	add hl, bc
	jr .row_mul

.row_col
;> col = hScrollCol
	ldh a, [hScrollCol]
	ld c, a
;> if wScrollDX == 1:
	ld a, [wScrollDX]
	cp $01
	jr nz, .row_split

;>     col = (col - 1) & 0x0F
	dec c
	ld a, $0f
	and c
	ld c, a

.row_split
;> dest += col * 2
	sla c
	add hl, bc
;> first, second = 0, 0                       # tiles before / after the wrap
	push hl
	ld bc, $0000
;> if wScrollDY != 0:
	ld a, [wScrollDY]
	or a
	jr z, .row_jobs

;>     room = 0x20 - (dest & 0x1F)             # tiles left in this background row
	ld a, l
	and $1f
	ld b, a
	ld a, $20
	sub b
;>     if room >= 22: first = 22
	sub $16
	jr c, .row_wraps

	ld b, $16
	jr .row_jobs

.row_wraps
;>     else: first, second = room, 22 - room
	add $16
	ld b, a
	ld a, $16
	sub b
	ld c, a

.row_jobs
;> top_wrap = dest & 0xFFE0                   # start of the same background row
	pop hl
	push hl
	pop de
	ld a, e
	and $e0
	ld e, a
;> top_job = [top_wrap, second, dest]        # the copy jobs wait on the stack
	push de
	ld a, c
	push af
	push hl
;> top_job += [first, wNewRowTop]
	ld a, b
	push af
	ld de, wNewRowTop
	push de
;> dest2 = dest + 0x20                         # the bottom tile row
	ld de, $0020
	add hl, de
;> bottom_wrap = dest2 & 0xFFE0
	push hl
	pop de
	ld a, e
	and $e0
	ld e, a
;> bottom_job = [bottom_wrap, second, dest2]
	push de
	ld a, c
	push af
	push hl
;> bottom_job += [first, wNewRowBottom]
	ld a, b
	push af
	ld de, wNewRowBottom
	push de
;> # where the column goes: below the new top row / above the new bottom row
;> row = hScrollRow
	ldh a, [hScrollRow]
	ld d, a
;> if wScrollDY == 0xFF: row += 1
	ld a, [wScrollDY]
	cp $ff
	jr nz, .col_row_down

	inc d

.col_row_down
;> if wScrollDY == 1: row -= 1
	cp $01
	jr nz, .col_row_wrap

	dec d

.col_row_wrap
;> row &= 0x0F
	ld a, $0f
	and d
	ld d, a
	ld e, d
;> cdest = 0x9800
	ld bc, $0040
	ld hl, $9800
;> cdest += row * 0x40
	inc d

.col_mul
	dec d
	jr z, .col_col

	add hl, bc
	jr .col_mul

.col_col
;> col = hScrollCol
	ldh a, [hScrollCol]
	ld c, a
;> if wScrollDX == 1:
	ld a, [wScrollDX]
	cp $01
	jr nz, .col_split

;>     col = (col + 9) & 0x0F
	ld a, $09
	add c
	and $0f
	ld c, a

.col_split
;> cdest += col * 2
	sla c
	add hl, bc
;> cfirst, csecond = 0, 0                      # tile rows before / after the wrap
	push hl
	push bc
	ld bc, $0000
;> if wScrollDX != 0:
	ld a, [wScrollDX]
	or a
	jr z, .col_job

;>     room = 0x20 - row * 2                   # tile rows left down to the map's bottom
	ld a, $20
	sla e
	sub e
;>     if room >= 18: cfirst = 18
	sub $12
	jr c, .col_wraps

	ld b, $12
	jr .col_job

.col_wraps
;>     else: cfirst, csecond = room, 18 - room
	add $12
	ld b, a
	ld a, $12
	sub b
	ld c, a

.col_job
;> cwrap = 0x9800 + col * 2                   # the column continues at the map's top
	pop de
	ld hl, $9800
	add hl, de
	pop de
;> column_job = [cwrap, csecond, cdest]
	push hl
	ld a, c
	push af
	push de
;> column_job += [cfirst, wNewColumn]
	ld a, b
	push af
	ld de, wNewColumn
	push de
;> # write it all in the next VBlanks
;> hSysFlags |= 0x01
	ld bc, $001e
	ld hl, hSysFlags
	set 0, [hl]
;> WaitFrame()
	call WaitFrame
;> src = CopyTilePairs(cfirst, wNewColumn, cdest, 0x1E)     # 2 tiles a row, 32 tiles apart
	pop de
	pop af
	pop hl
	call CopyTilePairs
;> CopyTilePairs(csecond, src, cwrap, 0x1E)
	pop af
	pop hl
	call CopyTilePairs
;> WaitFrame()
	call WaitFrame
;> src = CopyB(first, wNewRowBottom, dest2)
	pop de
	pop bc
	pop hl
	call CopyB
;> CopyB(second, src, bottom_wrap)
	pop bc
	pop hl
	call CopyB
;> src = CopyB(first, wNewRowTop, dest)
	pop de
	pop bc
	pop hl
	call CopyB
;> CopyB(second, src, top_wrap)
	pop bc
	pop hl
	call CopyB
	ret


;@ def ResetHeroSprite()
;@ path: player/sprite
;@ Gives the hero's two sprites their plain standing picture (tiles $00 and $10, no
;@ flipping) and has the sprite buffer copied to OAM at the next VBlank.
;@ sig: 03bfe4be
ResetHeroSprite::
;> wOAMBuffer[2] = 0; wOAMBuffer[3] = 0         # left half: tile, flags
	xor a
	ld hl, wOAMBuffer + 2
	ld [hli], a
	ld [hli], a
;> wOAMBuffer[6] = 0x10; wOAMBuffer[7] = 0      # right half
	inc hl
	inc hl
	ld [hl], $10
	inc hl
	ld [hl], a
;> hSysFlags |= 0x80
	ld hl, hSysFlags
	set 7, [hl]
	ret


;@ def DrawViewAt(pos: de)
;@ path: map/scroll
;@ Puts the hero at map position pos and draws the whole view around him, row by row,
;@ with him at row 4, column 5. A monster standing on that cell is removed and a rock
;@ there (cell type 1) is cleared. Then the monsters are worked out and drawn.
;@ writes: hHeroPosHi, hHeroPosLo, hOldViewPosHi, hOldViewPosLo, hViewPosHi, hViewPosLo, hVisibleObjects
;@ test: skip waits for VBlank frames
;@ sig: 8415c74e
DrawViewAt::
;> ClearObjectSprites()
	push de
	call ClearObjectSprites
;> HideObjects()
	call HideObjects
;> found, rec = FindObjectAt(pos)             # rec points at the monster's +4
	pop de
	push de
	call FindObjectAt
;> if found:                                  # remove the monster standing there
	ld a, b
	or a
	jr z, .placeHero

;>     mem[rec - 2] &= ~0xC0
	dec hl
	dec hl
	res 7, [hl]
	res 6, [hl]
;>     mem[rec - 3] = 0; mem[rec - 4] = 0
	dec hl
	xor a
	ld [hld], a
	ld [hl], a

.placeHero
;> hHeroPosHi = hi(pos); hHeroPosLo = lo(pos)
	pop de
	push de
	ld a, d
	ldh [hHeroPosHi], a
	ld a, e
	ldh [hHeroPosLo], a
;> if GetCellUnderHero() == 1:                # a rock: clear it
	call GetCellUnderHero
	cp $01
	jr nz, .view

;>     SetCellNibble(pos, 0)
	pop hl
	push hl
	ld a, $00
	call SetCellNibble

.view
;> view = u16(pos - 4 * 80 - 5)
	pop de
	ld hl, $febb
	add hl, de
;> hViewPosHi = hi(view)
	ld a, h
	ldh [hViewPosHi], a
;> hOldViewPosHi = hi(view)
	ldh [hOldViewPosHi], a
;> hViewPosLo = lo(view)
	ld a, l
	ldh [hViewPosLo], a
;> hOldViewPosLo = lo(view)
	ldh [hOldViewPosLo], a
;> dest = ViewBGAddr(0, 0)
	push hl
	ld bc, $0000
	call ViewBGAddr
	push hl
	pop de
;> room = 0x20 - (dest & 0x1F)                # tiles left in the background row
	ld a, l
	and $1f
	ld b, a
	ld a, $20
	sub b
;> if room >= 22: first, second = 22, 0       # a row of 11 cells is 22 tiles
	sub $16
	jr c, .wraps

	ld b, $16
	jr .rows

.wraps
;> else: first, second = room, 22 - room
	add $16
	ld b, a
	ld a, $16
	sub b
	ld c, a

.rows
;>@row for _ in range(9):
	pop hl
	ld a, $09

.row
;>     BuildViewRow(view, wNewRowTop)
	push af
	push hl
	push bc
	push de
	ld de, wNewRowTop
	call BuildViewRow
;>     WaitFrame()
	pop hl
	pop bc
	push bc
	push hl
	ld de, wNewRowTop
	call WaitFrame
;>     src = CopyB(first, wNewRowTop, dest)
	call CopyB
;>     wrap = dest & 0xFFE0                    # the row's start in the background map
	pop hl
	push hl
	ld a, l
	and $e0
	ld l, a
;>     CopyB(second, src, wrap)
	ld b, c
	call CopyB
;>     dest2 = dest + 0x20                     # the bottom tile row
	pop hl
	pop bc
	push bc
	ld de, $0020
	add hl, de
;>     src = CopyB(first, wNewRowBottom, dest2)
	push hl
	ld de, wNewRowBottom
	call CopyB
;>     wrap = dest2 & 0xFFE0
	pop hl
	push hl
	ld a, l
	and $e0
	ld l, a
;>     CopyB(second, src, wrap)
	ld b, c
	call CopyB
;>     dest += 0x40
	pop hl
	pop bc
	ld de, $0020
	add hl, de
;>     if hi(dest) == 0x9C: dest -= 0x400      # wrap to the map's top
	ld a, $9c
	cp h
	jr nz, .next_row

	ld h, $98

.next_row
;>     view += 80
	pop de
	push hl
	ld hl, $0050
	add hl, de
	pop de
;=@row
	pop af
	dec a
	jr nz, .row

;> for i in range(13):
	ld hl, wThieves
	ld b, $0d
	ld de, $000e
	xor a

.clear_thieves
;>     wThieves[i * 14] = 0                    # first byte of each thief record
	ld [hl], a
	add hl, de
	dec b
	jr nz, .clear_thieves

;> hVisibleObjects = 0
	xor a
	ldh [hVisibleObjects], a
;> UpdateMonsters()
	call UpdateMonsters
;> RedrawMonsters()
	call RedrawMonsters
	ret


;@ def RedrawMonsters()
;@ path: monsters/draw
;@ Puts the monsters back where they stood before their last step and builds and
;@ shows their sprites again. hModeFlags bit 4 is set meanwhile, so that none of them
;@ starts an attack.
;@ sig: 3b689a44
RedrawMonsters::
;> UndoObjectSteps()
	call UndoObjectSteps
;> hModeFlags |= 0x10
	ld hl, hModeFlags
	set 4, [hl]
;> BuildSprites()
	call BuildSprites
;> AnimateStep()
	call AnimateStep
;> hModeFlags &= ~0x10
	ld hl, hModeFlags
	res 4, [hl]
	ret


;@ def MoveThievesAndMonsters()
;@ path: monsters/move
;@ Lets the thieves and then the monsters take their step.
;@ test: skip UpdateThieves and UpdateMonsters are not testable on random states (their random numbers use leftover register values)
;@ sig: a29abaf2
MoveThievesAndMonsters::
;> UpdateThieves()
	call UpdateThieves
;> UpdateMonsters()
	call UpdateMonsters
	ret


;@ def RemoveObject(rec: hl, yx: de)
;@ path: combat/death
;@ Removes the object whose record kind byte is at rec (record + 1): if one of its
;@ sprites stands at screen position yx (Y in d, X in e) it vanishes in a puff, the
;@ record is cleared, and an object of kind $10-$1F leaves its picture behind as the
;@ map cell (kind - $10) drawn at its position.
;@ writes: hPictureOverride
;@ reads: hSpriteSlot
;@ test: skip waits for VBlank frames
;@ sig: 4182bef8
RemoveObject::
;> RestoreObjectSprites()
	push hl
	push de
	call RestoreObjectSprites
;> OpenMonsterWindow()
	call OpenMonsterWindow
;> slot = hSpriteSlot
	ldh a, [hSpriteSlot]
	ld b, a
;> offset = (slot + 1) * 8                     # the sprite pairs after the last one filled
	inc a
	sla a
	sla a
	sla a
	ld e, a
	ld d, $00
;> sprite = wOAMBuffer + offset
	ld hl, wOAMBuffer
	add hl, de
;>@search for _ in range(19 - hSpriteSlot):
	pop de
	ld a, $14
	sub b
	ld b, a

.search
	dec b
	jr z, .clear

;>     if mem[sprite] == hi(yx):
	ld a, d
	cp [hl]
	jr nz, .y_differs

;>         if mem[sprite + 1] == lo(yx):
	inc hl
	ld a, e
	cp [hl]
	jr nz, .next

;>             AnimateVanish(sprite + 1)
;>             break
	jr .found

.y_differs
;>     sprite += 8
	inc hl

.next
	push bc
	ld bc, $0007
	add hl, bc
	pop bc
;=@search
	jr .search

.found
;=@search
	call AnimateVanish

.clear
;> kind = mem[rec]
	pop hl
	ld b, [hl]
;> mem[rec - 1] = 0; mem[rec] = 0
	xor a
	dec hl
	ld [hli], a
	ld [hli], a
;> hPictureOverride = mem[rec + 1] + 1
	ld a, [hl]
	inc a
	ldh [hPictureOverride], a
;> if (kind & 0x3F) < 0x10: return
	ld a, b
	and $3f
	sub $10
	ret c

;> pos = mem[rec + 3] << 8 | mem[rec + 4]
	inc hl
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
;> DrawMetatileNextFrame((kind & 0x3F) - 0x10, MapPosToBG(pos))
	push af
	call MapPosToBG
	pop af
	call DrawMetatileNextFrame
	ret


;@ def AnimateVanish(sprite: hl)
;@ path: combat/death
;@ A puff of smoke on a sprite pair (sprite points at the left sprite's X byte): the
;@ pictures $BC, $AA, $BC, $AC and $AA follow each other over 24 frames.
;@ test: skip waits for VBlank frames
;@ sig: f59fcde5
AnimateVanish::
;> mem[sprite + 1] = 0xBC; mem[sprite + 2] = 0
	ld a, $bc
	inc hl
	ld [hli], a
	ld [hl], $00
;> mem[sprite + 5] = 0xBC; mem[sprite + 6] = 0x20     # mirrored right half
	inc hl
	inc hl
	inc hl
	ld [hli], a
	ld [hl], $20
;> CopyOAMAndDelay(4)
	ld a, $04
	call CopyOAMAndDelay
;> mem[sprite + 5] = 0xAA
	ld a, $aa
	dec hl
	ld [hld], a
;> mem[sprite + 1] = 0xAA
	dec hl
	dec hl
	dec hl
	ld [hl], a
;> CopyOAMAndDelay(4)
	ld a, $04
	call CopyOAMAndDelay
;> mem[sprite + 1] = 0xBC; mem[sprite + 5] = 0xBC
	ld a, $bc
	ld [hli], a
	inc hl
	inc hl
	inc hl
	ld [hl], a
;> CopyOAMAndDelay(7)
	ld a, $07
	call CopyOAMAndDelay
;> mem[sprite + 5] = 0xAC
	ld a, $ac
	ld [hld], a
;> mem[sprite + 1] = 0xAC
	dec hl
	dec hl
	dec hl
	ld [hl], a
;> CopyOAMAndDelay(9)
	ld a, $09
	call CopyOAMAndDelay
;> mem[sprite + 1] = 0xAA; mem[sprite + 5] = 0xAA
	ld a, $aa
	ld [hli], a
	inc hl
	inc hl
	inc hl
	ld [hl], a
;> hSysFlags |= 0x80
	ld hl, hSysFlags
	set 7, [hl]
	ret


;@ def SetHPPalette()
;@ path: status/palette
;@ Below 50 hit points the screen and the sprites turn darker (palette $C9) as a
;@ warning; otherwise the normal palette $E4 is used.
;@ reads: hHPHi, hHPLo
;@ sig: 34407afe
SetHPPalette::
;> hp = hHPHi << 8 | hHPLo
	ldh a, [hHPHi]
	ld d, a
	ldh a, [hHPLo]
	ld e, a
;> if hp >= 50:
	ld hl, $0032
	call SubDE
	jr c, .low

;>     palette = 0xE4
	ld a, $e4
	jr .set

;> else:
.low
;>     palette = 0xC9
	ld a, $c9

.set
;> rBGP = palette
	ldh [rBGP], a
;> rOBP0 = palette
	ldh [rOBP0], a
	ret


;@ def FlashScreen(times: b)
;@ path: gfx/palette
;@ Flashes the background: inverts its palette for 6 frames and back for 6, times
;@ times.
;@ test: skip waits for VBlank frames
;@ sig: fdaf73cd
FlashScreen::
;> for _ in range(times):
;>     InvertBGPalette()
	call InvertBGPalette
;>     DelayFrames(6)
	ld a, $06
	call DelayFrames
;>     InvertBGPalette()
	call InvertBGPalette
;>     DelayFrames(6)
	ld a, $06
	call DelayFrames
	dec b
	jr nz, FlashScreen

	ret


;@ def InvertBGPalette()
;@ path: gfx/palette
;@ Flips the background palette between its normal and its flash look (xor $87: $E4
;@ becomes $63).
;@ sig: f8475b39
InvertBGPalette::
;> rBGP ^= 0x87
	ldh a, [rBGP]
	xor $87
	ldh [rBGP], a
	ret


;@ def LoadTile3EOnThirdKill()
;@ path: gfx/tiles
;@ After the dragon's third defeat (hDragonKills 3) replaces background tile $3E with
;@ the 16 bytes at $5E62.
;@ reads: hDragonKills
;@ test: skip waits for a VBlank frame
;@ sig: f807e2e1
LoadTile3EOnThirdKill::
;> if hDragonKills != 3: return
	ldh a, [hDragonKills]
	cp $03
	ret nz

;> WaitFrame()
	ld de, DottedFloorTile
	ld hl, $93e0
	call WaitFrame
;> copy(0x93E0, 0x5E62, 0x10)
	ld b, $10
	call CopyB
	ret


;@ def PutBGTile(row: d, col: e, tile: c)
;@ path: gfx/bgmap
;@ Writes one tile into the background map at a tile row and column.
;@ sig: ac6849a7
PutBGTile::
;> addr = 0x9800
	push bc
	ld hl, $9800
	ld bc, $0020
;> addr += row * 0x20
	inc d

.mul
	dec d
	jr z, .add_col

	add hl, bc
	jr .mul

.add_col
;> mem[addr + col] = tile
	add hl, de
	pop bc
	ld [hl], c
	ret


;@ def ClearObjectSprites()
;@ path: gfx/sprites
;@ Takes everything but the hero off the screen: when the dragon was shown, its cell
;@ (DRAGON_HEAD_POS) is drawn back as cell type $10 and wDragonVRAM is cleared; all
;@ sprites after the hero's are emptied.
;@ test: skip waits for a VBlank frame
;@ sig: ebbf9a7a
ClearObjectSprites::
;> if wDragonVRAM[0] != 0:
	push de
	ld hl, wDragonVRAM
	push hl
	ld a, [hl]
	or a
	jr z, .clear

;>     DrawCellAt(0x10, DRAGON_HEAD_POS)
	ld a, $10
	ld hl, DRAGON_HEAD_POS
	call DrawCellAt

.clear
;> ClearBytes(wDragonVRAM, 6)
	pop hl
	ld c, $06
	call ClearBytes
;> ClearOtherSprites()
	call ClearOtherSprites
;> hSysFlags |= 0x80
	ld hl, hSysFlags
	set 7, [hl]
	pop de
	ret


;@ def RedrawObjectsInView()
;@ path: monsters/draw
;@ Draws the objects of kind $10-$1F (those shown as map cells) that are on or near
;@ the screen as background cells: kind - $10 is the cell picture.
;@ test: skip waits for VBlank frames
;@ sig: 7f25cfca
RedrawObjectsInView::
;>@loop for rec in range(wObjects + 1, wObjects + 1 + 64 * 14, 14):     # rec = the kind byte
	ld b, $40
	ld hl, wObjects + 1

.loop
;>     cell = (mem[rec] & 0x3F) - 0x10
	push bc
	push hl
	ld a, [hli]
	and $3f
	sub $10
;>     if not 0 <= cell < 0x10: continue
	jr c, .next

	cp $10
	jr nc, .next

;>     pos = mem[rec + 3] << 8 | mem[rec + 4]
	push af
	inc hl
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
;>@hid     if GetViewCell(pos)[0]:
	call GetViewCell
	or a
	jr z, .hidden

;>         DrawMetatileNextFrame(cell, MapPosToBG(pos))
	call MapPosToBG
	pop af
	call DrawMetatileNextFrame
	jr .next

.hidden
;=@hid
	pop af

.next
;=@loop
	pop hl
	pop bc
	dec b
	ret z

;=@loop
	ld de, $000e
	add hl, de
	jr .loop

;@ def GetViewCell(pos: de) -> (a, b, c)
;@ path: map/view
;@ Where map position pos is on the 14-column, 13-row grid that reaches two cells past
;@ the view's top and left edges: returns a nonzero a with b = row (0-12) and c =
;@ column (0-13), or a = 0 when pos is outside the grid.
;@ sig: db841725
GetViewCell::
;> origin = u16(GetViewPos() - 2 * 80 - 2)
	push de
	call GetViewPos
	ld bc, $ff5e
	add hl, bc
;> if pos < origin: return 0, 0xFF, 0x5E            # (b, c: leftovers)
	call SubDE
	jp c, .outside

;> row, rest = (pos - origin) // 80, (pos - origin) % 80     # (by subtracting rows)
	ld b, $00
	ld hl, $0050

.rows
	call SubDE
	jr c, .found_row

;>@rows if row >= 13: return 0, 13, 0x5E
	inc b
	ld a, $0d
	cp b
	jp z, .outside

	jr .rows

.found_row
;> if rest > 13: return 0, row, rest
	call AddDE
	ld c, e
	ld a, $0d
	cp e
	jr c, .outside

;> return 13, row, rest
	pop de
	ret


.outside
;=@rows
	xor a
	pop de
	ret


;@ def AddFacingStep(yx: de) -> de
;@ path: map/view
;@ Moves a pixel position (Y in d, X in e) one cell (16 pixels) in the direction of
;@ hHeroDir.
;@ sig: 50d8d42b
AddFacingStep::
;> dy, dx, delta = GetDirStep()
	push bc
	push de
	call GetDirStep
	pop de
;> step_y = dy * 16
	ld a, b
	sla a
	sla a
	sla a
	sla a
;> y = u8(hi(yx) + step_y)
	add d
	ld d, a
;> step_x = dx * 16
	ld a, c
	sla a
	sla a
	sla a
	sla a
;> x = u8(lo(yx) + step_x)
	add e
	ld e, a
;> return y << 8 | x
	pop bc
	ret


;@ def GetCellAhead() -> (a, carry)
;@ path: map/cells
;@ The cell type in front of the hero (in hHeroDir), or carry when that is off the map.
;@ sig: c21b8668
GetCellAhead::
;> pos, off_map = GetPosAhead()
	call GetPosAhead
;> if off_map: return (hi(pos) if pos < 0xC000 else hi(u16(0xDF3F - pos))), True   # a: left over from IsOffMap
	ret c

;> return GetCell(pos), False
	call GetCell
	scf
	ccf
	ret


;@ def GetCellUnderHero() -> a
;@ path: map/cells
;@ The cell type of the cell the hero stands on.
;@ sig: 033c04c8
GetCellUnderHero::
;> pos = GetHeroPos()
	push bc
	push hl
	call GetHeroPos
;> return GetCell(pos)
	call GetCell
	pop hl
	pop bc
	ret


;@ def GetCell(pos: hl) -> a
;@ path: map/cells
;@ The cell type at map position pos ($C000 + row * 80 + column). Off the map counts as
;@ a rock (1). Types 0-14 are stored in the map's nibble itself; nibble 15 means "look it
;@ up": first in wBigCellTable (one slot per low address byte), else in wBigCellList.
;@ The list search compares the stored high byte with pos's high byte xor $C0, but
;@ UnpackMap stores the plain high byte there, and the search has no end marker.
;@ test: pos = rand(0xC000, 0xDF3F)
;@ test: i = rand(0, 31); mem[wBigCellList + 3 * i] = (pos >> 8) ^ 0xC0; mem[wBigCellList + 3 * i + 1] = pos & 0xFF
;@ sig: 6aadb939
GetCell::
;> off = IsOffMap(pos)
	push de
	push hl
	call IsOffMap
;> if off: return 1
	jr nc, .on_map

	ld a, $01
	pop hl
	jr .return

.on_map
;> high = hi(pos) < 0xD0                      # $C000-$CF9F: high nibbles, the rest low ones
	bit 4, h
	jr nz, .low_nibble

;> if hi(pos) == 0xCF: high = lo(pos) < 0xA0
	ld a, h
	cp $cf
	jr nz, .high_nibble

	ld a, l
	cp $a0
	jr nc, .low_nibble

;> if high:
.high_nibble
;>     cell = mem[pos] >> 4
	ld a, [hl]
	swap a
	jr .nibble

;> else:                                      # second half: low nibbles, $0FA0 lower
.low_nibble
;>     cell = mem[pos - 0x0FA0] & 0x0F
	push hl
	pop de
	ld hl, $0FA0
	call SubDE
	ld a, [de]

.nibble
;> if cell != 15: return cell
	and $0f
	cp $0f
	jr nz, .done

;> entry = wBigCellTable + lo(pos) * 2
	pop hl
	push hl
	ld b, $00
	ld c, l
	sla c
	rl b
;> key = hi(pos) ^ 0xC0
	ld a, $c0
	xor h
	ld hl, wBigCellTable
	add hl, bc
	ld b, a
;> if mem[entry] == key: return mem[entry + 1]
	ld a, [hli]
	cp b
	jr nz, .search_list

	ld a, [hl]
	jr .done

.search_list
;> key = hi(pos) ^ 0xC0
	pop bc
	push bc
	ld a, $c0
	xor b
	ld b, a
;> entry = wBigCellList
	ld hl, wBigCellList

;>@list while True:                           # 3-byte entries (high, low, type)
.list
;>     if mem[entry] == key:
	ld a, [hli]
	cp b
	jr z, .key_matches

	inc hl
	jr .next_entry

.key_matches
;>         if mem[entry + 1] == lo(pos):
	ld a, [hli]
	cp c
	jr nz, .next_entry

;>             return mem[entry + 2]
	ld a, [hl]
	jr .done

.next_entry
;>     entry += 3
	inc hl
;=@list
	jr .list

.done
	pop hl

.return
	pop de
	ret


;@ def GetCellNibble(pos: hl) -> a
;@ path: map/cells
;@ The raw 4-bit map value at map position pos (15 for the bigger cell types), without
;@ the off-map check.
;@ test: pos = rand(0xC000, 0xDF3F)
;@ sig: 56d0a162
GetCellNibble::
;> # (keeps bc, de, hl)
	push bc
	push de
	push hl
;> high = hi(pos) < 0xD0                      # $C000-$CF9F: high nibbles, the rest low ones
	bit 4, h
	jr nz, .low_nibble

;> if hi(pos) == 0xCF: high = lo(pos) < 0xA0
	ld a, h
	cp $cf
	jr nz, .high_nibble

	ld a, l
	cp $a0
	jr nc, .low_nibble

;> if high:
.high_nibble
;>     nib = mem[pos] >> 4
	ld a, [hl]
	swap a
	jr .done

;> else:
.low_nibble
;>     nib = mem[pos - 0x0FA0]
	push hl
	pop de
	ld hl, $0FA0
	call SubDE
	ld a, [de]

.done
;> return nib & 0x0F
	and $0f
	pop hl
	pop de
	pop bc
	ret


;@ def RaiseMaxHP(rec: hl)
;@ path: combat/reward
;@ Rewards a defeated monster: the maximum hit points grow by (kind + 1) * 4, kind being
;@ the record's byte +1, up to 65535.
;@ writes: hMaxHPHi, hMaxHPLo
;@ reads: hMaxHPHi, hMaxHPLo
;@ sig: a1cce30f
RaiseMaxHP::
;> gain = u8((mem[rec + 1] + 1) * 4)
	inc hl
	ld e, [hl]
	inc e
	sla e
	sla e
	ld d, $00
;> total = (hMaxHPHi << 8 | hMaxHPLo) + gain
	ldh a, [hMaxHPHi]
	ld h, a
	ldh a, [hMaxHPLo]
	ld l, a
	call AddDE
;> if total > 0xFFFF: total = 0xFFFF
	jr nc, .store

	ld de, $ffff

.store
;> hMaxHPHi = hi(total); hMaxHPLo = lo(total)
	ld a, d
	ldh [hMaxHPHi], a
	ld a, e
	ldh [hMaxHPLo], a
	ret


;@ def LoadFireHitTiles()
;@ path: gfx/tiles
;@ Loads the sprite tiles shown after the dragon's fire has hit the hero (hHeroFlags bit
;@ 5): 28 tiles from $6432 to $8000, then two tiles each from $65F2, $6612 and $6632 to
;@ $81E0, $8280 and $8380. Copies at most 64 bytes a frame.
;@ test: skip waits for VBlank frames
;@ sig: f2d18a8a
LoadFireHitTiles::
;> src, dest = CopyTiles8(0x6432, 0x8000)
	ld de, FireHitTiles
	ld hl, $8000
	call CopyTiles8
;> src, dest = CopyTiles8(src, dest)
	call CopyTiles8
;> src, dest = CopyTiles8(src, dest)
	call CopyTiles8
;> CopyTiles4(src, dest)
	call CopyTiles4
;> WaitFrame()
	call WaitFrame
;> copy(0x81E0, 0x65F2, 0x20)
	ld de, FireHitTiles + $1C0
	ld hl, $81e0
	ld b, $20
	call CopyB
;> copy(0x8280, 0x6612, 0x20)
	ld de, FireHitTiles + $1E0
	ld hl, $8280
	ld b, $20
	call CopyB
;> WaitFrame()
	call WaitFrame
;> copy(0x8380, 0x6632, 0x20)
	ld de, FireHitTiles + $200
	ld hl, $8380
	ld b, $20
	call CopyB
	ret


;@ def LoadTile3E()
;@ path: gfx/tiles
;@ Replaces background tile $3E with the 16 bytes at $5E62 (in the next VBlank).
;@ test: skip waits for a VBlank frame
;@ sig: 8759ff76
LoadTile3E::
;> WaitFrame()
	ld de, DottedFloorTile
	ld hl, $93e0
	call WaitFrame
;> copy(0x93E0, 0x5E62, 0x10)
	ld b, $10
	call CopyB
	ret


;@ def SetCell(value: a, pos: de)
;@ path: map/cells
;@ Puts cell type value (0-15) at map position pos, and draws it when it is on or near
;@ the screen.
;@ test: skip waits for a VBlank frame
;@ sig: 59adb45a
SetCell::
;> if GetViewCell(pos)[0]:
	push af
	call GetViewCell
	push de
	pop hl
	or a
	jr z, .hidden

;>     SetCellAndDraw(value, pos)
	pop af
	call SetCellAndDraw
	ret


;> else:
.hidden
;>     SetCellNibble(pos, value)
	pop af
	call SetCellNibble
	ret


;@ def SetCellAndDraw(value: a, pos: hl)
;@ path: map/cells
;@ Puts cell type value (0-15) at map position pos and draws it.
;@ test: skip waits for a VBlank frame
;@ sig: a2582239
SetCellAndDraw::
;> SetCellNibble(pos, value)
	push af
	push hl
	call SetCellNibble
	pop hl
	pop af
;> DrawCellAt(value, pos)

;@ def DrawCellAt(cell: a, pos: hl)
;@ path: map/draw
;@ Draws the picture of cell type cell at map position pos (which must be on or near the
;@ screen).
;@ test: skip waits for a VBlank frame
;@ sig: 9304f714
DrawCellAt::
;> DrawCellAtDE(cell, pos)
	push hl
	pop de

;@ def DrawCellAtDE(cell: a, pos: de)
;@ path: map/draw
;@ Draws the picture of cell type cell at map position pos (on or near the screen) in
;@ the next VBlank.
;@ test: skip waits for a VBlank frame
;@ sig: f1bb7886
DrawCellAtDE::
;> dest = MapPosToBG(pos)
	push bc
	push af
	call MapPosToBG
	pop af
;> DrawMetatileNextFrame(cell, dest)
	push hl
	call DrawMetatileNextFrame
	pop hl
	pop bc
	ret


;@ def DrawMetatileNextFrame(cell: a, dest: hl)
;@ path: map/draw
;@ Waits for the next VBlank (holding off the handler's joypad work), then draws cell
;@ picture cell into the background map at dest.
;@ writes: hSysFlags
;@ reads: hSysFlags
;@ test: skip waits for a VBlank frame
;@ sig: 8670a7bc
DrawMetatileNextFrame::
;> hSysFlags |= 0x01
	push af
	ldh a, [hSysFlags]
	set 0, a
	ldh [hSysFlags], a
;> WaitFrame()
	call WaitFrame
	pop af
;> DrawMetatile(cell, dest)

;@ def DrawMetatile(cell: a, dest: hl)
;@ path: map/draw
;@ Writes the 2x2 tiles of cell picture cell into the background map at dest: CellTiles
;@ holds 4 tiles per picture (top left, top right, bottom left, bottom right).
;@ test: cell = rand(0, 63); dest = rand(0x9800, 0x9BDE)
;@ sig: fccbcc24
DrawMetatile::
;> offset = u8(cell * 4)
	sla a
	sla a
;> tiles = CellTiles + offset
	push hl
	ld hl, CellTiles
	ld b, $00
	ld c, a
	add hl, bc
;> mem[dest] = mem[tiles]
	pop de
	ld a, [hli]
	ld [de], a
;> mem[dest + 1] = mem[tiles + 1]
	inc de
	ld a, [hli]
	ld [de], a
;> mem[dest + 0x21] = mem[tiles + 3]
	ld a, [hli]
	ld c, a
	ld a, [hl]
	ld hl, $0020
	add hl, de
	ld [hl], a
;> mem[dest + 0x20] = mem[tiles + 2]
	dec hl
	ld [hl], c
	ret


;@ def SetCellNibble(pos: hl, value: a)
;@ path: map/cells
;@ Stores value (0-15) in the map's 4 bits for position pos, keeping the other nibble of
;@ the byte.
;@ test: pos = rand(0xC000, 0xDF3F); value = rand(0, 15)
;@ sig: f216d131
SetCellNibble::
;> # (keeps de, hl)
	push de
	push hl
	push af
;> high = hi(pos) < 0xD0                      # $C000-$CF9F: high nibbles, the rest low ones
	bit 4, h
	jr nz, .low_nibble

;> if hi(pos) == 0xCF: high = lo(pos) < 0xA0
	ld a, h
	cp $cf
	jr nz, .high_nibble

	ld a, l
	cp $a0
	jr nc, .low_nibble

;> if high:
.high_nibble
;>     addr = pos; keep = mem[pos] & 0x0F
	ld a, [hl]
	and $0f
	ld b, a
;>     nib = swap(value)
	pop af
	swap a
	jr .store

;> else:
.low_nibble
;>     addr = pos - 0x0FA0
	push hl
	pop de
	ld hl, $0FA0
	call SubDE
	push de
	pop hl
;>     keep = mem[addr] & 0xF0; nib = value
	ld a, [hl]
	and $f0
	ld b, a
	pop af

.store
;> mem[addr] = keep | nib
	or b
	ld [hl], a
	pop hl
	pop de
	ret


;@ def SaveAndCopyByte(dest: hl, save: bc, src: de) -> (hl, bc, de)
;@ path: system/memory
;@ Saves the byte at dest to save, overwrites it with the byte at src, and advances all
;@ three pointers.
;@ test: dest = rand(0xC000, 0xDF00); save = rand(0xC000, 0xDF00)
;@ sig: cd89b84a
SaveAndCopyByte::
;> mem[save] = mem[dest]
	ld a, [hl]
	ld [bc], a
;> mem[dest] = mem[src]
	ld a, [de]
	ld [hli], a
;> return dest + 1, save + 1, src + 1
	inc bc
	inc de
	ret


;@ def CopyByte(dest: hl, src: de) -> (hl, de)
;@ path: system/memory
;@ Copies one byte and advances both pointers.
;@ test: dest = rand(0xC000, 0xDF00)
;@ sig: a67ec1ef
CopyByte::
;> mem[dest] = mem[src]
	ld a, [de]
	ld [hli], a
;> return dest + 1, src + 1
	inc de
	ret


;@ def FillObjectRecord(obj: hl, dir: b, pos: de)
;@ path: monsters/move
;@ Writes a monster's new state into its record (obj points at the flags byte, +1): the
;@ direction to +3 and the map position to +4/+5. When it is on screen (hTemp1 = its
;@ distance from the hero, 1-4, from ObjDistance) it is counted in hVisibleObjects, its
;@ grid cell (hObjRow+1, hObjCol+1 as nibbles) goes to +0, bit 7 of +1 is set when hTemp2
;@ bit 0 is, and distance - 1 is or-ed into bits 6-7 of +2. Off screen +0 becomes 0.
;@ reads: hObjCol, hObjRow, hTemp1, hTemp2
;@ test: obj = rand(0xD57C, 0xD8E0); hTemp1 = rand(0, 4)
;@ sig: d6b59095
FillObjectRecord::
;> if hTemp1 == 0:                            # off screen
	ldh a, [hTemp1]
	or a
	jr nz, .visible

;>     mem[obj - 1] = 0
	dec hl
	xor a
	ld [hli], a
	inc hl
	inc hl
	jr .tail

;> else:
.visible
;>     hVisibleObjects += 1
	push de
	push hl
	ld hl, hVisibleObjects
	inc [hl]
	pop hl
	dec hl
;>     cell = (hObjRow + 1) << 4
	ldh a, [hObjRow]
	inc a
	sla a
	sla a
	sla a
	sla a
;>     mem[obj - 1] = cell | (hObjCol + 1)
	ld d, a
	ldh a, [hObjCol]
	inc a
	or d
	ld [hli], a
	pop de
;>     if hTemp2 & 0x01: mem[obj] |= 0x80
	ldh a, [hTemp2]
	bit 0, a
	jr z, .distance

	set 7, [hl]

.distance
;>     mem[obj + 1] |= (hTemp1 - 1) << 6
	inc hl
	ldh a, [hTemp1]
	dec a
	sra a
	rra
	rra
;>     # (bits 6-7: 0 next to the hero ... 3 at the screen's edge)
	or [hl]
	ld [hli], a

.tail
;> mem[obj + 2] = dir
	ld a, b
	ld [hli], a
;> mem[obj + 3] = hi(pos); mem[obj + 4] = lo(pos)
	ld [hl], d
	inc hl
	ld [hl], e
	ret


;@ def LoadAltTiles()
;@ path: gfx/tiles
;@ Loads the sprite tile set used while hSysFlags bit 6 is set, from $6272-$6431 and
;@ $4AB2-$4D11 into $8000-$83DF, spread over several frames.
;@ test: skip waits for VBlank frames
;@ sig: 0ae65a7c
LoadAltTiles::
;> src, dest = CopyTiles4(0x6272, 0x8000)
	ld de, AltSpriteTiles
	ld hl, $8000
	call CopyTiles4
;> src, dest = CopyB(0x30, 0x4AB2, dest)
	ld de, GameTiles + $40
	ld b, $30
	call CopyB
;> WaitFrame()
	call WaitFrame
;> src, dest = CopyB(0x30, src, dest)
	ld b, $30
	call CopyB
;> src, dest = CopyTiles4(0x62B2, dest)
	ld de, $62b2
	call CopyTiles4
;> WaitFrame()
	call WaitFrame
;> src, dest = CopyB(0x20, src, dest)
	ld b, $20
	call CopyB
;> src, dest = CopyTiles4(0x4B72, dest)
	ld de, GameTiles + $100
	call CopyTiles4
;> CopyTiles8(0x6312, dest)
	ld de, $6312
	call CopyTiles8
;> WaitFrame()
	call WaitFrame
;> copy(0x81E0, 0x4C52, 0x20)
	ld de, GameTiles + $1E0
	ld hl, $81e0
	ld b, $20
	call CopyB
;> copy(0x8280, 0x4CF2, 0x20)
	ld de, GameTiles + $280
	ld hl, $8280
	ld b, $20
	call CopyB
;> WaitFrame()
	call WaitFrame
;> copy(0x82A0, 0x6392, 0x30)
	ld de, $6392
	ld hl, $82a0
	ld b, $30
	call CopyB
;> WaitFrame()
	call WaitFrame
;> copy(0x82D0, 0x63C2, 0x30)
	ld b, $30
	call CopyB
;> WaitFrame()
	call WaitFrame
;> copy(0x8380, 0x63F2, 0x20)
	ld de, $63f2
	ld hl, $8380
	ld b, $20
	call CopyB
;> copy(0x83C0, 0x6412, 0x20)
	ld de, $6412
	ld hl, $83c0
	ld b, $20
	call CopyB
	ret


;@ def CopyTiles8(src: de, dest: hl) -> (de, hl)
;@ path: gfx/tiles
;@ Copies 8 tiles (128 bytes) to VRAM, 4 tiles in each of the next two VBlanks.
;@ test: skip waits for VBlank frames
;@ sig: fd685848
CopyTiles8::
;> src, dest = CopyTiles4(src, dest)
	call CopyTiles4
;> return CopyTiles4(src, dest)
	call CopyTiles4
	ret


;@ def CopyTiles4(src: de, dest: hl) -> (de, hl)
;@ path: gfx/tiles
;@ Copies 4 tiles (64 bytes) to VRAM in the next VBlank.
;@ test: skip waits for a VBlank frame
;@ sig: 5db93634
CopyTiles4::
;> hSysFlags |= 0x01
	push hl
	ld hl, hSysFlags
	set 0, [hl]
	pop hl
;> WaitFrame()
	ld b, $40
	call WaitFrame
;> return CopyB(0x40, src, dest)
	call CopyB
	ret


;@ def InitHeroSprite()
;@ path: player/sprite
;@ Clears all sprites and puts the hero's sprite pair in the middle of the view (cell
;@ row 4, column 5) with tile 0.
;@ sig: 733a3669
InitHeroSprite::
;> ClearOtherSprites()
	call ClearOtherSprites
;> SetSpritePair(0, 0x0405, wOAMBuffer)
	ld de, $0405
	ld a, $00
	ld hl, wOAMBuffer
	jr SetSpritePair

;@ def SetHeroSpriteDir()
;@ path: player/sprite
;@ Turns the hero's picture to hHeroDir: right tiles $08/$18, left the same mirrored,
;@ up $06/$14, otherwise (down or standing) $00/$12.
;@ writes: wOAMBuffer
;@ reads: hHeroDir
;@ sig: 4a8b5f1b
SetHeroSpriteDir::
;> if hHeroDir & 0x10:                        # right
	push hl
	ldh a, [hHeroDir]
	ld de, $0000
	ld h, $12
	bit 4, a
	jr z, .notRight

;>     tile, flags, other = 0x08, 0x00, 0x10   # right tile = tile ^ other
	ld d, $08
	jr .pair10

;> elif hHeroDir & 0x20:                      # left: mirrored
.notRight
	bit 5, a
	jr z, .notLeft

;>     tile, flags, other = 0x18, 0x20, 0x10
	ld de, $1820

.pair10
	ld h, $10
	jr .store

;> elif hHeroDir & 0x40:                      # up
.notLeft
	bit 6, a
	jr z, .store

;>     tile, flags, other = 0x06, 0x00, 0x12
	ld d, $06
	ld h, $12

;> else:
;>     tile, flags, other = 0x00, 0x00, 0x12
.store
;> wOAMBuffer[2] = tile; wOAMBuffer[3] = flags
	ld a, d
	ld [wOAMBuffer + 2], a
	ld a, e
	ld [wOAMBuffer + 3], a
;> wOAMBuffer[6] = tile ^ other
	ld a, d
	xor h
	ld [wOAMBuffer + 6], a
;> wOAMBuffer[7] = flags
	ld a, e
	ld [wOAMBuffer + 7], a
	pop hl
	ret


;@ def SetSpritePair(tile: a, rowcol: de, dest: hl) -> hl
;@ path: gfx/sprites
;@ Fills two sprite entries at dest for a 16x16 object standing on screen cell (row d,
;@ column e): the left half with tile, the right half 8 pixels further with tile + $10.
;@ test: dest = rand(0xD000, 0xD098)
;@ sig: 45d4992f
SetSpritePair::
;> y = hi(rowcol) * 16 + 16
	push af
	ld a, d
	sla a
	sla a
	sla a
	sla a
;> mem[dest] = y
	add $10
	ld [hl], a
	inc hl
;> x = lo(rowcol) * 16 + 8
	ld d, a
	ld a, e
	sla a
	sla a
	sla a
	sla a
;> mem[dest + 1] = x
	add $08
	ld [hl], a
	inc hl
;> x2 = x + 8                                  # the right half
	add $08
	ld e, a
;> mem[dest + 2] = tile
	pop af
	ld [hl], a
	inc hl
;> mem[dest + 3] = 0
	ld b, $00
	ld [hl], b
	inc hl
;> return SetSprite(y, x2, tile + 0x10, dest + 4)
	add $10

;@ def SetSprite(y: d, x: e, tile: a, dest: hl) -> hl
;@ path: gfx/sprites
;@ Fills one sprite entry at dest (Y, X, tile, no flags) and returns the next entry.
;@ test: dest = rand(0xD000, 0xD09C)
;@ sig: e3c001e2
SetSprite::
;> mem[dest] = y; mem[dest + 1] = x
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
;> mem[dest + 2] = tile; mem[dest + 3] = 0
	ld [hli], a
	xor a
	ld [hli], a
;> return dest + 4
	ret


;@ def ClearOtherSprites()
;@ path: gfx/sprites
;@ Empties all sprite entries except the hero's two.
;@ sig: bbbe8654
ClearOtherSprites::
;> ClearSprites(38, wOAMBuffer + 8)
	ld b, $26
	ld hl, wOAMBuffer + 8

;@ def ClearSprites(count: b, dest: hl) -> hl
;@ path: gfx/sprites
;@ Zeroes count sprite entries (4 bytes each) from dest on.
;@ test: count = rand(1, 40); dest = rand(0xC000, 0xC800)
;@ sig: e7555a66
ClearSprites::
;> for _ in range(count):
	xor a

.loop
;>     fill(dest, 0, 4); dest += 4
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	dec b
	jr nz, .loop

;> return dest
	ret


;@ def SwapByte(a: hl, b: de) -> (hl, de)
;@ path: system/memory
;@ Exchanges the bytes at a and b and advances both pointers.
;@ test: a = rand(0xC000, 0xDF00); b = rand(0xC000, 0xDF00)
;@ sig: 76668e4e
SwapByte::
;> mem[a], mem[b] = mem[b], mem[a]
	ld a, [hl]
	ld b, a
	ld a, [de]
	ld [hli], a
	ld a, b
	ld [de], a
;> return a + 1, b + 1
	inc de
	ret


;@ def CopyBC(src: de, dest: hl, count: bc) -> (de, hl)
;@ path: system/memory
;@ Copies count bytes (1-65536; 0 copies 65536) from src to dest.
;@ test: count = rand(1, 64); dest = rand(0xC000, 0xD000); src = rand(0x0000, 0x7F00)
;@ sig: 32b91a4a
CopyBC::
;> copy(dest, src, count)
	ld a, [de]
	ld [hli], a
	inc de
	dec bc
	ld a, b
	or c
;> return src + count, dest + count
	jr nz, CopyBC

	ret


;@ def CopyB(count: b, src: de, dest: hl) -> (de, hl)
;@ path: system/memory
;@ Copies count bytes (0-255) from src to dest.
;@ test: dest = rand(0xC000, 0xD000)
;@ sig: 369a45b3
CopyB::
;> copy(dest, src, count)
	inc b

.loop
	dec b
	ret z

	ld a, [de]
	ld [hli], a
	inc de
;> return src + count, dest + count
	jr .loop

;@ def CopyTilePairs(rows: a, src: de, dest: hl, gap: bc) -> de
;@ path: gfx/bgmap
;@ Copies rows pairs of bytes from src, each pair to dest and then gap bytes further on:
;@ with gap $1E a column two tiles wide goes down the background map.
;@ test: rows = rand(0, 18); dest = rand(0x9800, 0x9A00); gap = 0x1E
;@ sig: 11652e7e
CopyTilePairs::
;> for _ in range(rows):
	inc a

.loop
	dec a
	ret z

;>     mem[dest] = mem[src]; mem[dest + 1] = mem[src + 1]
	push af
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
;>     src += 2; dest += 2 + gap
	inc de
	add hl, bc
	pop af
	jr .loop
;> return src

;@ def UnpackMap(src: de)
;@ path: map/unpack
;@ Unpacks a phase's world map from a bit stream (read from the top bit of each byte
;@ down) into wMap, all 8000 cells in order. The first cell starts with a code; after
;@ each cell one bit follows: 0 = the next cell is the same type again, 1 = a new code
;@ follows. A code is "1x" for type x (0 or 1) or "0xxxxx" for a 5-bit type 0-31.
;@ Types 15 and up are stored as nibble 15 plus an entry in wBigCellTable (keyed by
;@ the low address byte), or in wBigCellList when that slot is taken; a list entry
;@ skips the nibble write.
;@ test: skip unpacks 8000 cells
;@ sig: ec6b4125
UnpackMap::
;> fill(wBigCellTable, 0xFF, 0x200)
	push de
	ld hl, wBigCellTable
	ld d, $ff
	ld bc, $0200
	call FillMem
;> fill(wBigCellList, 0xFF, 0x60)
	ld hl, wBigCellList
	ld d, $ff
	ld bc, $0060
	call FillMem
;> pos = wMap; bits = 0                       # bits left in the current byte
	pop de
	ld hl, wMap
	ld c, $00

;>@cells while True:                          # read a code
.code
;>     if ReadMapBit():
	xor a
	call ReadMapBit
	jr c, .short_code

;>@short         cell = ReadMapBit()         # "1x": type 0 or 1
;>     else:
;>         cell = 0
	push hl
	ld h, $05

.bits5
;>         for _ in range(5):                  # "0xxxxx": a 5-bit type
;>             cell = cell << 1 | ReadMapBit()
	call ReadMapBit
	rla
	dec h
	jr nz, .bits5

	pop hl
	jr .store

.short_code
;=@short
	call ReadMapBit
	rla

;>@same     while True:                        # store cells of this type
.store
;>         # (bits, cell, src and pos wait on the stack)
	push bc
	push af
	push de
	push hl
;>         if cell >= 15:
	ld b, a
	add $f1
	jr nc, .nibble

;>             slot = wBigCellTable + lo(pos) * 2
	sla l
	ld h, $00
	rl h
	ld de, wBigCellTable
	add hl, de
;>             if mem[slot] == 0xFF:
	ld a, [hl]
	cp $ff
	jr nz, .to_list

;>                 mem[slot] = hi(pos) & 0x1F
	pop de
	push de
	ld a, d
	and $1f
	ld [hli], a
;>                 mem[slot + 1] = cell
	ld [hl], b
	jr .nibble

;>             else:
.to_list
;>                 entry = wBigCellList
	ld hl, wBigCellList
	ld de, $0003
	ld a, $ff

;>                 while mem[entry] != 0xFF: entry += 3
.find_free
	cp [hl]
	jr z, .free

	add hl, de
	jr .find_free

.free
;>                 mem[entry] = hi(pos); mem[entry + 1] = lo(pos)
	pop de
	push de
	ld [hl], d
	inc hl
	ld [hl], e
;>                 mem[entry + 2] = cell
	inc hl
	ld [hl], b
	jr .advance

.nibble
;>         nib = cell
	pop hl
	push hl
	ld a, b
;>         if cell >= 15: nib = 15
	add $f1
	jr nc, .first_half

	ld b, $0f

.first_half
;>         high = hi(pos) < 0xD0               # $C000-$CF9F: high nibbles, the rest low ones
	bit 4, h
	jr nz, .second_half

;>         if hi(pos) == 0xCF: high = lo(pos) < 0xA0
	ld a, h
	cp $cf
	jr nz, .high_nibble

	ld a, l
	cp $a0
	jr nc, .second_half

;>         if high:
.high_nibble
;>             mem[pos] = nib << 4             # (the low nibble is filled later)
	ld a, b
	swap a
	ld [hl], a
	jr .advance

;>         else:
.second_half
;>             addr = pos - 0x0FA0
	push hl
	pop de
	ld hl, $0FA0
	call SubDE
;>             mem[addr] |= nib
	ld a, [de]
	or b
	ld [de], a

.advance
;>         pos += 1
	pop hl
	pop de
	inc hl
;>         if pos == 0xDF40:
	ld a, $df
	cp h
	jr nz, .next

	ld a, $40
	cp l
	jr nz, .next

;>             return
	pop af
	pop bc
	ret


.next
;>         if ReadMapBit(): break              # 1: a new code follows; 0: the same type again
	pop af
	pop bc
	call ReadMapBit
;=@same
	jp nc, .store

;=@cells
	jp .code


;@ def ReadMapBit() -> carry
;@ path: map/unpack
;@ The next bit of UnpackMap's stream (src in de, the current byte in b, bits left in c),
;@ top bit first; fetches the next byte when the current one is used up.
;@ test: skip works on the caller's registers
;@ sig: 314b5f6b
ReadMapBit::
;> if bits == 0:
	inc c
	dec c
	jr nz, .take

;>     byte = mem[src]; src += 1; bits = 8
	push af
	ld a, [de]
	ld b, a
	pop af
	inc de
	ld c, $08

.take
;> bit = byte >> 7; byte = u8(byte << 1); bits -= 1
	sla b
	dec c
;> return bit
	ret


;@ def BuildViewRow(pos: hl, dest: de)
;@ path: map/scroll
;@ Builds the tiles of 11 map cells in a row from pos: their top tiles to dest (22
;@ bytes), their bottom tiles 32 bytes further on.
;@ sig: f9d39130
BuildViewRow::
;>@loop for _ in range(11):
	ld b, $0c

.loop
	dec b
	ret z

;>     cell = GetCell(pos)
	push bc
	push hl
	call GetCell
;>     tiles = CellTiles + cell * 4
	sla a
	sla a
	ld hl, CellTiles
	ld b, $00
	ld c, a
	add hl, bc
;>     mem[dest] = mem[tiles]                  # top left
	ld a, [hli]
	ld [de], a
;>     right = mem[tiles + 1]; low_left = mem[tiles + 2]
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
;>     low_right = mem[tiles + 3]
	ld a, [hl]
	push de
;>     mem[dest + 0x20] = low_left
	ld hl, $0020
	add hl, de
	ld [hl], c
;>     mem[dest + 0x21] = low_right
	inc hl
	ld [hl], a
	pop de
;>     mem[dest + 1] = right; dest += 2
	inc de
	ld a, b
	ld [de], a
	inc de
;>     pos += 1
	pop hl
	inc hl
;=@loop
	pop bc
	jr .loop

;@ def BuildViewColumn(pos: hl, dest: de)
;@ path: map/scroll
;@ Builds the tiles of 9 map cells in a column from pos downwards: 4 bytes per cell
;@ (top left, top right, bottom left, bottom right) to dest.
;@ test: pos = rand(0xC000, 0xDF3F - 8 * 80); dest = rand(0xC000, 0xDFD0)
;@ test: for k in range(9): mem[wBigCellList + 3 * k] = ((pos + 80 * k) >> 8) ^ 0xC0; mem[wBigCellList + 3 * k + 1] = (pos + 80 * k) & 0xFF
;@ sig: 6f25a7ce
BuildViewColumn::
;>@loop for _ in range(9):
	ld b, $0a

.loop
	dec b
	ret z

;>     cell = GetCell(pos)
	push bc
	push hl
	call GetCell
;>     tiles = CellTiles + u8(cell * 4)           # (the offset is only 8 bits wide)
	sla a
	sla a
	ld hl, CellTiles
	ld b, $00
	ld c, a
	add hl, bc
;>     copy(dest, tiles, 4); dest += 4
	ld b, $04

.copy
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy

;>     pos += 80                               # the cell below
	pop hl
	ld bc, $0050
	add hl, bc
;=@loop
	pop bc
	jr .loop

;@ def RestoreObjectSprites()
;@ path: gfx/sprites
;@ Puts back the object sprites saved in wSavedObjSprites: hOAMCount - 1 sprite pairs
;@ after the hero's.
;@ reads: hOAMCount
;@ sig: ead21660
RestoreObjectSprites::
;> pairs = hOAMCount - 1
	ldh a, [hOAMCount]
	ld b, a
	dec b
;> if pairs == 0: return
	ret z

;> size = u8(pairs * 8)
	sla b
	sla b
	sla b
;> copy(wOAMBuffer + 8, wSavedObjSprites, size)
	ld de, wSavedObjSprites
	ld hl, wOAMBuffer + 8
	call CopyB
	ret


;@ def GetHeroPos() -> hl
;@ path: player/position
;@ The hero's map position.
;@ reads: hHeroPosHi, hHeroPosLo
;@ sig: fb40e4c0
GetHeroPos::
;> return hHeroPosHi << 8 | hHeroPosLo
	ldh a, [hHeroPosHi]
	ld h, a
	ldh a, [hHeroPosLo]
	ld l, a
	ret


;@ def GetPosAhead() -> (hl, carry)
;@ path: player/position
;@ The map position one step from the hero in hHeroDir; carry when it is off the map.
;@ sig: 6b5c5298
GetPosAhead::
;> return StepPos(GetHeroPos())
	call GetHeroPos
	call StepPos
	ret


;@ def GetPosTwoAhead() -> (hl, de, carry)
;@ path: player/position
;@ The map positions two steps and one step ahead of the hero in hHeroDir; carry when
;@ either is off the map.
;@ sig: 12a408cf
GetPosTwoAhead::
;> one, off = StepPos(GetHeroPos())
	call GetHeroPos
	call StepPos
;> if off: return one, GetDirStep()[2], True   # de still holds the step from GetDirStep
	ret c

;> two, off = StepPos(one)
	push hl
	call StepPos
;> return two, one, off
	pop de
	ret


;@ def StepPos(pos: hl) -> (hl, carry)
;@ path: player/position
;@ pos moved one step in hHeroDir; carry when the result is off the map.
;@ sig: 17f8faa2
StepPos::
;> dy, dx, delta = GetDirStep()
	call GetDirStep
;> pos = u16(pos + delta)
	add hl, de
;> return pos, IsOffMap(pos)
	call IsOffMap
	ret


;@ def StepPosByDir(dir: b, pos: de) -> de
;@ path: monsters/move
;@ pos moved one step in a packed direction (row step in the high nibble, column step in
;@ the low one, each 1 or -1 = $F; see RandomDirection).
;@ sig: 09399ab6
StepPosByDir::
;> delta = 0
	ld hl, $0000
;> if dir & 0x80: delta = -80                 # up
	bit 7, b
	jr z, .down

	ld hl, -80
	jr .horizontal

.down
;> elif dir & 0x10: delta = 80                # down
	bit 4, b
	jr z, .horizontal

	ld hl, $0050

.horizontal
;> if dir & 0x08: delta -= 1                  # left
	bit 3, b
	jr z, .right

	dec hl
	jr .add

.right
;> elif dir & 0x01: delta += 1                # right
	bit 0, b
	jr z, .add

	inc hl

.add
;> return u16(pos + delta)
	add hl, de
	push hl
	pop de
	ret


;@ def GetDirStep() -> (b, c, de)
;@ path: player/position
;@ The step for hHeroDir: row step dy, column step dx (each -1, 0 or 1) and the map
;@ position change dy * 80 + dx.
;@ reads: hHeroDir
;@ sig: 89ce811b
GetDirStep::
;> dy, dx, delta = 0, 0, 0
	ldh a, [hHeroDir]
	ld bc, $0000
	ld de, $0000
;> if hHeroDir & 0x80: dy, delta = 1, 80      # down
	bit 7, a
	jr z, .up

	ld b, $01
	ld de, $0050

.up
;> if hHeroDir & 0x40: dy, delta = -1, -80    # up
	bit 6, a
	jr z, .right

	ld b, $ff
	ld de, -80

.right
;> if hHeroDir & 0x10: dx = 1; delta += 1     # right
	bit 4, a
	jr z, .left

	ld c, $01
	inc de

.left
;> if hHeroDir & 0x20: dx = -1; delta -= 1    # left
	bit 5, a
	jr z, .done

	ld c, $ff
	dec de

.done
;> return u8(dy), u8(dx), u16(delta)
	ret


;@ def RandomDirection(seed: hl, flags: f) -> (b, c)
;@ path: monsters/move
;@ One of the 8 directions at random. Returns it packed (row step in the high nibble,
;@ column step in the low one, -1 written as $F) and the low byte of the matching map
;@ position change (e.g. $B0 = -80 for up). seed and flags go on to Random.
;@ test: flags = rand(0, 15) << 4
;@ sig: 8cd5b1db
RandomDirection::
;> r = Random(seed, flags)
	call Random
;> if r < 0x20: return 0xF0, 0xB0             # up
	sub $20
	jr nc, .r40

	ld bc, $f0b0
	ret


.r40
;> elif r < 0x40: return 0xF1, 0xB1           # up right
	sub $20
	jr nc, .r60

	ld bc, $f1b1
	ret


.r60
;> elif r < 0x60: return 0x01, 0x01           # right
	sub $20
	jr nc, .r80

	ld bc, $0101
	ret


.r80
;> elif r < 0x80: return 0x11, 0x51           # down right
	sub $20
	jr nc, .rA0

	ld bc, $1151
	ret


.rA0
;> elif r < 0xA0: return 0x10, 0x50           # down
	sub $20
	jr nc, .rC0

	ld bc, $1050
	ret


.rC0
;> elif r < 0xC0: return 0x1F, 0x4F           # down left
	sub $20
	jr nc, .rE0

	ld bc, $1f4f
	ret


.rE0
;> elif r < 0xE0: return 0x0F, 0xFF           # left
	sub $20
	jr nc, .rest

	ld bc, $0fff
	ret


.rest
;> else: return 0xFF, 0xAF                    # up left
	ld bc, $ffaf
	ret


;@ def MapPosToBG(pos: de) -> hl
;@ path: map/view
;@ The background map address of the top-left tile of a map cell on or near the
;@ screen: its row and column are counted from two cells above and left of the view,
;@ then laid onto the background map at the scroll position (hScrollRow, hScrollCol),
;@ wrapping round the 32x32-tile map.
;@ reads: hScrollCol, hScrollRow
;@ test: hViewPosHi = rand(0xC4, 0xD8); hViewPosLo = rand(0, 255); hScrollRow = rand(0, 15); hScrollCol = rand(0, 15); pos = (hViewPosHi << 8 | hViewPosLo) - 162 + rand(0, 1050)
;@ sig: 3296e0ce
MapPosToBG::
;> off = u16(pos - (GetViewPos() - 2 * 80 - 2))
	call GetViewPos
	ld bc, $ff5e
	add hl, bc
	call SubDE
;> row = 0
	ld hl, $0050
	ld b, $00

;> while off >= 80: off -= 80; row += 1
.rows
	call SubDE
	jr c, .found_row

	inc b
	jr .rows

.found_row
;> if off < 64:
	ld a, e
	cp $f0
	jr nc, .left_edge

;>     col = off
	call AddDE
	jr .row_addr

;> else:                                      # counted as left of the grid, two rows on
.left_edge
;>     col = u16(off - 80); row += 2
	inc b
	inc b

.row_addr
;> dest = 0x9800
	ld hl, $9800
	ld a, b
	ld bc, $0040
;> dest += row * 0x40
	inc a

.row_mul
	dec a
	jr z, .add_col

	add hl, bc
	jr .row_mul

.add_col
;> dest = u16(dest + (col & 0xFF00 | lo(col << 1)))
	sla e
	add hl, de
;> scroll_row = (hScrollRow - 2) & 0x0F
	ld de, $0040
	ldh a, [hScrollRow]
	sub $02
	jr nc, .scroll_rows

	add $10

.scroll_rows
;> dest += scroll_row * 0x40
	inc a

.scroll_mul
	dec a
	jr z, .wrap

	add hl, de
	jr .scroll_mul

.wrap
;>@wrap if dest >= 0x9C00:                   # wrap round the map's bottom
	push hl
	pop de
	push de
	ld hl, $9c00
	call SubDE
	jr c, .inside

;>     dest -= 0x400
	ld hl, $9800
	call AddDE
	pop hl
	jr .column

.inside
;=@wrap
	pop de

.column
;> low = dest & 0x3F
	ld a, $3f
	and e
	ld l, a
;> scroll_col = (hScrollCol - 2) & 0x0F
	ldh a, [hScrollCol]
	sub $02
	jr nc, .scroll_cols

	add $10

.scroll_cols
;> tile_col = (scroll_col * 2 + low) & 0x1F
	sla a
	add l
	and $1f
	ld l, a
;> return (dest & 0xFFC0) | tile_col          # the cell's top tile row
	ld a, $c0
	and e
	or l
	ld l, a
	ld h, d
	ret


;@ def GetViewPos() -> hl
;@ path: map/view
;@ The map position of the top-left cell on screen.
;@ reads: hViewPosHi, hViewPosLo
;@ sig: 29947b6f
GetViewPos::
;> return hViewPosHi << 8 | hViewPosLo
	ldh a, [hViewPosHi]
	ld h, a
	ldh a, [hViewPosLo]
	ld l, a
	ret


;@ def ViewBGAddr(drow: b, dcol: c) -> hl
;@ path: map/view
;@ The background map address drow tile rows and dcol tile columns from the tile at
;@ the top-left of the view, wrapping round the 32x32-tile map.
;@ reads: hScrollCol, hScrollRow
;@ sig: 89c38a07
ViewBGAddr::
;> row = (hScrollRow * 2 + drow) & 0x1F
	push bc
	push de
	ldh a, [hScrollRow]
	sla a
	add b
	and $1f
;> col = (hScrollCol * 2 + dcol) & 0x1F
	ld d, a
	ldh a, [hScrollCol]
	sla a
	add c
	and $1f
;> addr = 0x9800
	ld e, a
	ld bc, $0020
	ld hl, $9800
;> addr += row * 0x20
	inc d

.mul
	dec d
	jr z, .done

	add hl, bc
	jr .mul

.done
;> return addr + col
	add hl, de
	pop de
	pop bc
	ret


;@ def GetCurObjPos() -> hl
;@ path: monsters/records
;@ The address of the current object's position field.
;@ reads: hCurObjPosHi, hCurObjPosLo
;@ sig: abe68efd
GetCurObjPos::
;> return hCurObjPosHi << 8 | hCurObjPosLo
	ldh a, [hCurObjPosHi]
	ld h, a
	ldh a, [hCurObjPosLo]
	ld l, a
	ret


;@ def GetCurObj() -> hl
;@ path: monsters/records
;@ The address of the current object's record.
;@ reads: hCurObjHi, hCurObjLo
;@ sig: 49a65d28
GetCurObj::
;> return hCurObjHi << 8 | hCurObjLo
	ldh a, [hCurObjHi]
	ld h, a
	ldh a, [hCurObjLo]
	ld l, a
	ret


;@ def EnterHome()
;@ path: player/home
;@ The hero walks into his home (cell type 2). Carrying item $F8 he pushes the house
;@ instead (see BumpRock). Otherwise he is home: with 4 or more pieces carried
;@ hModeFlags bit 0 is set; else the palette turns normal and the hit points are
;@ refilled to the maximum (hit points of 100 and more first count as 100, of which
;@ only the low byte is written back).
;@ writes: hHPHi, hHPLo
;@ reads: hCarriedItem, hHPHi, hHPLo, hMaxHPHi, hMaxHPLo, hPiecesCarried
;@ test: skip ends in the turn loop
;@ sig: 76446afa
EnterHome::
;> if hCarriedItem == 0xF8:                   # pushes the house
	ldh a, [hCarriedItem]
	cp $f8
	jr nz, .home

;>     return TryPushCell(2)
	ld a, $02
	jr TryPushCell

.home
;> hHeroFlags |= 0x10                         # came home this turn
	ld hl, hHeroFlags
	set 4, [hl]
;> if hPiecesCarried >= 4:
	ldh a, [hPiecesCarried]
	cp $04
	jr c, .refill

;>     hModeFlags |= 0x01
	ld hl, hModeFlags
	set 0, [hl]
	jr .walk

;> else:
.refill
;>     rBGP = 0xE4; rOBP0 = 0xE4
	ld a, $e4
	ldh [rBGP], a
	ldh [rOBP0], a
;>     hp = hHPHi << 8 | hHPLo
	ldh a, [hHPHi]
	ld d, a
	ldh a, [hHPLo]
	ld e, a
;>     if hp >= 100:
	push de
	ld hl, $0064
	call SubDE
	jr nc, .high

;>         hHPLo = 100; hp = 100
	ld a, $64
	ldh [hHPLo], a
	pop de
	ld de, $0064
	jr .compare

.high
	pop de

.compare
;>     maxhp = hMaxHPHi << 8 | hMaxHPLo
	ldh a, [hMaxHPHi]
	ld h, a
	ldh a, [hMaxHPLo]
	ld l, a
;>     if hp < maxhp:
	call SubDE
	jr nc, .walk

;>         hHPHi = hi(maxhp); hHPLo = lo(maxhp)
	ld a, h
	ldh [hHPHi], a
	ld a, l
	ldh [hHPLo], a

.walk
;> WalkOn()
	jr WalkOn

;@ def BumpRock()
;@ path: player/push
;@ The hero walks against a rock (cell type 1). Carrying item $F8 he pushes it one cell
;@ on, if the cell behind it is on the map, empty (type 0) and free of monsters; then
;@ he steps into its place. TryPushCell does the same for the house (type 2), which
;@ also moves the home position. Otherwise the turn simply ends.
;@ writes: hHomePosHi, hHomePosLo, hPushFromHi, hPushFromLo, hPushToHi, hPushToLo, hPushedCell
;@ reads: hCarriedItem
;@ test: skip ends in the turn loop
;@ sig: c650b4e5
BumpRock::
;>@bl if hCarriedItem != 0xF8: return TurnEnd()
	ldh a, [hCarriedItem]
	cp $f8
	jr nz, TryPushCell.blocked

;> cell = 1
	ld a, $01

TryPushCell:
;> two, one, off = GetPosTwoAhead()
	push af
	call GetPosTwoAhead
;>@cn if off: return TurnEnd()
	jr c, .cannot

;> if GetCellNibble(two) != 0: return TurnEnd()
	call GetCellNibble
	cp $00
	jr nz, .cannot

;> found, rec = FindObjectAt(two)
	push de
	push hl
	push hl
	pop de
	call FindObjectAt
;> if found: return TurnEnd()                 # a monster stands behind it
	pop hl
	pop de
	xor a
	cp b
	jr z, .push

.cannot
;=@cn
	pop af

.blocked
;=@bl
	jp TurnEnd


.push
;> hPushFromHi = hi(one); hPushFromLo = lo(one)
	ld a, d
	ldh [hPushFromHi], a
	ld a, e
	ldh [hPushFromLo], a
;> hPushToHi = hi(two); hPushToLo = lo(two)
	ld a, h
	ldh [hPushToHi], a
	ld a, l
	ldh [hPushToLo], a
;> if cell == 2:                              # the house moves: so does home
	pop af
	push af
	cp $02
	jr nz, .move

;>     hHomePosHi = hi(two); hHomePosLo = lo(two)
	ld a, h
	ldh [hHomePosHi], a
	ld a, l
	ldh [hHomePosLo], a

.move
;> hPushedCell = cell
	pop af
	ldh [hPushedCell], a
;> SetCellNibble(two, cell)
	call SetCellNibble
;> SetCellNibble(one, 0)
	push de
	pop hl
	ld a, $00
	call SetCellNibble
;> WalkOn()
	jr WalkOn

;@ def WalkOn()
;@ path: player/move
;@ The hero has stepped onto a cell that does nothing special: the after-step checks
;@ run and the turn ends.
;@ test: skip ends in the turn loop
;@ sig: affa25e6
WalkOn::
;> AfterHeroStep()
	call AfterHeroStep
;> TurnEnd()
	jp TurnEnd


;@ def EnterWarp()
;@ path: map/warps
;@ The hero steps into a warp (cell type 4): he vanishes, the view is redrawn at the
;@ next warp of WarpRing (the four warps lead round in a ring) and he appears there.
;@ writes: hMarkRow
;@ reads: hMarkRow
;@ test: skip ends in the turn loop
;@ sig: a7432ecf
EnterWarp::
;> AfterHeroStep()
	call AfterHeroStep
;> BuildSprites()
	call BuildSprites
;> AnimateStep()
	call AnimateStep
;> PlaySong(0x10)
	ld a, $10
	call PlaySong
;> WarpOutEffect()
	call WarpOutEffect
;> ClearSprites(38, wOAMBuffer + 8)
	ld hl, wOAMBuffer + 8
	ld b, $26
	call ClearSprites
;> pos = GetHeroPos(); entry = WarpRing
	call GetHeroPos
	push hl
	pop de
	ld hl, WarpRing
;>@ring for _ in range(4):
	ld b, $04

.find
;>     equal = CompareDEWithU16(pos, entry)[0]; entry += 2
	call CompareDEWithU16
	inc hl
	inc hl
;>     if equal: break                        # the next entry is the destination
	jr z, .found

;=@ring
	cp c
	dec b
	jr nz, .find

.found
;> dest = mem[entry] << 8 | mem[entry + 1]
	ld a, [hli]
	ld d, a
	ld a, [hl]
	ld e, a
;> if hMarkRow != 0: hMarkRow = 0xFF          # the marker sprite goes back onto the hero
	ldh a, [hMarkRow]
	or a
	jr z, .draw

	ld a, $ff
	ldh [hMarkRow], a

.draw
;> DrawViewAt(dest)
	call DrawViewAt
;> PlaySong(0x11)
	ld a, $11
	call PlaySong
;> WaitSongEnd()
	call WaitSongEnd
;> PlayFieldMusic()
	call PlayFieldMusic
;> WarpInEffect()
	call WarpInEffect
;> TurnEnd()
	jr StepOnPit.end

;@ path: map/warps
;@ The four warps as big-endian map positions; each one leads to the next, the last
;@ entry repeats the first to close the ring: row 25 column 35 -> row 60 column 49 ->
;@ row 45 column 75 -> row 90 column 10 -> back.
WarpRing::
	db $c7, $f3                     ; row 25, column 35
	db $d2, $f1                     ; row 60, column 49
	db $ce, $5b                     ; row 45, column 75
	db $dc, $2a                     ; row 90, column 10
	db $c7, $f3                     ; row 25, column 35 again

;@ def StepOnPit()
;@ path: map/traps
;@ The hero steps onto a pit (cell type $14): the cell opens (pictures $1C, then $1B),
;@ he falls and lands at row 5, column 6 of the map, losing 50 hit points (keeping at
;@ least 1); the status window shows for a second.
;@ writes: hHPHi, hHPLo
;@ reads: hHPHi, hHPLo
;@ test: skip ends in the turn loop
;@ sig: b4c65cff
StepOnPit::
;> pit, off = GetPosAhead()
	call GetPosAhead
;> DrawCellAt(0x1C, pit)
	ld a, $1c
	call DrawCellAt
;> DelayFrames(20)
	ld a, $14
	call DelayFrames
;> PlaySfx(8)
	push hl
	ld a, $08
	call PlaySfx
;> DrawMetatileNextFrame(0x1B, MapPosToBG(pit))   # (DrawCellAt left the BG address in hl)
	pop hl
	ld a, $1b
	call DrawMetatileNextFrame
;> WarpOutEffect()
	call WarpOutEffect
;> DropMarker()
	call DropMarker
;> DrawViewAt(0xC196)                         # row 5, column 6
	ld de, $c196
	call DrawViewAt
;> WarpInEffect()
	call WarpInEffect
;> hp = hHPHi << 8 | hHPLo
	ldh a, [hHPHi]
	ld d, a
	ldh a, [hHPLo]
	ld e, a
;> if hp <= 50:
	ld hl, $0032
	call SubDE
	jr c, .one

	ld a, d
	or e
	jr nz, .store

.one
;>     hp = 1
	ld de, $0001
;> else:
;>     hp -= 50

.store
;> hHPHi = hi(hp); hHPLo = lo(hp)
	ld a, d
	ldh [hHPHi], a
	ld a, e
	ldh [hHPLo], a
;> SetHPPalette()
	call SetHPPalette
;> OpenStatusWindow()
	call OpenStatusWindow
;> DelayFrames(60)
	ld a, $3c
	call DelayFrames
;> CloseStatusWindow()
	call CloseStatusWindow
;> ResetObjectStates()
	call ResetObjectStates

.end
;> TurnEnd()
	jp TurnEnd


;@ def PauseGame(new: c) -> carry
;@ path: game/pause
;@ Start pauses the game: the pause tune plays, the hero is drawn into the background (his
;@ sprites are hidden), the status window opens and the game waits for Start again. A+Select
;@ while paused restarts the game (hit points set to 0). Carry when the game was paused.
;@ writes: wOAMBuffer
;@ reads: hHeroFlags
;@ test: skip waits for buttons the VBlank interrupt delivers
;@ sig: 103821d6
PauseGame::
;> if not new & START:
	scf
	ccf
	bit 3, c
;>     return False
	ret z

;> PlaySong(0x0F)                       # pause tune
	ld a, $0f
	call PlaySong
;> under = GetCellUnderHero()
	call GetCellUnderHero
	push af
;> bg = ViewBGAddr(8, 10)               # the hero's cell, in the middle of the view
	ld b, $08
	ld c, $0a
	call ViewBGAddr
	push hl
;> WaitFrame()
	call WaitFrame
;> mem[bg] = 0x00; mem[bg + 1] = 0x01   # the hero's own tiles, drawn as background
	ld [hl], $00
	inc hl
	ld [hl], $01
;> mem[bg + 32] = 0x10; mem[bg + 33] = 0x11
	ld de, $001f
	add hl, de
	ld [hl], $10
	inc hl
	ld [hl], $11
;> # tests bit 3 of the $11 just written: always clear, so this always goes on
	bit 3, [hl]
	jr nz, .waitStart

;> OpenStatusWindow()
	call OpenStatusWindow
;> wOAMBuffer[0] = 0; wOAMBuffer[1] = 0     # hide the hero's two sprites
	xor a
	ld [wOAMBuffer], a
	ld [wOAMBuffer+1], a
;> wOAMBuffer[4] = 0; wOAMBuffer[5] = 0
	ld [wOAMBuffer+4], a
	ld [wOAMBuffer+5], a
;> hSysFlags |= 0x80                    # copy the sprites to OAM at the next VBlank
	ld hl, hSysFlags
	set 7, [hl]

.waitStart
;> while True:
;>     held, new, restart = TakeButtons()
	call TakeButtons
;>     if restart:
;>@giveup         ZeroHP(); return True
	jr c, .giveUp

;>     if new & START:
;>         break
	bit 3, c
	jr z, .waitStart

;> if not hHeroFlags & 0x40:            # at home the status window stays open
	ldh a, [hHeroFlags]
	bit 6, a
	jr nz, .restore

;>     CloseStatusWindow()
	ld a, $08
	ld bc, $0000
	call CloseStatusWindow

.restore
;> DrawMetatileNextFrame(bg, under)     # the cell under the hero back in place
	pop hl
	pop af
	call DrawMetatileNextFrame
;> wOAMBuffer[0] = 0x50; wOAMBuffer[4] = 0x50 # the hero's sprites back in the middle
	ld a, $50
	ld [wOAMBuffer], a
	ld [wOAMBuffer+4], a
;> wOAMBuffer[1] = 0x58; wOAMBuffer[5] = 0x60
	ld a, $58
	ld [wOAMBuffer+1], a
	add $08
	ld [wOAMBuffer+5], a
;> hSysFlags |= 0x80
	ld hl, hSysFlags
	set 7, [hl]
;> PlaySong(0x0F)
	ld a, $0f
	call PlaySong
;> WaitSongEnd()
	call WaitSongEnd
;> PlayFieldMusic()
	call PlayFieldMusic
;> WaitNoActionButtons()
	call WaitNoActionButtons
;> return True
	scf
	ret


.giveUp
;=@giveup
	pop hl
	pop af
	call ZeroHP
	scf
	ret


;@ def AfterHeroStep()
;@ path: player/move
;@ Runs after every step of the hero. Next to a sleeping marker (cell $0E) it wakes it: the
;@ cell gets back what lay under the marker (from wHiddenCells) and the marker sprite takes
;@ over at that screen spot; from then on it follows the hero (it always stands on his
;@ previous cell). On the home or on cell 9, or facing the home, the marker is put back to
;@ sleep. Counts the step and scrolls the view.
;@ writes: hMarkCol, hMarkDX, hMarkDY, hMarkRow, hPictureOverride, hStepCount
;@ reads: hHeroPosHi, hHeroPosLo, hMarkCol, hMarkRow, hStepCount
;@ test: skip draws to VRAM and waits for frames
;@ sig: fb7a1b34
AfterHeroStep::
;> hHeroFlags &= ~0x40                  # no longer resting at home
	ld hl, hHeroFlags
	res 6, [hl]
;> mem[0xFFC3] = 0
	xor a
	ldh [$ffc3], a
;> CloseWindows()
	call CloseWindows
;> under = GetCellUnderHero()
	call GetCellUnderHero
;> if under == 0x09 or under == 0x02 or GetCellAhead() == 0x02:
	cp $09
	jp z, .dropMarker

	cp $02
	jr z, .dropMarker

;> # (cell 2 is the home: standing on it or facing it)
	call GetCellAhead
	cp $02
	jr nz, .noHome

.dropMarker
;>     DropMarker()
	call DropMarker
	jp .countStep


.noHome
;> else:
;>     follow = hMarkRow != 0            # a marker follows already?
	ldh a, [hMarkRow]
	or a
	jp nz, .follow

;>     if not follow:                    # look for a sleeping marker above, right, below, left
;>         pos = GetHeroPos()
	call GetHeroPos
	push hl
;>         n = pos - 80
	ld de, -80
	add hl, de
;>         if not IsOffMap(n) and GetCellNibble(n) == 0x0E:
	call IsOffMap
	jr c, .notUp

	call GetCellNibble
	cp $0e
	jr nz, .notUp

;>             row, col = 3, 5           # its place on the screen (the hero is at 4, 5)
	ld bc, $0305
	jr .wake

.notUp
;>         elif not IsOffMap(pos + 1) and GetCellNibble(pos + 1) == 0x0E:
	pop hl
	push hl
	inc hl
	call IsOffMap
	jr c, .notRight

;>             # (second half of the test)
	call GetCellNibble
	cp $0e
	jr nz, .notRight

;>             n = pos + 1; row, col = 4, 6
	ld bc, $0406
	jr .wake

.notRight
;>         elif not IsOffMap(pos + 80) and GetCellNibble(pos + 80) == 0x0E:
	pop hl
	push hl
	ld de, $0050
	add hl, de
;>             # (the tests)
	call IsOffMap
	jr c, .notDown

	call GetCellNibble
	cp $0e
	jr nz, .notDown

;>             n = pos + 80; row, col = 5, 5
	ld bc, $0505
	jr .wake

.notDown
;>         elif not IsOffMap(pos - 1) and GetCellNibble(pos - 1) == 0x0E:
	pop hl
	push hl
	dec hl
	call IsOffMap
	jr c, .none

;>             # (second half of the test)
	call GetCellNibble
	cp $0e
	jr z, .left

.none
;>@left             n = pos - 1; row, col = 4, 4
;>         else:
;>             n = None                  # nothing to wake: on to counting the step
	pop hl
	jp .countStep


.left
;=@left
	ld bc, $0404

.wake
;>         if n is not None:
	pop de
;>             hMarkRow = row; hMarkCol = col   # the marker sprite starts on the woken cell
	ld de, hMarkRow
	ld a, b
	ld [de], a
	inc de
	ld a, c
	ld [de], a
;>             # what lay under this marker?
	push hl
	pop de
	ld a, $3f
	ld hl, wHiddenCells

.search
;>@search             for e in range(63):
;>                 if CompareDEWithU16(n, wHiddenCells + 3 * e):
;>@freed                     mem[wHiddenCells + 3 * e] = 0; mem[wHiddenCells + 3 * e + 1] = 0   # entry free again
;>@take                     cell = mem[wHiddenCells + 3 * e + 2]; break
	push af
	call CompareDEWithU16
	jr z, .found

;=@search
	inc hl
	inc hl
	inc hl
	pop af
	dec a
	jr nz, .search

;>             else:
;>                 cell = 0
	ld a, $00
	jr .store

.found
;=@freed
	pop af
	xor a
	ld [hli], a
	ld [hli], a
;=@take
	ld a, [hl]

.store
;>             wMarkCellHi = hi(n); wMarkCellLo = lo(n); wMarkWokeCell = cell
	ld hl, wMarkCellHi
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld [hl], a
;>             SetCellAndDraw(n, cell)
	push de
	pop hl
	push af
	push hl
	call SetCellAndDraw
;>             if cell == 0x0F:
	pop hl
	pop af
	cp $0f
	jr nz, .sound

;>                 DrawCellAt(n, 0x17)   # big cell types show their own picture
	ld a, $17
	call DrawCellAt

.sound
;>             PlaySfx(6)
;>             follow = True
	ld a, $06
	call PlaySfx

.follow
;>     if follow:
;>         hHeroFlags &= ~0x03            # the break / kick spell ends with the step
	ld hl, hHeroFlags
	res 1, [hl]
	res 0, [hl]
;>         wMarkCellHi = hHeroPosHi; wMarkCellLo = hHeroPosLo   # it will sleep where the hero stood
	ld hl, wMarkCellHi
	ldh a, [hHeroPosHi]
	ld [hli], a
	ldh a, [hHeroPosLo]
	ld [hli], a
;>         if hMarkRow == 0xFF:           # placed on the hero after a warp
	ldh a, [hMarkRow]
	cp $ff
	jr nz, .slide

;>             hMarkCol = 5; hMarkRow = 4
	ld a, $05
	ldh [hMarkCol], a
	ld a, $04
	ldh [hMarkRow], a

.slide
;>         hMarkDY = 4 - hMarkRow         # slide it to the hero's cell during the scroll
	ld b, a
	ld a, $04
	sub b
	ldh [hMarkDY], a
;>         hMarkDX = 5 - hMarkCol
	ldh a, [hMarkCol]
	ld b, a
	ld a, $05
	sub b
	ldh [hMarkDX], a

.countStep
;> hStepCount += 1
	ldh a, [hStepCount]
	inc a
	ldh [hStepCount], a
;> ScrollView()
	call ScrollView
	ret


;@ def DropMarker()
;@ path: player/move
;@ Puts the following marker back to sleep: its cell (wMarkCellHi/Lo) becomes cell $0E again
;@ and, unless that cell was empty, what lay there is remembered in a free wHiddenCells entry.
;@ Nothing happens on cell 9.
;@ writes: hMarkRow
;@ reads: hMarkRow
;@ test: skip draws to VRAM and waits for a frame
;@ sig: ac40f829
DropMarker::
;> if hMarkRow == 0:
;>     return
	ldh a, [hMarkRow]
	or a
	ret z

;> hMarkRow = 0
	xor a
	ldh [hMarkRow], a
;> if GetCellUnderHero() == 0x09:
;>     return
	call GetCellUnderHero
	cp $09
	ret z

;> pos = wMarkCellHi << 8 | wMarkCellLo
	ld hl, wMarkCellHi
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	push de
;> cell = GetCellNibble(pos)
	push hl
	push de
	pop hl
	call GetCellNibble
;> SetCellAndDraw(pos, 0x0E)
	push af
	ld a, $0e
	call SetCellAndDraw
	pop af
	pop hl
	pop de
;> if cell == 0:
;>     return
	cp $00
	ret z

	dec hl
	ld b, a
	ld c, $3f

.find
;>@find for e in range(63):
;>     if mem[wHiddenCells + 3 * e] == 0:
	inc hl
	inc hl
	ld a, [hli]
	or a
	jr z, .free

;=@find
	dec c
	jr nz, .find

	ret


.free
;>         mem[wHiddenCells + 3 * e] = hi(pos); mem[wHiddenCells + 3 * e + 1] = lo(pos)
	dec hl
	ld [hl], d
	inc hl
	ld [hl], e
;>         mem[wHiddenCells + 3 * e + 2] = cell
;>         return
	inc hl
	ld [hl], b
	ret


;@ def WarpOutEffect()
;@ path: player/warp
;@ The hero vanishes: his sprite blinks six times with the warp tiles $04/$14, then shows
;@ tile $EE (both halves, the right one mirrored) for 12 frames.
;@ writes: wOAMBuffer
;@ test: skip waits for frames the VBlank interrupt counts
;@ sig: 37fbd1bf
WarpOutEffect::
;>@blink for _ in range(6):
	ld b, $06

.blink
;>     wOAMBuffer[2] = 0x04; wOAMBuffer[3] = 0
	ld hl, wOAMBuffer+2
	ld a, $04
	ld [hli], a
	ld [hl], $00
;>     wOAMBuffer[6] = 0x14; wOAMBuffer[7] = 0
	ld hl, wOAMBuffer+6
	ld a, $14
	ld [hli], a
	ld [hl], $00
;>     CopyOAMAndDelay(5)
	ld a, $05
	call CopyOAMAndDelay
;>     wOAMBuffer[2] = 0xAA; wOAMBuffer[6] = 0xAA   # blank tile
	ld a, $aa
	ld [wOAMBuffer+2], a
	ld [wOAMBuffer+6], a
;>     CopyOAMAndDelay(5)
	ld a, $05
	call CopyOAMAndDelay
;=@blink
	dec b
	jr nz, .blink

;> wOAMBuffer[2] = 0xEE; wOAMBuffer[6] = 0xEE
	ld a, $ee
	ld [wOAMBuffer+2], a
	ld hl, wOAMBuffer+6
	ld [hli], a
;> wOAMBuffer[7] = 0x20                  # right half mirrored
	ld a, $20
	ld [hl], a
;> CopyOAMAndDelay(12)
	ld a, $0c
	call CopyOAMAndDelay
	ret


;@ def WarpInEffect()
;@ path: player/warp
;@ The hero appears: his normal tiles $00/$10 blink six times, then his sprite is reset.
;@ writes: wOAMBuffer
;@ test: skip waits for frames the VBlank interrupt counts
;@ sig: 58319a85
WarpInEffect::
;>@blink for _ in range(6):
	ld b, $06

.blink
;>     wOAMBuffer[2] = 0x00; wOAMBuffer[3] = 0
	ld hl, wOAMBuffer+2
	ld a, $00
	ld [hli], a
	ld [hl], $00
;>     wOAMBuffer[6] = 0x10; wOAMBuffer[7] = 0
	ld hl, wOAMBuffer+6
	ld a, $10
	ld [hli], a
	ld [hl], $00
;>     CopyOAMAndDelay(9)
	ld a, $09
	call CopyOAMAndDelay
;>     wOAMBuffer[2] = 0xAA; wOAMBuffer[6] = 0xAA
	ld a, $aa
	ld [wOAMBuffer+2], a
	ld [wOAMBuffer+6], a
;>     CopyOAMAndDelay(8)
	ld a, $08
	call CopyOAMAndDelay
;=@blink
	dec b
	jr nz, .blink

;> ResetHeroSprite()
	call ResetHeroSprite
	ret


;@ def TakeOrDropItem()
;@ path: items/take
;@ The A button. With empty hands the hero takes what lies on his cell: gold (cell 7) and
;@ potions (cell $0D) are counted, pieces (cell $0C) are carried (any number), cells 8, 9, $0A
;@ and $0B are carried one at a time (hCarriedItem gets the sprite tile, hCarriedCell the cell),
;@ and cell 6 changes the hero for good (hSysFlags bit 6, new tiles, tune $12).
;@ Carrying something, he drops it on an empty cell (an item first, then the pieces one by one);
;@ at home only the item with sprite $E8 (cell $0A) is used up: it adds 250 strength. Carrying
;@ the cell-8 item ($FE) onto cell 5 turns cell 5 into a random find: every 8th step cell $0A,
;@ otherwise cell 9, $0B, $0E, $0D or gold with chances 10, 10, 15, 41 and 180 out of 256.
;@ writes: hCarriedCell, hCarriedItem, hPiecesCarried, hStrHi, hStrLo
;@ reads: hCarriedCell, hCarriedItem, hHomePosHi, hHomePosLo, hPiecesCarried, hStepCount, hStrHi, hStrLo
;@ test: skip draws to VRAM, plays sounds and waits for frames
;@ sig: 7bd6d1cf
TakeOrDropItem::
;> if hPiecesCarried != 0 or hCarriedItem != 0:
	ldh a, [hPiecesCarried]
	or a
	jr nz, .carrying

	ldh a, [hCarriedItem]
	or a
	jr z, .handsEmpty

.carrying
;>     if GetHeroPos() == (hHomePosHi << 8 | hHomePosLo):   # at home
	ldh a, [hHomePosHi]
	ld d, a
	ldh a, [hHomePosLo]
	ld e, a
	call GetHeroPos
	call SubDE
;>         # (difference 0?)
	ld a, d
	or e
	jr nz, .notHome

;>         if hCarriedItem != 0xE8:
;>             return
	ldh a, [hCarriedItem]
	cp $e8
	ret nz

;>         s = (hStrHi << 8 | hStrLo) + 250
	ldh a, [hStrHi]
	ld d, a
	ldh a, [hStrLo]
	ld e, a
	ld hl, $00fa
	call AddDE
;>         if s > 0xFFFF:
;>             s = 0xFFFF
	jr nc, .storeStrength

	ld de, $ffff

.storeStrength
;>         hStrHi = hi(s)
	ld a, d
	ldh [hStrHi], a
;>         hStrLo = lo(s)
	ld a, e
	ldh [hStrLo], a
;>         hCarriedItem = 0; PlaySfx(4); WaitNoActionButtons(); return   # the item is used up
	jp .itemGone


.notHome
;>     else:
;>         under = GetCellUnderHero()
	call GetCellUnderHero
;>         if under == 0:                # drop something on the empty cell
;>@drop             if hCarriedItem != 0:
;>@dropItem                 SetCellUnderHero(hCarriedCell)   # the item first
;>             else:
;>@dropPiece                 hPiecesCarried -= 1          # then the pieces one by one
;>@dropPiece2                 SetCellUnderHero(0x0C)
;>@gone             hCarriedItem = 0; PlaySfx(4); WaitNoActionButtons(); return
	cp $00
	jp z, .drop

;>         elif under != 0x0C:
;>@cell5             if under != 0x05 or hCarriedItem != 0xFE:   # the cell-8 item on cell 5?
;>                 return
;>@step8             if hStepCount & 7 == 0:
;>@find0A                 find = 0x0A
;>             else:
;>@roll                 r = Random(hl, af & 0xFF)
;>@r9                 if r < 10:
;>@f9                     find = 0x09
;>@rB                 elif r < 20:
;>@fB                     find = 0x0B
;>@rE                 elif r < 35:
;>@fE                     find = 0x0E
;>@rD                 elif r < 76:
;>@fD                     find = 0x0D
;>                 else:
;>@f7                     find = 0x07   # gold
;>@setFind             SetCellUnderHero(find)
;>@sfx5             PlaySfx(5); WaitNoActionButtons(); return
	cp $0c
	jp nz, .cell5

;>         elif hCarriedItem == 0:       # another piece: take it too
;>@takePiece             hPiecesCarried += 1
;>@takeTail             SetCellUnderHero(0); PlaySfx(4); WaitNoActionButtons(); return
	ldh a, [hCarriedItem]
	or a
	jr z, .takePiece

;>         else:
;>             return
	ret


.drop
;=@drop
	ldh a, [hCarriedItem]
	or a
	jr z, .dropPiece

;=@dropItem
	ldh a, [hCarriedCell]
	jr .putDown

.dropPiece
;=@dropPiece
	ldh a, [hPiecesCarried]
	dec a
	ldh [hPiecesCarried], a
;=@dropPiece2
	ld a, $0c

.putDown
	call SetCellUnderHero

.itemGone
;=@gone
	xor a
	ldh [hCarriedItem], a
	jr .sfx4

.handsEmpty
;> else:
;>     under = GetCellUnderHero()
	call GetCellUnderHero
;>     if under == 0x06:
	cp $06
	jp nz, .notSix

;>         hSysFlags |= 0x41              # bit 6: the hero is changed; bit 0: VRAM copy under way
	ld hl, hSysFlags
	set 0, [hl]
	set 6, [hl]
;>         hHeroFlags &= ~0x20
	ld hl, hHeroFlags
	res 5, [hl]
;>         LoadAltTiles()
	call LoadAltTiles
;>         PlaySong(0x12)
	ld a, $12
	call PlaySong
;>         WaitSongEnd()
	call WaitSongEnd
;>         PlayFieldMusic()
	call PlayFieldMusic
;>         SetCellUnderHero(0)
	ld a, $00
	call SetCellUnderHero
;>         WaitNoActionButtons(); return
	jp .done


.notSix
;>     elif under == 0x07:               # gold
	cp $07
	jr nz, .notGold

;>         IncVar(hGoldHi); SetCellUnderHero(0); PlaySfx(4); return
	ld hl, hGoldHi
	jr .count

.notGold
;>     elif under == 0x0C:               # a piece
	cp $0c
	jr nz, .notPiece

;>         hPiecesCarried += 1; SetCellUnderHero(0); PlaySfx(4); WaitNoActionButtons(); return

.takePiece
;=@takePiece
	ld hl, hPiecesCarried
	inc [hl]
;=@takeTail
	jr .takeIt

.notPiece
;>     elif under == 0x0D:               # a potion
	cp $0d
	jr nz, .notPotion

;>         IncVar(hPotionsHi)            # big-endian count + 1
	ld hl, hPotionsHi

.count
	call IncVar
;>         SetCellUnderHero(0)
	ld a, $00
	call SetCellUnderHero
;>         PlaySfx(4)
	ld a, $04
	call PlaySfx
;>         return
	ret


.notPotion
;>     elif under == 0x08:               # items carried one at a time
	cp $08
	jr nz, .notEight

;>         hCarriedItem = 0xFE; hCarriedCell = under
;>         SetCellUnderHero(0); PlaySfx(4); WaitNoActionButtons(); return
	ld b, a
	ld a, $fe
	jr .carry

.notEight
;>     elif under == 0x09:
	cp $09
	jr nz, .notNine

;>         hCarriedItem = 0xEA; hCarriedCell = under
;>         SetCellUnderHero(0); PlaySfx(4); WaitNoActionButtons(); return
	ld b, a
	ld a, $ea
	jr .carry

.notNine
;>     elif under == 0x0A:
	cp $0a
	jr nz, .notTen

;>         hCarriedItem = 0xE8; hCarriedCell = under
;>         SetCellUnderHero(0); PlaySfx(4); WaitNoActionButtons(); return
	ld b, a
	ld a, $e8
	jr .carry

.notTen
;>     elif under != 0x0B:
;>         return
	cp $0b
	ret nz

;>     else:
;>         hCarriedItem = 0xF8
	ld b, a
	ld a, $f8

.carry
	ldh [hCarriedItem], a
;>         hCarriedCell = under
	ld a, b
	ldh [hCarriedCell], a

.takeIt
;>         SetCellUnderHero(0)
	ld a, $00
	call SetCellUnderHero

.sfx4
;>         PlaySfx(4); WaitNoActionButtons(); return
	ld a, $04
	jr .playSfx

.cell5
;=@cell5
	cp $05
	ret nz

	ldh a, [hCarriedItem]
	cp $fe
	ret nz

;=@step8
	ldh a, [hStepCount]
	and $07
	jr nz, .roll

;=@find0A
	ld a, $0a
	jr .setFind

.roll
;=@roll
	call Random
;=@r9
	sub $0a
	jr nc, .not9

;=@f9
	ld a, $09
	jr .setFind

.not9
;=@rB
	sub $0a
	jr nc, .notB

;=@fB
	ld a, $0b
	jr .setFind

.notB
;=@rE
	sub $0f
	jr nc, .notE

;=@fE
	ld a, $0e
	jr .setFind

.notE
;=@rD
	sub $29
	jr nc, .gold

;=@fD
	ld a, $0d
	jr .setFind

.gold
;=@f7
	ld a, $07

.setFind
;=@setFind
	call SetCellUnderHero
;=@sfx5
	ld a, $05

.playSfx
	call PlaySfx

.done
	call WaitNoActionButtons
	ret


;@ def SetCellUnderHero(cell: a)
;@ path: player/cells
;@ Puts a cell type on the hero's map cell and draws it.
;@ test: skip draws to VRAM
;@ sig: 56c2fd64
SetCellUnderHero::
;> SetCellAndDraw(GetHeroPos(), cell)
	push af
	call GetHeroPos
	pop af
	call SetCellAndDraw
	ret


;@ def MagicMenu()
;@ path: player/magic
;@ The B button opens the magic menu. The spells offered grow with the maximum hit points:
;@ jump from 100, return 200, map 300, break 500, kick 1000, freeze 1500, flash 2500 and fly
;@ from 5000. Without potions, or carrying pieces, the $EA item or a marker, only "quit" is
;@ offered. Up/Down move the cursor (wrapping), B jumps to "quit", A casts the chosen spell.
;@ writes: hMagicCursor, hSavedSCY
;@ reads: hCarriedItem, hMagicCursor, hMarkRow, hMaxHPHi, hMaxHPLo, hPiecesCarried, hSavedSCY, hTemp1, hTemp2
;@ test: skip waits for buttons the VBlank interrupt delivers
;@ sig: 69a28f33
MagicMenu::
;> hHeroFlags &= ~0x40
	ld hl, hHeroFlags
	res 6, [hl]
;> CloseWindows()
	call CloseWindows
;> lines = 2                             # title and "quit"
	ld c, $02
;> if (hPotionsHi << 8 | hPotionsLo) != 0 and hCarriedItem != 0xEA \
;>         and hPiecesCarried == 0 and hMarkRow == 0:
	ld hl, hPotionsHi
	call TestU16Zero
	jr z, .counted

;>     # (the other conditions)
	ldh a, [hCarriedItem]
	cp $ea
	jr z, .counted

	ldh a, [hPiecesCarried]
	or a
	jr nz, .counted

;>     # (no marker)
	ldh a, [hMarkRow]
	or a
	jr nz, .counted

;>     hp = hMaxHPHi << 8 | hMaxHPLo
	ldh a, [hMaxHPHi]
	ld d, a
	ldh a, [hMaxHPLo]
	ld e, a
;>     for step in (100, 100, 100, 200, 500, 500, 1000, 2500):   # 100, 200, 300, 500, ... 5000
;>         hp -= step
	ld hl, $0064
	call SubDE
;>         if hp < 0:
;>             break
	jr c, .counted

;>         lines += 1
	inc c
	call SubDE
	jr c, .counted

;>         # (unrolled: one subtraction per spell)
	inc c
	call SubDE
	jr c, .counted

;>         # (200)
	inc c
	ld hl, $00c8
	call SubDE
	jr c, .counted

;>         # (500, 500)
	inc c
	ld hl, $01f4
	call SubDE
	jr c, .counted

;>         # (second 500)
	inc c
	call SubDE
	jr c, .counted

;>         # (1000)
	inc c
	ld hl, $03e8
	call SubDE
	jr c, .counted

;>         # (2500)

	inc c
	ld hl, $09c4
	call SubDE
	jr c, .counted

;>     # (all eight passed)
	inc c

.counted
;> if hMagicCursor == 0:
;>     hMagicCursor = 1
	ld hl, hMagicCursor
	xor a
	cp [hl]
	jr nz, .clamp

	ld [hl], $01

.clamp
;> if lines - 1 < hMagicCursor:          # keep the cursor on an offered line
;>     hMagicCursor = lines - 1
	ld a, c
	dec a
	cp [hl]
	jr nc, .open

	ld [hl], a

.open
;> hSavedSCY = lines                     # (used here as the menu's line count)
	ld a, c
	ldh [hSavedSCY], a
;> DrawWindow(lines, 0, MagicMenuText)    # open the window with the first `lines` lines
	ld bc, $0000
	ld de, MagicMenuText
	call DrawWindow
;> HideSpritesInCorner((hSavedSCY + 1) * 8 + 16, 0x48)   # sprites and the window's bottom edge
	ldh a, [hSavedSCY]
	inc a
	sla a
	sla a
	sla a
	add $10
;> # (passes the bottom edge in b)
	ld b, a
	ld c, $48
	call HideSpritesInCorner
;> bg = ViewBGAddr(hMagicCursor, 0)
	ldh a, [hMagicCursor]
	ld b, a
	ld c, $00
	call ViewBGAddr
;> WaitFrame()
	call WaitFrame
;> mem[bg] = 0x2F                        # the cursor tile
	ld a, $2f
	ld [hl], a

.input
;> while True:
;>     held, new, restart = TakeButtons()
	call TakeButtons
;>     if restart:
;>         return GiveUp()
	jp c, GiveUp

;>     if new & A_BUTTON:
;>@cast         break
	bit 0, c
	jr nz, .cast

;>     old = hMagicCursor
	ldh a, [hMagicCursor]
	ld d, a
;>     if new & B_BUTTON:
;>@toQuit         line = 1                     # B: straight to "quit"
	bit 1, c
	jr nz, .toQuit

;>     elif held & DOWN:
	bit 7, b
	jr z, .notDown

;>         line = old + 1
	inc a
	ld e, a
;>         if line == hSavedSCY:          # past the last line: back to "quit"
;>@wrapDown             line = 1
	ld hl, hSavedSCY
	sub [hl]
	jr nz, .move

.toQuit
;=@toQuit
;=@wrapDown
	ld e, $01
	jr .move

.notDown
;>     elif held & UP:
;>         line = old - 1
	bit 6, b
	jr z, .input

	dec a
	ld e, a
;>         if line == 0:                  # above "quit": to the last line
;>             line = hSavedSCY - 1
	jr nz, .move

	ldh a, [hSavedSCY]
	dec a
	ld e, a
;>     else:
;>         continue                       # (the jr z back to .input above)

.move
;>     hMagicCursor = line
	ld a, e
	ldh [hMagicCursor], a
;>     new_bg = ViewBGAddr(line, 0)
	ld b, e
	ld c, $00
	push de
	call ViewBGAddr
	pop de
;>     old_bg = ViewBGAddr(old, 0)
	push hl
	ld b, d
	ld c, $00
	call ViewBGAddr
;>     WaitFrame()
	call WaitFrame
;>     mem[old_bg] = 0x3E                 # blank
	ld a, $3e
	ld [hl], a
;>     mem[new_bg] = 0x2F
	pop hl
	ld a, $2f
	ld [hl], a
;>     DelayFrames(15)
	ld a, $0f
	call DelayFrames
	jr .input

.cast
;=@cast
;> RestoreWindowArea(hSavedSCY + 1, 0, hTemp1 << 8 | hTemp2)   # close the window again
	ldh a, [hTemp1]
	ld d, a
	ldh a, [hTemp2]
	ld e, a
	ldh a, [hSavedSCY]
	inc a
;> # (and closes it)
	ld bc, $0000
	call RestoreWindowArea
;> hHeroFlags &= ~0x03                   # a new spell replaces break / kick
	ld hl, hHeroFlags
	res 1, [hl]
	res 0, [hl]
;> if hMagicCursor == 1:                 # quit
;>     return CloseMenu()
	ldh a, [hMagicCursor]
	cp $01
	jp z, CloseMenu

;> spells = [CastJump, CastReturn, CastMap, CastBreak, CastKick, CastFreeze, CastFlash, CastFly]
;> return spells[hMagicCursor - 2]()     # through SpellTable, 3 bytes an entry
	dec a
	dec a
	ld e, a
	sla a
	add e
	ld e, a
;> # (jump through the table)
	ld d, $00
	ld hl, SpellTable
	add hl, de
	jp hl


;@ def SpellTable()
;@ path: player/magic
;@ test: skip one entry of the spell jump table
;@ The spell jump table, one `jp` per menu line from line 2 on; this first entry is the jump spell.
;@ sig: c9aef27b
SpellTable::
;> return CastJump()
	jp CastJump


;@ def SpellTableReturn()
;@ path: player/magic
;@ test: skip one entry of the spell jump table
;@ Spell table entry for line 3: return.
;@ sig: 1defcda4
SpellTableReturn::
;> return CastReturn()
	jp CastReturn


;@ def SpellTableMap()
;@ path: player/magic
;@ test: skip one entry of the spell jump table
;@ Spell table entry for line 4: map.
;@ sig: 384613dd
SpellTableMap::
;> return CastMap()
	jp CastMap


;@ def SpellTableBreak()
;@ path: player/magic
;@ test: skip one entry of the spell jump table
;@ Spell table entry for line 5: break.
;@ sig: bd3cf986
SpellTableBreak::
;> return CastBreak()
	jp CastBreak


;@ def SpellTableKick()
;@ path: player/magic
;@ test: skip one entry of the spell jump table
;@ Spell table entry for line 6: kick.
;@ sig: 4642bfaf
SpellTableKick::
;> return CastKick()
	jp CastKick


;@ def SpellTableFreeze()
;@ path: player/magic
;@ test: skip one entry of the spell jump table
;@ Spell table entry for line 7: freeze.
;@ sig: aaa29e0c
SpellTableFreeze::
;> return CastFreeze()
	jp CastFreeze


;@ def SpellTableFlash()
;@ path: player/magic
;@ test: skip one entry of the spell jump table
;@ Spell table entry for line 8: flash.
;@ sig: 7344712f
SpellTableFlash::
;> return CastFlash()
	jp CastFlash


;@ def SpellTableFly()
;@ path: player/magic
;@ test: skip one entry of the spell jump table
;@ Spell table entry for line 9: fly.
;@ sig: 209d523f
SpellTableFly::
;> return CastFly()
	jp CastFly


;@ path: player/magic
;@ The magic menu's text: 10 lines of 8 bytes, each ended by $5E (next line). Letters are
;@ ASCII lower case, $3E is a blank; the title line is the tiles $44-$4A (the word for magic
;@ drawn in its own tiles). MagicMenu shows only the first lines, as many as spells are offered.
MagicMenuText::
	db $44, $45, $46, $47, $48, $49, $4a, $5e   ; title
	db $3e, $71, $75, $69, $74, $3e, $3e, $5e   ; " quit"
	db $3e, $6a, $75, $6d, $70, $3e, $3e, $5e   ; " jump"
	db $3e, $72, $65, $74, $75, $72, $6e, $5e   ; " return"
	db $3e, $6d, $61, $70, $3e, $3e, $3e, $5e   ; " map"
	db $3e, $62, $72, $65, $61, $6b, $3e, $5e   ; " break"
	db $3e, $6b, $69, $63, $6b, $3e, $3e, $5e   ; " kick"
	db $3e, $66, $72, $65, $65, $7a, $65, $5e   ; " freeze"
	db $3e, $66, $6c, $61, $73, $68, $3e, $5e   ; " flash"
	db $3e, $66, $6c, $79, $3e, $3e, $3e, $5e   ; " fly"

;@ def CastJump()
;@ path: player/magic
;@ The jump spell: warps the hero to the jump position (hJumpPosHi/Lo).
;@ reads: hJumpPosHi, hJumpPosLo
;@ test: skip redraws the whole view and waits for the music
;@ sig: 71b11a21
CastJump::
;> pos = hJumpPosHi << 8 | hJumpPosLo
	ldh a, [hJumpPosHi]
	ld h, a
	ldh a, [hJumpPosLo]
	ld l, a
;> return WarpHeroTo(pos)
	push hl
	pop de
	jr WarpHeroTo

;@ def CastReturn()
;@ path: player/magic
;@ The return spell: warps the hero home.
;@ reads: hHomePosHi, hHomePosLo
;@ test: skip redraws the whole view and waits for the music
;@ sig: 05c62c5f
CastReturn::
;> pos = hHomePosHi << 8 | hHomePosLo
	ldh a, [hHomePosHi]
	ld d, a
	ldh a, [hHomePosLo]
	ld e, a
;> return WarpHeroTo(pos)                # (falls through)

;@ def WarpHeroTo(pos: de)
;@ path: player/magic
;@ Ends the jump and return spells: puts the hero on pos and redraws the view, puts the marker
;@ to sleep, plays the warp tune $13 and spends the potion.
;@ test: skip redraws the whole view and waits for the music
;@ sig: 3170656b
WarpHeroTo::
;> DrawViewAt(pos)
	call DrawViewAt
;> DropMarker()
	call DropMarker
;> PlaySong(0x13)
	ld a, $13
	call PlaySong
;> WaitSongEnd()
	call WaitSongEnd
;> PlayFieldMusic()
	call PlayFieldMusic
;> return SpellDoneRespawn()
	jp SpellDoneRespawn


;@ def CastMap()
;@ path: player/magic/map
;@ The map spell: draws 72 rows x 80 columns of the world around the hero (rows 36 above to
;@ 35 below him) as a picture filling the screen, every cell 2x2 pixels: walls and the
;@ space beyond the map edge dark, items light, sleeping markers (cell $0E) mid grey. The
;@ picture is built one tile row (4 map rows) at a time in wMapRowTiles and copied to VRAM
;@ as 360 tiles shown through the $9C00 tile map. This part saves the screen state and
;@ starts the loops; the loops run through MapTileRowLoop .. MapNextCell, which keep their
;@ counters on the stack, and MapShow shows the result.
;@ writes: hFlashRounds, hFlashTimer, wMapBGHi, wMapBGLo, wMapCellHi, wMapCellLo, wMapCountHi, wMapCountLo, wMapHeroX, wMapHomeX, wMapSavedSCX, wMapTilesHi, wMapTilesLo, wMapVram8Hi, wMapVram8Lo, wMapVram9Hi, wMapVram9Lo, wMenuLast, wMidRows, wNearRows
;@ test: skip writes VRAM and LCD registers and waits for frames
;@ sig: cdc07fc5
CastMap::
;> hFlashRounds = 0
	xor a
	ldh [hFlashRounds], a
;> hFlashTimer = 0                       # stop a flash
	ldh [hFlashTimer], a
;> SetHPPalette()
	call SetHPPalette
;> WaitFrame()
	call WaitFrame
;> rLCDC = 0x85                          # window off
	ld a, $85
	ldh [rLCDC], a
;> hSysFlags = (hSysFlags & ~0x80) | 0x01   # no OAM copy; VRAM work under way
	ld hl, hSysFlags
	res 7, [hl]
	set 0, [hl]
;> copy(wSavedOAM, wOAMBuffer, 0xA0)     # keep the sprites for later
	ld b, $a0
	ld de, wOAMBuffer
	ld hl, wSavedOAM
	call CopyB
;> ClearWindowMap()
	call ClearWindowMap
;> wNearRows = rSCY                      # (that buffer keeps the scroll here)
	ldh a, [rSCY]
	ld [wNearRows], a
;> wMapSavedSCX = rSCX
	ldh a, [rSCX]
	ld [wMapSavedSCX], a
;> rSCY = 0
	xor a
	ldh [rSCY], a
;> rSCX = 0
	ldh [rSCX], a
;> rLCDC = 0x9D                          # background from the $9C00 map
	ld a, $9d
	ldh [rLCDC], a
;> start = GetHeroPos() - 2920           # 36 rows and 40 columns back from the hero
	call GetHeroPos
	push hl
	pop de
	ld hl, $0b68
	call SubDE
;> wMapCellHi = hi(start)
	ld a, d
	ld [wMapCellHi], a
;> wMapCellLo = lo(start)
	ld a, e
	ld [wMapCellLo], a
;> wMapCountHi = 0
	xor a
	ld [wMapCountHi], a
;> wMapCountLo = 0
	ld [wMapCountLo], a
;> wMapTilesHi = 0
	ld [wMapTilesHi], a
;> wMapTilesLo = 0
	ld [wMapTilesLo], a
;> wMapHomeX = 0
	ld [wMapHomeX], a
;> wMidRows = 0                          # the home marker's Y (until the home is found)
	ld [wMidRows], a
;> wMenuLast = 0x58                      # the hero marker's Y ...
	ld a, $58
	ld [wMenuLast], a
;> wMapHeroX = 0x58                      # ... and X: the middle of the screen
	ld a, $58
	ld [wMapHeroX], a
;> wMapVram8Hi = 0x80                    # the first 240 tiles go to $8000 on
	ld de, $8000
	ld a, d
	ld [wMapVram8Hi], a
;> wMapVram8Lo = 0x00
	ld a, e
	ld [wMapVram8Lo], a
;> wMapVram9Hi = 0x90                    # the rest to $9000 on
	ld de, $9000
	ld a, d
	ld [wMapVram9Hi], a
;> wMapVram9Lo = 0x00
	ld a, e
	ld [wMapVram9Lo], a
;> wMapBGHi = 0x9C
	ld de, $9c00
	ld a, d
	ld [wMapBGHi], a
;> wMapBGLo = 0x00
	ld a, e
	ld [wMapBGLo], a
;> hSysFlags |= 0x10
	ld hl, hSysFlags
	set 4, [hl]
;> tile_rows_left = 0x13                 # 18 tile rows (counted down before each)
;> return MapTileRowLoop()
	ld b, $13
	push bc

;@ def MapTileRowLoop()
;@ path: player/magic/map
;@ Map spell, outer loop: one tile row (8 pixel lines, 4 map rows) per pass. Starts with a
;@ cleared wMapRowTiles; done after 18 rows.
;@ writes: wMapLineHi, wMapLineLo
;@ test: skip part of the map spell's loops, which keep their counters on the stack
;@ sig: 6e487bcc
MapTileRowLoop::
;> tile_rows_left -= 1                   # (the counter lives on the stack)
	pop bc
	dec b
;> if tile_rows_left == 0:
;>     return MapShow()
	jp z, MapShow

;> wMapLineHi = hi(wMapRowTiles)
	push bc
	ld hl, wMapRowTiles
	ld a, h
	ld [wMapLineHi], a
;> wMapLineLo = lo(wMapRowTiles)
	ld a, l
	ld [wMapLineLo], a
;> fill(wMapRowTiles, 0x140, 0)
	ld bc, $0140
	call ClearMem
;> line_pairs_left = 5                   # 4 map rows
;> return MapLinePairLoop()
	ld b, $05
	push bc

;@ def MapLinePairLoop()
;@ path: player/magic/map
;@ Map spell: one map row (two pixel lines of the tile row) per pass, 4 per tile row.
;@ writes: wMapTileHi, wMapTileLo
;@ reads: wMapLineHi, wMapLineLo
;@ test: skip part of the map spell's loops, which keep their counters on the stack
;@ sig: 3c86a6e9
MapLinePairLoop::
;> line_pairs_left -= 1
	pop bc
	dec b
;> if line_pairs_left == 0:
;>     return MapFlushTileRow()
	jp z, MapFlushTileRow

;> wMapTileHi = wMapLineHi               # the first tile of the row
	push bc
	ld a, [wMapLineHi]
	ld [wMapTileHi], a
;> wMapTileLo = wMapLineLo
	ld a, [wMapLineLo]
	ld [wMapTileLo], a
;> tiles_left = 0x15                     # 20 tiles across
;> return MapTileLoop()
	ld b, $15
	push bc

;@ def MapTileLoop()
;@ path: player/magic/map
;@ Map spell: one tile (4 cells, 8 pixels across) per pass, 20 per map row.
;@ test: skip part of the map spell's loops, which keep their counters on the stack
;@ sig: 78ed2b6a
MapTileLoop::
;> tiles_left -= 1
	pop bc
	dec b
;> if tiles_left == 0:
;>     return MapNextLinePair()
	jp z, MapNextLinePair

;> cells_left = 5                        # 4 cells
;> return MapCellLoop()
	push bc
	ld b, $05
	push bc

;@ def MapCellLoop(cells_left: stack)
;@ path: player/magic/map
;@ Map spell: one cell per pass. Off the map and walls are drawn dark; the hero's cell stays
;@ blank (his marker sprite sits in the middle of the screen); the home's cell gives the home
;@ marker's sprite position; other cells go through MapCellTable by their type.
;@ writes: wMapHomeX, wMidRows
;@ reads: hHomePosHi, hHomePosLo, wMapCountHi, wMapCountLo
;@ test: skip part of the map spell's loops, which keep their counters on the stack
;@ sig: ae2015db
MapCellLoop::
;> cells_left -= 1
	pop bc
	dec b
;> if cells_left == 0:
;>     return MapNextTile()
	jp z, MapNextTile

;> pos = GetMapCellPtr()
	push bc
	call GetMapCellPtr
;> if IsOffMap(pos):
;>     return MapDotDark()
	call IsOffMap
	jr c, MapDotDark

;> if pos == GetHeroPos():
	push hl
	call GetHeroPos
	push hl
	pop de
	pop hl
;>     return MapNextCell(cells_left)
	call SubDE
	ld a, d
	or e
	jp z, MapNextCell

;> if pos == (hHomePosHi << 8 | hHomePosLo):
	ldh a, [hHomePosHi]
	ld d, a
	ldh a, [hHomePosLo]
	ld e, a
	call SubDE
;>@cell     # (else: below)
	ld a, d
	or e
	jr nz, .byType

;>     count = wMapCountHi << 8 | wMapCountLo   # cells drawn so far
;>     row = count // 80
	ld b, $00
	ld a, [wMapCountHi]
	ld d, a
	ld a, [wMapCountLo]
	ld e, a
	ld hl, $0050

.divide
;>     col = count % 80
	call SubDE
	jr c, .divided

	inc b
	jr .divide

.divided
;>     wMapHomeX = col * 2 + 8
	call AddDE
	ld a, e
	sla a
	add $08
	ld [wMapHomeX], a
;>     wMidRows = row * 2 + 16           # the home marker's Y
	ld a, b
	sla a
	add $10
	ld [wMidRows], a
;>     return MapNextCell(cells_left)
	jr MapNextCell

.byType
;=@cell
;> return MapCellTable[GetCellNibble(pos)]()   # 2-byte jr entries
	call GetCellNibble
	ld hl, MapCellTable
	ld c, a
	sla c
	ld b, $00
;> # (jump into the table)
	add hl, bc
	jp hl


;@ def MapCellTable()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell, what each cell type looks like: a `jr` per type. This entry is type 0 (empty):
;@ nothing drawn. Types 2-4 are blank too, type 1 (wall) dark, $0E (marker) mid grey, the rest
;@ light.
;@ sig: 2b7a5e95
MapCellTable::
;> return MapNextCell()
	jr MapNextCell

;@ def MapCell01()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type 1 (wall) is dark.
;@ sig: d7c3d6e9
MapCell01::
;> return MapDotDark()
	jr MapDotDark

;@ def MapCell02()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type 2 (the home) stays blank; its marker sprite shows it.
;@ sig: 2c179a8c
MapCell02::
;> return MapNextCell()
	jr MapNextCell

;@ def MapCell03()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type 3 stays blank.
;@ sig: c219fba0
MapCell03::
;> return MapNextCell()
	jr MapNextCell

;@ def MapCell04()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type 4 stays blank.
;@ sig: 75a4a79b
MapCell04::
;> return MapNextCell()
	jr MapNextCell

;@ def MapCell05()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type 5 is light.
;@ sig: 16a2cb42
MapCell05::
;> return MapDotLight()
	jr MapDotLight

;@ def MapCell06()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type 6 is light.
;@ sig: f8acaa6e
MapCell06::
;> return MapDotLight()
	jr MapDotLight

;@ def MapCell07()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type 7 (gold) is light.
;@ sig: 39cdb7c5
MapCell07::
;> return MapDotLight()
	jr MapDotLight

;@ def MapCell08()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type 8 is light.
;@ sig: d7c3d6e9
MapCell08::
;> return MapDotLight()
	jr MapDotLight

;@ def MapCell09()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type 9 is light.
;@ sig: 3ea073dc
MapCell09::
;> return MapDotLight()
	jr MapDotLight

;@ def MapCell0A()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type $0A is light.
;@ sig: d0ae12f0
MapCell0A::
;> return MapDotLight()
	jr MapDotLight

;@ def MapCell0B()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type $0B is light.
;@ sig: 37163ff7
MapCell0B::
;> return MapDotLight()
	jr MapDotLight

;@ def MapCell0C()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type $0C (a piece) is light.
;@ sig: d9185edb
MapCell0C::
;> return MapDotLight()
	jr MapDotLight

;@ def MapCell0D()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type $0D (a potion) is light.
;@ sig: 307bfbee
MapCell0D::
;> return MapDotLight()
	jr MapDotLight

;@ def MapCell0E()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type $0E (a sleeping marker) is mid grey.
;@ sig: 39cdb7c5
MapCell0E::
;> return MapDotMid()
	jr MapDotMid

;@ def MapCell0F()
;@ path: player/magic/map
;@ test: skip one entry of a jump table into the map spell loops
;@ Map spell: cell type $0F (the big cell types, $10 and up) is light.
;@ sig: 247aa7a1
MapCell0F::
;> return MapDotLight()
	jr MapDotLight

;@ def MapDotDark()
;@ path: player/magic/map
;@ Map spell: colour 3 into the cell's 2x2 pixels (both bit planes of both lines).
;@ test: skip part of the map spell's loops, which keep their counters on the stack
;@ sig: e15a05b7
MapDotDark::
;> p = GetMapTilePtr()
	call GetMapTilePtr
;> for i in range(4):
	ld b, $05

.loop
;>@next     mem[p + i] |= 0x03
	dec b
	jr z, MapNextCell

	ld a, [hl]
	or $03
	ld [hli], a
;=@next
	jr .loop

;> return MapNextCell()

;@ def MapDotLight()
;@ path: player/magic/map
;@ Map spell: colour 1 into the cell's 2x2 pixels (the low bit plane of both lines).
;@ test: skip part of the map spell's loops, which keep their counters on the stack
;@ sig: 1c9a02a9
MapDotLight::
;> p = GetMapTilePtr()
	call GetMapTilePtr
;> mem[p] |= 0x03
	ld a, [hl]
	or $03
	ld [hli], a
;> mem[p + 2] |= 0x03
	inc hl
	ld a, [hl]
	or $03
	ld [hl], a
;> return MapNextCell()
	jr MapNextCell

;@ def MapDotMid()
;@ path: player/magic/map
;@ Map spell: colour 2 into the cell's 2x2 pixels (the high bit plane of both lines).
;@ test: skip part of the map spell's loops, which keep their counters on the stack
;@ sig: b04c0bd8
MapDotMid::
;> p = GetMapTilePtr()
	call GetMapTilePtr
;> mem[p + 1] |= 0x03
	inc hl
	ld a, [hl]
	or $03
	ld [hli], a
;> mem[p + 3] |= 0x03
	inc hl
	ld a, [hl]
	or $03
	ld [hl], a
;> return MapNextCell()                  # (falls through)

;@ def MapNextCell(cells_left: stack)
;@ path: player/magic/map
;@ Map spell, end of a cell: unless it was the tile's 4th cell, shifts the 4 bytes left by
;@ 2 bits to make room for the next cell's two pixels; then on to the next map cell.
;@ writes: wMapCellHi, wMapCellLo, wMapCountHi, wMapCountLo
;@ reads: wMapCountHi, wMapCountLo
;@ test: skip part of the map spell's loops, which keep their counters on the stack
;@ sig: e2bdefaa
MapNextCell::
;> if cells_left - 1 != 0:               # (counter peeked from the stack)
	pop bc
	push bc
	dec b
	jr z, .advance

;>     p = GetMapTilePtr()
	call GetMapTilePtr
;>     for i in range(4):
	ld b, $05

.shift
;>@next         mem[p + i] = u8(mem[p + i] << 2)
	dec b
	jr z, .advance

	ld a, [hl]
	sla a
	sla a
	ld [hli], a
;=@next
	jr .shift

.advance
;> count = (wMapCountHi << 8 | wMapCountLo) + 1
	ld a, [wMapCountHi]
	ld h, a
	ld a, [wMapCountLo]
	ld l, a
	inc hl
;> wMapCountHi = hi(count)
	ld a, h
	ld [wMapCountHi], a
;> wMapCountLo = lo(count)
	ld a, l
	ld [wMapCountLo], a
;> pos = GetMapCellPtr() + 1
	call GetMapCellPtr
	inc hl
;> wMapCellHi = hi(pos)
	ld a, h
	ld [wMapCellHi], a
;> wMapCellLo = lo(pos)
	ld a, l
	ld [wMapCellLo], a
;> return MapCellLoop(cells_left)
	jp MapCellLoop


;@ def MapNextTile()
;@ path: player/magic/map
;@ Map spell: the next 16-byte tile of the row.
;@ writes: wMapTileHi, wMapTileLo
;@ test: skip part of the map spell's loops, which keep their counters on the stack
;@ sig: e4cb1e02
MapNextTile::
;> p = GetMapTilePtr() + 16
	call GetMapTilePtr
	ld b, $00
	ld c, $10
	add hl, bc
;> wMapTileHi = hi(p)
	ld a, h
	ld [wMapTileHi], a
;> wMapTileLo = lo(p)
	ld a, l
	ld [wMapTileLo], a
;> return MapTileLoop()
	jp MapTileLoop


;@ def MapNextLinePair()
;@ path: player/magic/map
;@ Map spell: the next map row goes two pixel lines (4 bytes) further down in the tiles.
;@ writes: wMapLineHi, wMapLineLo
;@ reads: wMapLineHi, wMapLineLo
;@ test: skip part of the map spell's loops, which keep their counters on the stack
;@ sig: 5d343fb4
MapNextLinePair::
;> p = (wMapLineHi << 8 | wMapLineLo) + 4
	ld a, [wMapLineHi]
	ld h, a
	ld a, [wMapLineLo]
	ld l, a
	ld b, $00
	ld c, $04
;> # (add)
	add hl, bc
;> wMapLineHi = hi(p)
	ld a, h
	ld [wMapLineHi], a
;> wMapLineLo = lo(p)
	ld a, l
	ld [wMapLineLo], a
;> return MapLinePairLoop()
	jp MapLinePairLoop


;@ def MapFlushTileRow()
;@ path: player/magic/map
;@ Map spell, end of a tile row: copies its 20 tiles to VRAM (64 bytes a frame) - the first
;@ 240 tiles of the picture to $8000 on, the rest to $9000 on (the LCD interrupt switches
;@ the tile area halfway down the screen) - and writes their numbers into the next row of
;@ the $9C00 tile map.
;@ writes: wMapBGHi, wMapBGLo, wMapTilesHi, wMapTilesLo, wMapVram8Hi, wMapVram8Lo, wMapVram9Hi, wMapVram9Lo
;@ reads: wMapBGHi, wMapBGLo, wMapTilesHi, wMapTilesLo, wMapVram8Hi, wMapVram8Lo, wMapVram9Hi, wMapVram9Lo
;@ test: skip part of the map spell's loops, which keep their counters on the stack
;@ sig: ee40f762
MapFlushTileRow::
;> if (wMapTilesHi << 8 | wMapTilesLo) < 240:
	call CompareMapTiles
	jr nc, .upper9

;>     dest = wMapVram8Hi << 8 | wMapVram8Lo
	ld a, [wMapVram8Hi]
	ld h, a
	ld a, [wMapVram8Lo]
	ld l, a
	jr .copy

.upper9
;> else:
;>     dest = wMapVram9Hi << 8 | wMapVram9Lo
	ld a, [wMapVram9Hi]
	ld h, a
	ld a, [wMapVram9Lo]
	ld l, a

.copy
;> src = wMapRowTiles
	ld de, wMapRowTiles
	ld c, $06

.copyLoop
;>@copy for _ in range(5):
	dec c
	jr z, .copied

;>     WaitFrame()
	ld b, $40
	call WaitFrame
;>     copy(dest, src, 0x40); dest += 0x40; src += 0x40
	call CopyB
;=@copy
	jr .copyLoop

.copied
;> WaitFrame()
	call WaitFrame
;> if (wMapTilesHi << 8 | wMapTilesLo) < 240:
	push hl
	call CompareMapTiles
	jr nc, .save9

;>     wMapVram8Hi = hi(dest)
	pop hl
	ld a, h
	ld [wMapVram8Hi], a
;>     wMapVram8Lo = lo(dest)
	ld a, l
	ld [wMapVram8Lo], a
	jr .numbers

.save9
;> else:
;>     wMapVram9Hi = hi(dest)
	pop hl
	ld a, h
	ld [wMapVram9Hi], a
;>     wMapVram9Lo = lo(dest)
	ld a, l
	ld [wMapVram9Lo], a

.numbers
;> WaitFrame()
	call WaitFrame
;> n = (wMapTilesHi << 8 | wMapTilesLo) - 240
	call CompareMapTiles
;> if n < 0:
;>     n += 240                          # tile numbers count from 0 in each area
	jr nc, .first

	call AddDE

.first
;> bg = wMapBGHi << 8 | wMapBGLo
	ld a, [wMapBGHi]
	ld h, a
	ld a, [wMapBGLo]
	ld l, a
	ld b, $15

.row
;>@row for _ in range(20):
	dec b
	jr z, .rowDone

;>     mem[bg + _] = lo(n + _)
	ld [hl], e
	inc e
	inc hl
;=@row
	jr .row

.rowDone
;> tiles = (wMapTilesHi << 8 | wMapTilesLo) + 20
	push hl
	ld a, [wMapTilesHi]
	ld h, a
	ld a, [wMapTilesLo]
	ld l, a
;> # (add)
	ld b, $00
	ld c, $14
	add hl, bc
;> wMapTilesHi = hi(tiles)
	ld a, h
	ld [wMapTilesHi], a
;> wMapTilesLo = lo(tiles)
	ld a, l
	ld [wMapTilesLo], a
;> bg += 12                              # to the start of the next tile-map row
	pop hl
	ld b, $00
	ld c, $0c
	add hl, bc
;> wMapBGHi = hi(bg)
	ld a, h
	ld [wMapBGHi], a
;> wMapBGLo = lo(bg)
	ld a, l
	ld [wMapBGLo], a
;> return MapTileRowLoop()
	jp MapTileRowLoop


;@ def MapShow()
;@ path: player/magic/map
;@ Map spell, the picture is done: the hero and the home are marked by blinking 2x2 dots
;@ (sprite tile $F0, made here at $8F00; all sprites blink every 30 frames). A closes the
;@ map: all game tiles are loaded again from $4A72 (plus the hero's changed tiles), the
;@ scroll, the sprites and the LCD set-up are put back, and the potion is spent.
;@ reads: wMapHeroX, wMapHomeX, wMapSavedSCX, wMenuLast, wMidRows, wNearRows
;@ test: skip writes VRAM and LCD registers and waits for buttons
;@ sig: da4c9660
MapShow::
;> WaitFrame()
	call WaitFrame
;> fill(wOAMBuffer, 0xA0, 0)
	ld hl, wOAMBuffer
	ld bc, $00a0
	call ClearMem
;> WaitFrame()
	call WaitFrame
;> fill(0x8F00, 4, 0xC0)                 # tile $F0: a dark 2x2 dot in its top-left corner
	ld hl, $8f00
	ld bc, $0004
	ld d, $c0
	call FillMem
;> fill(0x8F04, 0x1C, 0)
	ld bc, $001c
	call ClearMem
;> wOAMBuffer[0] = wMenuLast; wOAMBuffer[1] = wMapHeroX; wOAMBuffer[2] = 0xF0   # the hero
	ld hl, wOAMBuffer
	ld a, [wMenuLast]
	ld [hli], a
	ld a, [wMapHeroX]
	ld [hli], a
	ld [hl], $f0
;> wOAMBuffer[4] = wMidRows; wOAMBuffer[5] = wMapHomeX; wOAMBuffer[6] = 0xF0    # the home
	ld hl, wOAMBuffer+4
	ld a, [wMidRows]
	ld [hli], a
	ld a, [wMapHomeX]
	ld [hli], a
	ld [hl], $f0
;> hSysFlags = (hSysFlags | 0x80) & ~0x01
	ld hl, hSysFlags
	set 7, [hl]
	res 0, [hl]

.blink
;> while True:
;>     SetTimer(30)
	ld hl, $001e
	call SetTimer
;>     WaitFrame()
	call WaitFrame
;>     rLCDC ^= 0x02                     # sprites on / off
	ldh a, [rLCDC]
	xor $02
	ldh [rLCDC], a

.wait
;>     while True:
;>         held, new, restart = TakeButtons()
	call TakeButtons
;>         if restart:
;>             return GiveUp()
	jp c, GiveUp

;>         if new & A_BUTTON:
;>@close             break                  # (leaves both loops)
	bit 0, c
	jr nz, .close

;>         if not TimerRunning():
;>             break
	call TimerRunning
	jr z, .blink

	jr .wait

.close
;=@close
;> WaitFrame()
	call WaitFrame
;> rLCDC = 0x9D
	ld a, $9d
	ldh [rLCDC], a
;> hSysFlags = (hSysFlags & ~0x80) | 0x01
	ld hl, hSysFlags
	res 7, [hl]
	set 0, [hl]
;> ClearWindowMap()
	call ClearWindowMap
;> src = 0x4A72; dest = 0x8000          # the game's 384 tiles
	ld de, $4a72
	ld hl, $8000
	ld c, $61

.reload
;>@reload for _ in range(0x60):
	dec c
	jr z, .reloaded

;>     WaitFrame()
	ld b, $40
	call WaitFrame
;>     copy(dest, src, 0x40); dest += 0x40; src += 0x40
	call CopyB
;=@reload
	jr .reload

.reloaded
;> if hSysFlags & 0x40:                  # the hero's changed look
	ld hl, hSysFlags
	bit 6, [hl]
	jr z, .tilesDone

;>     LoadAltTiles()
	call LoadAltTiles
;>     if hHeroFlags & 0x20:
	ld hl, hHeroFlags
	bit 5, [hl]
	jr z, .tilesDone

;>         LoadFireHitTiles()
	call LoadFireHitTiles

.tilesDone
;> LoadTile3EOnThirdKill()
	call LoadTile3EOnThirdKill
;> rSCY = wNearRows
	ld a, [wNearRows]
	ldh [rSCY], a
;> rSCX = wMapSavedSCX
	ld a, [wMapSavedSCX]
	ldh [rSCX], a
;> hSysFlags &= ~0x10
	ld hl, hSysFlags
	res 4, [hl]
;> rLCDC = 0x85
	ld a, $85
	ldh [rLCDC], a
;> rLYC = 0
	xor a
	ldh [rLYC], a
;> copy(wOAMBuffer, wSavedOAM, 0xA0)     # the sprites back
	ld b, $a0
	ld hl, wOAMBuffer
	ld de, wSavedOAM
	call CopyB
;> WaitFrame()
	call WaitFrame
;> rLCDC = 0x87                          # sprites on
	ld a, $87
	ldh [rLCDC], a
;> hSysFlags = (hSysFlags | 0x80) & ~0x01
	ld hl, hSysFlags
	set 7, [hl]
	res 0, [hl]
;> return SpellDone()
	jp SpellDone


;@ def GetMapTilePtr() -> hl
;@ path: player/magic/map
;@ Map spell: where the current tile's bytes are in wMapRowTiles.
;@ reads: wMapTileHi, wMapTileLo
;@ sig: ccfd24b6
GetMapTilePtr::
;> return wMapTileHi << 8 | wMapTileLo
	ld a, [wMapTileHi]
	ld h, a
	ld a, [wMapTileLo]
	ld l, a
	ret


;@ def GetMapCellPtr() -> hl
;@ path: player/magic/map
;@ Map spell: the map position of the next cell to draw.
;@ reads: wMapCellHi, wMapCellLo
;@ sig: 48e012fe
GetMapCellPtr::
;> return wMapCellHi << 8 | wMapCellLo
	ld a, [wMapCellHi]
	ld h, a
	ld a, [wMapCellLo]
	ld l, a
	ret


;@ def CompareMapTiles() -> (de, carry)
;@ path: player/magic/map
;@ Map spell: tiles written so far minus 240; carry while still in the first 240.
;@ reads: wMapTilesHi, wMapTilesLo
;@ sig: f7918582
CompareMapTiles::
;> n = (wMapTilesHi << 8 | wMapTilesLo) - 240
	ld a, [wMapTilesHi]
	ld d, a
	ld a, [wMapTilesLo]
	ld e, a
	ld hl, $00f0
;> return (u16(n), n < 0)
	call SubDE
	ret


;@ def CastBreak()
;@ path: player/magic/break
;@ The break spell: asks for a direction and crumbles the wall there. It stays active (hHeroFlags
;@ bit 1) until the next step or spell: walking against a wall with B held breaks it too.
;@ Casting it costs no potion.
;@ test: skip waits for buttons and animates
;@ sig: 65cd1b09
CastBreak::
;> hHeroFlags |= 0x02
	ld hl, hHeroFlags
	set 1, [hl]
;> if AskSpellDirection():               # carry: no wall there, or restart
;>     MoveThievesAndMonsters(); return
	call AskSpellDirection
	jr c, BreakWallAhead.done

;> return BreakWallAhead()               # (falls through)

;@ def BreakWallAhead()
;@ path: player/magic/break
;@ Crumbles the wall in front of the hero (hHeroDir), unless the direction is diagonal and
;@ he has less than 3000 maximum hit points. The monsters take their turn after it.
;@ test: skip animates and moves the monsters
;@ sig: e953a221
BreakWallAhead::
;> if not DiagonalBlocked():
	call DiagonalBlocked
	jr c, .done

;>     CrumbleWallAhead()
	call CrumbleWallAhead

.done
;> MoveThievesAndMonsters()
	call MoveThievesAndMonsters
	ret


;@ def CastKick()
;@ path: player/magic/kick
;@ The kick spell: asks for a direction and kicks the wall block there (KickWallAhead).
;@ It stays active (hHeroFlags bit 0) like break: B held against a wall kicks again.
;@ test: skip waits for buttons and animates
;@ sig: cc41c511
CastKick::
;> hHeroFlags |= 0x01
	ld hl, hHeroFlags
	set 0, [hl]
;> if AskSpellDirection():
	call AskSpellDirection
;>     MoveThievesAndMonsters(); TakeButtons(); WaitFrame(); TakeButtons()   # (KickWallAhead's end: no potion spent)
;>     return
	jr c, KickWallAhead.noKick

;> return KickWallAhead()                # (falls through)

;@ def KickWallAhead()
;@ path: player/magic/kick
;@ Kicks the wall block in front of the hero (hHeroDir). If the cell behind it is not free
;@ (off the map, not empty, or a monster there) the block just crumbles. Otherwise it flies
;@ as a sprite pair (tiles $E0/$F0), 2 pixels a frame, until the next cell is not empty: there
;@ it lands as a wall again. A monster in its way is defeated outright and only then is the
;@ potion spent; out of sight the block slides on unseen for up to 60 cells. Diagonal kicks
;@ need 3000 maximum hit points.
;@ writes: hKickRange, hOAMCount, hSavedSCX, hSavedSCY
;@ reads: hKickRange, hOAMCount
;@ test: skip animates sprites and waits for frames
;@ sig: 3923ba66
KickWallAhead::
;> if not DiagonalBlocked():
	call DiagonalBlocked
	jr c, .noKick

;>     two, front, off = GetPosTwoAhead()
	call GetPosTwoAhead
	push de
;>     hSavedSCY = hi(two)               # (used here as the block's next cell)
	ld a, h
	ldh [hSavedSCY], a
;>     hSavedSCX = lo(two)
	ld a, l
	ldh [hSavedSCX], a
;>     if off or GetCellNibble(two) != 0 or FindObjectAt(two) != 0:
	jr c, .crumble

	call GetCellNibble
	cp $00
	jr nz, .crumble

;>         # (a monster behind it?)
	push hl
	pop de
	call FindObjectAt
	xor a
	cp b
	jr z, .kick

.crumble
;>         CrumbleWallAhead()            # the block cannot move: it crumbles
	pop af
	call CrumbleWallAhead

.noKick
;>         # (on to the end, no potion spent)
	jp .finish


.kick
;>     else:
;>         PlaySfx(1)
	ld a, $01
	call PlaySfx
;>         SetHeroSpriteDir()
	call SetHeroSpriteDir
;>         SetCellAndDraw(front, 0)      # the block leaves its cell...
	pop hl
	ld a, $00
	call SetCellAndDraw
;>         if hOAMCount != 20:           # ... and becomes a sprite pair in the last slot
	ldh a, [hOAMCount]
	cp $14
	jr z, .slotFull

;>             hOAMCount += 1
	inc a
	ldh [hOAMCount], a

.slotFull
;>         sprite = wOAMBuffer + (hOAMCount - 1) * 8
	dec a
	sla a
	ld c, a
	ld b, $00
	sla c
	sla c
;>         yx = AddFacingStep(0x5058)    # its screen position (the hero is at Y $50, X $58)
	ld de, $5058
	call AddFacingStep
	ld hl, wOAMBuffer
	add hl, bc
	push hl
	push de
;>         mem[sprite] = hi(yx); mem[sprite + 1] = lo(yx)
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
;>         mem[sprite + 2] = 0xE0; mem[sprite + 3] = 0
	ld [hl], $e0
	inc hl
	ld [hl], $00
	inc hl
;>         mem[sprite + 4] = hi(yx); mem[sprite + 5] = lo(yx) + 8
	ld [hl], d
	inc hl
	ld a, e
	add $08
	ld [hli], a
;>         mem[sprite + 6] = 0xF0; mem[sprite + 7] = 0
	ld [hl], $f0
	inc hl
	ld [hl], $00
;>         WaitOAMCopy()
	call WaitOAMCopy

.flyCell
;>         while True:                   # one cell (16 pixels) per pass
;>@frames             for _ in range(8):
	ld a, $08

.flyFrame
;>                 dy, dx, step = GetDirStep()
	pop de
	pop hl
	push hl
	push de
	push af
	call GetDirStep
;>                 MoveSpritePairBy2(sprite, dy, dx)
	call MoveSpritePairBy2
;>                 MoveSpritePairBy2(sprite + 4, dy, dx)   # the right half
	inc hl
	inc hl
	call MoveSpritePairBy2
;>                 WaitOAMCopy()
	call WaitOAMCopy
;=@frames
	pop af
	dec a
	jr nz, .flyFrame

;>             here, nxt, off = AdvanceKickPos()
	call AdvanceKickPos
	push de
;>             if off:
;>                 SetCellAndDraw(here, 1); break   # (at .landHere below)
	jr c, .landHere

;>             monster = FindObjectAt(nxt)   # (hl: the monster's record + 4)
	push hl
	push hl
	pop de
	call FindObjectAt
;>             if monster:
;>@hs1                 SetCellAndDraw(here, 1)   # the block stops in front of it
;>@hs2                 ClearScrollState()
;>@hs3                 if NextSpritePosOffscreen(yx) or NextSpritePosOffscreen(AddFacingStep(yx)):
;>@hs4                     DefeatMonster(monster - 3); mem[monster - 4] = 0; mem[monster - 3] = 0
;>                     # (then the potion-spending end, below)
;>                 else:
;>@hs5                     DefeatMonster(monster - 3)
;>@hs6                     RemoveObject(monster - 3, yx)   # it vanishes in a puff
;>@hs7                 MoveThievesAndMonsters(); TakeButtons(); WaitFrame(); TakeButtons()
;>                 return SpellDone()
	xor a
	cp b
	jr nz, .hitSeen

;>             if GetCellNibble(nxt) != 0:
	pop hl
	call GetCellNibble
	cp $00
	jr z, .moveOn

.landHere
;>                 SetCellAndDraw(here, 1)   # lands as a wall
	pop hl
	ld a, $01
	call SetCellAndDraw
;>                 break
	pop bc
	pop bc
	jr .finish

.hitSeen
;=@hs1
	pop de
	pop de
	push hl
	push de
	pop hl
;=@hs1
	ld a, $01
	call SetCellAndDraw
;=@hs2
	call ClearScrollState
;=@hs3
	pop hl
	pop de
	push hl
	call NextSpritePosOffscreen
	jr c, .hitNoPuff

;=@hs3
	call NextSpritePosOffscreen
	jr nc, .hitPuff

.hitNoPuff
;=@hs4
	pop hl
	pop af
	jr .defeat

.hitPuff
;=@hs5
	pop hl
	dec hl
	dec hl
	dec hl
	call DefeatMonster
;=@hs6
	call RemoveObject
;=@hs7
	pop bc
	jr .spent

.moveOn
;>             yx, gone = NextSpritePosOffscreen(yx)
	pop hl
	pop de
	call NextSpritePosOffscreen
;>             if not gone:
;>                 continue
	jr c, .offscreen

	push de
	jr .flyCell

.offscreen
;>             mem[sprite] = 0; mem[sprite + 1] = 0   # out of sight: hide the sprite pair
	pop hl
	xor a
	ld [hli], a
	ld [hli], a
;>             mem[sprite + 4] = 0; mem[sprite + 5] = 0
	inc hl
	inc hl
	ld [hli], a
	ld [hl], a
;>             hSysFlags |= 0x80
	ld hl, hSysFlags
	set 7, [hl]
;>             hKickRange = 60
	ld a, $3c

.slide
;>             while True:               # slide on unseen
	ldh [hKickRange], a
;>                 here, nxt, off = AdvanceKickPos()
	call AdvanceKickPos
	push de
;>                 if off:
;>                     break
	jr c, .land

;>                 monster = FindObjectAt(nxt)
	push hl
	push hl
	pop de
	call FindObjectAt
;>                 if monster:
;>@hu1                     SetCellNibble(here, 1)   # stops in front of it (map only)
;>@hu2                     DefeatMonster(monster - 3)
;>@hu3                     mem[monster - 4] = 0; mem[monster - 3] = 0   # its record is free
;>@hu4                     MoveThievesAndMonsters()
;>@hu5                     TakeButtons(); WaitFrame(); TakeButtons()
;>@hu6                     return SpellDone()     # the potion is spent
	xor a
	cp b
	jr nz, .hitUnseen

;>                 if GetCellNibble(nxt) != 0:
;>                     break
	pop hl
	call GetCellNibble
	cp $00
	jr nz, .land

;>                 hKickRange -= 1
;>                 if hKickRange == 0:
	ldh a, [hKickRange]
	dec a
;>                     break
	jr z, .land

	pop hl
	jr .slide

.land
;>             SetCellNibble(here, 1)    # (only the map: it is out of sight)
;>             break
	pop hl
	ld a, $01
	call SetCellNibble

.finish
;> MoveThievesAndMonsters()
	call MoveThievesAndMonsters
;> TakeButtons(); WaitFrame(); TakeButtons()   # drop the presses made meanwhile
	call TakeButtons
	call WaitFrame
	call TakeButtons
	ret


.hitUnseen
;=@hu1
	pop de
	pop de
	push hl
	push de
	pop hl
;=@hu1
	ld a, $01
	call SetCellNibble
	pop hl

.defeat
;=@hu2
	dec hl
	dec hl
	dec hl
	call DefeatMonster
;=@hu3
	dec hl
	xor a
	ld [hli], a
	ld [hli], a

.spent
;=@hu4
	call MoveThievesAndMonsters
;=@hu5
	call TakeButtons
	call WaitFrame
	call TakeButtons
;=@hu6
	jp SpellDone


;@ def AdvanceKickPos() -> (de, hl, carry)
;@ path: player/magic/kick
;@ Moves the kicked block's position (kept in hSavedSCY/hSavedSCX) one step in hHeroDir.
;@ Returns the old position (de), the new one (hl) and carry when the new one is off the map.
;@ writes: hSavedSCX, hSavedSCY
;@ reads: hSavedSCX, hSavedSCY
;@ test: skip
;@ sig: d6ac0bb4
AdvanceKickPos::
;> here = hSavedSCY << 8 | hSavedSCX
	ldh a, [hSavedSCY]
	ld h, a
	ldh a, [hSavedSCX]
	ld l, a
	push hl
;> nxt, off = StepPos(here)
	call StepPos
;> hSavedSCY = hi(nxt)
	ld a, h
	ldh [hSavedSCY], a
;> hSavedSCX = lo(nxt)
	ld a, l
	ldh [hSavedSCX], a
;> return (here, nxt, off)
	pop de
	ret


;@ def AskSpellDirection() -> carry
;@ path: player/magic
;@ Break and kick: waits for a direction (into hHeroDir) and checks the cell there. No carry
;@ only when it is a wall (cell 1); carry when it is anything else or off the map, and when
;@ A+Select restarts the game (hit points set to 0).
;@ writes: hHeroDir
;@ test: skip waits for buttons the VBlank interrupt delivers
;@ sig: 88f5bcfd
AskSpellDirection::
;> RedrawMonsters()
	call RedrawMonsters

.wait
;> while True:
;>     held, new, restart = TakeButtons()
	call TakeButtons
;>     if restart:
;>         ZeroHP(); return True
	jr nc, .noRestart

	call ZeroHP
	scf
	ret


.noRestart
;>     if held & (UP | DOWN | LEFT | RIGHT):
;>         break
	ld a, b
	and UP | DOWN | LEFT | RIGHT
	jr z, .wait

;> hHeroDir = held & (UP | DOWN | LEFT | RIGHT)
	ldh [hHeroDir], a
;> cell, off = GetCellAhead()
	call GetCellAhead
;> if off:
;>     return True
	ret c

;> return cell != 0x01
	cp $01
	scf
	ret nz

	ccf
	ret


;@ def MoveSpritePairBy2(oam: hl, dy: b, dx: c) -> hl
;@ path: gfx/sprites
;@ Moves one sprite by 2*dy pixels down and 2*dx across; returns the address of its tile byte.
;@ test: hl = rng.randrange(0xC000, 0xDFF0)
;@ sig: f9db058f
MoveSpritePairBy2::
;> mem[oam] = u8(mem[oam] + 2 * dy)
	ld a, [hl]
	add b
	add b
	ld [hli], a
;> mem[oam + 1] = u8(mem[oam + 1] + 2 * dx)
	ld a, [hl]
	add c
	add c
	ld [hli], a
;> return oam + 2
	ret


;@ def NextSpritePosOffscreen(yx: de) -> (de, carry)
;@ path: gfx/sprites
;@ Moves a sprite position one cell in hHeroDir (AddFacingStep) and gives carry when it is
;@ outside the visible screen (Y below 16 or from 160 on, X below 8 or from 168 on).
;@ test: skip
;@ sig: b1d1c364
NextSpritePosOffscreen::
;> yx = AddFacingStep(yx)
	call AddFacingStep
;> if hi(yx) >= 0xA0:
;>     return (yx, True)
	ld a, d
	cp $a0
	jr nc, .outside

;> if hi(yx) < 0x10:
;>     return (yx, True)
	cp $10
	ret c

;> if lo(yx) >= 0xA8:
;>     return (yx, True)
	ld a, e
	cp $a8
	jr nc, .outside

;> return (yx, lo(yx) < 0x08)
	cp $08
	ret c

	ret


.outside
	scf
	ret


;@ def CrumbleWallAhead()
;@ path: player/magic/break
;@ The cell in front of the hero becomes empty, shown crumbling: pictures $18 and $19 for 10
;@ frames each, then the empty floor; sound effect 0.
;@ test: skip draws to VRAM and waits for frames
;@ sig: 552a1ed4
CrumbleWallAhead::
;> SetHeroSpriteDir()
	call SetHeroSpriteDir
;> hSysFlags |= 0x80
	ld hl, hSysFlags
	set 7, [hl]
;> bg = SetCellAndDraw(GetPosAhead(), 0)   # returns the cell's place in the BG map
	call GetPosAhead
	ld a, $00
	call SetCellAndDraw
;> DrawMetatileNextFrame(bg, 0x18)
	push hl
	ld a, $18
	call DrawMetatileNextFrame
;> DelayFrames(10)
	ld a, $0a
	call DelayFrames
;> DrawMetatileNextFrame(bg, 0x19)
	pop hl
	push hl
	ld a, $19
	call DrawMetatileNextFrame
;> DelayFrames(10)
	ld a, $0a
	call DelayFrames
;> DrawMetatileNextFrame(bg, 0)
	pop hl
	ld a, $00
	call DrawMetatileNextFrame
;> PlaySfx(0)
	ld a, $00
	call PlaySfx
;> TakeButtons()
	call TakeButtons
	ret


;@ def DefeatMonster(rec: hl)
;@ path: combat/reward
;@ A monster is beaten by a spell: the maximum hit points grow (RaiseMaxHP), its life (record
;@ bytes +8/+9) drops to 0 and the windows open showing its picture. rec points at the
;@ record's byte +1.
;@ writes: hCurObjHi, hCurObjLo, hPictureOverride
;@ test: skip opens the windows (VRAM, VBlank)
;@ sig: d3bab928
DefeatMonster::
;> RaiseMaxHP(rec)
	push de
	push hl
	call RaiseMaxHP
	pop hl
	push hl
;> hCurObjHi = hi(rec)
	ld a, h
	ldh [hCurObjHi], a
;> hCurObjLo = lo(rec)
	ld a, l
	ldh [hCurObjLo], a
;> hPictureOverride = mem[rec + 1] + 1   # show this monster's kind
	inc hl
	ld a, [hld]
	inc a
	ldh [hPictureOverride], a
;> mem[rec + 7] = 0; mem[rec + 8] = 0    # life 0
	ld de, $0007
	add hl, de
	xor a
	ld [hli], a
	ld [hl], a
;> ShowWindows()
	call ShowWindows
	pop hl
	pop de
	ret


;@ def CastFreeze()
;@ path: player/magic/freeze
;@ The freeze spell: every monster on the 8 cells around the hero is turned into a still
;@ object showing the cell it stands on (FreezeMonsterAt). The potion is spent only when
;@ at least one monster was caught.
;@ test: skip moves the monsters and plays a sound
;@ sig: 4745594e
CastFreeze::
;> RedrawMonsters()
	call RedrawMonsters
;> pos = GetHeroPos()
	call GetHeroPos
;> missed = True
	scf
;> for step in (-81, -80, -79, 1, 81, 80, 79, -1):   # all 8 neighbours
;>     missed = FreezeMonsterAt(pos, step, missed)
	ld bc, -81
	call FreezeMonsterAt
	ld bc, -80
	call FreezeMonsterAt
;>     # (unrolled)
	ld bc, -79
	call FreezeMonsterAt
	ld bc, $0001
	call FreezeMonsterAt
;>     # (81, 80)
	ld bc, $0051
	call FreezeMonsterAt
	ld bc, $0050
	call FreezeMonsterAt
;>     # (79, -1)
	ld bc, $004f
	call FreezeMonsterAt
	ld bc, -1
	call FreezeMonsterAt
;> MoveThievesAndMonsters()
	push af
	call MoveThievesAndMonsters
	pop af
;> if missed:
;>     return
	ret c

;> PlaySfx(2)
	ld a, $02
	call PlaySfx
;> return SpellDone()
	jp SpellDone


;@ def FreezeMonsterAt(pos: hl, step: bc, missed: carry) -> carry
;@ path: player/magic/freeze
;@ If a monster stands on pos + step it becomes an object of kind $10 + the cell type
;@ there (such objects stand still and look like that cell), and the carry is cleared.
;@ test: skip
;@ sig: 4acde8bb
FreezeMonsterAt::
;> p = u16(pos + step)
	push af
	push hl
	add hl, bc
	push hl
	pop de
;> cell = GetCellNibble(p)
	call GetCellNibble
;> rec = FindObjectAt(p)                  # (hl: the record's byte +4)
	push af
	call FindObjectAt
	pop de
;> if not rec:
;>     return missed
	xor a
	cp b
	jr nz, .found

	pop hl
	pop af
	ret


.found
;> mem[rec - 3] = cell + 0x10            # the kind byte
	dec hl
	dec hl
	dec hl
	ld a, d
	add $10
	ld [hl], a
;> return False
	pop hl
	pop af
	ret nc

	ccf
	ret


;@ def CastFlash()
;@ path: player/magic/flash
;@ The flash spell: the screen flashes (the VBlank handler inverts the palette every 8
;@ frames) for 4 + 5 * 256 frames, about 21 seconds; meanwhile the monsters stand still.
;@ test: skip plays a sound and spends the potion
;@ sig: 8d8bb9ab
CastFlash::
;> PlaySfx(3)
	ld a, $03
	call PlaySfx
;> hFlashRounds = 5
	ld de, $0504
	ld hl, hFlashRounds
	ld [hl], d
;> hFlashTimer = 4
	inc hl
	ld [hl], e
;> return SpellDone()
	jp SpellDone


;@ def CastFly()
;@ path: player/magic/fly
;@ The fly spell: the hero takes off (his tiles are swapped for the flying ones from $6652,
;@ the old ones parked in VRAM at $9C00) and flies over everything: the D-pad steers, B
;@ hovers, A lands. Flight time (hFlyTime, 255) ticks down once a second and once a step;
;@ when it runs out he lands as soon as the cell below allows it (not a wall, not cell
;@ types $10-$14, no monster). Landing puts his tiles back and spends the potion.
;@ writes: hFlyTime, hHeroDir, wOAMBuffer
;@ reads: hHeroDir, wSongId
;@ test: skip swaps VRAM tiles, plays music and waits for buttons
;@ sig: afa8de15
CastFly::
;> DropMarker()
	call DropMarker
;> HideObjects()
	call HideObjects
;> RedrawObjectsInView()
	call RedrawObjectsInView
;> hFlyTime = 255
	ld a, $ff
	ldh [hFlyTime], a
;> CopySixTiles(0x8000, 0x9C00)          # park the hero's walking tiles
	ld de, $8000
	ld hl, $9c00
	call CopySixTiles
;> CopySixTiles(0x8080, 0x9C80)
	ld de, $8080
	ld hl, $9c80
	call CopySixTiles
;> CopySixTiles(0x8100, 0x9D00)
	ld de, $8100
	ld hl, $9d00
	call CopySixTiles
;> CopySixTiles(0x6652, 0x8000)          # and load the flying ones
	ld de, FlyTiles
	ld hl, $8000
	call CopySixTiles
;> CopySixTiles(0x66B2, 0x8080)
	ld de, FlyTiles + $60
	ld hl, $8080
	call CopySixTiles
;> CopySixTiles(0x6712, 0x8100)
	ld de, FlyTiles + $C0
	ld hl, $8100
	call CopySixTiles
;> wOAMBuffer[2] = 0x08; wOAMBuffer[3] = 0
	ld hl, wOAMBuffer+2
	ld a, $08
	ld [hli], a
	ld [hl], $00
;> wOAMBuffer[6] = 0x08; wOAMBuffer[7] = 0x20   # the right half mirrored
	ld hl, wOAMBuffer+6
	ld [hli], a
	ld [hl], $20
;> PlaySong(0x14)                        # take-off tune
	ld a, $14
	call PlaySong

.takeOff
;> while True:                           # the hero blinks while it plays
;>     CopyOAMAndDelay(8)
	ld a, $08
	call CopyOAMAndDelay
;>     wOAMBuffer[0] = 0; wOAMBuffer[4] = 0
	xor a
	ld [wOAMBuffer], a
	ld [wOAMBuffer+4], a
;>     CopyOAMAndDelay(8)
	ld a, $08
	call CopyOAMAndDelay
;>     wOAMBuffer[0] = 0x50; wOAMBuffer[4] = 0x50
	ld a, $50
	ld [wOAMBuffer], a
	ld [wOAMBuffer+4], a
;>     if wSongId == 0xFF:
;>         break
	ld a, [wSongId]
	cp $ff
	jr nz, .takeOff

;> hSysFlags |= 0x80
	ld hl, hSysFlags
	set 7, [hl]
;> hHeroDir = 0
	xor a
	ldh [hHeroDir], a
;> PlaySong(8)                           # flying music
	ld a, $08
	call PlaySong

.second
;> while True:
;>     SetTimer(60)
	ld hl, $003c
	call SetTimer

.poll
;>     while TimerRunning():             # (when it runs out: a tick, below)
	call TimerRunning
	jp z, .tick

;>         held, new, restart = TakeButtons()
	call TakeButtons
;>         if restart:
;>             return GiveUp()
	jp c, GiveUp

;>         if new & A_BUTTON:
	bit 0, c
	jr z, .notA

;>             if LandingBlocked():
;>@hover                 hHeroDir = 0; WaitNoActionButtons(); continue
	call LandingBlocked
	jr z, .hover

;>             break                     # (out of both loops: land, below)
	jp .land


.notA
;>         if new & B_BUTTON:            # hover
	bit 1, c
	jr z, .steer

.hover
;=@hover
;>             hHeroDir = 0
	xor a
	ldh [hHeroDir], a
;>             WaitNoActionButtons()
;>             continue
	call WaitNoActionButtons
	jr .poll

.steer
;>         if held & (UP | DOWN | LEFT | RIGHT):
;>             hHeroDir = held
	ld a, b
	and UP | DOWN | LEFT | RIGHT
	jr z, .move

	ld a, b
	ldh [hHeroDir], a

.move
;>         if hHeroDir == 0:
;>             continue
	ldh a, [hHeroDir]
	or a
	jr z, .poll

;>         ahead, off = GetCellAhead()
	call GetCellAhead
;>         if off:
;>             continue
	jr c, .poll

;>         ScrollView()                  # one step, over anything
	call ScrollView
;>         if hHeroDir & UP:
	ldh a, [hHeroDir]
	bit 6, a
	jr z, .notUp

;>             left, right = 0x0800, 0x0820   # tile and attributes of the two halves
	ld bc, $0800
	ld de, $0820
	jr .frame

.notUp
;>         elif hHeroDir & DOWN:
	bit 7, a
	jr z, .notDown

;>             left, right = 0x0840, 0x0860   # flipped upside down
	ld bc, $0840
	ld de, $0860
	jr .frame

.notDown
;>         elif hHeroDir & LEFT:
	bit 5, a
	jr z, .right

;>             left, right = 0x0000, 0x1000
	ld bc, $0000
	ld de, $1000
	jr .frame

.right
;>         else:
;>             left, right = 0x1020, 0x0020   # mirrored
	ld bc, $1020
	ld de, $0020

.frame
;>         wOAMBuffer[2] = hi(left); wOAMBuffer[3] = lo(left)
	ld hl, wOAMBuffer+2
	ld [hl], b
	inc hl
	ld [hl], c
;>         wOAMBuffer[6] = hi(right); wOAMBuffer[7] = lo(right)
	inc hl
	inc hl
	inc hl
	ld [hl], d
	inc hl
	ld [hl], e
;>         AnimateStep()
	call AnimateStep
;>         wOAMBuffer[2] -= 4                # the other wing beat
	ld hl, wOAMBuffer+2
	ld a, [hl]
	sub $04
	ld [hli], a
;>         wOAMBuffer[6] -= 4
	inc hl
	inc hl
	inc hl
	ld a, [hl]
	sub $04
	ld [hl], a
;>         hSysFlags |= 0x80
;>         break                         # a step counts as a tick too
	ld hl, hSysFlags
	set 7, [hl]

.tick
;>     GetCellUnderHero()                # (its result is not used)
	call GetCellUnderHero
;>     hFlyTime -= 1
;>     if hFlyTime == 0:
	ld hl, hFlyTime
	dec [hl]
	jp nz, .second

;>         if not LandingBlocked():
;>             break                     # out of time: land
	call LandingBlocked
	jr nz, .land

;>         hFlyTime += 2                 # not here: fly two more ticks
	ld hl, hFlyTime
	inc [hl]
	inc [hl]
	jp .second


.land
;> PlayFieldMusic()
	call PlayFieldMusic
;> hSysFlags |= 0x01
	ld hl, hSysFlags
	set 0, [hl]
;> CopySixTiles(0x9C00, 0x8000)          # the walking tiles back
	ld de, $9c00
	ld hl, $8000
	call CopySixTiles
;> CopySixTiles(0x9C80, 0x8080)
	ld de, $9c80
	ld hl, $8080
	call CopySixTiles
;> CopySixTiles(0x9D00, 0x8100)
	ld de, $9d00
	ld hl, $8100
	call CopySixTiles
;> hFlyTime = 0
	xor a
	ldh [hFlyTime], a
;> ResetHeroSprite()
	call ResetHeroSprite
;> return SpellDoneRespawn()             # (falls through)

;@ def SpellDoneRespawn()
;@ path: player/magic
;@ End of the spells that move the hero far: the objects are reset, then SpellDone.
;@ test: skip
;@ sig: c9aacee5
SpellDoneRespawn::
;> ResetObjectStates()
	call ResetObjectStates
;> return SpellDone()                    # (falls through)

;@ def SpellDone()
;@ path: player/magic
;@ A spell was cast: one potion less (hPotionsHi/Lo), then the buttons must be let go.
;@ test: skip waits for the buttons to be released
;@ sig: 22118416
SpellDone::
;> DecCounter16(hPotionsHi)
	ld hl, hPotionsHi
	call DecCounter16
;> return CloseMenu()                    # (falls through)

;@ def CloseMenu()
;@ path: player/magic
;@ Waits until A and B are let go.
;@ test: skip waits for the buttons to be released
;@ sig: 193bd27c
CloseMenu::
;> WaitNoActionButtons()
	call WaitNoActionButtons
	ret


;@ def GiveUp()
;@ path: player/magic
;@ A+Select in a spell restarts the game: hit points to 0.
;@ sig: 1e40fe14
GiveUp::
;> ZeroHP()
	call ZeroHP
	ret


;@ def LandingBlocked() -> zero
;@ path: player/magic/fly
;@ Zero (cannot land) when the hero is over a wall (cell 1), a cell type $10-$14 or a monster.
;@ test: skip
;@ sig: a2b5e6b4
LandingBlocked::
;> cell = GetCellUnderHero()
	call GetCellUnderHero
;> if cell == 0x01:
;>     return True
	cp $01
	ret z

;> if 0x10 <= cell < 0x15:
;>     return True
	cp $10
	jr c, .notBig

	cp $15
	jr nc, .notBig

	xor a
	ret


.notBig
;> monster = FindObjectAt(GetHeroPos())
	call GetHeroPos
	push hl
	pop de
	call FindObjectAt
;> if monster:
;>     return True
	ld a, b
	or a
	jr z, .free

	xor a
	ret


.free
;> return False
	ld a, $01
	or a
	ret


;@ def CopySixTiles(src: de, dest: hl) -> (de, hl)
;@ path: gfx/tiles
;@ Copies 96 bytes (six tiles) into VRAM, 64 and then 32 bytes, a frame apart.
;@ test: skip waits for frames
;@ sig: fa511aaa
CopySixTiles::
;> CopyTiles4(src, dest)                 # 64 bytes
	call CopyTiles4
;> WaitFrame()
	call WaitFrame
;> copy(dest + 64, src + 64, 32)
	ld b, $20
	call CopyB
	ret


;@ def ResetObjectStates()
;@ path: monsters/spawn
;@ After the hero was moved far (warp, jump, return, fly): byte +0 of all 77 object records
;@ (the 13 thieves and the 64 monsters, which follow each other) is cleared, and so are the
;@ flag bits 6-7 of bytes +1 and +2; then the thieves and the monsters take a turn.
;@ writes: hHeroDir
;@ test: skip runs the monster and thief turns
;@ sig: 5cddb634
ResetObjectStates::
;>@loop for rec in range(wThieves, wThieves + 77 * 14, 14):
	ld hl, wThieves
	ld de, $000c
	ld b, $4d
	xor a

.loop
;>     mem[rec] = 0
	ld [hli], a
;>     mem[rec + 1] &= 0x3F
	res 7, [hl]
	res 6, [hl]
;>     mem[rec + 2] &= 0x3F
	inc hl
	res 7, [hl]
	res 6, [hl]
;=@loop
	add hl, de
	dec b
	jr nz, .loop

;> hHeroDir = 0
	xor a
	ldh [hHeroDir], a
;> UpdateThieves()
	call UpdateThieves
;> UpdateMonsters()
	call UpdateMonsters
	ret


;@ def InitObjects()
;@ path: monsters/spawn
;@ Empties the 64 monster records of wObjects at the start of a game. Byte +2 gets the kind
;@ before the first one to appear: $1F, 1, 2, 3 for groups of 4 slots in turn, so the slots'
;@ first monsters are of kinds 0, 2, 3 and 4.
;@ test: skip
;@ sig: 2509ce7b
InitObjects::
;> rec = wObjects
;> kind = 0x1F
	ld b, $10
	ld de, $000a
	ld hl, wObjects
	ld a, $1f

.group
;>@group for _ in range(16):
;>@slot     for _ in range(4):
	ld c, $04

.slot
;>         mem[rec] = 0; mem[rec + 1] = 0   # empty
	ld [hl], $00
	inc hl
	ld [hl], $00
	inc hl
;>         mem[rec + 2] = kind
	ld [hli], a
;>         mem[rec + 4] = 0
	inc hl
	ld [hl], $00
;>         rec += 14
	add hl, de
;=@slot
	dec c
	jr nz, .slot

;>     if kind == 0x1F:
	cp $1f
	jr nz, .not1F

;>         kind = 1
	ld a, $01
	jr .next

.not1F
;>     elif kind == 3:
	cp $03
	jr nz, .inc

;>         kind = 0x1F
	ld a, $1f
	jr .next

.inc
;>     else:
;>         kind += 1
	inc a

.next
;=@group
	dec b
	jr nz, .group

	ret


;@ path: monsters/spawn
;@ Where new monsters appear: 16 map positions (big-endian), picked by the low nibble of
;@ hCellYX (UpdateMonsters). As row, column: 5,65  15,15  25,5  25,45  35,25  35,75  45,5
;@ 45,55  60,29  60,69  61,11  87,10  89,29  93,10  97,76  98,59.
ObjectSpawnPoints::
	db $c1, $d1, $c4, $bf, $c7, $d5, $c7, $fd, $cb, $09, $cb, $3b, $ce, $15, $ce, $47
	db $d2, $dd, $d3, $05, $d3, $1b, $db, $3a, $db, $ed, $dd, $1a, $de, $9c, $de, $db
;@ path: monsters/spawn
;@ The 32 monster kinds: three big-endian words each, copied into a new monster's record
;@ bytes +8 to +13; the first is its life (DefeatMonster sets it to 0), the other two are
;@ its fighting values. Kind: life, value 2, value 3 -
;@ 0: 150 30 15; 1: 300 80 40; 2: 200 200 160; 3: 420 400 300; 4: 500 750 640;
;@ 5: 750 1300 1100; 6: 1000 2000 1140; 7: 2000 2500 1780; 8: 30000 3500 900;
;@ 9: 10000 4550 3600; 10: 6000 5800 6100; 11: 1300 7000 5400; 12: 4700 8500 8900;
;@ 13: 6000 10000 5100; 14: 5000 11500 9100; 15: 14700 13500 8600; 16: 9000 15000 10900;
;@ 17: 27000 17500 27000; 18: 34800 19500 14200; 19: 30000 22000 12500;
;@ 20: 16000 24500 14100; 21: 6000 27000 32700; 22: 64700 29500 1100;
;@ 23: 28000 32300 11100; 24: 15000 35500 20100; 25: 34700 38500 33000;
;@ 26: 51000 41500 1000; 27: 39000 45000 22000; 28: 48000 48300 34200;
;@ 29: 30000 50000 24500; 30: 60000 55000 40000; 31: 65000 65000 52000.
ObjectKindStats::
	db $00, $96, $00, $1e, $00, $0f   ; 0
	db $01, $2c, $00, $50, $00, $28   ; 1
	db $00, $c8, $00, $c8, $00, $a0   ; 2
	db $01, $a4, $01, $90, $01, $2c   ; 3
	db $01, $f4, $02, $ee, $02, $80   ; 4
	db $02, $ee, $05, $14, $04, $4c   ; 5
	db $03, $e8, $07, $d0, $04, $74   ; 6
	db $07, $d0, $09, $c4, $06, $f4   ; 7
	db $75, $30, $0d, $ac, $03, $84   ; 8
	db $27, $10, $11, $c6, $0e, $10   ; 9
	db $17, $70, $16, $a8, $17, $d4   ; 10
	db $05, $14, $1b, $58, $15, $18   ; 11
	db $12, $5c, $21, $34, $22, $c4   ; 12
	db $17, $70, $27, $10, $13, $ec   ; 13
	db $13, $88, $2c, $ec, $23, $8c   ; 14
	db $39, $6c, $34, $bc, $21, $98   ; 15
	db $23, $28, $3a, $98, $2a, $94   ; 16
	db $69, $78, $44, $5c, $69, $78   ; 17
	db $87, $f0, $4c, $2c, $37, $78   ; 18
	db $75, $30, $55, $f0, $30, $d4   ; 19
	db $3e, $80, $5f, $b4, $37, $14   ; 20
	db $17, $70, $69, $78, $7f, $bc   ; 21
	db $fc, $bc, $73, $3c, $04, $4c   ; 22
	db $6d, $60, $7e, $2c, $2b, $5c   ; 23
	db $3a, $98, $8a, $ac, $4e, $84   ; 24
	db $87, $8c, $96, $64, $80, $e8   ; 25
	db $c7, $38, $a2, $1c, $03, $e8   ; 26
	db $98, $58, $af, $c8, $55, $f0   ; 27
	db $bb, $80, $bc, $ac, $85, $98   ; 28
	db $75, $30, $c3, $50, $5f, $b4   ; 29
	db $ea, $60, $d6, $d8, $9c, $40   ; 30
	db $fd, $e8, $fd, $e8, $cb, $20   ; 31

;@ def UpdateMonsters()
;@ path: monsters/move
;@ One round over the 64 monster records, starting at slot hNextMonster. An empty slot gets a new monster
;@ (the next of the 32 kinds) at its spawn point - or at the hero's home once the dragon has been beaten -
;@ unless the screen is flashing. A monster fighting the hero (flags bit 6) stays put. While the hero walks,
;@ only the monsters of one parity move each frame. A monster on screen walks towards the hero, or away when
;@ he is at full health, kills it with one blow and it cannot hurt him; next to him it stops (and fights).
;@ When its way is blocked it keeps its old direction or tries random ones. Off screen at most 8 monsters
;@ wander per round; the next round starts after them.
;@ writes: hCellYX, hCount, hMonsterParity, hNextMonster, hOffscreenMoves, hSavedSCX, hSavedSCY, hTemp1, hTemp2, hVisibleObjects
;@ reads: hCellYX, hCount, hDragonKills, hFlashTimer, hHPHi, hHPLo, hHeroDir, hHomePosHi, hHomePosLo, hMonsterParity, hNextMonster, hObjCol, hObjRow, hSavedSCX, hSavedSCY, hStrHi, hStrLo, hTemp1, hTemp2, hVisibleObjects
;@ test: skip works through the object records with many routines that are not annotated yet
;@ sig: 33bdf012
UpdateMonsters::
;> hNextMonster &= 0xFE
	ldh a, [hNextMonster]
	res 0, a
	ldh [hNextMonster], a
;> hCellYX = hNextMonster                  # the slot counter
	ldh [hCellYX], a
;> obj = hCellYX * 2
	ld hl, $0000
	ld d, $00
	ld e, a
	sla e
	add hl, de
;> obj += hCellYX * 4
	sla e
	rl d
	add hl, de
;> obj += hCellYX * 8                       # 14 bytes a record
	sla e
	rl d
	add hl, de
;> obj += wObjects + 1                      # the flags byte
	ld de, wObjects + 1
	add hl, de
;> hSavedSCX = 0                            # (borrowed) 1 = the hero walks: monsters move by parity
	ld b, $00
;>@wk if hDragonKills == 0 and hHeroDir != 0 and hFlashTimer == 0:
	ldh a, [hDragonKills]
	or a
	jr nz, .setWalkFlag

;=@wk
	ldh a, [hHeroDir]
	or a
	jr z, .setWalkFlag

	ldh a, [hFlashTimer]
	or a
	jr nz, .setWalkFlag

;>     hSavedSCX = 1
	ld b, $01
;>     hMonsterParity ^= 1
	ldh a, [hMonsterParity]
	xor $01
	ldh [hMonsterParity], a

.setWalkFlag
;> hOffscreenMoves = 0
	ld a, b
	ldh [hSavedSCX], a
	xor b
	ldh [hOffscreenMoves], a
;> records_left = 0x40
	ld a, $40

.loop
;>@lp while True:
;>     hSavedSCY = records_left             # (borrowed) records left to look at
	ldh [hSavedSCY], a
;>     act = 'next'
	push hl
;>     if mem[obj] == 0:                    # empty slot: a new monster may appear
	ld a, [hl]
	or a
	jp nz, .active

;>         if hFlashTimer == 0:
	ldh a, [hFlashTimer]
	or a
	jp nz, .next

;>@p             p = ObjectSpawnPoints + (hCellYX & 0x0F) * 2
	ldh a, [hCellYX]
	and $0f
	sla a
	ld d, $00
	ld e, a
;=@p
	ld hl, ObjectSpawnPoints
	add hl, de
;>             pos = mem[p] << 8 | mem[p + 1]
	ld d, [hl]
	inc hl
	ld e, [hl]
;>             if hDragonKills != 0:
	ldh a, [hDragonKills]
	or a
	jr z, .spawnPosSet

;>                 pos = hHomePosHi << 8 | hHomePosLo
	ldh a, [hHomePosHi]
	ld d, a
	ldh a, [hHomePosLo]
	ld e, a

.spawnPosSet
;>             if not IsCellBlocked(pos):
	call IsCellBlocked
	jp c, .next

;>                 mem[obj - 1] = 0             # not on screen
	pop hl
	push hl
	dec hl
	xor a
	ld [hli], a
;>                 mem[obj] = 2                 # active
	ld a, $02
	ld [hli], a
;>                 kind = (mem[obj + 1] + 1) & 0x1F   # the next kind in this slot
	ld a, [hl]
	inc a
	and $1f
;>                 mem[obj + 1] = kind
	ld [hli], a
	push af
;>                 mem[obj + 2] = 0             # no direction
	xor a
	ld [hli], a
;>                 mem[obj + 3] = hi(pos)       # position and previous position
	ld [hl], d
	inc hl
;>                 mem[obj + 4] = lo(pos)
	ld [hl], e
	inc hl
;>                 mem[obj + 5] = hi(pos)
	ld [hl], d
	inc hl
;>                 mem[obj + 6] = lo(pos)
	ld [hl], e
	inc hl
;>@src                 src = ObjectKindStats + kind * 6
	pop af
	push de
	sla a
	ld b, a
	sla a
	add b
;=@src
	push hl
	ld hl, ObjectKindStats
	ld d, $00
	ld e, a
	add hl, de
;=@src
	push hl
	pop de
	pop hl
;>                 copy(obj + 7, src, 6)        # hit points, attack, defence
	ld b, $06
	call CopyB
;>                 hTemp1 = ObjDistance(obj)
	pop de
	pop hl
	push hl
	push de
	call ObjDistance
	ldh [hTemp1], a
;>                 if hTemp1 != 0:              # on screen: show it appearing
	pop de
	or a
	jr z, .spawned

;>                     hTemp2 = 1
	ld a, $01
	ldh [hTemp2], a
;>                     FillObjectRecord(obj, 0x66, pos)   # direction $66 = just appeared
	ld b, $66
	pop hl
	push hl
	call FillObjectRecord

.spawned
	jp .next


.active
;>     elif mem[obj] & 0x40:                # fighting the hero: it stays put
	pop hl
	push hl
	bit 6, [hl]
	jr z, .mayMove

;>         hVisibleObjects += 1
	ldh a, [hVisibleObjects]
	inc a
	ldh [hVisibleObjects], a
	jp .next


.mayMove
;>     else:
;>@pv         mem[obj + 5] = mem[obj + 3]      # previous position = position
	inc hl
	inc hl
	inc hl
	ld d, [hl]
	inc hl
	ld a, [hli]
;=@pv
	ld [hl], d
	inc hl
;>         mem[obj + 6] = mem[obj + 4]
	ld [hl], a
;>@stand         if mem[obj] >= 0x10 or hFlashTimer != 0 or (hSavedSCX == 1 and (hSavedSCY ^ hMonsterParity) & 1):
	pop hl
	push hl
	ld a, [hl]
	sub $10
	jr nc, .stand

;=@stand
	ldh a, [hFlashTimer]
	or a
	jr nz, .stand

;=@stand
	dec hl
	ldh a, [hSavedSCX]
	dec a
	jr nz, .move

;=@stand
	ldh a, [hSavedSCY]
	ld b, a
	ldh a, [hMonsterParity]
	xor b
	bit 0, a
	jr z, .move

;=@stand
	ld a, [hl]
	jr z, .standDone

.stand
;>             dist = ObjDistance(obj)      # dying, frozen by the flash, or not its turn
	pop hl
	push hl
	call ObjDistance
;>             if dist != 0:
	or a
	jr z, .standOff

;>                 hTemp1 = dist
	ldh [hTemp1], a
;>                 hTemp2 = 1
	ld a, $01
	ldh [hTemp2], a
;>                 act = 'stay'
	jp .stay


.standOff
;>             else:
;>                 mem[obj - 1] = 0         # off screen
	pop hl
	push hl
	dec hl
	ld [hl], $00

.standDone
	jp .next


.move
;>         else:
;>             mem[obj - 1] = 0
	xor a
	ld [hli], a
;>             hTemp1 = ObjDistance(obj)
	call ObjDistance
	ldh [hTemp1], a
;>             if hTemp1 == 0:              # off screen: wander, at most 8 a round
	or a
	jr nz, .onScreen

;>                 if hOffscreenMoves != 8:
	ld hl, hOffscreenMoves
	ld a, [hl]
	cp $08
	jp z, .next

;>                     hOffscreenMoves += 1
	inc [hl]
;>                     if hOffscreenMoves == 8:     # the next round starts after this one
	cp $07
	jr nz, .wanderOff

;>                         hNextMonster = (hCellYX + 1) & 0x3F
	ldh a, [hCellYX]
	inc a
	cp $40
	jr nz, .setNext

	xor a

.setNext
	ldh [hNextMonster], a

.wanderOff
;>                     act = 'wander'
	jp .wander


.onScreen
;>             else:
;>                 kind = mem[obj + 1]          # (with the distance bits)
	pop hl
	push hl
	inc hl
	ld a, [hl]
;>@nf                 hTemp2 = 0                   # 1 = flee from the hero
;>@kind                 if kind == 0 or (kind != 0x14 and (kind & 0xF3) != 0):   # kinds 4, 8, 12, 20 never flee
	or a
	jr z, .fleeCheck

;=@kind
	cp $14
	jr z, .noFlee

	and $f3
	jr z, .noFlee

.fleeCheck
;>@fl                     if (mem[obj + 9] << 8 | mem[obj + 10]) < (hMaxHPHi << 8 | hMaxHPLo) \
;>                             and (hStrHi << 8 | hStrLo) - (mem[obj + 11] << 8 | mem[obj + 12]) \
;>                                 - (mem[obj + 7] << 8 | mem[obj + 8]) > 0 \
;>                             and (hHPHi << 8 | hHPLo) >= (hMaxHPHi << 8 | hMaxHPLo):
	ld de, $0008
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
;=@fl
	ld hl, hMaxHPHi
	call SubVarFromDE
	jr nc, .noFlee

;=@fl
	pop hl
	push hl
	ld de, $000b
	add hl, de
;=@fl
	ldh a, [hStrHi]
	ld d, a
	ldh a, [hStrLo]
	ld e, a
	call SubVarFromDE
	jr c, .noFlee

;=@fl
	pop hl
	push hl
	ld de, $000b
	add hl, de
;=@fl
	ldh a, [hStrHi]
	ld d, a
	ldh a, [hStrLo]
	ld e, a
	call SubVarFromDE
	jr c, .noFlee

;=@fl
	pop hl
	push hl
	push de
	ld de, $0007
	add hl, de
	pop de
;=@fl
	call SubVarFromDE
	jr c, .noFlee

	ld a, d
	or e
	jr z, .noFlee

;=@fl
	ldh a, [hHPHi]
	ld d, a
	ldh a, [hHPLo]
	ld e, a
;=@fl
	ld hl, hMaxHPHi
	call SubVarFromDE
	jr nc, .flee

.noFlee
;=@nf
	xor a
	jr .setFlee

.flee
;>                         hTemp2 = 1           # attack below his armour, one blow kills it, he is unhurt: run
	ld a, $01

.setFlee
;>                 if hObjRow == 6:             # the hero's row: straight left or right
	ldh [hTemp2], a
	ldh a, [hObjRow]
	cp $06
	jr nz, .notHeroRow

;>                     if hObjCol < 7:
	ldh a, [hObjCol]
	cp $07
	jr nc, .goLeft

;>                         direction, offset = 0x01, 0x01     # right
	ld bc, $0101
	jr .haveDir

.goLeft
;>                     else:
;>                         direction, offset = 0x0F, 0xFF     # left
	ld bc, $0fff
	jr .haveDir

.notHeroRow
;>                 elif hObjCol == 7:           # the hero's column: straight up or down
	ldh a, [hObjCol]
	cp $07
	jr nz, .diagonal

;>                     if hObjRow < 6:
	ldh a, [hObjRow]
	cp $06
	jr nc, .goUp

;>                         direction, offset = 0x10, 0x50     # down
	ld bc, $1050
	jr .haveDir

.goUp
;>                     else:
;>                         direction, offset = 0xF0, 0xB0     # up
	ld bc, $f0b0
	jr .haveDir

.diagonal
;>                 else:                        # diagonally towards him
;>                     direction, offset = (0x01, 0x01) if hObjCol < 7 else (0x0F, 0xFF)
	ld bc, $0fff
	jr nc, .diagHoriz

	ld bc, $0101

.diagHoriz
;>                     if hObjRow < 6:
	ldh a, [hObjRow]
	cp $06
	jr nc, .diagUp

;>                         direction |= 0x10                  # and down
	set 4, b
;>                         offset = (offset + 0x50) & 0xFF
	ld a, c
	add $50
	ld c, a
	jr .haveDir

.diagUp
;>                     else:
;>                         direction |= 0xF0                  # and up
	ld a, b
	or $f0
	ld b, a
;>                         offset = (offset - 0x50) & 0xFF
	ld a, c
	sub $50
	ld c, a

.haveDir
;>                 if hTemp2 == 1:              # fleeing: the opposite way
	ldh a, [hTemp2]
	dec a
	jr nz, .dirDone

;>@nd                     direction = (((direction ^ 0xFF) + 0x10) & 0xF0) | (((direction ^ 0xFF) + 1) & 0x0F)
	ld a, b
	xor $ff
	ld d, a
	add $10
	and $f0
	ld e, a
;=@nd
	ld a, d
	inc a
	and $0f
	or e
	ld b, a
;>                     offset = u8((offset ^ 0xFF) + 1)
	ld a, c
	xor $ff
	inc a
	ld c, a

.dirDone
;>                 if hTemp1 == 1 and hTemp2 != 1:   # next to the hero: stop and fight
;>                     act = 'stay'
	ldh a, [hTemp1]
	dec a
	jr nz, .stepTowards

	ldh a, [hTemp2]
	dec a
	jr nz, .stay

.stepTowards
;>                 else:
;>                     act = 'wander'
;>                     target = StepTarget(obj, offset)
	pop hl
	push hl
	call StepTarget
;>@unr                     if hTemp2 != 1 and hTemp1 == 1:   # (cannot happen any more)
;>                         act = 'store'
	ldh a, [hTemp2]
	dec a
	jr z, .tryStep

;=@unr
	ldh a, [hTemp1]
	dec a
	jp z, .store

.tryStep
;>                     elif not IsCellBlocked(target):
;>                         act = 'store'
	call IsCellBlocked
	jp nc, .store

;>                     elif direction & 0x0F and direction & 0xF0:   # blocked diagonally: try just up or down
	ld a, b
	and $0f
	jr z, .wander

	ld a, b
	and $f0
	jr z, .wander

;>                         target += 1 if direction & 0x08 else -1     # undo the sideways part
	bit 3, b
	jr z, .undoRight

	inc de
	jr .vertical

.undoRight
	dec de

.vertical
;>                         direction &= 0xF0
	ld a, b
	and $f0
	ld b, a
;>                         if not IsCellBlocked(target):
;>                             act = 'store'
	call IsCellBlocked
	jp nc, .store

.wander
;>     if act == 'wander':                  # keep the old direction if it is free
;>         direction = mem[obj + 2]
	pop hl
	push hl
	inc hl
	inc hl
	ld b, [hl]
;>         if direction != 0:
	xor a
	cp b
	jr z, .randomTries

;>             pos = mem[obj + 3] << 8 | mem[obj + 4]
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
;>             target = StepPosByDir(direction, pos)
	call StepPosByDir
;>             if not IsCellBlocked(target):
;>                 act = 'store'
	call IsCellBlocked
	jp nc, .store

.randomTries
;>         if act == 'wander':
;>             act = 'stay'                 # after 4 blocked tries it stays
	ld a, $04

.tryRandom
;>@rt             for _ in range(4):           # (counted down in hCount)
	ldh [hCount], a
;>                 direction, offset = RandomDirection(hl, af & 0xFF)
	call RandomDirection
;>                 target = StepTarget(obj, offset)
	pop hl
	push hl
	call StepTarget
;>@ok                 if not IsCellBlocked(target) and (hTemp1 != 1 or hTemp2 != 1 or target != hHeroPosHi << 8 | hHeroPosLo):
	call IsCellBlocked
	jr c, .nextTry

;=@ok
	ldh a, [hTemp1]
	dec a
	jr nz, .store

	ldh a, [hTemp2]
	dec a
	jr nz, .store

;=@ok
	ld hl, hHeroPosHi
	call CompareDEWithU16
	jr nz, .store

.nextTry
;>                     act = 'store'
;>                     break
;=@rt
	ldh a, [hCount]
	dec a
	jr nz, .tryRandom

.stay
;>     if act == 'stay':                    # no step this time
;>         target = GetObjPos(obj)
	pop hl
	push hl
	call GetObjPos
;>         direction = 0
;>         act = 'store'
	ld bc, $0000

.store
;>     if act == 'store':
;>         FillObjectRecord(obj, direction, target)
	pop hl
	push hl
	call FillObjectRecord

.next
;>     if hCellYX == 0x3F:                  # wrap around to the first record
	pop hl
	ldh a, [hCellYX]
	cp $3f
	jr nz, .nextRecord

;>         obj = wObjects + 1
;>         hCellYX = 0
	ld hl, wObjects + 1
	xor a
	jr .setSlot

.nextRecord
;>     else:
;>         obj += 14
	ld de, $000e
	add hl, de
;>         hCellYX += 1
	inc a

.setSlot
	ldh [hCellYX], a
;>     records_left = hSavedSCY - 1         # (stored at the top of the loop: hSavedSCY ends at 1)
;>     if records_left == 0:
	ldh a, [hSavedSCY]
	dec a
;=@lp
	jp nz, .loop

;>         return
	ret


;@ def StepTarget(obj: hl, offset: c) -> de
;@ path: monsters/move
;@ The map position one step from an object: its position plus the signed address offset of a direction
;@ (c of RandomDirection: +1 right, +80 down, -81 up-left ...). obj points at the record's flags byte (+1).
;@ sig: 6b1925e8
StepTarget::
;> pos = GetObjPos(obj)
	call GetObjPos
;> if offset & 0x80:                       # negative offset
	ld h, $00
	ld l, c
	bit 7, l
	jr z, .positive

;>     offset -= 0x100
	ld h, $ff

.positive
;> return u16(pos + offset)
	add hl, de
	push hl
	pop de
	ret


;@ def GetObjPos(obj: hl) -> de
;@ path: monsters/move
;@ Reads an object's map position (record +4/+5, big-endian); obj points at the record's flags byte (+1).
;@ sig: 768d7c3a
GetObjPos::
;> p = obj + 3
	inc hl
	inc hl
	inc hl
;> return mem[p] << 8 | mem[p + 1]
	ld d, [hl]
	inc hl
	ld e, [hl]
	ret


;@ def IsCellBlocked(pos: de) -> carry
;@ path: monsters/move
;@ Can a monster step onto this map cell? Blocked (carry) are positions off the map, walls (cell types 1
;@ and 9), the cell types $10-$14, a cell another monster stands on, and the hero's cell.
;@ sig: 21eecd06
IsCellBlocked::
;> if IsOffMap(pos):
;>     return True
	push bc
	push de
	push de
	pop hl
	call IsOffMap
	jr c, .done

;> cell = GetCell(pos)
	call GetCell
;>@cell if cell == 1 or cell == 9 or 0x10 <= cell < 0x15:    # walls and the like
;>@ret     return True
	cp $01
	jr z, .blocked

	cp $09
	jr z, .blocked

;=@cell
	cp $10
	jr c, .free

	cp $15
	jr c, .blocked

.free
;> if FindObjectAt(pos) != 0:              # b = slots left when it found one, 0 = none there
;>     return True
	call FindObjectAt
	xor a
	cp b
	jr nz, .blocked

;> if pos == hHeroPosHi << 8 | hHeroPosLo:
;>     return True
	ld hl, hHeroPosHi
	call CompareDEWithU16
	jr z, .blocked

;> return False
	scf
	ccf
	jr .done

.blocked
;=@ret
	scf

.done
	pop de
	pop bc
	ret


;@ def FindObjectAt(pos: de) -> b
;@ path: monsters/move
;@ Looks for an active monster at a map position among the 64 records of wObjects. Returns b = the number
;@ of slots that were still left to search when it found one (not 0), or 0 when no monster stands there.
;@ sig: b8d7e89c
FindObjectAt::
;> n = 0x40
	ld b, $40
;> p = wObjects + 4                        # position field of the first record
	ld hl, wObjects + 4

.loop
;> while True:
;>     active = mem[p - 3]
	push hl
	dec hl
	dec hl
	dec hl
	ld a, [hl]
	pop hl
;>     if active and pos == mem[p] << 8 | mem[p + 1]:
	or a
	jr z, .next

	call CompareDEWithU16
;>         return n
	ret z

.next
;>     n -= 1
	dec b
;>     if n == 0:
;>         return 0
	ret z

;>     p += 14
	push bc
	ld bc, $000e
	add hl, bc
	pop bc
	jr .loop

;@ def UndoObjectSteps()
;@ path: monsters/move
;@ Puts all 64 monsters back where they were before their last step (+6/+7 into +4/+5), clears their
;@ direction and the "peaceful" flag (bit 7). Used after an UpdateMonsters pass that should only work out who is on screen.
;@ sig: 8518f63f
UndoObjectSteps::
;> obj = wObjects + 1
	ld b, $40
	ld hl, wObjects + 1
	ld de, $000b

.loop
;>@lp for _ in range(0x40):
;>     mem[obj] &= ~0x80                    # no longer peaceful
	res 7, [hl]
;>     mem[obj + 2] = 0                     # no direction
	inc hl
	inc hl
	xor a
	ld [hli], a
;>     mem[obj + 3] = mem[obj + 5]          # position = previous position
	inc hl
	inc hl
	inc hl
	ld a, [hld]
	ld c, a
	ld a, [hld]
;>     mem[obj + 4] = mem[obj + 6]
	ld [hl], c
	dec hl
	ld [hl], a
;>     obj += 14
	add hl, de
;=@lp
	dec b
	jr nz, .loop

	ret


;@ def InitThieves()
;@ path: monsters/thieves
;@ Sets up the 13 thief records from ThiefStarts: kind $20, inactive, the start direction and position,
;@ turn timer $29 and no item.
;@ sig: 559ceb63
InitThieves::
;> obj = wThieves
	ld b, $0d
	ld hl, wThieves
;> src = ThiefStarts
	ld de, ThiefStarts

.loop
;>@lp for _ in range(13):
;>     mem[obj] = 0                         # not on screen
	xor a
	ld [hli], a
;>     mem[obj + 1] = 0                     # inactive (UpdateThieves wakes them up)
	ld [hli], a
;>     mem[obj + 2] = 0x20                  # kind: thief
	ld [hl], $20
	inc hl
;>     mem[obj + 3] = mem[src]              # direction
	ld a, [de]
	inc de
	ld [hli], a
;>     mem[obj + 4] = mem[src + 1]          # position and previous position
	ld a, [de]
	inc de
	ld [hli], a
	ld c, a
;>     mem[obj + 5] = mem[src + 2]
	ld a, [de]
	inc de
	ld [hli], a
;>     mem[obj + 6] = mem[src + 1]
	ld [hl], c
	inc hl
;>     mem[obj + 7] = mem[src + 2]
	ld [hli], a
;>     mem[obj + 8] = 0x29                  # turn timer
	ld [hl], $29
	inc hl
;>     mem[obj + 9] = 0                     # carries nothing
	ld [hl], $00
;>     obj, src = obj + 14, src + 3
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
;=@lp
	dec b
	jr nz, .loop

	ret


;@ path: monsters/thieves
;@ Start of the 13 thieves, 3 bytes each: direction (row nibble, column nibble: 1 = down/right, F = up/left),
;@ map position (big-endian). Nine start in the top row at column 4 ($C004), one at the top-left corner
;@ ($C000), and the last four at the dragon's lair ($DC15, the middle of the dragon's body).
ThiefStarts::
	db $11, $c0, $04
	db $1f, $c0, $04
	db $11, $c0, $00
	db $ff, $c0, $04
	db $f1, $c0, $04
	db $01, $c0, $04
	db $10, $c0, $04
	db $0f, $c0, $04
	db $f0, $c0, $04
	db $ff, $dc, $15
	db $f1, $dc, $15
	db $11, $dc, $15
	db $1f, $dc, $15

;@ def UpdateThieves()
;@ path: monsters/thieves
;@ Moves the thieves, one step each. The stronger the hero, the more of them are out (all 13 once the
;@ dragon has been beaten three times). A thief that reaches the hero takes one of his pieces, or the item
;@ he carries when it reaches the cell where that item is shown (right of him); on its way it picks up items
;@ lying on the map (cell types 6-12) and drops what it carries on the next free floor cell once its turn
;@ timer has run out. Thieves fly over walls, only cell type 9 stops them, and leave the map on one side to
;@ come back on the other.
;@ writes: hCarriedItem, hCount, hJumpPosHi, hJumpPosLo, hPiecesCarried, hTemp1, hTemp2, hTemp7, hVisibleObjects
;@ reads: hCarriedCell, hCarriedItem, hCount, hDragonKills, hPiecesCarried, hStrHi, hSysFlags, hTemp7
;@ test: skip walks the thief records through several routines that are not annotated yet
;@ sig: 175427f6
UpdateThieves::
;> hVisibleObjects = 0
	xor a
	ldh [hVisibleObjects], a
;> if not hSysFlags & 0x40:                # no thieves in this part of the game
;>     return
	ldh a, [hSysFlags]
	bit 6, a
	ret z

;> n = hStrHi >> 5                         # one more thief for every 8192 points of strength
	ldh a, [hStrHi]
	srl a
	srl a
	srl a
	srl a
	srl a
;> n += 2
	add $02
;> if n >= hThiefCount:
;>     hThiefCount = n                     # never fewer than before
	ld hl, hThiefCount
	cp [hl]
	jr c, .countSet

	ld [hl], a

.countSet
;> if hDragonKills >= 3:
;>     hThiefCount = 13
	ldh a, [hDragonKills]
	cp $03
	jr c, .countDone

	ld a, $0d
	ld [hl], a

.countDone
;> obj = wThieves + 1
;> n = hThiefCount
	ld a, [hl]
	ld hl, wThieves + 1
	inc a

.loop
;>@lp for _ in range(n):
	dec a
	ret z

	push af
	push hl
;>     mem[obj] = 2                         # active
	ld [hl], $02
;>     action = 'look'                      # look for the hero and for items
;>     if mem[obj + 7] != 0:                # turn timer still running
	ld bc, $0007
	add hl, bc
	ld a, [hl]
	or a
	jr z, .timerDone

;>         mem[obj + 7] -= 1
	dec [hl]
	jr .look

.timerDone
;>     elif mem[obj + 8] == 0:              # timer over, carrying nothing: just turn
;>         action = 'turn'
	inc hl
	ld a, [hl]
	cp $00
	jp z, .turn

;>     else:
;>         item = mem[obj + 8]
	pop de
	push de
	push af
	push hl
;>         cell, pos = CellUnderObject(obj)
	call CellUnderObject
	pop de
;>         if cell == 0:                    # free floor: put the item down here
	cp $00
	jr nz, .keepItem

;>             mem[obj + 8] = 0
	xor a
	ld [de], a
;>             hJumpPosHi = hi(pos)         # the jump spell's target
	ld a, h
	ldh [hJumpPosHi], a
;>             hJumpPosLo = lo(pos)
	ld a, l
	ldh [hJumpPosLo], a
;>             new_cell = item
;>             action = 'change'
	jr .changeCell

.keepItem
	pop af

.look
;>     if action == 'look':
;>         if mem[obj + 8] != 0:            # hands full: walk on
	pop hl
	push hl
	ld de, $0008
	add hl, de
	ld a, [hl]
	or a
;>             action = 'walk'
	jp nz, .walk

;>         else:
;>             hero = GetHeroPos()
	push hl
	pop bc
	call GetHeroPos
	push hl
	pop de
;>             pos = mem[obj + 3] << 8 | mem[obj + 4]
;>@pc             if pos == hero and hPiecesCarried != 0:      # on the hero: take a piece
	pop hl
	push hl
	inc hl
	inc hl
	inc hl
	call CompareDEWithU16
;=@pc
	jr nz, .notOnHero

	ldh a, [hPiecesCarried]
	or a
	jr z, .pickUp

;>                 hPiecesCarried -= 1
	dec a
	ldh [hPiecesCarried], a
;>@took                 mem[obj + 8] = 0x0C
	ld a, $0c
	jr .took

.notOnHero
;>             elif pos == u16(hero + 1) and hCarriedItem != 0:   # where his item is shown: take it
	inc de
	call CompareDEWithU16
	jr nz, .pickUp

	ldh a, [hCarriedItem]
	or a
	jr z, .pickUp

;>                 hCarriedItem = 0
	xor a
	ldh [hCarriedItem], a
;>                 mem[obj + 8] = hCarriedCell
	ldh a, [hCarriedCell]

.took
;=@took
	ld [bc], a
;>                 action = 'turn'
	jr .turn

.pickUp
;>             else:
;>@cl                 cell = GetCellNibble(pos)
	pop hl
	push hl
	inc hl
	inc hl
	inc hl
	ld a, [hli]
;=@cl
	ld l, [hl]
	ld h, a
	call GetCellNibble
;>                 if cell < 6 or cell >= 0x0D:      # not an item
;>                     action = 'walk'
	cp $06
	jr c, .walk

	cp $0d
	jr nc, .walk

;>@pk                 elif cell == 0x0A and Random(hl, af & 0xFF) >= 0x56:   # this item only one time in three
;>                     action = 'walk'
	cp $0a
	jr nz, .pick

	call Random
	cp $56
	jr nc, .walk

;=@pk
	ld a, $0a

.pick
;>                 else:
;>                     mem[obj + 8] = cell
	ld [bc], a
;>                     new_cell = 0                 # take it off the map
;>                     action = 'change'
	ld a, $00
	push af

.changeCell
;>     if action == 'change':
;>         under = MapPosUnderWindow(pos)   # the cell lies under an open window
	push hl
	pop de
	call MapPosUnderWindow
;>         flags = hSysFlags
	ld l, a
	ldh a, [hSysFlags]
	ld h, a
	push hl
;>         if under:
;>             CloseWindows()
	jr z, .notUnder

	push de
	call CloseWindows
	pop de

.notUnder
;>         SetCell(new_cell, pos)
	pop hl
	pop af
	push hl
	call SetCell
	pop hl
;>         if under:
;>             if flags & 0x08:
	ld a, l
	or a
	jr z, .turn

	bit 3, h
	jr z, .notWindow3

;>                 OpenStatusWindow()              # draw the window over it again
	push hl
	call OpenStatusWindow
	pop hl

.notWindow3
;>             if flags & 0x04:
;>                 OpenMonsterWindow()
	bit 2, h
	jr z, .turn

	call OpenMonsterWindow

.turn
;>         action = 'turn'
	ld a, $01
	jp .move


.walk
;>     turn = action == 'turn'
	xor a

.move
;>     hTemp1 = ObjDistance(obj)
	pop hl
	push hl
	push af
	call ObjDistance
	ldh [hTemp1], a
;>     hTemp2 = 1                           # a thief never attacks
	ld a, $01
	ldh [hTemp2], a
;>     # (obj and the turn flag stay on the stack)
	pop af
	pop hl
	push hl
	push af
;>     direction = mem[obj + 2]
	inc hl
	inc hl
	ld b, [hl]
;>     pos = mem[obj + 3] << 8 | mem[obj + 4]
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
;>     mem[obj + 5] = hi(pos)               # previous position
	inc hl
	ld [hl], d
;>     mem[obj + 6] = lo(pos)
	inc hl
	ld [hl], e
;>     hCount = direction
	ld a, b
	ldh [hCount], a
;>     hTemp7 = 5                           # tries before it turns back
	ld a, $05
	ldh [hTemp7], a
;>     if turn:
	pop af
	pop hl
	push hl
	push de
	dec a
	jr nz, .step

;>         direction = TurnThief(1, obj, af & 0xFF)
	ld a, $01
	call TurnThief

.step
;>     while True:
;>         new = StepPosByDir(direction, pos)
	pop de
	push de
	call StepPosByDir
;>         if IsOffMap(new):                # off one edge of the map: in at the other
	call IsOffMap
	jr nc, .onMap

;>             if new < 0xC000:
;>                 new += 0x1F40
	ld a, h
	cp $c0
	jr nc, .belowMap

	ld de, $1f40
	jr .wrap

.belowMap
;>             else:
;>                 new -= 0x1F40
	ld de, $e0c0

.wrap
;>             new = u16(new)
	add hl, de
	push hl
	pop de

.onMap
;>         if GetCellNibble(new) != 9:
;>             break
	call GetCellNibble
	cp $09
	jr nz, .stepOk

;>         if hTemp7 != 1:                  # try another direction
	ldh a, [hTemp7]
	dec a
	jr z, .reverse

;>             hTemp7 -= 1
	ldh [hTemp7], a
;>             direction = TurnThief(0, obj, af & 0xFF)
	pop de
	pop hl
	push hl
	push de
	xor a
	call TurnThief
;>             continue
	jr .step

.reverse
;>@rv         direction   = u8(((hCount & 0xF0) ^ 0xF0) + 0x10) | (((hCount & 0x0F) ^ 0x0F) + 1)   # both nibbles negated
	ldh a, [hCount]
	and $f0
	xor $f0
	add $10
	ld b, a
;=@rv
	ldh a, [hCount]
	and $0f
	xor $0f
	inc a
	or b
	ld b, a
;>@md         mem[obj + 2] = direction
	pop de
	pop hl
	push hl
	inc hl
	inc hl
	inc hl
;=@md
	ld [hl], b
;>         new = StepPosByDir(direction, pos)   # tried enough: back the way it came
;>         break
	call StepPosByDir
	jr .store

.stepOk
	pop af

.store
;>     FillObjectRecord(obj, direction, new)
	pop hl
	push hl
	call FillObjectRecord
;>     obj += 14
	pop hl
	ld de, $000e
	add hl, de
;=@lp
	pop af
	jp .loop


;@ def CellUnderObject(obj: de) -> (a, hl)
;@ path: monsters/thieves
;@ The map cell type under an object and its position; obj points at the record's flags byte (+1).
;@ test: obj = rand(0xC000, 0xDD00); mem[obj + 3] = rand(0xC0, 0xDE)
;@ sig: 42256457
CellUnderObject::
;> p = obj + 3
	inc de
	inc de
	inc de
;> pos = mem[p] << 8 | mem[p + 1]
	ld a, [de]
	ld h, a
	inc de
	ld a, [de]
	ld l, a
;> return (GetCellNibble(pos), pos)
	call GetCellNibble
	ret


;@ def TurnThief(reset_timer: a, obj: hl, flags: f) -> b
;@ path: monsters/thieves
;@ Gives a thief a new random direction; with reset_timer = 1 also restarts its turn timer.
;@ Returns the new direction in b (c holds its address offset). The random number depends on obj and
;@ on the flags the caller left (see Random).
;@ test: obj = rand(0xC000, 0xDFF0); flags = rand(0, 15) << 4
;@ sig: 584f2894
TurnThief::
;> direction, offset = RandomDirection(obj, flags)
	push af
	push hl
	call RandomDirection
	pop hl
;> mem[obj + 2] = direction
	ld a, b
	inc hl
	inc hl
	ld [hli], a
;> # on to the turn timer at +8
	inc hl
	inc hl
	inc hl
	inc hl
;> if reset_timer == 1:
	pop af
	dec a
	ret nz

;>     mem[obj + 7] = 0x29
;> return direction
	ld [hl], $29
	ret


;@ def InitDragon()
;@ path: monsters/dragon
;@ Sets up the dragon's four records from DragonStarts: active, kinds $21-$24, position and the 6 bytes of
;@ hit points and strength values. Then starts the head animation (the second write was surely meant for
;@ hDragonFlip, but it clears hDragonTile again).
;@ writes: hDragonTile
;@ sig: 5d9ea890
InitDragon::
;> obj = wDragon
	ld c, $04
	ld hl, wDragon
;> src = DragonStarts
	ld de, DragonStarts

.loop
;>@lp for n in range(4, 0, -1):
;>     mem[obj] = 0                         # not on screen
	ld [hl], $00
	inc hl
;>     mem[obj + 1] = 2                     # active
	ld [hl], $02
	inc hl
;>     mem[obj + 2] = 0x25 - n              # kinds $21 (head), $22, $23, $24
	ld a, $25
	sub c
	ld [hli], a
;>     mem[obj + 3] = 0                     # no direction
	ld [hl], $00
	inc hl
;>     mem[obj + 4] = mem[src]              # position and previous position
	ld a, [de]
	inc de
	ld b, a
	ld [hli], a
;>     mem[obj + 5] = mem[src + 1]
	ld a, [de]
	inc de
	ld [hli], a
;>     mem[obj + 6] = mem[src]
	ld [hl], b
	inc hl
;>     mem[obj + 7] = mem[src + 1]
	ld [hli], a
;>     copy(obj + 8, src + 2, 6)            # hit points and the strength values
	ld b, $06
	call CopyB
;>     obj, src = obj + 14, src + 8          # where hl and de have ended up
;=@lp
	dec c
	jr nz, .loop

;> hDragonTile = 0xC4
	ld a, $c4
	ldh [hDragonTile], a
;> hDragonTile = 0
	xor a
	ldh [hDragonTile], a
	ret


;@ path: monsters/dragon
;@ The dragon's four parts, 8 bytes each: map position (big-endian), then three big-endian words copied to
;@ record +8: hit points and two strength values. The head ($DBC5, 65000 hit points) sits above the three
;@ body parts at $DC14, $DC15 and $DC16; the middle one ($FFFF, 0, $FFFF) cannot be beaten.
DragonStarts::
	db $db, $c5, $fd, $e8, $c3, $50, $9c, $40
	db $dc, $14, $fd, $e8, $ea, $60, $75, $30
	db $dc, $16, $fd, $e8, $c3, $50, $94, $70
	db $dc, $15, $ff, $ff, $00, $00, $ff, $ff

;@ def BuildSprites()
;@ path: gfx/sprites/lists
;@ Builds the sprites of a frame. Slot 0 of the first OAM buffer is the hero; then come the item he
;@ carries, the block he pushes, the marker and the dragon's head. Every thief and monster on screen goes
;@ into one of three lists by its distance from the hero: near (next to him) straight into the first buffer,
;@ middle and far into lists of their own. A monster dying blinks; one right next to the hero starts a fight
;@ (flags bit 6). Then the middle and far lists are merged into the two OAM buffers, which the screen shows
;@ in turn: each screen row takes 5 sprite pairs per buffer (10 hardware sprites a line), so where more
;@ crowd together they flicker. Each pair also gets a second animation frame and a motion for the step
;@ animation. A thief in view plays a sound.
;@ writes: hCellYX, hCount, hCurObjPosHi, hCurObjPosLo, hDragonFlip, hDragonTile, hFarCount, hMarkCol, hMarkDX, hMarkDY, hMarkRow, hMergeIndex, hMergeLeft, hMergeList, hMergeTarget, hMidCount, hMotionPtrHi, hMotionPtrLo, hNearCount, hOAMCount, hPictureOverride, hRowRoom, hSpriteSlot, hStepShowList2, hTemp1, hTemp2, hTemp3, hTemp7, hTemp8, hVisibleObjects, wDragonVRAM, wOAMBuffer
;@ reads: hCarriedItem, hCellYX, hCount, hDragonFlip, hDragonTile, hFarCount, hFlashTimer, hHeroDir, hMarkCol, hMarkDX, hMarkDY, hMarkRow, hMergeIndex, hMergeLeft, hMergeList, hMergeTarget, hMidCount, hMotionPtrHi, hMotionPtrLo, hNearCount, hOAM2Count, hOAMCount, hObjCol, hObjRow, hPiecesCarried, hPushedCell, hRowRoom, hSpriteSlot, hTemp1, hTemp2, hTemp3, hTemp7, hTemp8, hVisibleObjects, wDragonVRAM, wScrollDX, wScrollDY
;@ test: skip builds whole sprite tables through many routines that are not annotated yet
;@ sig: 42ce32d7
BuildSprites::
;> hSpriteSlot = 0
	xor a
	ldh [hSpriteSlot], a
;> hNearCount = 0
;> hMidCount = 0
	ld hl, hNearCount
	ld [hli], a
	ld [hli], a
;> hFarCount = 0
	ld [hli], a
;> for r in range(9):
;>     hRowRoom[r] = 5                      # 5 sprite pairs a screen row
	ld hl, hRowRoom
	ld c, $09
	ld a, $05

.fillRoom
	ld [hli], a
	dec c
	jr nz, .fillRoom

;> hRowRoom[4] = 4                          # the hero's row: he is one of them
	ld a, $04
	ldh [hRowRoom + 4], a
;>@car if hCarriedItem != 0 or hPiecesCarried != 0:   # the item he carries, shown right of him
	ldh a, [hCarriedItem]
	or a
	jr nz, .carried

;=@car
	ldh a, [hPiecesCarried]
	or a
	jr z, .noItem

;>     tile = hCarriedItem or 0xEC            # $EC: a piece
	ld a, $ec

.carried
;>     SetSprite(0x50, 0x68, tile, wOAMBuffer + 8)   # slot 1, a single 8x16 sprite
	ld hl, wOAMBuffer + 8
	ld de, $5068
	call SetSprite
;>     mem[wOAMBuffer + 12] = 0                 # its right half stays hidden
	xor a
	ld [wOAMBuffer + 12], a
;>     mem[wOAMBuffer + 13] = 0
	ld [wOAMBuffer + 13], a
;>     hRowRoom[4] = 3
	ld a, $03
	ldh [hRowRoom + 4], a
;>     hSpriteSlot = 1
	ld a, $01
	ldh [hSpriteSlot], a

.noItem
;> if hPushedCell != 0:                     # the block he pushes, in front of him
	ldh a, [hPushedCell]
	or a
	jr z, .noBlock

;>     oam = NextSpriteSlot()
	call NextSpriteSlot
;>     row, col = 4, 5                      # the hero's cell
	ld de, $0405
;>     if hHeroDir & 0x80:                  # down
	ldh a, [hHeroDir]
	bit 7, a
	jr z, .notDown

;>         row = 5
	inc d
;>         hRowRoom[5] = 4
	ld a, $04
	ldh [hRowRoom + 5], a
;>         hRowRoom[6] = 4
	ldh [hRowRoom + 6], a
	jr .blockCol

.notDown
;>     elif hHeroDir & 0x40:                # up
	bit 6, a
	jr z, .level

;>         row = 3
	dec d
;>         hRowRoom[3] = 4
	ld a, $04
	ldh [hRowRoom + 3], a
;>         hRowRoom[2] = 4
	ldh [hRowRoom + 2], a
	jr .blockCol

.level
;>     else:
;>         hRowRoom[4] -= 1
	ldh a, [hRowRoom + 4]
	dec a
	ldh [hRowRoom + 4], a

.blockCol
;>     if hHeroDir & 0x10:                  # right
;>         col = 6
	ldh a, [hHeroDir]
	bit 4, a
	jr z, .notRight

	inc e
	jr .blockTile

.notRight
;>     elif hHeroDir & 0x20:                # left
;>         col = 4
	bit 5, a
	jr z, .blockTile

	dec e

.blockTile
;>     SetSpritePair(0xE0 + (hPushedCell & 2), row << 8 | col, oam)
	ldh a, [hPushedCell]
	and $02
	add $e0
	call SetSpritePair

.noBlock
;> if hMarkRow != 0 and hMarkRow != 0xFF:   # the marker sprite
	ldh a, [hMarkRow]
	or a
	jp z, .head

	cp $ff
	jp z, .head

;>     oam = NextSpriteSlot()
	call NextSpriteSlot
;>     SetSpritePair(0xE4, hMarkRow << 8 | hMarkCol, oam)
	ldh a, [hMarkRow]
	ld d, a
	ldh a, [hMarkCol]
	ld e, a
	ld a, $e4
	call SetSpritePair
;>     i = hSpriteSlot * 2
	ldh a, [hSpriteSlot]
	sla a
	ld b, $00
	ld c, a
;>     p = wSpriteFrame2 + i * 2                # second frame: tiles $E4 and $F4
	push bc
	sla c
	ld hl, wSpriteFrame2
	add hl, bc
;>     mem[p] = 0xE4
	ld [hl], $e4
	inc hl
;>     mem[p + 1] = 0
	xor a
	ld [hli], a
;>     mem[p + 2] = 0xF4
	ld [hl], $f4
	inc hl
;>     mem[p + 3] = 0
	ld [hl], a
;>     p = wScrollDY + i                        # its motion: the slide minus the scroll
	pop bc
	ld hl, wScrollDY
	add hl, bc
;>     dy = u8(hMarkDY - wScrollDY)
	ld a, [wScrollDY]
	ld b, a
	ldh a, [hMarkDY]
	sub b
;>     mem[p] = dy
	ld [hli], a
	push af
;>     mem[p + 1] = u8(hMarkDX - wScrollDX)
	ld a, [wScrollDX]
	ld c, a
	ldh a, [hMarkDX]
	sub c
	ld [hli], a
;>     if wScrollDY != 0 or wScrollDX != 0:     # the view stepped: the marker starts over
	ld a, b
	or c
	jr z, .markRoom

;>         hMarkRow = u8(4 - wScrollDY)         # on the cell the hero came from
	ld a, $04
	sub b
	ldh [hMarkRow], a
;>         hMarkCol = u8(5 - wScrollDX)
	ld a, $05
	sub c
	ldh [hMarkCol], a
;>         hMarkDY = 0
	xor a
	ldh [hMarkDY], a
;>         hMarkDX = 0
	ldh [hMarkDX], a

.markRoom
;>     r = hMarkRow
	ldh a, [hMarkRow]
	ld c, a
	ld b, $00
;>     hRowRoom[r] -= 1
	ld hl, hRowRoom
	add hl, bc
	dec [hl]
;>     if dy != 0:                              # it slides over further rows
;>         q = r
	pop af
	or a
	jr z, .head

;>         if not dy & 0x80:                    # downwards
	bit 7, a
	jr nz, .markUp

;>             q += 1
;>             hRowRoom[q] -= 1
	inc hl
	dec [hl]
;>             if (dy & 1) == 0:
	bit 0, a
	jr nz, .head

;>                 q += 1
;>                 hRowRoom[q] -= 1
	inc hl
	dec [hl]

.markUp
;>         if dy & 0x80 or (dy & 1) == 0:       # upwards - and a two-row slide down runs on into here
;>             q -= 1
	dec hl
;>             hRowRoom[q] -= 1
	dec [hl]
;>             if (dy & 1) == 0:
	bit 0, a
	jr nz, .head

;>                 q -= 1
;>                 hRowRoom[q] -= 1
	dec hl
	dec [hl]

.head
;> head = wDragon + 1                       # the dragon's head
;> dist = ObjDistance(head)
	ld hl, wDragon + 1
	call ObjDistance
;> if dist != 0:
	or a
	jp z, .headOff

;>@fight     if dist == 1 and (hHeroPosHi << 8 | hHeroPosLo) in (DRAGON_HEAD_POS - 0x50, DRAGON_HEAD_POS - 1, DRAGON_HEAD_POS + 1):
	dec a
	jr nz, .headRows

;=@fight
	ld de, DRAGON_HEAD_POS - $50
	ld hl, hHeroPosHi
	call CompareDEWithU16
	jr z, .headFight

;=@fight
	ld de, DRAGON_HEAD_POS - 1
	call CompareDEWithU16
	jr z, .headFight

;=@fight
	ld de, DRAGON_HEAD_POS + 1
	call CompareDEWithU16
	jr nz, .headRows

.headFight
;>         if not ScrolledLastStep():           # the hero stands above or beside it: fight
	call ScrolledLastStep
	jr c, .headRows

;>             mem[head] |= 0x40
	ld hl, wDragon + 1
	set 6, [hl]

.headRows
;>     UseRowRoom(hObjRow)
	ldh a, [hObjRow]
	call UseRowRoom
;>     if wScrollDY != 0:                       # while the view steps up or down it covers the next row too
	ld a, [wScrollDY]
	or a
	jr z, .headSprite

;>         HighNibbleSigned(wScrollDY)          # (the result is not used)
	call HighNibbleSigned
;>         if hObjRow + 1 < 0x100:
	xor a
	inc a
	ld hl, hObjRow
	add [hl]
	jr c, .headSprite

;>             UseRowRoom(hObjRow + 1)
	call UseRowRoom

.headSprite
;>     oam = NextSpriteSlot()
	call NextSpriteSlot
	push de
;>     hCurObjPosHi = hi(oam)                   # (borrowed) the head's OAM entry
	ld a, h
	ldh [hCurObjPosHi], a
;>     hCurObjPosLo = lo(oam)
	ld a, l
	ldh [hCurObjPosLo], a
	push hl
;>@cy     hCellYX = u8((hObjRow + 1 + wScrollDY) << 4) | ((hObjCol + 1 + wScrollDX) & 0x0F)   # where it is drawn
	ld hl, wScrollDY
	ldh a, [hObjRow]
	inc a
	add [hl]
	swap a
;=@cy
	and $f0
	ld b, a
	ldh a, [hObjCol]
	inc a
	inc hl
	add [hl]
;=@cy
	and $0f
	or b
	ldh [hCellYX], a
;>     oam = PutSpriteYX(oam)
	pop hl
	call PutSpriteYX
	push hl
;>     left = oam
;>     if wDragonVRAM[0] != 0:                     # on screen before: animate
	ld a, [wDragonVRAM]
	or a
	jr z, .headAppears

;>         hDragonTile ^= 0x10                  # $C4 <-> $D4
	ldh a, [hDragonTile]
	xor $10
;>         mem[oam] = hDragonTile
	ld [hli], a
	ldh [hDragonTile], a
;>         hDragonFlip ^= 0x20                  # and mirrored every other frame
	ldh a, [hDragonFlip]
	xor $20
;>         mem[oam + 1] = hDragonFlip
	ld [hli], a
	ldh [hDragonFlip], a
	jr .headRight

.headAppears
;>     else:                                    # just came into view
;>         vram = MapPosToBG(DRAGON_HEAD_POS)
	push hl
	ld de, DRAGON_HEAD_POS
	call MapPosToBG
;>         mem[wDragonVRAM] = hi(vram)
	ld a, h
	ld [wDragonVRAM], a
;>         mem[wDragonVRAM + 1] = lo(vram)
	ld a, l
	ld [wDragonVRAM + 1], a
	pop hl
;>         mem[oam] = 0xC4
	ld a, $c4
	ld [hli], a
;>         hDragonTile = 0xC4
	ldh [hDragonTile], a
;>         hDragonFlip = 0
	xor a
	ldh [hDragonFlip], a
;>         mem[oam + 1] = 0
	ld [hli], a

.headRight
;>     oam = PutRightHalfYX(oam + 2)
	call PutRightHalfYX
;>     mem[oam] = mem[left] ^ 0x10              # the right half: the other tile
	pop bc
	ld a, [bc]
	xor $10
	ld [hli], a
;>     mem[oam + 1] = mem[left + 1]
	inc bc
	ld a, [bc]
	ld [hli], a
;>     p = wSpriteFrame2 + hSpriteSlot * 4      # second frame: tiles 2 further on
	pop de
	srl e
	ld hl, wSpriteFrame2
	add hl, de
;>     mem[p] = mem[left] | 2
	push af
	dec bc
	ld a, [bc]
	or $02
	ld [hli], a
;>     mem[p + 1] = mem[left + 1]
	ld b, a
	pop af
	ld [hli], a
;>     mem[p + 2] = (mem[left] | 2) ^ 0x10
	ld c, a
	ld a, b
	xor $10
	ld [hli], a
;>     mem[p + 3] = mem[left + 1]
	ld [hl], c
;>     p = wScrollDY + hSpriteSlot * 2          # it stays put on the map: moves against the scroll
	srl e
	ld hl, wScrollDY
	add hl, de
;>     mem[p] = u8(-wScrollDY)
	ld a, [wScrollDY]
	xor $ff
	inc a
	ld [hli], a
;>     mem[p + 1] = u8(-wScrollDX)
	ld a, [wScrollDX]
	xor $ff
	inc a
	ld [hl], a
	jr .bodyParts

.headOff
;> else:
;>     mem[wDragonVRAM] = 0
	xor a
	ld [wDragonVRAM], a

.bodyParts
;> dest = BuildDragonPartSprite(wDragonVRAM + 2, wDragon + 14 + 1, DRAGON_LEFT_POS)
	ld bc, wDragonVRAM + 2
	ld de, DRAGON_LEFT_POS
	ld hl, wDragon + 14 + 1
	call BuildDragonPartSprite
;> BuildDragonPartSprite(dest, wDragon + 28 + 1, DRAGON_RIGHT_POS)
	ld de, DRAGON_RIGHT_POS
	ld hl, wDragon + 28 + 1
	call BuildDragonPartSprite
;>@mo motion = wScrollDY + (hSpriteSlot + 1) * 2   # the near list's motions follow the fixed slots
	ldh a, [hSpriteSlot]
	inc a
	sla a
	ld b, $00
	ld c, a
;=@mo
	ld hl, wScrollDY
	add hl, bc
;> hMotionPtrHi = hi(motion)
	ld a, h
	ldh [hMotionPtrHi], a
;> hMotionPtrLo = lo(motion)
	ld a, l
	ldh [hMotionPtrLo], a
;> obj = wThieves + 1                       # the 13 thieves, then the 64 monsters
	ld c, $4d
	ld hl, wThieves + 1

.objLoop
;>@ol for _ in range(13 + 64):
;>     if hVisibleObjects == 0:             # all on-screen objects done
	ldh a, [hVisibleObjects]
	or a
;>         break
	jp z, .merge

;>     if mem[obj - 1] != 0:                # on screen
	push bc
	push hl
	dec hl
	ld a, [hl]
	or a
	jp z, .nextObj

;>         hCellYX = mem[obj - 1]
	inc hl
	ldh [hCellYX], a
;>         hVisibleObjects -= 1
	ldh a, [hVisibleObjects]
	dec a
	ldh [hVisibleObjects], a
;>         hCount = mem[obj]                # (borrowed) its flags
	ld a, [hl]
	ldh [hCount], a
;>         mem[obj] &= 0x7F
	res 7, [hl]
;>@d         hTemp7 = (mem[obj + 1] >> 6) + 1 # the distance FillObjectRecord noted
	inc hl
	ld a, [hl]
	sla a
	rla
	rla
	and $03
;=@d
	inc a
	ldh [hTemp7], a
;>         kind = mem[obj + 1] & 0x3F
	ld a, [hl]
	and $3f
;>         mem[obj + 1] = kind
	ld [hli], a
	push af
;>         hTemp8 = mem[obj + 2]            # (borrowed) its direction
	ld a, [hli]
	ldh [hTemp8], a
;>         if hTemp8 == 0x66:               # just appeared (a reload with no effect)
;>             pass
	cp $66
	jr nz, .notNew

	xor a
	dec hl
	ld a, [hli]

.notNew
;>         pos_ptr = obj + 3
	push hl
	pop bc
	pop af
	push af
;>@ti         if kind == 0x20 and mem[obj + 8] != 0:   # a thief with an item looks like the item
	cp $20
	jr nz, .kindTiles

;=@ti
	ld de, $0005
	add hl, de
	ld a, [hl]
	or a
	jr nz, .thiefItem

;=@ti
	ld a, $20
	jr .kindTiles

.thiefItem
;>@tt             tiles = 0xFF00 | mem[BuildSprites.thiefItemTiles + mem[obj + 8] - 6]   # $FF = one tile only
	sub $06
	ld e, a
	ld hl, .thiefItemTiles
	add hl, de
	ld a, [hl]
;=@tt
	ld l, a
	ld h, $ff
	jr .haveTiles

.thiefItemTiles
	db $fc, $fa, $fe, $ea, $e8, $f8, $ec   ; item cell types 6-12

.kindTiles
;>         else:
;>@kt             tiles = ObjectSpriteTiles + kind * 8
	sla a
	sla a
	sla a
	ld d, $00
	rl d
	ld e, a
;=@kt
	ld hl, ObjectSpriteTiles
	add hl, de

.haveTiles
;>@dy         if (hCount & 0x7F) >= 0x10:      # dying: its remains go onto the background
	pop af
	push hl
	push af
	ldh a, [hCount]
	res 7, a
	sub $10
;=@dy
	jr c, .alive

;>             if not ScreenCellUnderWindow():
	call ScreenCellUnderWindow
	jr nz, .dyingDone

;>                 DrawCellAtDE(0x1A, LoadPosAtBC(pos_ptr))
	call LoadPosAtBC
	ld a, $1a
	call DrawCellAtDE

.dyingDone
	pop af
	jr .toList

.alive
;>         elif kind == 0x20:               # a thief
	pop af
	cp $20
	jr nz, .notThief

;>@iv             if 0x30 <= (hCellYX & 0xF0) < 0xC0 and 3 <= (hCellYX & 0x0F) < 0x0D:   # in view
	ldh a, [hCellYX]
	and $f0
	cp $30
	jr c, .thiefDone

;=@iv
	cp $c0
	jr nc, .thiefDone

	ldh a, [hCellYX]
	and $0f
	cp $03
	jr c, .thiefDone

;=@iv
	cp $0d
	jr nc, .thiefDone

;>                 hModeFlags |= 0x20           # play its sound below
	ld hl, hModeFlags
	set 5, [hl]

.thiefDone
	jr .toList

.notThief
;>         elif hTemp8 == 0x66:             # just appeared: no motion
;>             hTemp8 = 0
	ldh a, [hTemp8]
	cp $66
	jr nz, .notAppearing

	xor a
	ldh [hTemp8], a
	jr .toList

.notAppearing
;>         elif hCount & 0x80:              # peaceful this step
;>             pass
	ldh a, [hCount]
	bit 7, a
	jr nz, .toList

;>@nx         elif hTemp7 == 1 and 0x60 <= (hCellYX & 0xF0) < 0x90 and 7 <= (hCellYX & 0x0F) < 0x0A \
;>                 and not ScrolledLastStep() and not CannotAttack() and hFlashTimer == 0 and not hModeFlags & 0x10:
	ldh a, [hTemp7]
	dec a
	jr nz, .toListNear

;=@nx
	ldh a, [hCellYX]
	and $f0
	cp $60
	jr c, .toList

;=@nx
	cp $90
	jr nc, .toList

	ldh a, [hCellYX]
	and $0f
	cp $07
	jr c, .toList

;=@nx
	cp $0a
	jr nc, .toList

	call ScrolledLastStep
	jr c, .toListNear

;=@nx
	call CannotAttack
	jr c, .toListNear

	ldh a, [hFlashTimer]
	or a
	jr nz, .toListNear

;=@nx
	ld hl, hModeFlags
	bit 4, [hl]
	jr nz, .toListNear

;>             mem[obj] |= 0x40             # right next to the hero: a fight starts
	dec bc
	dec bc
	dec bc
	push bc
	pop hl
	set 6, [hl]
;>         # (on to the lists)

.toList
	jr .toListNear

.toListNear
;>         if hTemp7 == 1:                  # near list: straight into the first OAM buffer
	ldh a, [hTemp7]
	dec a
	jr nz, .notNear

;>             hNearCount += 1
	ldh a, [hNearCount]
	inc a
	ldh [hNearCount], a
;>             SetSpriteListRow(wNearRows, hNearCount)
	ld hl, wNearRows
	call SetSpriteListRow
;>             motions = hMotionPtrHi << 8 | hMotionPtrLo
	ldh a, [hMotionPtrHi]
	ld b, a
	ldh a, [hMotionPtrLo]
	ld c, a
;>@fr             frames = wSpriteFrame2 + (hSpriteSlot + 1) * 4
	ld de, wSpriteFrame2
	ldh a, [hSpriteSlot]
	inc a
	sla a
	sla a
;=@fr
	push af
	add e
	ld e, a
	jr nc, .noCarry

	inc d

.noCarry
;>             oams = wOAMBuffer + (hSpriteSlot + 1) * 8
	pop af
	ld hl, wOAMBuffer
	sla a
	add l
	ld l, a
;>             n = hNearCount
	ldh a, [hNearCount]
	jr .addSprite

.notNear
;>         elif hTemp7 == 2:                # middle list
	dec a
	jr nz, .far

;>             hMidCount += 1
	ldh a, [hMidCount]
	inc a
	ldh [hMidCount], a
;>             SetSpriteListRow(wMidRows, hMidCount)
	ld hl, wMidRows
	call SetSpriteListRow
;>             motions, frames, oams = wSpriteMotion2, wSpriteFrame2B, wOAMBuffer2
	ld bc, wSpriteMotion2
	ld de, wSpriteFrame2B
	ld hl, wOAMBuffer2
;>             n = hMidCount
	ldh a, [hMidCount]
	jr .addSprite

.far
;>         elif hFarCount >= 20:            # far list full: not drawn
;>             n = 0
	ldh a, [hFarCount]
	cp $14
	jr c, .addFar

	pop af
	jp .nextObj


.addFar
;>         else:                            # far list
;>             hFarCount += 1
	inc a
	ldh [hFarCount], a
;>             SetSpriteListRow(wFarRows, hFarCount)
	ld hl, wFarRows
	call SetSpriteListRow
;>             motions, frames, oams = wFarMotion, wFarFrame2, wFarSprites
	ld bc, wFarMotion
	ld de, wFarFrame2
	ld hl, wFarSprites
;>             n = hFarCount
	ldh a, [hFarCount]

.addSprite
;>         if n != 0:
;>             p = motions + (n - 1) * 2        # motion: its own direction minus the scroll
	dec a
	push hl
	sla a
	ld l, a
	ld h, $00
	add hl, bc
;>@my             mem[p] = u8(HighNibbleSigned(hTemp8) - wScrollDY)
	push af
	ld a, [wScrollDY]
	ld b, a
	ldh a, [hTemp8]
	call HighNibbleSigned
;=@my
	sub b
	ld [hli], a
;>@mx             mem[p + 1] = u8(NibbleSigned(hTemp8) - wScrollDX)
	ld a, [wScrollDX]
	ld b, a
	ldh a, [hTemp8]
	call NibbleSigned
;=@mx
	sub b
	ld [hl], a
;>@fm             frame2 = frames + (n - 1) * 4
	pop af
	sla a
	ld l, a
	ld h, $00
	add hl, de
;=@fm
	push hl
	pop de
;>@po             oam = PutSpriteYX(oams + (n - 1) * 8)
	pop hl
	sla a
	ld c, a
	ld b, $00
	add hl, bc
;=@po
	call PutSpriteYX
;>             if hi(tiles) == 0xFF:            # a single tile (thief's item)
	pop bc
	ld a, b
	cp $ff
	jr nz, .leftPair

;>                 mem[oam] = lo(tiles)
	ld a, c
	ld [hli], a
;>                 mem[oam + 1] = 0
;>                 oam += 2
	xor a
	ld [hli], a
	jr .rightHalf

.leftPair
;>             else:
;>                 oam, tiles = PutTileAttr(oam, tiles)
	call PutTileAttr

.rightHalf
;>             oam = PutRightHalfYX(oam)
	push bc
	call PutRightHalfYX
	pop bc
;>             if hi(tiles) == 0xFF:
;>                 mem[oam] = 0xAA                  # blank
	ld a, b
	cp $ff
	jr nz, .rightPair

	ld [hl], $aa
	inc hl
;>                 mem[oam + 1] = 0
	ld [hl], $00
	jr .frame2

.rightPair
;>             else:
;>                 oam, tiles = PutTileAttr(oam, tiles)
	call PutTileAttr

.frame2
;>             if (hCount & 0x7F) >= 0x10:      # dying: blank in the second frame, so it blinks
	push de
	pop hl
	ldh a, [hCount]
	res 7, a
	cp $10
	jr c, .frame2Alive

;>                 mem[frame2] = 0xAA
	ld [hl], $aa
	inc hl
	jr .frame2Rest

.frame2Alive
;>             elif hi(tiles) == 0xFF:
;>                 mem[frame2] = lo(tiles)
	ld a, b
	cp $ff
	jr nz, .frame2Copy

	ld a, c
	ld [hli], a

.frame2Rest
;>             if (hCount & 0x7F) >= 0x10 or hi(tiles) == 0xFF:
;>                 mem[frame2 + 1] = 0
	xor a
	ld [hli], a
;>                 mem[frame2 + 2] = 0xAA
	ld [hl], $aa
	inc hl
;>                 mem[frame2 + 3] = 0
	ld [hl], a
	jr .nextObj

.frame2Copy
;>             else:
;>                 copy(frame2, tiles, 4)
	push bc
	pop de
	ld b, $04
	call CopyB

.nextObj
;>     obj += 14
	pop hl
	pop bc
	ld de, $000e
	add hl, de
;=@ol
	dec c
	jp nz, .objLoop

.merge
;> copy(hRowRoom2, hRowRoom, 9)             # the second buffer starts with the same rows taken
	ld de, hRowRoom
	ld hl, hRowRoom2
	ld b, $09
	call CopyB
;> hOAMCount = hSpriteSlot + 1               # the fixed slots and the near list are in both
	ld hl, hOAMCount
	ldh a, [hSpriteSlot]
	inc a
	ld [hli], a
;> hOAM2Count = hSpriteSlot + 1
	ld [hli], a
;> hMergeList = 0
	xor a
	ld [hli], a
;> rows = wNearRows
	ld de, wNearRows
;> motions = hMotionPtrHi << 8 | hMotionPtrLo
	ldh a, [hMotionPtrHi]
	ld b, a
	ldh a, [hMotionPtrLo]
	ld c, a
;> count = hNearCount
	ldh a, [hNearCount]

.startList
;>@sl while True:
;>     hMergeLeft = count
	ldh [hMergeLeft], a
;>     hMergeIndex = 0
	xor a
	ldh [hMergeIndex], a

.mergeLoop
;>     while hMergeLeft != 0:
	ldh a, [hMergeLeft]
	or a
	jr nz, .mergeOne

;=@last
	ldh a, [hMergeList]
	cp $02
;=@brk
	jp z, .finish

;=@inc
	inc a
	ldh [hMergeList], a
;=@mid
	cp $01
	jr nz, .farList

;=@midset
	ld de, wMidRows
	ld bc, wSpriteMotion2
	ldh a, [hMidCount]
	jr .startList

.farList
;=@farset
	ld de, wFarRows
	ld bc, wFarMotion
	ldh a, [hFarCount]
;=@sl
	jr .startList

.mergeOne
;>         hMergeLeft -= 1
	dec a
	ldh [hMergeLeft], a
;>         hMergeIndex += 1
	ldh a, [hMergeIndex]
	inc a
	ldh [hMergeIndex], a
	push bc
	push de
;>         dy = mem[motions]
	ld a, [bc]
	ldh [hTemp3], a
;>         r = u8(mem[rows] - 2)            # its screen row (0-8; above/below the screen beyond)
	ld a, [de]
	ld d, $00
	sub $02
;>         # the rows it covers while it slides: n = 1-3 rows, r1, then r2, r3 in the slide's direction
;>         if r >= 0x80:                    # above the screen (grid row 0 or 1)
	jr nc, .notAbove

;>             r1, n = 0, 1
	ld e, $00
	inc d
;>             if r == 0xFE:                # grid row 0: just the top row
;>                 pass
	cp $fe
	jr z, .rowsDone

;>             elif (dy & 1) == 0:          # not sliding by one row: two rows
	ldh a, [hTemp3]
	bit 0, a
	jr nz, .rowsDone

;>                 r2, n = 1, 2
	ld b, $01
	inc d
	jr .rowsDone

.notAbove
;>         elif r >= 9:                     # below the screen
	cp $09
	jr c, .onScreenRow

;>             r1, n = 8, 1
	ld e, $08
	inc d
;>             if r == 0x0A:
;>                 pass
	cp $0a
	jr z, .rowsDone

;>             elif (dy & 1) == 0:
	ldh a, [hTemp3]
	bit 0, a
	jr nz, .rowsDone

;>                 r2, n = 7, 2
	ld b, $07
	inc d
	jr .rowsDone

.onScreenRow
;>         else:
;>             r1, n = r, 1
	ld e, a
	inc d
;>             if dy == 0:                  # not moving
;>                 pass
	ldh a, [hTemp3]
	or a
	jr z, .rowsDone

;>             elif not dy & 0x80:          # moving down
	bit 7, a
	jr nz, .rowsUp

;>                 if r1 != 8:
	ld a, e
	cp $08
	jr z, .rowsDone

;>                     r2, n = r1 + 1, 2
	ld b, e
	inc b
	inc d
;>                     if (dy & 1) == 0 and r2 != 8:   # two rows a step: a third row
	ldh a, [hTemp3]
	bit 0, a
	jr nz, .rowsDone

	ld a, b
	cp $08
	jr z, .rowsDone

;>                         r3, n = r2 + 1, 3
	ld c, b
	inc c
	inc d
	jr .rowsDone

.rowsUp
;>             else:                        # moving up
;>                 if r1 != 0:
	ld a, e
	or a
	jr z, .rowsDone

;>                     r2, n = r1 - 1, 2
	ld b, e
	dec b
	inc d
;>                     if (dy & 1) == 0 and r2 != 0:
	ldh a, [hTemp3]
	bit 0, a
	jr nz, .rowsDone

	ld a, b
	or a
	jr z, .rowsDone

;>                         r3, n = r2 - 1, 3
	ld c, b
	dec c
	inc d

.rowsDone
;>         target = None
;>         if hOAMCount != 20:              # room in the first buffer?
	ldh a, [hOAMCount]
	cp $14
	jr z, .trySecond

;>             if hMergeList == 0:          # near sprites are in it already: just count them
	ld hl, hRowRoom
	ldh a, [hMergeList]
	or a
	jr nz, .tryFirst

;>                 hOAMCount += 1
	ldh a, [hOAMCount]
	inc a
	ldh [hOAMCount], a
;>                 TakeRowRoom(hRowRoom, n, r1, r2, r3)
;>                 target = 'done'
	call TakeRowRoom
	jp .mergeNext


.tryFirst
;>             elif TakeRowRoom(hRowRoom, n, r1, r2, r3) == 0:
;>                 target = 0
	call TakeRowRoom
	or a
	jr nz, .trySecond

	xor a
	jr .copy

.trySecond
;>         if target is None:               # else the second buffer, if it has room
;>@t2             if hOAM2Count != 20 and TakeRowRoom(hRowRoom2, n, r1, r2, r3) == 0:
	ldh a, [hOAM2Count]
	cp $14
	jp z, .mergeNext

;=@t2
	ld hl, hRowRoom2
	call TakeRowRoom
	or a
	jp nz, .mergeNext

;>                 target = 1               # (no room in either: not drawn this frame)
	ld a, $01

.copy
;>         if target == 0 or target == 1:
;>             hMergeTarget = target
	ldh [hMergeTarget], a
;>             if hMergeList == 1:          # where the sprite is now (a near sprite would be read from the far list)
	ldh a, [hMergeList]
	cp $01
	jr nz, .fromFar

;>                 src_m, src_f, src_o = wSpriteMotion2, wSpriteFrame2B, wOAMBuffer2
	ld bc, wSpriteMotion2
	ld de, wSpriteFrame2B
	ld hl, wOAMBuffer2
	jr .haveSource

.fromFar
;>             else:
;>                 src_m, src_f, src_o = wFarMotion, wFarFrame2, wFarSprites
	ld bc, wFarMotion
	ld de, wFarFrame2
	ld hl, wFarSprites

.haveSource
;>             hTemp1 = (hMergeIndex - 1) * 2
	push hl
	push de
	ldh a, [hMergeIndex]
	dec a
	sla a
	ldh [hTemp1], a
;>             src = src_m + hTemp1
	ld h, $00
	ld l, a
	add hl, bc
	push hl
	pop de
;>             if hMergeTarget == 0:
	ldh a, [hMergeTarget]
	or a
	jr nz, .toSecond

;>                 dst_m, count_var = wScrollDY, addr(hOAMCount)
	ld bc, wScrollDY
	ld hl, hOAMCount
	jr .haveDest

.toSecond
;>             else:
;>                 dst_m, count_var = wSpriteMotion2, addr(hOAM2Count)
	ld bc, wSpriteMotion2
	ld hl, hOAM2Count

.haveDest
;>             hTemp2 = mem[count_var] * 2
	ld a, [hl]
	inc [hl]
	sla a
	ldh [hTemp2], a
;>             mem[count_var] += 1
;>             copy(dst_m + hTemp2, src, 2) # the motion
	ld h, $00
	ld l, a
	add hl, bc
	ld b, $02
	call CopyB
;>             hTemp1 *= 2
	pop de
	ldh a, [hTemp1]
	sla a
	ldh [hTemp1], a
;>             src = src_f + hTemp1
	ld h, $00
	ld l, a
	add hl, de
	push hl
	pop de
;>             if hMergeTarget == 0:
;>                 dst_f = wSpriteFrame2
	ldh a, [hMergeTarget]
	or a
	jr nz, .frameNot0

	ld bc, wSpriteFrame2
	jr .haveFrame

.frameNot0
;>             elif hMergeTarget == 1:
;>                 dst_f = wSpriteFrame2B
	cp $01
	jr nz, .frameFar

	ld bc, wSpriteFrame2B
	jr .haveFrame

.frameFar
;>             else:
;>                 dst_f = wFarFrame2
	ld bc, wFarFrame2

.haveFrame
;>             hTemp2 *= 2
	ldh a, [hTemp2]
	sla a
	ldh [hTemp2], a
;>             copy(dst_f + hTemp2, src, 4) # the second frame
	ld h, $00
	ld l, a
	add hl, bc
	ld b, $04
	call CopyB
;>@so             src = src_o + hTemp1 * 2
	pop hl
	ldh a, [hTemp1]
	sla a
	ld d, $00
	ld e, a
;=@so
	add hl, de
	push hl
	pop de
;>             if hMergeTarget == 0:
;>                 dst_o = wOAMBuffer
	ldh a, [hMergeTarget]
	or a
	jr nz, .oamNot0

	ld bc, wOAMBuffer
	jr .haveOAM

.oamNot0
;>             elif hMergeTarget == 1:
;>                 dst_o = wOAMBuffer2
	cp $01
	jr nz, .oamFar

	ld bc, wOAMBuffer2
	jr .haveOAM

.oamFar
;>             else:
;>                 dst_o = wFarSprites
	ld bc, wFarSprites

.haveOAM
;>@co             copy(dst_o + hTemp2 * 2, src, 8) # the sprite pair itself
	ldh a, [hTemp2]
	sla a
	ld h, $00
	ld l, a
	add hl, bc
;=@co
	ld b, $08
	call CopyB

.mergeNext
;>         motions += 2
;>         rows += 1
	pop de
	pop bc
	inc bc
	inc bc
	inc de
	jp .mergeLoop

;>@last     if hMergeList == 2:
;>@brk         break
;>@inc     hMergeList += 1
;>@mid     if hMergeList == 1:
;>@midset         rows, motions, count = wMidRows, wSpriteMotion2, hMidCount
;>     else:
;>@farset         rows, motions, count = wFarRows, wFarMotion, hFarCount

.finish
;> unused = 20 - hOAMCount                  # clear the rest of both buffers
	ldh a, [hOAMCount]
	ld c, a
	ld a, $14
	sub c
;> if unused != 0:
;>@c1     fill(wOAMBuffer + hOAMCount * 8, 0, unused * 8)
	jr z, .clear2

	ld hl, wOAMBuffer
	sla c
	sla c
	sla c
;=@c1
	ld b, $00
	add hl, bc
	ld c, a
	sla c
	sla c
	sla c
;=@c1
	call ClearBytes

.clear2
;> unused = 20 - hOAM2Count
	ldh a, [hOAM2Count]
	ld c, a
	ld a, $14
	sub c
;> if unused != 0:
;>@c2     fill(wOAMBuffer2 + hOAM2Count * 8, 0, unused * 8)
	jr z, .thiefSound

	ld hl, wOAMBuffer2
	sla c
	sla c
	sla c
;=@c2
	ld b, $00
	add hl, bc
	ld c, a
	sla c
	sla c
	sla c
;=@c2
	call ClearBytes

.thiefSound
;> if hModeFlags & 0x20:                  # a thief came into view
	ld hl, hModeFlags
	bit 5, [hl]
	jr z, .done

;>     hModeFlags &= ~0x20
	res 5, [hl]
;>     PlaySfx(7)
	ld a, $07
	call PlaySfx
;>     if ScrolledLastStep():
	call ScrolledLastStep
	jr nc, .done

;>         hPictureOverride = 0
	xor a
	ldh [hPictureOverride], a
;>         CloseWindows()
	call CloseWindows

.done
;> HideSpritesUnderStatus()
	call HideSpritesUnderStatus
;> ShowMonsterPicture()
	call ShowMonsterPicture
	ret


;@ def TakeRowRoom(room: hl, rows: d, row1: e, row2: b, row3: c) -> a
;@ path: gfx/sprites/lists
;@ A sprite pair covers 1-3 screen rows while it slides between cells. If each of those rows (row1, row2,
;@ row3, the first `rows` of them) still has room in the budget array `room` (hRowRoom or hRowRoom2), takes
;@ one place in each and returns 0; otherwise changes nothing and returns $FF.
;@ sig: 7d0934cb
TakeRowRoom::
;> # (the rows are kept on the stack)
	push bc
	push de
	push hl
	push de
;>@full if mem[room + row1] == 0:
;>@ret     return 0xFF
	ld d, $00
	add hl, de
	ld a, [hl]
	or a
	jr z, .fullFirst

;>@r2 if rows >= 2 and mem[room + row2] == 0:
;>     return 0xFF
	pop af
	dec a
	jr z, .take

;=@r2
	ld e, b
	ld b, a
	pop hl
	push hl
	add hl, de
	xor a
;=@r2
	cp [hl]
	jr z, .full

;>@r3 if rows >= 3 and mem[room + row3] == 0:
;>     return 0xFF
	dec b
	jr z, .take

;=@r3
	ld e, c
	pop hl
	push hl
	add hl, de
	cp [hl]
	jr z, .full

.take
;> # (room, rows and the row numbers back from the stack)
	pop hl
	pop de
	pop bc
	ld a, d
	ld d, $00
;> mem[room + row1] -= 1
	push hl
	add hl, de
	dec [hl]
	pop hl
;> if rows == 1:
;>     return 0
	dec a
	jp z, .done

;> mem[room + row2] -= 1
	ld e, b
	push hl
	add hl, de
	dec [hl]
	pop hl
;> if rows == 2:
;>     return 0
	dec a
	jr z, .done

;> mem[room + row3] -= 1
	ld e, c
	add hl, de
	dec [hl]

.done
;> return 0
	xor a
	ret


.fullFirst
;=@full
	pop bc

.full
;=@ret
	ld a, $ff
	pop hl
	pop de
	pop bc
	ret


;@ path: gfx/sprites
;@ Sprite tiles of every object kind, 8 bytes each: tile and attributes of the left and of the right 8x16
;@ half in the first animation frame, then the same for the second frame (often the first one mirrored:
;@ attribute $20 = X flip, with the halves swapped). Kinds $00-$1F are the monsters, $20 the thief, $21-$24
;@ the dragon's head and body parts (only a first frame; BuildSprites draws them its own way).
ObjectSpriteTiles::
	db $20, $00, $30, $00, $30, $20, $20, $20   ; kind $00
	db $22, $00, $32, $00, $32, $20, $22, $20   ; kind $01
	db $24, $00, $34, $00, $34, $20, $24, $20   ; kind $02
	db $26, $00, $36, $00, $36, $20, $26, $20   ; kind $03
	db $40, $00, $40, $20, $50, $00, $50, $20   ; kind $04
	db $42, $00, $42, $20, $52, $20, $52, $00   ; kind $05
	db $44, $00, $54, $00, $54, $20, $44, $20   ; kind $06
	db $46, $00, $46, $20, $46, $00, $46, $20   ; kind $07
	db $48, $00, $58, $00, $58, $20, $48, $20   ; kind $08
	db $4a, $00, $5a, $00, $5a, $20, $4a, $20   ; kind $09
	db $4c, $00, $4c, $20, $5c, $20, $5c, $00   ; kind $0A
	db $4e, $00, $5e, $00, $5e, $20, $4e, $20   ; kind $0B
	db $60, $00, $70, $00, $70, $20, $60, $20   ; kind $0C
	db $62, $00, $62, $20, $72, $20, $72, $00   ; kind $0D
	db $64, $00, $74, $00, $74, $20, $64, $20   ; kind $0E
	db $66, $00, $66, $20, $76, $20, $76, $00   ; kind $0F
	db $68, $00, $78, $00, $78, $20, $68, $20   ; kind $10
	db $6a, $00, $7a, $00, $7a, $20, $6a, $20   ; kind $11
	db $6c, $00, $7c, $00, $7c, $20, $6c, $20   ; kind $12
	db $56, $00, $56, $20, $56, $00, $56, $20   ; kind $13
	db $6e, $00, $7e, $00, $7e, $20, $6e, $20   ; kind $14
	db $80, $00, $80, $20, $90, $20, $90, $00   ; kind $15
	db $a4, $00, $a4, $20, $a4, $00, $a4, $20   ; kind $16
	db $82, $00, $82, $20, $92, $20, $92, $00   ; kind $17
	db $84, $00, $94, $00, $94, $20, $84, $20   ; kind $18
	db $86, $00, $96, $00, $96, $20, $86, $20   ; kind $19
	db $88, $00, $98, $00, $98, $20, $88, $20   ; kind $1A
	db $8a, $00, $8a, $20, $9a, $20, $9a, $00   ; kind $1B
	db $8c, $00, $8c, $20, $9c, $00, $9c, $20   ; kind $1C
	db $8e, $00, $9e, $00, $9e, $20, $8e, $20   ; kind $1D
	db $a0, $00, $b0, $00, $b0, $20, $a0, $20   ; kind $1E
	db $a2, $00, $b2, $00, $b2, $20, $a2, $20   ; kind $1F
	db $e6, $00, $f6, $00, $e6, $00, $f6, $00   ; kind $20
	db $c4, $00, $d4, $00, $00, $00, $00, $00   ; kind $21
	db $c0, $00, $d0, $00, $00, $00, $00, $00   ; kind $22
	db $c8, $00, $d8, $00, $00, $00, $00, $00   ; kind $23
	db $a6, $00, $b6, $00, $00, $00, $00, $00   ; kind $24

;@ def ObjDistance(obj: hl) -> a
;@ path: monsters/move
;@ How far an object is from the hero, counted in cells the larger way (rows or columns): 1 next to him
;@ (or on his cell), up to 4 at the screen's edges; 0 when the object is inactive or off screen.
;@ Also leaves its place on the 13x13 grid around the view in hObjRow / hObjCol (the hero is at row 6,
;@ column 7). obj points at the record's flags byte (+1).
;@ writes: hObjCol, hObjRow
;@ sig: 91c9f24b
ObjDistance::
;> if mem[obj] == 0:                       # inactive
;>     return 0
	ld a, [hli]
	or a
	ret z

;> p = obj + 3                             # (the direction byte on the way is read and dropped)
	push hl
	inc hl
	ld a, [hli]
	push af
;> pos = mem[p] << 8 | mem[p + 1]
	ld d, [hl]
	inc hl
	ld e, [hl]
;> on_screen, row, col = GetViewCell(pos)
	call GetViewCell
;> if not on_screen:
;>     return 0
	or a
	jr nz, .onScreen

	pop hl
	pop hl
	ret


.onScreen
;> hObjRow = row
	ld a, b
	ldh [hObjRow], a
;> hObjCol = col
	ld a, c
	ldh [hObjCol], a
;> x = col - 2                             # 0-9 = the visible columns, the hero at 5
	ld a, c
	sub $02
;>@cfar if x < 0 or x >= 9:
;>@c4     dx = 4
	jr c, .colFar

;> elif x == 5:                            # the hero's column
;>     dx = 1
	cp $05
	jr nz, .colNotHero

	ld c, $01
	jr .rows

.colNotHero
;> elif x < 5:
	jr nc, .colRight

;>     dx = 5 - x
	ld c, a
	ld a, $05
	sub c
;>     if dx == 5:
;>         dx = 4
	cp $05
	jr nz, .colLeft

	ld a, $04

.colLeft
	jr .colDone

.colRight
;=@cfar
	cp $09
	jr c, .colNear

.colFar
;=@c4
	ld c, $04
	jr .rows

.colNear
;> else:
;>     dx = 4 - (9 - x)                    # = x - 5
	ld c, a
	ld a, $09
	sub c
	ld c, a
	ld a, $04
	sub c

.colDone
;> # (dx in c)
	ld c, a

.rows
;> y = row - 2                             # 0-8 = the visible rows, the hero at 4
	ld a, b
	sub $02
;>@rfar if y < 0 or y >= 8:
;>@r4     dy = 4
	jr c, .rowFar

;> elif y == 4:                            # the hero's row
;>     dy = 1
	cp $04
	jr nz, .rowNotHero

	ld a, $01
	jr .pick

.rowNotHero
;> elif y < 4:
	jr nc, .rowBelow

;>     dy = 4 - y
	ld b, a
	ld a, $04
	sub b
	jr .pick

.rowBelow
;=@rfar
	cp $08
	jr c, .rowNear

.rowFar
;=@r4
	ld a, $04
	jr .pick

.rowNear
;> else:
;>     dy = 4 - (8 - y)                    # = y - 4
	ld b, a
	ld a, $08
	sub b
	ld b, a
	ld a, $04
	sub b

.pick
;> return max(dx, dy)
	cp c
	jr nc, .done

	ld a, c

.done
	pop hl
	pop hl
	ret


;@ def NextSpriteSlot() -> hl
;@ path: gfx/sprites/lists
;@ Moves on to the next sprite pair slot of the first OAM buffer and returns its address.
;@ writes: hSpriteSlot
;@ reads: hSpriteSlot
;@ sig: 1bb93703
NextSpriteSlot::
;> hSpriteSlot += 1
	ldh a, [hSpriteSlot]
	inc a
	ldh [hSpriteSlot], a
;> offset = u8(hSpriteSlot * 8)               # 8 bytes: two OAM entries, left and right half
	sla a
	sla a
	sla a
	ld d, $00
	ld e, a
;> return wOAMBuffer + offset
	ld hl, wOAMBuffer
	add hl, de
	ret


;@ def PutSpriteYX(oam: hl) -> hl
;@ path: gfx/sprites/lists
;@ Writes the OAM Y and X of a sprite pair's left half for the screen cell hCellYX, and remembers the
;@ entry's address for PutRightHalfYX (in hSavedSCY/hSavedSCX, borrowed as scratch).
;@ writes: hSavedSCX, hSavedSCY
;@ reads: hCellYX
;@ test: oam = rand(0xC000, 0xDD00)
;@ sig: 1047a3e6
PutSpriteYX::
;> hSavedSCY = hi(oam)
	ld a, h
	ldh [hSavedSCY], a
;> hSavedSCX = lo(oam)
	ld a, l
	ldh [hSavedSCX], a
;> y = HighNibbleSigned(hCellYX)
	ldh a, [hCellYX]
	call HighNibbleSigned
;> y = u8((y - 3) * 16)                    # grid row 2 (nibble 3) is the top screen row
	sub $03
	sla a
	sla a
	sla a
	sla a
;> mem[oam] = u8(y + 0x10)                 # OAM Y is 16 more than the screen Y
	add $10
	ld [hli], a
;> x = NibbleSigned(hCellYX)
	ldh a, [hCellYX]
	call NibbleSigned
;> x = u8((x - 3) * 16)
	sub $03
	sla a
	sla a
	sla a
	sla a
;> mem[oam + 1] = u8(x + 8)                # OAM X is 8 more than the screen X
	add $08
	ld [hli], a
;> return oam + 2
	ret


;@ def PutRightHalfYX(oam: hl) -> hl
;@ path: gfx/sprites/lists
;@ Writes the OAM Y and X of a sprite pair's right half: the left half's (remembered by PutSpriteYX), 8
;@ pixels further right.
;@ reads: hSavedSCX, hSavedSCY
;@ test: oam = rand(0xC000, 0xDD00); hSavedSCY = rand(0xC0, 0xDD)
;@ sig: 5099d2d4
PutRightHalfYX::
;> left = hSavedSCY << 8 | hSavedSCX
	ldh a, [hSavedSCY]
	ld b, a
	ldh a, [hSavedSCX]
	ld c, a
;> mem[oam] = mem[left]
	ld a, [bc]
	ld [hli], a
;> mem[oam + 1] = u8(mem[left + 1] + 8)
	inc bc
	ld a, [bc]
	add $08
	ld [hli], a
;> return oam + 2
	ret


;@ def PutTileAttr(oam: hl, src: bc) -> (hl, bc)
;@ path: gfx/sprites/lists
;@ Copies a tile number and its attributes into an OAM entry (or any tile/attribute pair).
;@ test: oam = rand(0xC000, 0xDD00); src = rand(0x0000, 0xDD00)
;@ sig: a93905e0
PutTileAttr::
;> mem[oam] = mem[src]
	ld a, [bc]
	ld [hli], a
	inc bc
;> mem[oam + 1] = mem[src + 1]
	ld a, [bc]
	ld [hli], a
	inc bc
;> return (oam + 2, src + 2)
	ret


;@ def UseRowRoom(row: a)
;@ path: gfx/sprites/lists
;@ Takes one place in the sprite budget of a screen row (row on the 13x13 grid; rows off screen are ignored).
;@ sig: 38a09572
UseRowRoom::
;> r = row - 2
;> if r < 0:
	sub $02
;>     return
	ret c

;> if r >= 9:
;>     return
	cp $09
	ret nc

;> hRowRoom[r] -= 1
	ld hl, hRowRoom
	ld b, $00
	ld c, a
	add hl, bc
	dec [hl]
	ret


;@ def BuildDragonPartSprite(dest: bc, obj: hl, part_pos: de) -> bc
;@ path: monsters/dragon
;@ For one of the dragon's outer body parts (at part_pos, $DC14 or $DC16): marks it as touching the hero
;@ (flags bit 6) when he stands right next to it - not at its outer corners - and the view did not just
;@ scroll, then stores the background-map address of its cell at dest (big-endian; high byte 0 = off screen).
;@ sig: f91bd9d6
BuildDragonPartSprite::
;> dist = ObjDistance(obj)
	push bc
	push hl
	push de
	call ObjDistance
;> if dist == 0:
;>     vram = lo(obj)                      # high byte 0 = off screen (the low byte is left over)
	or a
	jr nz, .onScreen

	pop de
	pop hl
	jr .store

.onScreen
;> else:
;>     if dist == 1:
	dec a
	jr nz, .notTouching

;>         if part_pos == 0xDC16:
	pop de
	push de
	ld a, e
	cp $16
	jr nz, .leftPart

;>             corner = 0xDBC7             # up and right of the right part
	ld de, $dbc7
	jr .check

.leftPart
;>         else:
;>             corner = 0xDBC3             # up and left of the left part
	ld de, $dbc3

.check
;>@hero         hero = hHeroPosHi << 8 | hHeroPosLo
;>@cmp         if hero != corner and hero != 0xDC00 | (corner & 0x7F) | 0x20 and hero != 0xDBC5:
	ld hl, hHeroPosHi
	call CompareDEWithU16
	jr z, .notTouching

;=@cmp
	ld d, $dc
	res 7, e
	set 5, e
	call CompareDEWithU16
	jr z, .notTouching

;=@cmp
	ld de, $dbc5
	call CompareDEWithU16
	jr z, .notTouching

;>             if not ScrolledLastStep():  # the other corner is down and to the outside; $DBC5 is the head
	pop de
	pop hl
	call ScrolledLastStep
	jr c, .getVRAM

;>                 mem[obj] |= 0x40         # the part touches the hero
	set 6, [hl]
	jr .getVRAM

.notTouching
;>     vram = MapPosToBG(part_pos)
	pop de
	pop hl

.getVRAM
	call MapPosToBG
	ld a, h

.store
;> mem[dest] = hi(vram)
	pop bc
	ld [bc], a
	inc bc
;> mem[dest + 1] = lo(vram)
	ld a, l
	ld [bc], a
	inc bc
;> return dest + 2
	ret


;@ def SetSpriteListRow(rows: hl, n: a)
;@ path: gfx/sprites/lists
;@ Notes the screen row (0-based, from hCellYX) of sprite number n (1-based) of a sprite list.
;@ reads: hCellYX
;@ sig: 6e3d8ef7
SetSpriteListRow::
;> p = rows + n - 1
	ld d, $00
	dec a
	ld e, a
	add hl, de
;> mem[p] = u8((hCellYX >> 4) - 1)
	ldh a, [hCellYX]
	swap a
	and $0f
	dec a
	ld [hl], a
	ret


;@ def LoadPosAtBC(p: bc) -> de
;@ path: monsters/move
;@ Reads a big-endian map position at bc.
;@ sig: 6626e899
LoadPosAtBC::
;> hi_ = mem[p]
	ld a, [bc]
	ld d, a
	inc bc
;> return hi_ << 8 | mem[p + 1]
	ld a, [bc]
	ld e, a
	dec bc
	ret


;@ def AnimateStep()
;@ path: map/scroll
;@ Plays one step of 16 pixels: the background scrolls one cell the way wScrollDY/wScrollDX say and
;@ every sprite that has a motion moves along, one pixel a frame (two when flying, in 8 frames). The two
;@ sprite lists take turns frame by frame; halfway the walking frames flip; a block the hero pushes leaves
;@ its old cell in the first frame and is drawn on its new cell at the end.
;@ writes: hOldViewPosHi, hOldViewPosLo, hPushedCell, hRowRoom, hStepMovers, hStepMovers2, hStepShowList2, wOAMBuffer
;@ reads: hCarriedItem, hFlashTimer, hFlyTime, hMarkRow, hOAM2Count, hOAMCount, hPushFromHi, hPushFromLo, hPushToHi, hPushToLo, hPushedCell, hRowRoom, hSpriteSlot, hStepMovers, hStepMovers2, hStepShowList2, hViewPosHi, hViewPosLo, wDragonVRAM, wOAMBuffer
;@ test: skip waits for the VBlank interrupt
;@ sig: dd131852
AnimateStep::
;>@frame frame = 0x1F            # counts down by 2 a frame (by 4 when flying): 16 frames, 8 when flying
;> if not hFlyTime:
	ldh a, [hFlyTime]
	or a
	jr z, .walking

;=@frame
	ld b, $1f
	jr .flyFrame

.walking
;>     first = hSpriteSlot + 1   # the slots before `first` stay where they are on screen
	ldh a, [hSpriteSlot]
	ld c, a
	inc c
;>     if wDragonVRAM[0]:
	ld a, [wDragonVRAM]
	or a
	jr z, .noDragon

;>         first -= 1            # the dragon's head walks with the map
	dec c

.noDragon
;>     if hMarkRow not in (0, 0xFF):
	ldh a, [hMarkRow]
	or a
	jr z, .noMarker

	cp $ff
	jr z, .noMarker

;>         first -= 1            # and so does a marker that is not on the hero
	dec c

.noMarker
;>     hRowRoom[0] = first * 2      # borrowed: offset of slot `first` in the motion tables
	ld a, c
	sla a
	ldh [hRowRoom], a
;>     hStepMovers = hOAMCount - first
	ldh a, [hOAMCount]
	sub c
	ldh [hStepMovers], a
;>     hStepMovers2 = hOAM2Count - first
	ldh a, [hOAM2Count]
	sub c
	ldh [hStepMovers2], a
;>     hStepShowList2 = 1 if hStepMovers2 else 0
	or a
	jr z, .setToggle

	ld a, $01

.setToggle
	ldh [hStepShowList2], a
;>     copy(wOAMCopy, wOAMBuffer, 0xA0)   # the first list is moved in this copy
	ld de, wOAMBuffer
	ld hl, wOAMCopy
	ld b, $a0
	call CopyB
;=@frame
	ld b, $1f
	jr .walkFrame

.nextFrame
;=@w1
	ld hl, hSysFlags
	set 0, [hl]
	call WaitOAMCopy
	ld a, d
	ldh [rSCY], a
	ld a, e
;=@w1
	ldh [rSCX], a
;=@w5
	ld a, b
	cp $1f
	jr nz, .countDown

	ldh a, [hPushedCell]
	or a
	jr z, .countDown

;=@w5
	push bc
	push de
	ldh a, [hPushFromHi]
	ld d, a
	ldh a, [hPushFromLo]
	ld e, a
;=@w5
	call MapPosToBG
	ld a, $00
	call DrawMetatile
	pop de
	pop bc

.countDown
;=@w7
	dec b
;=@w8
	jp z, .done

;=@w10
	dec b
;=@fly
	ldh a, [hFlyTime]
	or a
	jr z, .walkFrame

.flyFrame
;>@loop while True:
;>@fly     if hFlyTime:
;>         if frame == 0x17:
	push bc
	ld a, b
	cp $17
	jr nz, .not17

;>             flap = 4      # the hero's wing frames while flying
	ld c, $04
	jr .flap

.not17
;>         elif frame == 0x0F:
	cp $0f
	jr nz, .not0F

;>             flap = -2
	ld c, $fe
	jr .flap

.not0F
;>         elif frame == 0x07:
	cp $07
	jr nz, .scroll2

;>             flap = 2
	ld c, $02

.flap
;>         if frame in (0x17, 0x0F, 0x07):
;>             wOAMBuffer[2] = u8(wOAMBuffer[2] + flap)   # the hero's left tile
	ld hl, wOAMBuffer + 2
	ld a, [hl]
	add c
	ld [hli], a
;>             wOAMBuffer[6] = u8(wOAMBuffer[6] + flap)   # and his right tile
	inc hl
	inc hl
	inc hl
	ld a, [hl]
	add c
	ld [hl], a

.scroll2
;>         scy = u8(rSCY + 2 * wScrollDY)
	pop bc
	ld hl, wScrollDY
	ldh a, [rSCY]
	add [hl]
	add [hl]
	ld d, a
;>         scx = u8(rSCX + 2 * wScrollDX)
	inc hl
	ldh a, [rSCX]
	add [hl]
	add [hl]
	ld e, a
;>         frame -= 2
	dec b
	dec b
	jr .nextFrame

;>@walk     else:
.walkFrame
;>         if hStepMovers:
	ldh a, [hStepMovers]
	or a
	jp z, .scroll1

;>             if hStepShowList2:
	push bc
	ldh a, [hStepShowList2]
	or a
	jr z, .showList1

;>                 src = wOAMBuffer2
	ld de, wOAMBuffer2
;>                 n = hStepMovers2
	ldh a, [hStepMovers2]
	jr .show

;>             else:
.showList1
;>                 src = wOAMCopy
	ld de, wOAMCopy
;>                 n = hStepMovers
	ldh a, [hStepMovers]

.show
;>             # this frame's list goes into the real buffer from slot `first` on
;>             n *= 8
	sla a
	sla a
	sla a
	push af
;>             offset = hRowRoom[0] * 4
	ldh a, [hRowRoom]
	sla a
	sla a
	ld l, a
	ld h, $00
;>             src += offset
	push hl
	add hl, de
	pop bc
;>             copy(wOAMBuffer + offset, src, n)
	push hl
	ld hl, wOAMBuffer
	add hl, bc
	pop de
	pop bc
	call CopyB
;>             if hStepMovers2:
	pop bc
	ldh a, [hStepMovers2]
	or a
	jr z, .move

;>                 hStepShowList2 ^= 1       # the other list next frame
	ldh a, [hStepShowList2]
	xor $01
	ldh [hStepShowList2], a

.move
;>             MoveStepSprites(hStepMovers, wOAMCopy, addr(wScrollDY))
	ldh a, [hStepMovers]
	ld de, wOAMCopy
	ld hl, wScrollDY
	call MoveStepSprites
;>             if hStepMovers2:
	ldh a, [hStepMovers2]
	or a
	jr z, .scroll1

;>                 MoveStepSprites(hStepMovers2, wOAMBuffer2, wSpriteMotion2)
	ld de, wOAMBuffer2
	ld hl, wSpriteMotion2
	call MoveStepSprites
;>                 n = 8 if wDragonVRAM[0] else 0
	ld c, $00
	ld a, [wDragonVRAM]
	or a
	jr z, .noDragonPair

	ld c, $08

.noDragonPair
;>                 if hMarkRow:
	ldh a, [hMarkRow]
	or a
	jr z, .checkPairs

;>                     n += 8
	ld a, $08
	add c
	ld c, a

.checkPairs
;>                 if n:             # the dragon's head and the marker never flicker:
	ld a, c
	or a
	jr z, .scroll1

;>                     offset = hRowRoom[0] * 4
	ldh a, [hRowRoom]
	sla a
	sla a
	ld h, $00
	ld l, a
;>                     src = wOAMCopy + offset    # always from the first list
	push hl
	ld de, wOAMCopy
	add hl, de
	pop de
;>@copyTail                     copy(wOAMBuffer + offset, src, n)
	push hl
	ld hl, wOAMBuffer
	add hl, de
	pop de
	push bc
	ld b, c
;=@copyTail
	call CopyB
	pop bc

.scroll1
;>         scy = u8(rSCY + wScrollDY)
	ld hl, wScrollDY
	ldh a, [rSCY]
	add [hl]
	ld d, a
;>         scx = u8(rSCX + wScrollDX)
	inc hl
	ldh a, [rSCX]
	add [hl]
	ld e, a
;>         if frame == 0x11:         # halfway through the step
	push de
	push bc
	ld a, b
	cp $11
	jr nz, .lastFrame

;>             RefreshDragonCells()
	call RefreshDragonCells
;>             if ScrolledLastStep():
	call ScrolledLastStep
	jr nc, .monsterFrames

;>                 flip = 0x20 if wOAMBuffer[2] & 0x08 else 0x02   # the hero's other walking frame
	ld c, $02
	ld a, [wOAMBuffer + 2]
	bit 3, a
	jr z, .flipHero

	ld c, $20

.flipHero
;>                 wOAMBuffer[2] ^= flip
	xor c
	ld [wOAMBuffer + 2], a
;>                 wOAMBuffer[6] ^= flip
	ld a, [wOAMBuffer + 6]
	xor c
	ld [wOAMBuffer + 6], a

.monsterFrames
;>             if not hFlashTimer and hStepMovers:   # (no monster frames while the screen flashes)
	ldh a, [hFlashTimer]
	or a
	jr nz, .loopEnd

	ldh a, [hStepMovers]
	or a
	jr z, .lastFrame

;>                 SwapSpriteFrames(hStepMovers, wOAMCopy, wSpriteFrame2)   # the monsters' second frame
	ld de, wOAMCopy
	ld hl, wSpriteFrame2
	call SwapSpriteFrames
;>                 if hStepMovers2:
	ldh a, [hStepMovers2]
	or a
	jr z, .lastFrame

;>                     SwapSpriteFrames(hStepMovers2, wOAMBuffer2, wSpriteFrame2B)
	ld de, wOAMBuffer2
	ld hl, wSpriteFrame2B
	call SwapSpriteFrames

.lastFrame
;>         if frame == 0x01:         # the last frame: the hero stands again
	ld a, b
	cp $01
	jr nz, .loopEnd

;>             if wOAMBuffer[2] < 0x08:
	ld a, [wOAMBuffer + 2]
	cp $08
	jr nc, .standSide

;>                 wOAMBuffer[2] &= 0x0F
	and $0f
	ld [wOAMBuffer + 2], a
;>                 wOAMBuffer[6] = wOAMBuffer[2] | 0x10
	or $10
	ld [wOAMBuffer + 6], a
	jr .loopEnd

;>             else:
.standSide
;>                 wOAMBuffer[2] |= 0x20
	or $20
	ld [wOAMBuffer + 2], a
;>                 wOAMBuffer[6] |= 0x20
	ld a, [wOAMBuffer + 6]
	or $20
	ld [wOAMBuffer + 6], a

.loopEnd
;>@w1     hSysFlags |= 0x01; WaitOAMCopy(); rSCY = scy; rSCX = scx   # VBlank handler skips the joypad; this frame's sprites and scroll
;>@w5     if frame == 0x1F and hPushedCell: DrawMetatile(0, MapPosToBG(hPushFromHi << 8 | hPushFromLo))   # first frame: the pushed block leaves its cell
	pop bc
	pop de
;>@w7     frame -= 1
;>@w8     if frame == 0: break
;=@loop
	jp .nextFrame

;>@w10     frame -= 1

.done
;> ClearScrollState()              # every sprite's motion back to 0
	call ClearScrollState
;> if hPushedCell:
	ldh a, [hPushedCell]
	or a
	jr z, .waitOAM

;>     slot = 0x10 if hCarriedItem else 0x08   # the pushed block's sprite pair comes after the hero (and his item)
	ld hl, $0008
	ldh a, [hCarriedItem]
	or a
	jr z, .clearBlockSprite

	ld hl, $0010

.clearBlockSprite
;>     fill(wOAMBuffer + slot, 0, 8)  # its sprite is no longer needed
	push hl
	ld c, $08
	ld de, wOAMBuffer
	add hl, de
	call ClearBytes
;>     fill(wOAMCopy + slot, 0, 8)
	ld c, $08
	pop hl
	push hl
	ld de, wOAMCopy
	add hl, de
	call ClearBytes
;>     fill(wOAMBuffer2 + slot, 0, 8)
	ld c, $08
	pop hl
	ld de, wOAMBuffer2
	add hl, de
	call ClearBytes
;>     bg = MapPosToBG(hPushToHi << 8 | hPushToLo)
	ldh a, [hPushToHi]
	ld d, a
	ldh a, [hPushToLo]
	ld e, a
	call MapPosToBG
	push hl

.waitOAM
;> hSysFlags &= ~0x01
	ld hl, hSysFlags
	res 0, [hl]
;> hSysFlags |= 0x80               # copy the sprites at the next VBlank
	set 7, [hl]

.wait
;> while hSysFlags & 0x80:
;>     wait_vblank_flag()
	bit 7, [hl]
	jr nz, .wait

;> if hPushedCell:
	ldh a, [hPushedCell]
	or a
	jr z, .finish

;>     DrawMetatile(hPushedCell, bg)  # the block in its new cell, now as background
	pop hl
	call DrawMetatile

.finish
;> hPushedCell = 0
	xor a
	ldh [hPushedCell], a
;> FlapDragonParts()
	call FlapDragonParts
;> hOldViewPosHi = hViewPosHi
	ldh a, [hViewPosHi]
	ldh [hOldViewPosHi], a
;> hOldViewPosLo = hViewPosLo
	ldh a, [hViewPosLo]
	ldh [hOldViewPosLo], a
	ret


;@ def MoveStepSprites(count: a, sprites: de, motion: hl)
;@ path: map/scroll
;@ Moves `count` sprite pairs of a list one pixel along their motion (rows and columns, -1/0/1),
;@ starting at the slot AnimateStep keeps in hRowRoom (as an offset into the motion table).
;@ Both sprites of a pair get the same motion.
;@ reads: hRowRoom
;@ test: mem[0xFFE5] = rand(0, 4) * 2
;@ test: count = rand(1, 8)
;@ test: sprites = rand_ram(0x80)
;@ test: motion = rand_ram(0x20)
;@ sig: d4fbe5ad
MoveStepSprites::
;> m = motion + hRowRoom[0]           # 2 bytes a pair: rows, columns
	ld c, a
	push bc
	ldh a, [hRowRoom]
	ld c, a
	ld b, $00
	add hl, bc
;> s = sprites + hRowRoom[0] * 4      # 8 bytes a pair: two OAM entries (Y, X, tile, flags)
	push hl
	sla c
	sla c
	push de
	pop hl
	add hl, bc
;> # (s goes to de, m back to hl, the count to c)
	push hl
	pop de
	pop hl
	pop bc

.loop
;> for i in range(count):
;>     mem[s] = u8(mem[s] + mem[m])           # left sprite Y
	ld a, [de]
	add [hl]
	ld [de], a
;>     mem[s + 1] = u8(mem[s + 1] + mem[m + 1])   # left sprite X
	inc de
	inc hl
	ld a, [de]
	add [hl]
	ld [de], a
	dec hl
;>     mem[s + 4] = u8(mem[s + 4] + mem[m])   # right sprite Y
	inc de
	inc de
	inc de
	ld a, [de]
	add [hl]
	ld [de], a
;>     mem[s + 5] = u8(mem[s + 5] + mem[m + 1])   # right sprite X
	inc de
	inc hl
	ld a, [de]
	add [hl]
	ld [de], a
;>     m += 2
	inc hl
;>     s += 8
	inc de
	inc de
	inc de
	dec c
	jr nz, .loop

	ret


;@ def SwapSpriteFrames(count: a, sprites: de, frames: hl)
;@ path: monsters/animation
;@ Swaps the tile and flag bytes of `count` sprite pairs with their stored second frame, starting at
;@ AnimateStep's first moving slot: called halfway through every step, it makes the monsters walk.
;@ reads: hRowRoom
;@ test: mem[0xFFE5] = rand(0, 4) * 2
;@ test: count = rand(1, 8)
;@ test: sprites = rand_ram(0x80)
;@ test: frames = rand_ram(0x40)
;@ sig: e537b2e2
SwapSpriteFrames::
;> n = count
	ld c, a
	push bc
;> f = frames + hRowRoom[0] * 2       # 4 bytes a pair: left tile, flags, right tile, flags
	ldh a, [hRowRoom]
	sla a
	ld c, a
	ld b, $00
	add hl, bc
;> s = sprites + hRowRoom[0] * 4
	push hl
	sla c
	push de
	pop hl
	add hl, bc
;> # (s goes to hl, f to de)
	pop de
	pop bc

.loop
;> for i in range(count):
;>     for k in (2, 3): mem[s + k], mem[f + k - 2] = mem[f + k - 2], mem[s + k]   # left tile, flags
	inc hl
	inc hl
	call SwapByte
	call SwapByte
;>     for k in (6, 7): mem[s + k], mem[f + k - 4] = mem[f + k - 4], mem[s + k]   # right tile, flags
	inc hl
	inc hl
	call SwapByte
	call SwapByte
;>     s += 8
;>     f += 4
	dec c
	jr nz, .loop

	ret


;@ def RefreshDragonCells()
;@ path: monsters/dragon
;@ After a frame's wait: if the dragon's head cell is on screen and not under a window, its four
;@ background tiles become tile $AA (the head is drawn as a sprite), then the body parts flap.
;@ reads: wDragonVRAM
;@ test: skip waits for the VBlank interrupt
;@ sig: 6f09e1f1
RefreshDragonCells::
;> WaitFrame()
	call WaitFrame
;> if wDragonVRAM[0]:
	ld a, [wDragonVRAM]
	or a
	jr z, FlapDragonParts

;>     bg = wDragonVRAM[0] << 8 | wDragonVRAM[1]
	ld h, a
	ld a, [wDragonVRAM + 1]
	ld l, a
;>     if not MapPosUnderWindow(DRAGON_HEAD_POS):
	push hl
	ld de, DRAGON_HEAD_POS
	call MapPosUnderWindow
	pop hl
	jr nz, FlapDragonParts

;>         mem[bg] = 0xAA
;>         mem[bg + 1] = 0xAA
	ld a, $aa
	ld [hli], a
	ld [hli], a
;>         mem[bg + 0x20] = 0xAA
;>         mem[bg + 0x21] = 0xAA
	ld de, $001e
	add hl, de
	ld [hli], a
	ld [hli], a
;> FlapDragonParts()               # (falls through)

;@ def FlapDragonParts()
;@ path: monsters/dragon
;@ Toggles the tiles of the dragon's two body parts between their two frames, each one only when it
;@ is on screen and not hidden by a window.
;@ test: skip waits for the VBlank interrupt
;@ sig: 6fd18037
FlapDragonParts::
;> if wDragonVRAM[2]:
	ld de, wDragonVRAM + 2
	ld a, [de]
	or a
	jr z, .right

;>     if not MapPosUnderWindow(DRAGON_LEFT_POS):
	ld de, DRAGON_LEFT_POS
	call MapPosUnderWindow
	jr nz, .right

;>         ToggleCellTiles(wDragonVRAM + 2)
	ld de, wDragonVRAM + 2
	call ToggleCellTiles

.right
;> if not wDragonVRAM[4]:
	ld de, wDragonVRAM + 4
	ld a, [de]
	or a
;>     return
	ret z

;> if not MapPosUnderWindow(DRAGON_RIGHT_POS):
	ld de, DRAGON_RIGHT_POS
	call MapPosUnderWindow
	ret nz

;>     ToggleCellTiles(wDragonVRAM + 4)
	ld de, wDragonVRAM + 4
	call ToggleCellTiles
	ret


;@ def ToggleCellTiles(ptr: de)
;@ path: gfx/bg
;@ After a frame's wait, flips bit 1 of the four tiles of the cell whose background-map address is
;@ stored big-endian at `ptr`: each tile becomes its other frame.
;@ test: skip waits for the VBlank interrupt
;@ sig: 430822b8
ToggleCellTiles::
;> WaitFrame()
	call WaitFrame
;> bg = mem[ptr] << 8 | mem[ptr + 1]
	ld a, [de]
	inc de
	ld h, a
	ld a, [de]
	ld l, a
;> ToggleTilePair(bg)
	call ToggleTilePair
;> ToggleTilePair(bg + 0x20)       # the row below
	ld bc, $0020
	add hl, bc
	call ToggleTilePair
	ret


;@ def ToggleTilePair(bg: hl)
;@ path: gfx/bg
;@ Flips bit 1 of two neighbouring tile numbers: the tile's other animation frame.
;@ test: bg = rand_ram(2)
;@ sig: e9c71c00
ToggleTilePair::
;> mem[bg] ^= 0x02
	ld a, [hl]
	xor $02
	ld [hli], a
;> mem[bg + 1] ^= 0x02
	ld a, [hl]
	xor $02
	ld [hld], a
	ret


;@ def ShowWindows()
;@ path: status/window
;@ Opens both windows over the map: the hero's status at the top left and the monster's at the
;@ bottom right, then has the sprites copied at the next VBlank.
;@ test: skip waits for the VBlank interrupt
;@ sig: ae7e646e
ShowWindows::
;> OpenStatusWindow()
	call OpenStatusWindow
;> OpenMonsterWindow()
	call OpenMonsterWindow
;> hSysFlags |= 0x80
	ld hl, hSysFlags
	set 7, [hl]
	ret


;@ def CloseWindows()
;@ path: status/window
;@ Closes the monster window, if it is open, by putting back the background it covered and hiding
;@ the monster's picture; then closes the status window the same way (CloseStatusWindow).
;@ reads: hMonsterWinLeft, hMonsterWinRight
;@ test: skip waits for the VBlank interrupt
;@ sig: 1e1e6928
CloseWindows::
;> if hSysFlags & 0x04:             # the monster window is open
	ld hl, hSysFlags
	bit 2, [hl]
	jr z, CloseStatusWindow

;>     left = hMonsterWinLeft
	ld bc, $0c0c
	ldh a, [hMonsterWinLeft]
	ld d, a
;>     right = hMonsterWinRight
	ldh a, [hMonsterWinRight]
	ld e, a
;>     RestoreWindowArea(6, 0x0C0C, left, right)   # 6 rows from tile row and column 12
	ld a, $06
	call RestoreWindowArea
;>     hModeFlags |= 0x08           # ShowMonsterPicture: only hide the sprites in that corner
	ld hl, hModeFlags
	set 3, [hl]
;>     ShowMonsterPicture()
	call ShowMonsterPicture
;>     hModeFlags &= ~0x08
	ld hl, hModeFlags
	res 3, [hl]
;>     hSysFlags |= 0x80
	ld hl, hSysFlags
	set 7, [hl]
;>     hSysFlags &= ~0x04
	ld hl, hSysFlags
	res 2, [hl]
;> CloseStatusWindow()              # (falls through)

;@ def CloseStatusWindow()
;@ path: status/window
;@ Closes the status window, if it is open: its 8 rows at the top left get their background back.
;@ reads: hStatusWinLeft, hStatusWinRight
;@ test: skip waits for the VBlank interrupt
;@ sig: 7a96395b
CloseStatusWindow::
;> if not hSysFlags & 0x08:
	ld hl, hSysFlags
	bit 3, [hl]
;>     return
	ret z

;> hSysFlags &= ~0x08
	res 3, [hl]
;> left = hStatusWinLeft
	ld bc, $0000
	ldh a, [hStatusWinLeft]
	ld d, a
;> right = hStatusWinRight
	ldh a, [hStatusWinRight]
	ld e, a
;> RestoreWindowArea(8, 0x0000, left, right)   # 8 rows from the top-left tile
	ld a, $08
	call RestoreWindowArea
	ret


;@ def OpenStatusWindow()
;@ path: status/window
;@ Opens the hero's status window in the top-left corner of the view (8 tiles wide, 8 rows): his hit
;@ points, strength, maximum hit points, gold and potions as numbers, and one crown icon for each
;@ crown piece he carries. The tile map is built in a borrowed buffer, then drawn by DrawWindow.
;@ writes: hStatusWinLeft, hStatusWinRight
;@ test: skip waits for the VBlank interrupt
;@ sig: 13fbe327
OpenStatusWindow::
;> copy(wFarSprites, StatusWindowMap, 0x38)   # 7 rows of 8 tiles, the frame and the icons
	ld de, StatusWindowMap
	ld hl, wFarSprites
	ld b, $38
	call CopyB
;> DrawNumber(hHPHi, wFarSprites + 14)        # row 1 (heart), right-aligned up to column 6
	ld bc, hHPHi
	ld hl, wFarSprites + 14
	call DrawNumber
;> DrawNumber(hStrHi, wFarSprites + 22)       # row 2 (sword)
	ld bc, hStrHi
	ld hl, wFarSprites + 22
	call DrawNumber
;> DrawNumber(hMaxHPHi, wFarSprites + 30)     # row 3
	ld bc, hMaxHPHi
	ld hl, wFarSprites + 30
	call DrawNumber
;> DrawNumberStyled(hGoldHi, wFarSprites + 38)    # row 4 (gold)
	ld bc, hGoldHi
	ld hl, wFarSprites + 38
	call DrawNumberStyled
;> DrawNumberStyled(hPotionsHi, wFarSprites + 46) # row 5 (potion)
	ld bc, hPotionsHi
	ld hl, wFarSprites + 46
	call DrawNumberStyled
;> p = wFarSprites + 54               # row 6, column 6
	ld bc, hPiecesCarried
	ld hl, wFarSprites + 54
;> if hPiecesCarried == 0:
	ld a, [bc]
	or a
	jr nz, .crowns

;>     mem[p] = 0x50                  # "0"
	ld [hl], $50
	jr .draw

;> else:
.crowns
;>     for _ in range(hPiecesCarried):   # a crown icon for each, leftwards
;>         mem[p] = 0x3D; p -= 1
	ld [hl], $3d
	dec hl
	dec a
	jr nz, .crowns

.draw
;> d, e = DrawWindow(7, 0x0000, wFarSprites)   # 7 rows at the top left, plus the bottom edge
	ld a, $07
	ld bc, $0000
	ld de, wFarSprites
	call DrawWindow
;> hSysFlags |= 0x08                 # the status window is open
	ld hl, hSysFlags
	set 3, [hl]
;> HideSpritesUnderStatus()
	push de
	call HideSpritesUnderStatus
	pop de
;> hStatusWinLeft = d                # kept for closing it
	ld a, d
	ldh [hStatusWinLeft], a
;> hStatusWinRight = e
	ld a, e
	ldh [hStatusWinRight], a
	ret


;@ path: status/window
;@ The status window's tile map: 7 rows of 8 tiles. Row 0 holds the word PLAYER (tiles $40-$43),
;@ rows 1-6 an icon in column 0 (heart, sword, a figure, gold coin, potion, crown) and blanks
;@ ($3E) where OpenStatusWindow writes the numbers; column 7 is the window's right edge ($5E).
;@ asset: tilemap width=8 height=7 tiles=LoadTiles addressing=8800
StatusWindowMap::
	db $3e, $40, $41, $42, $43, $3e, $3e, $5e, $2c, $3e, $3e, $3e, $3e, $3e, $3e, $5e
	db $2d, $3e, $3e, $3e, $3e, $3e, $3e, $5e, $2e, $3e, $3e, $3e, $3e, $3e, $3e, $5e
	db $2f, $3e, $3e, $3e, $3e, $3e, $3e, $5e, $3c, $3e, $3e, $3e, $3e, $3e, $3e, $5e
	db $3d, $3e, $3e, $3e, $3e, $3e, $3e, $5e

;@ path: status/window
;@ The status window's bottom edge (row 7): DrawWindow draws it straight from here, below a window
;@ that starts in the top row.
;@ asset: tilemap width=8 height=1 tiles=LoadTiles addressing=8800
StatusWindowBottom::
	db $5d, $5d, $5d, $5d, $5d, $5d, $5d, $5f

;@ def OpenMonsterWindow()
;@ path: status/window
;@ Opens the monster window in the bottom-right corner (8 tiles wide, 6 rows): the word MONSTER, the
;@ hit points, strength and maximum hit points of the current object, and its picture as a sprite.
;@ writes: hMonsterWinLeft, hMonsterWinRight
;@ test: skip waits for the VBlank interrupt
;@ sig: 81643311
OpenMonsterWindow::
;> copy(wFarSprites + 0x38, MonsterWindowMap, 0x30)   # after the status window's map
	ld de, MonsterWindowMap
	ld hl, wFarSprites + $38
	ld b, $30
	call CopyB
;> values = GetCurObj() + 7       # three big-endian words: hit points, strength, maximum hit points
	call GetCurObj
	ld bc, $0007
	add hl, bc
	push hl
	pop bc
;> DrawNumber(values, wFarSprites + 0x38 + 31)       # row 3, right-aligned up to column 7
	push bc
	ld hl, wFarSprites + $38 + 31
	call DrawNumber
;> DrawNumber(values + 2, wFarSprites + 0x38 + 39)   # row 4
	pop bc
	inc bc
	inc bc
	push bc
	ld hl, wFarSprites + $38 + 39
	call DrawNumber
;> DrawNumber(values + 4, wFarSprites + 0x38 + 47)   # row 5
	pop bc
	inc bc
	inc bc
	ld hl, wFarSprites + $38 + 47
	call DrawNumber
;> d, e = DrawWindow(6, 0x0606, wFarSprites + 0x38)   # 6 rows from cell row and column 6
	ld a, $06
	ld bc, $0606
	ld de, wFarSprites + $38
	call DrawWindow
;> hSysFlags |= 0x04               # the monster window is open
	ld hl, hSysFlags
	set 2, [hl]
;> ShowMonsterPicture()
	push de
	call ShowMonsterPicture
	pop de
;> hMonsterWinLeft = d
	ld a, d
	ldh [hMonsterWinLeft], a
;> hMonsterWinRight = e
	ld a, e
	ldh [hMonsterWinRight], a
	ret


;@ path: status/window
;@ The monster window's tile map: 6 rows of 8 tiles with the top edge ($5C corner, $5D) and the left
;@ edge ($5E). Row 1 holds the word MONSTER (tiles $4B-$4F), rows 3-5 the heart, sword and figure
;@ icons in front of the numbers OpenMonsterWindow writes.
;@ asset: tilemap width=8 height=6 tiles=LoadTiles addressing=8800
MonsterWindowMap::
	db $5c, $5d, $5d, $5d, $5d, $5d, $5d, $5d, $5e, $4b, $4c, $4d, $4e, $4f, $3e, $3e
	db $5e, $3e, $3e, $3e, $3e, $3e, $3e, $3e, $5e, $2c, $3e, $3e, $3e, $3e, $3e, $3e
	db $5e, $2d, $3e, $3e, $3e, $3e, $3e, $3e, $5e, $2e, $3e, $3e, $3e, $3e, $3e, $3e

;@ def DrawWindow(rows: a, cell: bc, src: de) -> (d, e)
;@ path: status/window
;@ Draws a window 8 tiles wide and `rows` tall from the tile map at `src` onto the background, at
;@ screen cell b (row) / c (column), one row per frame, saving the tiles it covers: the status window
;@ (row 0) to $9E80, the monster window to $9EC0 (unused rows of the second background map), or to
;@ wWindowUnder2 if that window is already open. A row that crosses the right edge of the 32-tile
;@ background map continues at its left edge; d and e return the tile counts before and after that
;@ wrap. A window in row 0 also gets StatusWindowBottom below it.
;@ writes: hTemp1, hTemp2, hTemp3
;@ reads: hScrollCol, hSysFlags, hTemp1, hTemp2, hTemp3
;@ test: skip waits for the VBlank interrupt
;@ sig: 913bf0bb
DrawWindow::
;> hTemp3 = rows
	ldh [hTemp3], a
;> col = (hScrollCol + b) & 0x0F   # (b for the column: both windows sit where row == column)
	push bc
	push de
	ldh a, [hScrollCol]
	add b
	and $0f
;> room = (16 - col) * 2           # tiles left before the background map's right edge
	ld b, a
	ld a, $10
	sub b
	sla a
;> if room >= 8:
	push af
	sub $08
	jr c, .wraps

;>     hTemp1 = 8                  # the whole row fits
	pop af
	ld a, $08
	ldh [hTemp1], a
;>     hTemp2 = 0
	xor a
	jr .setRest

;> else:
.wraps
;>     hTemp1 = room
	pop af
	ldh [hTemp1], a
;>     hTemp2 = 8 - room           # the rest goes to the start of the map row
	sub $08
	xor $ff
	inc a

.setRest
	ldh [hTemp2], a
;> bg = ViewBGAddr(b * 2, c * 2)
	pop de
	pop bc
	sla b
	sla c
	call ViewBGAddr
;>@ifb if b != 0:                 # the monster window
	ld a, b
	push bc
;=@s80
	ld bc, $9e80
;=@ifb
	or a
	jr z, .status

;>     save = 0x9EC0
	ld bc, $9ec0
;>     if hSysFlags & 0x04:        # already open: what is under it is the window itself
	ldh a, [hSysFlags]
	bit 2, a
	jr z, .rows

;>         save = wWindowUnder2
	ld bc, wWindowUnder2
	jr .rows

.status
;> else:                          # the status window
;>@s80     save = 0x9E80
;>     if hSysFlags & 0x08:
	ldh a, [hSysFlags]
	bit 3, a
	jr z, .rows

;>         save = wWindowUnder2
	ld bc, wWindowUnder2

.rows
;> for _ in range(hTemp3):
	ldh a, [hTemp3]

.row
;>     WaitFrame()                 # one row a frame
;>     p = bg
	push af
	push hl
	call WaitFrame
;>     for _ in range(hTemp1):     # SaveAndCopyByte: keep the old tile, put the window's
;>         mem[save] = mem[p]; mem[p] = mem[src]; p += 1; save += 1; src += 1
	ldh a, [hTemp1]

.left
	push af
	call SaveAndCopyByte
	pop af
	dec a
	jr nz, .left

;>     p = bg & 0xFFE0             # back to the start of this map row
	pop hl
	push hl
	ld a, l
	and $e0
	ld l, a
;>     for _ in range(hTemp2):
	ldh a, [hTemp2]
	inc a

.right
	dec a
	jr z, .nextRow

;>         mem[save] = mem[p]; mem[p] = mem[src]; p += 1; save += 1; src += 1
	push af
	call SaveAndCopyByte
	pop af
	jr .right

.nextRow
;>     bg += 0x20
	pop hl
	push de
	ld de, $0020
	add hl, de
	pop de
;>     if hi(bg) == 0x9C:          # below the map's bottom row: wrap to the top
	ld a, h
	cp $9c
	jr nz, .wrapped

;>         bg -= 0x400
	ld a, $98
	ld h, a

.wrapped
	pop af
	dec a
	jr nz, .row

;> if b == 0:                      # the status window gets its bottom edge
	pop af
	or a
	jr nz, .done

;>     src = StatusWindowBottom
	push hl
	ld de, StatusWindowBottom
;>     WaitFrame()
;>     p = bg
	call WaitFrame
;>     for _ in range(hTemp1):
;>         mem[save] = mem[p]; mem[p] = mem[src]; p += 1; save += 1; src += 1
	ldh a, [hTemp1]

.edgeLeft
	push af
	call SaveAndCopyByte
	pop af
	dec a
	jr nz, .edgeLeft

;>     p = bg & 0xFFE0
	pop hl
	ld a, l
	and $e0
	ld l, a
;>     for _ in range(hTemp2):
	ldh a, [hTemp2]
	inc a

.edgeRight
	dec a
	jr z, .done

;>         mem[save] = mem[p]; mem[p] = mem[src]; p += 1; save += 1; src += 1
	push af
	call SaveAndCopyByte
	pop af
	jr .edgeRight

.done
;> return hTemp1, hTemp2           # in d and e
	ldh a, [hTemp1]
	ld d, a
	ldh a, [hTemp2]
	ld e, a
	ret


;@ def RestoreWindowArea(rows: a, tile: bc, left: d, right: e)
;@ path: status/window
;@ Closes a window: copies the background tiles DrawWindow saved back over `rows` rows at tile row b /
;@ column c, one row per frame; `left` and `right` are the tile counts before and after the
;@ background map's right edge that DrawWindow returned.
;@ writes: hTemp1, hTemp2
;@ reads: hTemp1, hTemp2
;@ test: skip waits for the VBlank interrupt
;@ sig: 25099859
RestoreWindowArea::
;> hTemp1 = left
	push af
	ld a, d
	ldh [hTemp1], a
;> hTemp2 = right
	ld a, e
	ldh [hTemp2], a
;> bg = ViewBGAddr(b, c)
	call ViewBGAddr
;> saved = 0x9E80 if b == 0 else 0x9EC0
	ld de, $9e80
	ld a, b
	or a
	jr z, .rows

	ld de, $9ec0

.rows
;> for _ in range(rows):
	pop af

.row
;>     WaitFrame()
;>     p = bg
	push af
	push hl
	call WaitFrame
;>     for _ in range(hTemp1):
;>         mem[p] = mem[saved]; p += 1; saved += 1
	ldh a, [hTemp1]

.left
	push af
	call CopyByte
	pop af
	dec a
	jr nz, .left

;>     p = bg & 0xFFE0
	pop hl
	push hl
	ld a, l
	and $e0
	ld l, a
;>     for _ in range(hTemp2):
	ldh a, [hTemp2]
	inc a

.right
	dec a
	jr z, .nextRow

;>         mem[p] = mem[saved]; p += 1; saved += 1
	push af
	call CopyByte
	pop af
	jr .right

.nextRow
;>     bg += 0x20
	pop hl
	ld bc, $0020
	add hl, bc
;>     if hi(bg) == 0x9C:
	ld a, h
	cp $9c
	jr nz, .wrapped

;>         bg -= 0x400
	ld a, $98
	ld h, a

.wrapped
	pop af
	dec a
	jr nz, .row

	ret


;@ def HideSpritesUnderStatus()
;@ path: status/window
;@ While the status window is open, hides the sprites that stay inside its top-left corner
;@ (screen Y below 76 and X below 68 for the whole step), then flags the sprites for OAM.
;@ test: hSysFlags = rand(0, 255)
;@ test: hOAMCount = rand(0, 20)
;@ test: hOAM2Count = rand(0, 20)
;@ sig: 56048808
HideSpritesUnderStatus::
;> if not hSysFlags & 0x08:
	ld hl, hSysFlags
	bit 3, [hl]
;>     return
	ret z

;> HideSpritesInCorner(0x5048)     # OAM limits: Y $50, X $48 (the window's 64x64 pixels)
	ld bc, $5048

;@ def HideSpritesInCorner(limits: bc)
;@ path: status/window
;@ Hides the sprite pairs of both sprite lists that stay inside the top-left box given by OAM Y limit
;@ b and X limit c (HideSpritesTopLeft), then flags the sprites for the next OAM copy. The first call
;@ leaves b and c 4 lower, so for the second list the box is 4 pixels smaller each way.
;@ reads: hOAM2Count, hOAMCount
;@ test: limits = rand(4, 0xA0) << 8 | rand(4, 0xA8)
;@ test: hOAMCount = rand(0, 20)
;@ test: hOAM2Count = rand(0, 20)
;@ sig: cb9b601e
HideSpritesInCorner::
;> HideSpritesTopLeft(hOAMCount, wOAMBuffer, addr(wScrollDY), limits)
	ld hl, wOAMBuffer
	ld de, wScrollDY
	ldh a, [hOAMCount]
	call HideSpritesTopLeft
;> HideSpritesTopLeft(hOAM2Count, wOAMBuffer2, wSpriteMotion2, limits - 0x0404)   # b and c came back 4 lower: a smaller box
	ldh a, [hOAM2Count]
	ld hl, wOAMBuffer2
	ld de, wSpriteMotion2
	call HideSpritesTopLeft
;> hSysFlags |= 0x80               # (RequestOAMCopy, the end of ShowMonsterPicture)
	jr RequestOAMCopy

;@ def ShowMonsterPicture()
;@ path: status/window
;@ While the monster window is open: hides the sprites inside its bottom-right corner and, unless
;@ hModeFlags bit 3 asks only for that, adds the picture of the current object (or of picture
;@ hPictureOverride - 1) as the last sprite pair of the first list, at the right of the word MONSTER.
;@ writes: hOAMCount
;@ reads: hOAM2Count, hOAMCount, hPictureOverride
;@ test: hSysFlags = rand(0, 255)
;@ test: hModeFlags = rand(0, 255)
;@ test: hOAMCount = rand(0, 20)
;@ test: hOAM2Count = rand(0, 20)
;@ test: hPictureOverride = rand(0, 0x25)
;@ test: hCurObjHi = 0xD5; hCurObjLo = rand(0x7A, 0xF0)
;@ sig: 9b0cf0e9
ShowMonsterPicture::
;> if not hSysFlags & 0x04:
	ld hl, hSysFlags
	bit 2, [hl]
;>     return
	ret z

;> HideSpritesBottomRight(hOAMCount, wOAMBuffer, addr(wScrollDY))
	ld hl, wOAMBuffer
	ld de, wScrollDY
	ldh a, [hOAMCount]
	call HideSpritesBottomRight
;> HideSpritesBottomRight(hOAM2Count, wOAMBuffer2, wSpriteMotion2)
	ldh a, [hOAM2Count]
	ld hl, wOAMBuffer2
	ld de, wSpriteMotion2
	call HideSpritesBottomRight
;> if hModeFlags & 0x08:            # closing the window: hiding was all
	ld hl, hModeFlags
	bit 3, [hl]
;>     return
	ret nz

;> if hOAMCount != 20:
	ldh a, [hOAMCount]
	cp $14
	jr z, .full

;>     hOAMCount += 1
;>     slot = hOAMCount - 1         # a new pair at the end of the list
	inc a
	ldh [hOAMCount], a
	jr .slot

;> else:
.full
;>     slot = 18                    # the list is full: it takes over the pair before the last
	ld a, $13

.slot
;> # (one less for the slot number)
	dec a
;> mem[addr(wScrollDY) + slot * 2] = 0         # the picture does not move with the steps
	sla a
	ld e, a
	ld d, $00
	ld hl, wScrollDY
	add hl, de
;> mem[addr(wScrollDY) + slot * 2 + 1] = 0
	xor a
	ld [hli], a
	ld [hl], a
;> frame2 = wSpriteFrame2 + slot * 4
	sla e
	ld hl, wSpriteFrame2
	add hl, de
	push hl
;> oam = wOAMBuffer + slot * 8
	sla e
	ld hl, wOAMBuffer
	add hl, de
	push hl
;> if hPictureOverride:
	ldh a, [hPictureOverride]
	or a
	jr z, .kind

;>     pic = hPictureOverride - 1
	dec a
	jr .tiles

;> else:
.kind
;>     pic = mem[GetCurObj() + 1]   # the object's kind
	call GetCurObj
	inc hl
	ld a, [hl]

.tiles
;> offset = pic * 8
	ld d, $00
	sla a
	sla a
	sla a
	rl d
	ld e, a
;> src = ObjectSpriteTiles + offset   # its first frame: left tile and flags, right tile and flags
	ld hl, ObjectSpriteTiles
	add hl, de
	push hl
	pop de
	pop hl
	pop bc
;> mem[oam] = 0x78                 # left half at screen Y 104, X 144
	ld [hl], $78
	inc hl
;> mem[oam + 1] = 0x98
	ld [hl], $98
	inc hl
;> CopyTileAndFlags(oam + 2, src, frame2)   # also as its second frame: the picture stands still
	call CopyTileAndFlags
;> mem[oam + 4] = 0x78             # right half at X 152
	ld [hl], $78
	inc hl
;> mem[oam + 5] = 0xA0
	ld [hl], $a0
	inc hl
;> CopyTileAndFlags(oam + 6, src + 2, frame2 + 2)
	call CopyTileAndFlags

RequestOAMCopy:
;> hSysFlags |= 0x80               # copy the sprites at the next VBlank
	ld hl, hSysFlags
	set 7, [hl]
	ret


;@ def HideSpritesTopLeft(count: a, sprites: hl, motion: de, limits: bc)
;@ path: gfx/sprites
;@ Moves off screen (Y = X = $D0) each of `count` sprite pairs that stays above OAM Y b - 4 and left
;@ of OAM X c - 4 during the whole step: a pair moving down or right is tested at its end position.
;@ test: count = rand(0, 20)
;@ test: sprites = rand_ram(0xA0)
;@ test: motion = rand_ram(0x28)
;@ test: limits = rand(4, 0xA0) << 8 | rand(4, 0xA8)
;@ sig: 39c61b3e
HideSpritesTopLeft::
;> xlim = u8((limits & 0xFF) - 4)
	inc a
	dec c
	dec c
	dec c
	dec c
;> ylim = u8((limits >> 8) - 4)
	dec b
	dec b
	dec b
	dec b

.loop
;> for _ in range(count):
	dec a
	ret z

;>     y, motion = PosAfterStepPlus(sprites, motion)
	push af
	call PosAfterStepPlus
;>     if y >= ylim:
	cp b
	jr c, .checkX

;>         motion += 1              # (the column motion is not needed)
	inc de
	jr .skip

.checkX
;>     else:
;>         x, motion = PosAfterStepPlus(sprites + 1, motion)
	inc hl
	call PosAfterStepPlus
	dec hl
;>         if x < xlim:
	cp c
	jr nc, .skip

;>             sprites = HideSpritePair(sprites)
;>             continue
	call HideSpritePair
	jr .next

.skip
;>     sprites += 8
	push de
	ld de, $0008
	add hl, de
	pop de

.next
	pop af
	jr .loop

;@ def PosAfterStepPlus(pos: hl, motion: de) -> (a, de)
;@ path: gfx/sprites
;@ A sprite coordinate as it will be at the end of the step if its motion is +1 (16 pixels on),
;@ otherwise as it is now; moves on to the next motion byte.
;@ test: pos = rand_ram(1)
;@ test: motion = rand_ram(1); mem[motion] = rng.choice([0, 1, 0xFF, rand(0, 255)])
;@ sig: 275056c2
PosAfterStepPlus::
;> m = mem[motion]
	ld a, [de]
	inc de
;> if m != 1:
	dec a
	jr z, .plus

;>     add = 0
	xor a
	jr .add

;> else:
.plus
;>     add = 0x10
	ld a, $10

.add
;> return u8(add + mem[pos]), motion + 1
	add [hl]
	ret


;@ def HideSpritesBottomRight(count: a, sprites: hl, motion: de)
;@ path: gfx/sprites
;@ Moves off screen each of `count` sprite pairs that stays at OAM Y $70 or more and OAM X $68 or more
;@ (the monster window's corner) during the whole step: a pair moving up or left is tested at its
;@ end position.
;@ test: count = rand(0, 20)
;@ test: sprites = rand_ram(0xA0)
;@ test: motion = rand_ram(0x28)
;@ sig: 240aaf99
HideSpritesBottomRight::
;> for _ in range(count):
	inc a

.loop
	dec a
	ret z

;>     y, motion = PosAfterStepMinus(sprites, motion)
	push af
	call PosAfterStepMinus
;>     if y < 0x70:
	cp $70
	jr nc, .checkX

;>         motion += 1
	inc de
	jr .skip

.checkX
;>     else:
;>         x, motion = PosAfterStepMinus(sprites + 1, motion)
	inc hl
	call PosAfterStepMinus
	dec hl
;>         if x >= 0x68:
	cp $68
	jr c, .skip

;>             sprites = HideSpritePair(sprites)
;>             continue
	call HideSpritePair
	jr .next

.skip
;>     sprites += 8
	push de
	ld de, $0008
	add hl, de
	pop de

.next
	pop af
	jr .loop

;@ def PosAfterStepMinus(pos: hl, motion: de) -> (a, de)
;@ path: gfx/sprites
;@ A sprite coordinate as it will be at the end of the step if its motion is -1 (16 pixels back),
;@ otherwise as it is now; moves on to the next motion byte.
;@ test: pos = rand_ram(1)
;@ test: motion = rand_ram(1); mem[motion] = rng.choice([0, 1, 0xFF, rand(0, 255)])
;@ sig: 6170ed5c
PosAfterStepMinus::
;> m = mem[motion]
	ld a, [de]
	inc de
;> if m != 0xFF:
	inc a
	jr z, .minus

;>     add = 0
	xor a
	jr .add

;> else:
.minus
;>     add = 0xF0
	ld a, $f0

.add
;> return u8(add + mem[pos]), motion + 1
	add [hl]
	ret


;@ def HideSpritePair(sprites: hl) -> hl
;@ path: gfx/sprites
;@ Puts both sprites of a pair at Y = X = $D0, below the screen, and returns the next pair.
;@ test: sprites = rand_ram(8)
;@ sig: f1932b35
HideSpritePair::
;> mem[sprites] = 0xD0
;> mem[sprites + 1] = 0xD0
	ld a, $d0
	ld [hli], a
	ld [hli], a
;> mem[sprites + 4] = 0xD0
;> mem[sprites + 5] = 0xD0
	inc hl
	inc hl
	ld [hli], a
	ld [hli], a
;> return sprites + 8
	inc hl
	inc hl
	ret


;@ def CopyTileAndFlags(dest: hl, src: de, dest2: bc) -> (hl, de, bc)
;@ path: gfx/sprites
;@ Copies a sprite's tile number and attribute byte from `src` to `dest` and to `dest2`.
;@ test: dest = rand_ram(2)
;@ test: src = rand(0, 0x7FFE)
;@ test: dest2 = rand_ram(2)
;@ sig: 71aaf62e
CopyTileAndFlags::
;> mem[dest] = mem[src]            # tile
;> mem[dest2] = mem[src]
	ld a, [de]
	inc de
	ld [hli], a
	ld [bc], a
	inc bc
;> mem[dest + 1] = mem[src + 1]    # attributes
;> mem[dest2 + 1] = mem[src + 1]
	ld a, [de]
	inc de
	ld [hli], a
	ld [bc], a
	inc bc
;> return dest + 2, src + 2, dest2 + 2
	ret


;@ path: map/data
;@ The world map of phase 1, packed into 1848 bytes; UnpackMap unpacks it into wMap at the start of a game.
;@ The map is 80 cells wide and 100 tall; a cell is 16x16 pixels (2x2 tiles, its picture from CellTiles),
;@ and a map position is the address $C000 + row * 80 + column.
;@ Packing: a bit stream, each byte read from bit 7 down. A cell value is written either as 1 then one bit
;@ (value 0 or 1, the two commonest: floor and rock) or as 0 then five bits (0-31). After each cell comes
;@ one bit: 0 = the next cell repeats the value, 1 = a new value follows. The cells run row by row from the
;@ top left until all 8000 are filled; the stream holds nothing else (no size, no end mark).
;@ wMap keeps 4 bits a cell: rows 0-49 in the high nibbles of $C000-$CF9F, rows 50-99 in the low nibbles of
;@ the same bytes. Values 15-31 store nibble 15 and their real value in wBigCellTable / wBigCellList.
;@ Cell types: 0 floor, 1 rock (pushed with item $F8), 2 the home, 3 gravestone, 4 warp (the four warps
;@ lead round in a ring), 5 box (a key turns it into a find), 6 the sword (changes the hero for good),
;@ 7 gold, 8 key, 9 cross (monsters cannot pass it), $0A jewel (250 strength when used at home), $0B jar,
;@ $0C crown piece, $0D potion, $0E sleeping marker, $0F filler beside the dragon, $10-$13 the dragon
;@ (head, left part, right part, body), $14 pit (under the dragon's tail), $17 a "WP" sign above a warp.
;@ This phase: the home at row 5, column 5; the dragon's 3x3 cells at rows 88-90, columns 68-70.
Phase1Map::
	db $c0, $0c, $1f, $7c, $7c, $f8, $fb, $80, $37, $18, $70, $37, $25, $7c, $00, $00
	db $00, $70, $df, $7d, $f7, $6e, $dd, $9c, $df, $07, $c7, $6e, $df, $0e, $df, $1c
	db $02, $4f, $01, $80, $79, $5f, $1f, $7d, $f3, $ee, $dc, $dc, $6e, $37, $dd, $8e
	db $df, $73, $76, $ed, $f0, $00, $0f, $80, $78, $db, $99, $f7, $61, $f7, $67, $c3
	db $e1, $f7, $03, $7d, $f7, $c0, $ec, $00, $03, $e0, $1d, $9f, $3b, $1c, $37, $6e
	db $37, $6e, $30, $1f, $7d, $db, $83, $7c, $00, $03, $e2, $16, $1e, $4f, $dd, $9c
	db $c7, $dc, $61, $f3, $ef, $8f, $b8, $37, $c7, $df, $1c, $87, $80, $0e, $18, $07
	db $9b, $cd, $f7, $dd, $be, $1c, $37, $6f, $9d, $be, $e6, $7d, $c6, $ed, $f2, $6f
	db $c1, $cc, $3e, $00, $1e, $47, $c7, $c0, $e3, $03, $e3, $98, $7c, $3b, $0f, $87
	db $6e, $c3, $e3, $e3, $e0, $01, $c0, $03, $1c, $00, $00, $dd, $8e, $6e, $18, $9b
	db $f1, $f0, $7c, $f8, $00, $07, $60, $26, $98, $1f, $1f, $7c, $3e, $7d, $f7, $60
	db $0e, $df, $1f, $22, $e7, $cf, $80, $00, $70, $00, $00, $df, $7d, $f0, $71, $b8
	db $03, $3b, $00, $f8, $f8, $00, $07, $d1, $cd, $1c, $0d, $1f, $7d, $f7, $df, $1e
	db $28, $07, $37, $61, $f3, $b0, $1f, $0f, $82, $38, $30, $7c, $8f, $91, $c0, $1e
	db $6e, $7d, $c6, $8a, $01, $be, $3e, $ed, $db, $b0, $3e, $0f, $84, $bc, $09, $b8
	db $78, $f8, $8e, $d1, $f4, $73, $47, $df, $7d, $f3, $e7, $8a, $01, $8f, $be, $f8
	db $fb, $b0, $3e, $0f, $80, $8a, $c0, $78, $ed, $1c, $d1, $f4, $73, $47, $de, $6e
	db $f9, $db, $a2, $80, $71, $be, $fb, $ef, $bb, $00, $0f, $8f, $91, $46, $7c, $78
	db $71, $f4, $7d, $1f, $11, $f4, $7d, $1f, $76, $fb, $e3, $e8, $a0, $1f, $0f, $be
	db $76, $ec, $0f, $83, $e0, $22, $b0, $1f, $47, $d1, $f2, $38, $c4, $77, $9b, $b9
	db $be, $e8, $a0, $19, $db, $b7, $df, $3b, $00, $0f, $84, $7c, $08, $f8, $7c, $95
	db $80, $8e, $67, $df, $3e, $f9, $e2, $80, $7c, $fb, $e7, $df, $73, $00, $0f, $82
	db $38, $30, $7c, $00, $07, $dd, $be, $3a, $28, $07, $6e, $c7, $37, $df, $00, $0f
	db $80, $00, $7c, $00, $07, $9b, $93, $77, $4d, $e8, $a0, $1d, $37, $26, $f2, $56
	db $9b, $a6, $fc, $00, $3e, $00, $01, $f0, $00, $1c, $00, $00, $00, $00, $dc, $00
	db $00, $93, $c0, $37, $00, $0c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
	db $f0, $07, $c0, $1f, $38, $00, $18, $e3, $39, $8e, $dd, $80, $00, $8f, $81, $f0
	db $07, $c0, $1f, $78, $a0, $00, $7d, $f0, $07, $cf, $8f, $80, $00, $47, $c1, $f0
	db $af, $87, $c0, $1f, $78, $a0, $00, $7c, $00, $02, $1e, $11, $70, $8b, $88, $e0
	db $60, $08, $98, $02, $1e, $07, $8a, $00, $07, $df, $00, $7c, $f8, $f8, $00, $04
	db $7c, $1f, $00, $7c, $01, $f7, $8a, $70, $08, $a7, $df, $00, $7c, $ed, $d8, $00
	db $08, $f8, $1f, $00, $7c, $01, $f7, $8a, $70, $08, $a7, $df, $00, $7c, $00, $00
	db $00, $1f, $00, $7c, $01, $f7, $8a, $74, $a0, $e8, $a7, $df, $00, $7c, $00, $00
	db $00, $1f, $00, $7c, $01, $f7, $8a, $74, $a0, $e8, $a7, $ce, $01, $b8, $dc, $03
	db $71, $b8, $dc, $60, $8f, $83, $8d, $c6, $78, $a7, $49, $0e, $8a, $7d, $f0, $07
	db $c0, $00, $07, $c0, $1f, $11, $cc, $7c, $01, $f7, $8a, $74, $a0, $e8, $a7, $df
	db $00, $7c, $00, $00, $7c, $01, $f2, $3e, $8f, $a3, $e7, $c0, $1f, $78, $a7, $4a
	db $0e, $8a, $7d, $f0, $07, $c0, $00, $07, $c0, $1f, $08, $f8, $7c, $01, $f7, $8a
	db $70, $08, $a7, $df, $00, $7c, $22, $e0, $08, $b8, $7c, $01, $f0, $8f, $87, $c2
	db $2e, $1f, $78, $a7, $00, $8a, $7d, $f0, $07, $c4, $53, $01, $14, $c0, $21, $e0
	db $00, $04, $53, $07, $8a, $00, $07, $c0, $87, $87, $c2, $2e, $00, $8b, $87, $c0
	db $1f, $00, $7c, $22, $e1, $f7, $8a, $00, $07, $df, $00, $7c, $00, $00, $7c, $01
	db $f0, $07, $c0, $1f, $78, $a0, $00, $7d, $f0, $07, $c0, $00, $07, $c0, $1f, $00
	db $7c, $01, $f3, $80, $01, $9f, $00, $7c, $00, $00, $7c, $01, $f0, $07, $c0, $1f
	db $00, $00, $1f, $00, $7c, $00, $00, $38, $dc, $6e, $01, $b8, $dc, $6e, $37, $1b
	db $8d, $c6, $e3, $71, $b8, $06, $00, $7c, $03, $b7, $03, $76, $00, $00, $7c, $01
	db $f0, $07, $c0, $1f, $00, $7c, $03, $a2, $80, $76, $00, $00, $7c, $01, $f0, $07
	db $c0, $1f, $11, $f0, $7c, $03, $a2, $80, $76, $00, $00, $7c, $01, $f2, $3e, $23
	db $e7, $c0, $1f, $23, $e0, $7c, $03, $a2, $80, $76, $00, $00, $7c, $01, $f1, $1e
	db $bc, $7c, $02, $1e, $04, $70, $30, $25, $63, $a2, $80, $76, $01, $2b, $08, $78
	db $00, $00, $89, $87, $c0, $1f, $23, $e0, $7c, $03, $a2, $80, $76, $00, $00, $7c
	db $01, $f1, $1f, $47, $c7, $c0, $1f, $11, $f0, $7c, $03, $a2, $80, $76, $00, $00
	db $7c, $01, $f2, $3e, $23, $e7, $c0, $1f, $00, $7c, $03, $a2, $80, $76, $00, $00
	db $7c, $01, $f0, $07, $c0, $1f, $00, $7c, $03, $ee, $01, $be, $00, $00, $7c, $01
	db $f0, $07, $00, $6e, $00, $00, $dc, $00, $dc, $37, $6e, $0d, $db, $80, $6e, $01
	db $14, $00, $00, $00, $00, $03, $ef, $8e, $df, $3e, $3c, $50, $00, $00, $6f, $80
	db $00, $00, $00, $00, $e6, $ed, $c6, $fb, $ef, $8f, $81, $1f, $47, $c0, $f8, $f8
	db $00, $02, $36, $00, $00, $0f, $87, $c3, $ef, $be, $f9, $f7, $c3, $b7, $61, $f7
	db $cf, $80, $00, $07, $03, $70, $30, $e3, $71, $be, $fb, $ef, $be, $3e, $0f, $83
	db $e3, $e7, $c2, $2e, $02, $2e, $0f, $14, $00, $0f, $8e, $c9, $5f, $7c, $3e, $fb
	db $ef, $a3, $e7, $c3, $e1, $f2, $3e, $f8, $f8, $45, $c1, $17, $03, $e0, $00, $3e
	db $3e, $e3, $70, $6f, $be, $f8, $3e, $3e, $3e, $0f, $8f, $82, $2e, $22, $e0, $3c
	db $50, $00, $3e, $fb, $b7, $6f, $80, $fb, $e7, $c8, $b9, $f2, $56, $7c, $8b, $9f
	db $0f, $88, $b8, $45, $c4, $5c, $3c, $53, $00, $45, $3e, $fb, $b7, $0d, $db, $9b
	db $e3, $e4, $5c, $fb, $ef, $91, $73, $e1, $f0, $45, $c8, $a0, $63, $c5, $00, $03
	db $ef, $bb, $7c, $2b, $ef, $be, $fb, $e1, $f1, $2b, $04, $ac, $7c, $3e, $02, $2e
	db $01, $17, $11, $41, $a1, $e8, $a0, $c3, $b1, $d2, $e2, $4b, $f8, $3e, $0f, $be
	db $fa, $1e, $fb, $ef, $83, $e0, $08, $71, $43, $0f, $14, $00, $0f, $be, $e0, $63
	db $ee, $6f, $87, $c4, $ac, $12, $b1, $f0, $f8, $02, $2e, $08, $b8, $f1, $4c, $01
	db $14, $fb, $ef, $be, $74, $6e, $6f, $be, $f8, $f9, $17, $3e, $fb, $e4, $5c, $f8
	db $f8, $08, $ba, $2e, $08, $b8, $f1, $40, $00, $fb, $ef, $be, $e3, $0f, $be, $f9
	db $f2, $2e, $7c, $95, $9f, $22, $e7, $cf, $84, $53, $22, $81, $8f, $80, $00, $f8
	db $fb, $ee, $6e, $de, $56, $fb, $ef, $83, $e3, $e3, $e0, $f8, $00, $00, $3c, $50
	db $00, $3e, $3e, $f9, $28, $f9, $db, $ef, $be, $8f, $9f, $0f, $87, $c8, $fb, $e1
	db $f0, $00, $07, $03, $70, $30, $fb, $80, $06, $fb, $e3, $e0, $f8, $3e, $3e, $1f
	db $00, $00, $00, $00, $0f, $80, $00, $f9, $f7, $c1, $e3, $7c, $1f, $7c, $e6, $00
	db $00, $00, $f8, $00, $e0, $67, $03, $0f, $80, $00, $f8, $00, $00, $00, $1f, $7c
	db $00, $03, $e7, $c0, $00, $00, $00, $00, $00, $0e, $04, $a3, $81, $9f, $71, $81
	db $cd, $f7, $00, $00, $60, $39, $80, $0e, $60, $00, $01, $f7, $dc, $00, $df, $70
	db $00, $1b, $e0, $3c, $a0, $00, $3e, $00, $00, $1f, $7c, $e3, $07, $8a, $00, $00
	db $3e, $03, $80, $00, $60, $00, $01, $f7, $df, $70, $dc, $00, $00, $06, $00, $8f
	db $88, $f8, $8f, $84, $71, $88, $f8, $8e, $19, $1c, $df, $7d, $db, $8d, $db, $ef
	db $be, $ec, $fb, $ef, $14, $18, $70, $00, $00, $00, $00, $23, $fd, $f7, $6e, $37
	db $6f, $be, $76, $e6, $fb, $80, $18, $23, $e8, $fa, $3e, $8f, $88, $f9, $1c, $c8
	db $f8, $8f, $88, $f8, $8f, $88, $fc, $df, $76, $ed, $db, $ef, $b9, $b8, $cf, $80
	db $00, $8f, $88, $fa, $38, $60, $8f, $a3, $86, $23, $e2, $3e, $23, $fc, $70, $37
	db $63, $ee, $33, $9b, $e0, $00, $23, $e2, $3e, $8f, $88, $fa, $38, $c8, $f8, $8f
	db $88, $f8, $47, $37, $ce, $03, $70, $00, $67, $60, $03, $80, $00, $00, $00, $00
	db $00, $00, $00, $00, $01, $14, $00, $00, $00, $00, $00, $00, $00, $00, $00, $0f
	db $14, $00, $00, $e0, $01, $b8, $01, $bb, $39, $b9, $b9, $b8, $00, $06, $f1, $47
	db $00, $08, $af, $be, $38, $18, $ec, $0f, $bb, $73, $07, $1b, $cd, $00, $03, $ef
	db $14, $78, $a0, $07, $8a, $fb, $ef, $be, $f8, $76, $3e, $e6, $f8, $1f, $71, $83
	db $cd, $e4, $a7, $01, $37, $ef, $14, $79, $58, $02, $57, $8a, $fb, $ef, $9f, $3b
	db $0e, $67, $c7, $6e, $c7, $cf, $b9, $bc, $df, $37, $ca, $79, $a0, $f3, $7e, $f1
	db $47, $8a, $60, $8a, $78, $ac, $71, $bb, $70, $37, $dc, $6f, $b8, $37, $1b, $ef
	db $37, $cd, $f2, $9e, $6f, $04, $df, $bc, $51, $e2, $98, $22, $9e, $2b, $ef, $be
	db $00, $ed, $cc, $7d, $d8, $7d, $f0, $fb, $ef, $37, $cd, $f2, $9e, $6f, $94, $13
	db $7e, $f1, $47, $8a, $64, $3c, $8a, $78, $af, $b8, $0d, $d8, $e0, $6e, $06, $e1
	db $be, $fb, $cd, $f3, $7c, $a7, $93, $e5, $04, $df, $bc, $51, $e2, $98, $22, $9e
	db $2b, $e7, $c7, $63, $8d, $f0, $f8, $0f, $83, $9b, $ef, $37, $cd, $e4, $fa, $13
	db $f8, $4d, $fb, $c5, $1e, $29, $95, $f2, $29, $e2, $b9, $bb, $3e, $87, $be, $7d
	db $f7, $01, $b9, $9d, $83, $ef, $37, $cd, $14, $69, $d2, $9a, $3c, $df, $bc, $51
	db $e2, $99, $13, $22, $9e, $2b, $e0, $fb, $e0, $00, $07, $ce, $03, $76, $f3, $78
	db $4f, $a9, $3f, $93, $7c, $df, $bc, $51, $e2, $98, $22, $9e, $2b, $81, $9c, $06
	db $e0, $1b, $ef, $80, $3e, $f3, $65, $07, $9b, $e5, $3c, $df, $37, $ef, $14, $78
	db $a6, $08, $a7, $8a, $f8, $fb, $ee, $dd, $8f, $8f, $83, $ef, $9c, $dc, $6f, $bc
	db $d9, $41, $e6, $f9, $4f, $37, $cd, $fb, $c5, $1e, $29, $90, $f2, $29, $e2, $b3
	db $b7, $df, $3e, $73, $73, $73, $7d, $f7, $63, $e0, $3c, $de, $09, $be, $53, $cd
	db $f3, $7e, $f1, $47, $8a, $60, $8a, $78, $ae, $37, $df, $7d, $f7, $df, $3e, $7c
	db $7d, $f7, $df, $7d, $f7, $1b, $cd, $f3, $41, $e5, $3c, $df, $37, $ef, $14, $79
	db $58, $02, $57, $8a, $f8, $73, $7d, $f7, $63, $e7, $67, $df, $7d, $f7, $df, $0f
	db $bc, $de, $02, $53, $93, $7e, $f1, $47, $8a, $00, $78, $af, $bb, $7d, $f7, $df
	db $7d, $f3, $e7, $c7, $c7, $df, $73, $76, $fb, $cd, $00, $03, $ef, $14, $70, $00
	db $8a, $f8, $7d, $f3, $e7, $df, $73, $73, $73, $76, $7d, $f0, $fb, $80, $01, $0f
	db $c5, $00, $00, $0f, $28, $00, $00, $00, $00, $08, $72, $80, $00, $38, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $01, $7c

;@ path: map/data
;@ The world map of phase 2 (1657 bytes), in the format of Phase1Map: 80x100 cells, run-length coded
;@ bit stream. UnpackMap takes it instead of Phase1Map when hPhase is not 0. The home (row 5, column 5)
;@ and the dragon's cells (rows 88-90, columns 68-70) are where they are in phase 1; the rest is a new
;@ layout, with a whole row of warps (row 77) across the map.
Phase2Map::
	db $c0, $00, $18, $00, $7c, $1c, $00
	db $00, $00, $dc, $03, $00, $07, $00, $1b, $ee, $03, $1c, $c0, $03, $e0, $00, $7c
	db $7c, $7d, $f7, $00, $24, $f0, $01, $be, $f8, $1f, $7c, $38, $00, $00, $6e, $37
	db $dc, $df, $1f, $70, $06, $38, $60, $3e, $38, $df, $71, $be, $3e, $00, $00, $f8
	db $7c, $1c, $37, $00, $c1, $c6, $e0, $06, $1f, $0f, $be, $e6, $e0, $00, $03, $7d
	db $cc, $07, $c0, $4e, $c8, $59, $37, $0f, $80, $38, $06, $fb, $ef, $8f, $80, $f8
	db $00, $7c, $93, $c0, $37, $03, $07, $1b, $ee, $03, $00, $fb, $9b, $9b, $9b, $86
	db $e0, $00, $dc, $60, $70, $18, $e1, $be, $07, $c7, $dc, $6f, $80, $0f, $80, $07
	db $c1, $f1, $c6, $e0, $00, $8f, $c1, $b8, $37, $df, $7d, $f3, $ee, $00, $6e, $00
	db $0d, $c3, $7d, $c6, $38, $00, $dc, $30, $07, $df, $7d, $db, $e0, $03, $ef, $80
	db $00, $01, $c1, $b8, $00, $dc, $37, $00, $df, $7d, $f3, $80, $1b, $ef, $b8, $00
	db $03, $70, $1b, $80, $0d, $c3, $7c, $01, $cd, $f7, $60, $7c, $3e, $f8, $7c, $00
	db $07, $6f, $8f, $80, $e0, $dc, $37, $00, $31, $f3, $ee, $37, $dc, $6e, $37, $00
	db $00, $6f, $b9, $b8, $6e, $0d, $c3, $00, $07, $1b, $e9, $a7, $df, $7c, $3e, $1f
	db $00, $f8, $0f, $be, $0f, $83, $e0, $07, $00, $0d, $f0, $e0, $df, $7d, $db, $ee
	db $00, $6f, $b8, $6f, $b8, $6f, $b9, $be, $e3, $73, $7c, $3e, $07, $c7, $60, $1f
	db $7d, $f3, $e3, $e0, $3e, $fb, $e3, $ef, $80, $f8, $fb, $ef, $9f, $7d, $f7, $df
	db $7c, $fb, $80, $00, $37, $df, $71, $be, $e1, $be, $fb, $ef, $be, $e0, $dc, $1b
	db $ee, $df, $7d, $f1, $f7, $dd, $be, $fb, $cd, $30, $01, $f7, $c3, $ef, $be, $00
	db $fb, $e3, $e0, $7c, $0f, $87, $df, $73, $7c, $7c, $fb, $ee, $00, $03, $71, $b8
	db $00, $01, $be, $e3, $7d, $c6, $fb, $8d, $f0, $7d, $cd, $db, $ef, $80, $00, $7c
	db $3e, $03, $e0, $f8, $3e, $f8, $7d, $f0, $f8, $7d, $c0, $df, $03, $ee, $01, $b8
	db $0d, $c6, $fb, $9b, $ee, $6f, $b9, $be, $fb, $8d, $c0, $37, $df, $1f, $1f, $70
	db $60, $03, $e0, $03, $ef, $be, $fb, $ef, $be, $fb, $ef, $be, $f9, $f7, $c0, $f8
	db $7d, $f7, $df, $7d, $f0, $3e, $e0, $00, $01, $be, $fb, $ef, $be, $fb, $ef, $be
	db $fb, $ee, $37, $06, $fb, $ee, $dc, $df, $7d, $c1, $be, $f8, $07, $c7, $c0, $3e
	db $fb, $e0, $f8, $3e, $01, $f0, $0f, $be, $f1, $cf, $9f, $7d, $f0, $39, $b8, $37
	db $de, $bf, $dc, $06, $fb, $ee, $00, $00, $00, $6f, $be, $e1, $bb, $7d, $c1, $83
	db $e1, $f7, $de, $27, $df, $03, $9b, $e0, $1f, $07, $c0, $00, $fb, $e0, $3e, $7c
	db $1c, $1b, $ee, $37, $de, $34, $2d, $f7, $18, $3e, $fb, $8d, $f7, $37, $dc, $37
	db $dc, $6f, $b8, $00, $0d, $f0, $3e, $07, $dc, $37, $ce, $06, $fb, $e1, $f1, $f7
	db $df, $07, $df, $0f, $80, $00, $7d, $f7, $1b, $83, $7c, $07, $dd, $83, $ef, $be
	db $ed, $c3, $7d, $c3, $7d, $c0, $00, $03, $7d, $f0, $fb, $e0, $70, $0d, $f3, $9b
	db $ef, $be, $7d, $f0, $1f, $07, $c0, $f8, $00, $07, $dc, $1b, $ee, $0c, $00, $76
	db $3e, $fb, $b7, $dc, $0d, $f7, $00, $6f, $b8, $00, $0d, $f0, $3e, $01, $c0, $6e
	db $ce, $6f, $be, $7d, $f0, $1f, $07, $c0, $fb, $e0, $00, $f9, $c0, $00, $30, $3e
	db $f8, $3e, $fb, $8d, $c6, $ed, $c3, $7d, $c1, $be, $e0, $06, $fb, $b1, $f7, $c1
	db $f1, $f7, $6f, $be, $fb, $86, $f8, $7d, $f3, $ef, $9f, $7c, $7c, $0f, $be, $f8
	db $03, $ef, $87, $df, $7d, $cd, $f7, $df, $7c, $fb, $ef, $bc, $93, $ee, $37, $dd
	db $be, $fb, $b7, $37, $06, $fb, $ef, $b8, $1b, $ef, $b8, $df, $73, $7d, $f7, $dc
	db $dc, $6f, $bc, $99, $12, $7e, $f8, $7c, $0f, $be, $07, $cf, $8f, $be, $fb, $e0
	db $fb, $ef, $be, $1f, $00, $7c, $00, $f9, $24, $fb, $80, $01, $b8, $df, $71, $be
	db $fb, $ef, $b9, $be, $fb, $ee, $00, $00, $00, $01, $80, $00, $fb, $e1, $f0, $3e
	db $fb, $ef, $bc, $ac, $fb, $ef, $80, $00, $78, $d9, $f0, $1f, $70, $00, $06, $e0
	db $00, $6f, $be, $fb, $86, $fb, $ee, $03, $70, $df, $7d, $f7, $37, $df, $0f, $8f
	db $80, $00, $7c, $03, $ef, $8f, $80, $fb, $e0, $1f, $7c, $7d, $f7, $df, $7d, $f7
	db $dc, $6f, $be, $e0, $06, $e0, $01, $be, $e0, $01, $b8, $0d, $f7, $df, $73, $7c
	db $7c, $7c, $03, $e0, $00, $00, $03, $e0, $00, $3e, $01, $f1, $f0, $85, $c0, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $01, $ab, $ee, $d5, $f7, $6a, $fb, $a2, $80, $00, $00
	db $00, $00, $00, $00, $01, $da, $26, $ed, $13, $76, $89, $bb, $00, $00, $00, $00
	db $00, $00, $08, $f9, $1f, $01, $d8, $ec, $76, $3b, $00, $00, $95, $80, $00, $00
	db $94, $c0, $00, $01, $c9, $dc, $49, $e2, $1f, $30, $00, $00, $97, $80, $47, $60
	db $00, $00, $02, $16, $1c, $04, $4e, $03, $25, $60, $8e, $c0, $00, $00, $09, $b8
	db $02, $6e, $00, $01, $14, $00, $03, $00, $00, $01, $2b, $00, $00, $04, $dc, $47
	db $c4, $ac, $00, $00, $00, $00, $25, $60, $00, $85, $80, $00, $00, $00, $09, $78
	db $11, $f0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $02, $3e, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $08, $f9, $2b, $26, $e4, $7c, $23, $e0, $02, $6e, $11, $f0, $01, $2f
	db $00, $01, $2b, $00, $4a, $c0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $9b, $80, $00, $00, $00, $23, $e0, $25, $60
	db $02, $3e, $11, $f2, $6e, $01, $1f, $00, $00, $12, $b0, $00, $00, $00, $00, $00
	db $00, $00, $4e, $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $4e, $30, $00
	db $02, $16, $00, $00, $23, $e0, $23, $e0, $02, $3e, $12, $b0, $49, $c1, $2b, $4e
	db $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $37, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $02, $6e, $00, $00, $4a, $c0, $25, $60, $26, $e0
	db $02, $56, $11, $f0, $09, $b9, $1f, $00, $00, $00, $12, $f0, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $27
	db $09, $b8, $09, $b9, $1f, $00, $04, $ac, $97, $93, $70, $13, $70, $01, $1f, $09
	db $b8, $12, $b0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $02, $16, $00, $00, $00, $00, $00, $01, $37, $13, $70, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $8a, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $01, $c0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $44, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $e0, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $12, $80, $00, $00, $00, $00, $e9, $40
	db $00, $e4, $a0, $00, $03, $91, $4e, $0c, $03, $b7, $dc, $30, $1d, $8e, $c0, $00
	db $e9, $4e, $00, $01, $29, $d1, $4f, $83, $ee, $37, $dd, $9f, $7d, $c0, $6e, $ce
	db $c2, $28, $30, $e9, $5e, $6f, $00, $02, $6f, $95, $d1, $4e, $6e, $1b, $ee, $6f
	db $b8, $1b, $ee, $37, $ce, $c4, $50, $8d, $15, $8e, $95, $d3, $78, $00, $4d, $e9
	db $5d, $14, $e6, $f8, $f9, $d8, $f9, $f7, $df, $7d, $f7, $c7, $ce, $c4, $50, $46
	db $8b, $8e, $95, $c9, $bc, $00, $9b, $c9, $5d, $14, $e6, $fb, $ef, $b9, $be, $e3
	db $7d, $f7, $df, $7d, $f7, $6e, $c8, $a6, $8a, $0c, $e9, $5c, $4d, $e0, $13, $78
	db $95, $d1, $4e, $6f, $8f, $be, $f8, $7d, $f7, $df, $7d, $f7, $c3, $ee, $d1, $4d
	db $f3, $e8, $a6, $e9, $5c, $25, $00, $70, $95, $d1, $4e, $6f, $b8, $67, $06, $e0
	db $00, $6e, $d1, $4d, $f3, $e8, $a6, $e9, $5c, $25, $42, $02, $57, $09, $5d, $14
	db $e3, $7d, $c6, $e0, $00, $30, $0e, $c8, $a8, $f8, $47, $8a, $ce, $95, $c2, $54
	db $20, $25, $70, $95, $d1, $4e, $6f, $be, $e4, $50, $0e, $c7, $00, $6e, $c4, $79
	db $72, $72, $4c, $b8, $f8, $e9, $5c, $25, $42, $4f, $a1, $3e, $12, $57, $09, $5d
	db $14, $ed, $f1, $f7, $45, $00, $f9, $f3, $80, $6e, $c2, $2e, $92, $d1, $70, $e9
	db $5c, $25, $42, $51, $a7, $4a, $12, $57, $09, $5d, $14, $e6, $97, $12, $5e, $e4
	db $50, $0f, $b9, $b8, $06, $ec, $45, $d1, $f2, $3e, $8b, $8e, $95, $c2, $54, $24
	db $fa, $93, $e1, $25, $70, $95, $d1, $4e, $df, $1f, $74, $50, $0f, $9f, $3a, $20
	db $76, $ec, $8b, $a5, $69, $4d, $2b, $45, $ce, $95, $c2, $54, $20, $25, $70, $95
	db $d1, $4e, $6f, $be, $e4, $50, $0e, $df, $72, $24, $92, $27, $6e, $c8, $a0, $0c
	db $e9, $5c, $25, $42, $02, $57, $09, $5d, $14, $ed, $f7, $df, $74, $50, $0e, $c7
	db $22, $49, $91, $26, $27, $6e, $c0, $00, $e9, $5c, $25, $00, $70, $95, $d1, $4e
	db $6f, $be, $e4, $50, $0f, $83, $a2, $49, $22, $76, $e0, $00, $09, $5c, $4d, $e0
	db $13, $78, $95, $d1, $4e, $37, $dc, $45, $00, $dc, $08, $81, $db, $a4, $80, $03
	db $a5, $72, $6f, $00, $26, $f2, $57, $45, $38, $6e, $00, $0d, $c0, $01, $ba, $38
	db $00, $3a, $57, $4d, $e0, $01, $37, $a5, $74, $53, $86, $e0, $00, $dc, $00, $1b
	db $a6, $80, $03, $a5, $79, $bc, $00, $09, $be, $57, $45, $00, $00, $00, $00, $00
	db $00, $03, $a5, $38, $00, $04, $a7, $00, $00, $00, $00, $00, $00, $00, $12, $80
	db $00, $0f, $7c

;@ path: gfx/tiles
;@ Sprite tiles (VRAM $8000-$87FF, 128 tiles): the hero facing each way with his walking frames, the
;@ monsters, items as sprites, the marker. LoadTiles copies this block and the four after it ($1800 bytes)
;@ to $8000-$97FF in one go; LoadAltTiles copies parts of it back ($4AB2, $4B72, $4C52, $4CF2).
;@ asset: tiles bpp=2 length=$800
GameTiles::
	db $03, $03, $07, $05, $0f, $0b, $0f, $0f, $0f, $0a, $0f, $0a, $0f
	db $0f, $6c, $6f, $7f, $5b, $7f, $7e, $3d, $3f, $0d, $0f, $16, $1f, $3f, $3b, $0e
	db $0e, $3e, $3e, $03, $03, $07, $05, $0f, $0b, $0f, $0f, $0f, $0a, $0f, $0a, $0f
	db $0f, $0c, $0f, $1f, $1b, $7f, $7e, $7d, $5f, $7d, $7f, $16, $1b, $3f, $3f, $3e
	db $3e, $00, $00, $03, $03, $07, $05, $0f, $09, $0f, $0b, $0f, $0f, $3e, $39, $78
	db $4f, $f8, $8f, $ff, $9f, $f3, $bf, $f9, $bf, $7f, $5f, $36, $3f, $3f, $3b, $0e
	db $0e, $3e, $3e, $03, $03, $07, $05, $0f, $09, $0f, $0b, $0f, $0f, $0e, $09, $38
	db $3f, $78, $4f, $ff, $9f, $f3, $bf, $f9, $bf, $ff, $9f, $76, $5f, $3b, $3f, $3e
	db $3e, $00, $00, $07, $07, $0f, $0d, $1f, $18, $1f, $13, $1f, $14, $17, $1a, $13
	db $1f, $10, $1f, $1f, $1f, $0d, $0e, $0f, $09, $1f, $1f, $29, $3f, $7f, $7f, $38
	db $38, $1c, $1c, $03, $03, $07, $05, $0f, $0b, $0f, $0f, $0f, $0a, $0f, $0a, $0f
	db $0f, $0c, $0f, $0f, $0b, $1f, $1e, $3d, $3f, $fd, $ff, $f6, $bf, $ff, $fb, $0e
	db $0e, $3e, $3e, $80, $80, $c0, $c0, $e0, $e0, $e0, $e0, $c0, $40, $c0, $40, $ee
	db $ee, $3e, $fa, $de, $fe, $f8, $f8, $b0, $e0, $f0, $70, $70, $f0, $e0, $e0, $80
	db $80, $e0, $e0, $00, $00, $01, $01, $03, $02, $07, $05, $07, $07, $e7, $e5, $e7
	db $a5, $ff, $ff, $6e, $7b, $3f, $3f, $0d, $0e, $0d, $0f, $56, $5f, $7f, $7f, $39
	db $39, $00, $00, $c0, $c0, $e0, $a0, $f0, $d0, $f0, $f0, $f0, $50, $fc, $5c, $fe
	db $e2, $7f, $c9, $ff, $c1, $ff, $5d, $ff, $c9, $be, $e2, $7c, $f4, $fc, $dc, $70
	db $70, $7c, $7c, $c0, $c0, $e0, $a0, $f0, $d0, $f0, $f0, $f0, $50, $f0, $50, $fc
	db $fc, $7e, $e2, $ff, $c9, $ff, $41, $ff, $dd, $ff, $c9, $7e, $e2, $fc, $f4, $7c
	db $7c, $00, $00, $c0, $c0, $e0, $a0, $f0, $90, $f0, $d0, $f0, $f0, $70, $90, $10
	db $f0, $18, $f8, $fe, $fe, $ce, $fa, $9c, $fc, $f0, $f0, $68, $f8, $fc, $dc, $70
	db $70, $7c, $7c, $c0, $c0, $e0, $a0, $f0, $90, $f0, $d0, $f0, $f0, $70, $90, $10
	db $f0, $10, $f0, $f8, $f8, $cc, $fc, $9c, $fc, $fc, $f4, $68, $f8, $dc, $fc, $7c
	db $7c, $00, $00, $80, $80, $c0, $c0, $e0, $e0, $e0, $e0, $c0, $40, $c0, $40, $e0
	db $e0, $30, $e0, $f0, $c0, $b0, $e0, $f0, $e0, $f0, $b0, $70, $f0, $e8, $e8, $78
	db $78, $30, $30, $c0, $c0, $e0, $a0, $f0, $90, $f0, $d0, $f7, $f7, $77, $95, $17
	db $f7, $1e, $fe, $fe, $fe, $cc, $fc, $98, $f8, $f0, $f0, $68, $f8, $fc, $dc, $70
	db $70, $7c, $7c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $1c, $1c, $3e
	db $22, $7f, $49, $7f, $41, $7f, $5d, $7f, $49, $3e, $22, $1c, $14, $08, $08, $00
	db $00, $00, $00, $02, $02, $e0, $e0, $f1, $d1, $f8, $e8, $f9, $f9, $f8, $28, $fc
	db $3c, $fe, $e2, $7f, $c9, $ff, $c1, $ff, $5d, $ff, $c9, $7e, $e2, $fc, $d4, $e8
	db $e8, $f8, $f8, $07, $07, $0f, $08, $1f, $16, $1f, $16, $1f, $10, $0f, $0d, $3f
	db $35, $7f, $77, $df, $d0, $8f, $8f, $8f, $89, $c7, $c7, $1f, $1c, $33, $33, $98
	db $98, $f8, $f8, $00, $00, $03, $03, $07, $04, $0f, $08, $0f, $0a, $1f, $12, $1f
	db $16, $3f, $26, $7f, $40, $ff, $8c, $ff, $b3, $40, $7f, $3f, $3f, $24, $24, $24
	db $24, $12, $12, $08, $08, $1c, $1c, $36, $36, $63, $63, $47, $47, $49, $4e, $cf
	db $cf, $99, $9e, $9f, $9f, $34, $37, $23, $23, $20, $20, $20, $20, $20, $20, $30
	db $30, $10, $10, $1e, $1e, $07, $07, $6f, $68, $ff, $93, $ff, $95, $ff, $f4, $9f
	db $ff, $9f, $f0, $4f, $7a, $2f, $3f, $1f, $18, $1f, $18, $17, $1d, $3e, $3f, $7f
	db $41, $7f, $7f, $07, $07, $0f, $0d, $1f, $18, $1f, $13, $1f, $14, $17, $1a, $13
	db $1f, $10, $1f, $1f, $1f, $0d, $0e, $0f, $09, $1f, $1f, $29, $3f, $3f, $3f, $07
	db $03, $0f, $07, $01, $01, $04, $04, $00, $00, $09, $09, $04, $04, $02, $02, $00
	db $00, $0a, $0a, $14, $14, $00, $00, $15, $15, $00, $00, $09, $09, $26, $26, $00
	db $00, $36, $36, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $c0, $c0, $e0, $20, $f0, $10, $f0, $d0, $f8, $18, $fc, $7c, $f6
	db $56, $f2, $d2, $f2, $12, $e6, $e6, $e0, $20, $f0, $f0, $d8, $58, $b2, $b2, $3e
	db $3e, $00, $00, $00, $00, $c0, $c0, $a0, $60, $d0, $30, $d0, $70, $e8, $58, $e8
	db $d8, $f4, $cc, $f2, $0e, $f1, $3f, $ed, $df, $02, $fe, $fc, $fc, $92, $92, $92
	db $92, $49, $49, $00, $00, $00, $00, $08, $08, $bc, $bc, $e6, $e6, $ab, $6b, $fd
	db $fd, $95, $75, $f5, $f5, $25, $e5, $c5, $c5, $0d, $0d, $09, $09, $03, $03, $02
	db $02, $02, $02, $3c, $3c, $f0, $f0, $f9, $09, $fd, $e5, $ff, $d7, $fc, $94, $fc
	db $fc, $fe, $06, $fd, $2f, $f9, $ff, $fd, $a7, $fe, $a6, $f4, $5c, $3e, $fe, $ff
	db $c1, $7f, $7f, $80, $80, $c0, $c0, $e0, $e0, $e0, $e0, $c0, $40, $c0, $40, $e0
	db $e0, $30, $e0, $f0, $c0, $f0, $e0, $b0, $e0, $f0, $70, $70, $f0, $e0, $e0, $80
	db $80, $e0, $e0, $80, $80, $20, $20, $40, $40, $00, $00, $50, $50, $1c, $1c, $7e
	db $62, $ff, $c9, $7f, $41, $7f, $5d, $7f, $49, $3e, $22, $9c, $94, $08, $08, $40
	db $40, $54, $54, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $42
	db $7e, $ff, $ff, $3c, $3c, $66, $7e, $72, $5e, $7a, $4e, $7e, $66, $3f, $3f, $03
	db $03, $06, $07, $04, $07, $0e, $0f, $0f, $0b, $0f, $08, $1f, $18, $1f, $10, $1f
	db $10, $3f, $3f, $0f, $0f, $1b, $1c, $3d, $36, $5e, $73, $6f, $59, $77, $4e, $5f
	db $60, $2f, $30, $17, $18, $0b, $0c, $07, $07, $05, $06, $03, $03, $03, $02, $03
	db $03, $00, $00, $18, $18, $34, $2c, $7a, $5e, $fd, $af, $fd, $bf, $7b, $5e, $37
	db $2d, $1f, $1a, $1f, $1b, $37, $2d, $7b, $5e, $fd, $af, $fd, $bf, $7a, $5e, $34
	db $2c, $18, $18, $3f, $3f, $3d, $3e, $3d, $3e, $3d, $3e, $ff, $ff, $60, $3f, $7f
	db $7e, $ff, $b5, $d6, $bb, $bf, $ee, $7f, $70, $37, $38, $3f, $3b, $2f, $3f, $1e
	db $19, $0f, $0f, $3c, $3c, $3c, $24, $7e, $42, $ff, $95, $ff, $80, $ff, $81, $7f
	db $43, $7e, $7e, $42, $7f, $66, $7e, $3c, $3c, $18, $18, $18, $18, $3c, $24, $7e
	db $42, $7e, $7e, $1c, $1c, $3e, $22, $73, $4d, $64, $5f, $6e, $5b, $6f, $59, $27
	db $3d, $16, $1f, $18, $17, $33, $2d, $33, $2e, $1b, $15, $18, $1f, $17, $1f, $0e
	db $0e, $00, $00, $18, $38, $04, $04, $1a, $1a, $3e, $26, $7f, $5b, $7f, $5a, $3d
	db $27, $18, $1f, $3b, $37, $75, $4f, $e7, $9c, $e7, $9b, $f8, $87, $f7, $8f, $66
	db $5c, $3e, $3e, $07, $07, $1f, $18, $3d, $22, $7f, $58, $7f, $65, $ff, $aa, $ff
	db $92, $df, $ad, $bf, $c0, $9f, $ef, $4f, $75, $27, $3f, $10, $1f, $3f, $2f, $7e
	db $42, $7e, $7e, $00, $00, $00, $00, $3c, $3c, $46, $7e, $62, $7e, $72, $5e, $7a
	db $6e, $3f, $3f, $03, $03, $06, $07, $1c, $1f, $3e, $37, $3f, $23, $7f, $60, $ff
	db $c0, $ff, $ff, $00, $00, $00, $00, $f8, $f8, $de, $3e, $7d, $e7, $fb, $8d, $f5
	db $7b, $f6, $0e, $f8, $f8, $a0, $60, $e0, $e0, $c0, $44, $ca, $c8, $19, $01, $ac
	db $10, $fa, $04, $00, $00, $00, $00, $3e, $3e, $7f, $41, $ff, $ff, $69, $d7, $be
	db $fe, $d0, $f0, $d0, $f0, $be, $fe, $7f, $c1, $ff, $ff, $69, $57, $3e, $3e, $00
	db $00, $00, $00, $07, $07, $1d, $1e, $3b, $3c, $3d, $36, $7e, $73, $6f, $79, $d7
	db $ee, $ff, $c0, $ff, $e3, $ff, $f4, $be, $d9, $ff, $9f, $f8, $ff, $60, $7f, $3b
	db $3c, $0f, $0f, $00, $00, $3c, $3c, $3c, $24, $7e, $42, $ff, $a9, $ff, $01, $ff
	db $83, $fe, $fe, $42, $7e, $42, $fe, $3c, $3c, $7e, $42, $7e, $7e, $00, $00, $00
	db $00, $00, $00, $38, $38, $7c, $44, $ce, $b2, $26, $fa, $76, $da, $f6, $9a, $e4
	db $bc, $68, $f8, $18, $e8, $cc, $b4, $cc, $74, $db, $ab, $15, $ff, $eb, $ef, $0e
	db $0e, $0c, $0c, $30, $38, $40, $40, $58, $58, $64, $7c, $c2, $fe, $e6, $7e, $bc
	db $fc, $18, $f8, $98, $e8, $4c, $f4, $ce, $72, $ee, $92, $3e, $c2, $9e, $e2, $4c
	db $74, $f8, $f8, $e0, $e0, $f8, $18, $fc, $04, $f6, $ea, $fe, $32, $ff, $b1, $ff
	db $67, $ff, $c9, $ff, $15, $bf, $53, $ce, $3e, $04, $fc, $1a, $fe, $e2, $fe, $3c
	db $3c, $00, $00, $00, $00, $f7, $f7, $7f, $7a, $3f, $39, $0f, $0d, $3f, $3b, $5f
	db $54, $bf, $ab, $bf, $ad, $b7, $ad, $d3, $de, $49, $4f, $1f, $1f, $13, $13, $c9
	db $c9, $7c, $7c, $30, $30, $7b, $5b, $7f, $4c, $5f, $64, $7f, $78, $7f, $43, $ff
	db $8f, $ff, $9f, $fc, $bf, $79, $7e, $0d, $0e, $05, $06, $05, $06, $08, $0f, $10
	db $1f, $3f, $3f, $03, $03, $0f, $1f, $3c, $77, $79, $ce, $fc, $9f, $77, $6f, $ff
	db $a3, $ef, $b5, $f7, $f9, $1f, $1f, $0f, $0f, $18, $1f, $1f, $13, $0d, $0d, $78
	db $78, $fe, $fe, $03, $03, $07, $05, $0f, $0b, $1b, $17, $1b, $17, $13, $1f, $13
	db $1f, $09, $0f, $1f, $17, $1f, $13, $0f, $09, $07, $07, $3b, $3f, $69, $6f, $4d
	db $4f, $87, $87, $67, $67, $fa, $9d, $f4, $9f, $7e, $6b, $7f, $69, $76, $6f, $7c
	db $73, $3f, $3c, $1f, $1f, $0e, $0d, $06, $05, $0c, $0f, $19, $17, $72, $7e, $84
	db $fc, $fc, $fc, $07, $07, $1f, $0f, $1f, $14, $3f, $32, $3f, $39, $2e, $2f, $47
	db $64, $43, $42, $43, $43, $63, $26, $07, $0c, $0f, $08, $0b, $0c, $04, $0f, $03
	db $07, $00, $01, $78, $78, $7c, $44, $3e, $22, $1e, $12, $fe, $f2, $ff, $83, $7d
	db $46, $39, $3e, $1c, $17, $3e, $23, $7f, $42, $9c, $e7, $40, $7f, $3f, $3f, $12
	db $12, $f6, $f6, $06, $06, $02, $02, $13, $13, $1d, $1d, $06, $06, $0f, $0f, $7f
	db $79, $ff, $f7, $9f, $9f, $1f, $13, $7f, $7d, $ff, $f5, $df, $dd, $cf, $cf, $63
	db $63, $00, $00, $00, $00, $e0, $e0, $fc, $5c, $fe, $9e, $f3, $b3, $fc, $dc, $fa
	db $2a, $fd, $d5, $fd, $b5, $ed, $b5, $cb, $7b, $92, $f2, $f8, $f8, $d3, $d3, $be
	db $be, $00, $00, $00, $00, $00, $00, $00, $00, $0c, $0c, $ee, $ea, $fe, $32, $fa
	db $26, $fe, $1e, $fe, $c2, $7f, $f1, $3f, $f9, $0f, $fd, $8e, $7e, $e4, $1c, $02
	db $fe, $ff, $ff, $cc, $ce, $fe, $f3, $3b, $fd, $97, $75, $3b, $fb, $ec, $f4, $fc
	db $c4, $f4, $ac, $ec, $9c, $ff, $fb, $bf, $c9, $3e, $cf, $fc, $fc, $9e, $9e, $03
	db $03, $00, $00, $18, $18, $0c, $0c, $1e, $1a, $0b, $0d, $1b, $1d, $09, $0f, $d9
	db $df, $fa, $ee, $fc, $cc, $f8, $98, $e0, $f0, $dc, $fc, $94, $f4, $bc, $fc, $e8
	db $e8, $08, $08, $e0, $e0, $50, $b0, $28, $f8, $7c, $d4, $fc, $94, $6c, $f4, $38
	db $c8, $fb, $3b, $ff, $fd, $7f, $b9, $7d, $9b, $01, $ff, $ff, $ff, $1e, $12, $0c
	db $0c, $00, $00, $e0, $e0, $f8, $f0, $f8, $28, $fc, $4c, $fc, $9c, $74, $f4, $e2
	db $26, $c2, $42, $c2, $c2, $c6, $64, $e0, $30, $f6, $17, $fd, $0b, $fa, $06, $04
	db $fc, $f8, $f8, $00, $00, $1e, $1e, $3f, $23, $7f, $45, $7f, $49, $ff, $c1, $fe
	db $42, $bc, $7c, $38, $e8, $7c, $c4, $fe, $42, $39, $e7, $02, $fe, $fc, $fc, $6f
	db $6f, $00, $00, $60, $60, $40, $40, $c8, $c8, $b9, $b9, $61, $61, $f3, $f3, $ff
	db $9f, $fe, $ee, $f8, $f8, $f8, $c8, $f8, $b8, $fc, $ac, $fe, $be, $f6, $f6, $ce
	db $ce, $1c, $1c

;@ path: gfx/tiles
;@ Background tiles $80-$FF (VRAM $8800-$8FFF), most of the cell pictures CellTiles points to: the home,
;@ the dragon and its parts, the warp sign, the pit. Sprites can use them too (the dragon's head is sprite
;@ tile $C4).
;@ asset: tiles bpp=2 length=$800
CellGfxTiles::
	db $3c, $3c, $7e, $42, $ff, $91, $ff, $98, $ff, $94, $ff, $92, $7f
	db $4a, $3f, $26, $3f, $22, $7f, $40, $bf, $c0, $bf, $c0, $bc, $c3, $99, $e7, $42
	db $7e, $3c, $3c, $07, $07, $19, $1e, $33, $3c, $63, $7c, $69, $7e, $50, $7f, $68
	db $7f, $7a, $7f, $3c, $3f, $1f, $1f, $0f, $0f, $5f, $51, $ee, $ff, $b1, $bf, $9f
	db $9f, $40, $40, $78, $38, $7e, $4c, $7f, $4a, $7f, $21, $3f, $1f, $7f, $60, $ff
	db $cf, $ff, $98, $ff, $91, $ff, $c7, $7c, $7f, $10, $1f, $08, $0f, $c7, $c7, $fc
	db $fc, $78, $78, $71, $71, $73, $52, $7f, $7c, $3f, $38, $1f, $13, $3e, $27, $7c
	db $4f, $f8, $9f, $f8, $9f, $7c, $4f, $3e, $27, $1f, $13, $3f, $38, $77, $74, $eb
	db $9a, $f9, $f9, $3c, $3c, $7e, $42, $ff, $a5, $ff, $a5, $ff, $81, $7f, $43, $3d
	db $27, $1b, $1d, $2e, $39, $4f, $78, $f7, $fc, $93, $ff, $f0, $9f, $ff, $93, $ff
	db $ff, $f0, $f0, $01, $01, $03, $02, $7e, $7f, $d7, $a9, $a9, $d7, $7f, $7e, $eb
	db $95, $95, $eb, $7f, $7e, $1c, $1f, $3f, $22, $63, $5d, $f9, $ff, $ff, $b7, $7e
	db $72, $3c, $3c, $14, $14, $2a, $3e, $53, $6f, $ba, $c7, $bc, $c7, $59, $6e, $33
	db $3c, $16, $19, $2e, $31, $4b, $74, $51, $6e, $88, $ff, $99, $ff, $aa, $ee, $c4
	db $c4, $80, $80, $78, $30, $ff, $4b, $fd, $a6, $fd, $86, $f9, $4e, $71, $3e, $13
	db $1f, $1e, $1f, $09, $0e, $ad, $9e, $9f, $b7, $a6, $b9, $e1, $ff, $bf, $9f, $80
	db $80, $00, $00, $f0, $f0, $f8, $08, $fc, $04, $fe, $02, $fe, $0a, $fd, $0b, $f5
	db $1b, $ed, $73, $fd, $03, $fd, $03, $f9, $07, $fa, $06, $f2, $0e, $e4, $1c, $08
	db $f8, $f0, $f0, $f0, $f0, $0c, $fc, $d6, $3e, $eb, $1f, $17, $ff, $5f, $ff, $3e
	db $fe, $fc, $fc, $f8, $f8, $f8, $88, $74, $fc, $8c, $fc, $f8, $f8, $10, $10, $1b
	db $1b, $0d, $0d, $1e, $1c, $7e, $32, $fe, $52, $fe, $84, $fc, $f8, $fe, $06, $ff
	db $f3, $ff, $19, $ff, $89, $ff, $e3, $3e, $fe, $18, $f8, $2e, $ee, $c7, $c7, $03
	db $03, $00, $00, $87, $87, $c7, $c5, $ef, $6f, $fe, $3e, $fc, $1c, $7c, $8c, $3e
	db $c6, $1f, $e3, $1f, $e3, $3e, $c6, $7c, $8c, $fe, $1e, $fe, $3e, $ee, $6a, $ce
	db $ce, $80, $80, $00, $00, $00, $00, $00, $00, $78, $78, $fc, $84, $fe, $0a, $ff
	db $09, $ff, $21, $ff, $9f, $7e, $c2, $ff, $3f, $cf, $f9, $09, $ff, $ff, $cf, $f9
	db $ff, $0f, $0f, $86, $86, $df, $59, $7b, $e5, $f6, $8e, $bf, $d9, $fb, $65, $f6
	db $8e, $b8, $d8, $e0, $60, $38, $f8, $fc, $44, $c6, $ba, $f9, $ff, $b7, $b7, $72
	db $72, $3c, $3c, $50, $50, $a8, $f8, $a7, $df, $b2, $cf, $7c, $47, $39, $2e, $1b
	db $1c, $16, $19, $14, $1b, $27, $38, $2d, $33, $2a, $37, $22, $3f, $25, $3d, $28
	db $38, $10, $10, $1e, $0c, $ff, $d2, $bf, $69, $bf, $61, $9f, $72, $8e, $7c, $c8
	db $f8, $78, $f8, $90, $70, $b4, $78, $f8, $ec, $64, $9c, $84, $fc, $fc, $f8, $10
	db $10, $7e, $7e, $e3, $e3, $75, $76, $3f, $3d, $0f, $05, $0d, $0e, $1b, $17, $30
	db $2f, $21, $3f, $63, $7f, $6b, $7f, $f6, $f7, $cd, $ce, $8b, $8a, $c5, $c5, $60
	db $60, $20, $20, $3b, $3b, $1f, $1c, $0e, $0f, $1f, $16, $20, $3f, $3f, $3f, $3f
	db $2a, $3f, $3a, $3b, $2c, $3f, $34, $7b, $7f, $79, $6e, $ff, $97, $ff, $90, $ff
	db $9f, $60, $60, $70, $70, $af, $df, $f9, $ae, $af, $df, $77, $78, $47, $7f, $6b
	db $7c, $bf, $cf, $fb, $8c, $ff, $8f, $fb, $8c, $ff, $8f, $b4, $cc, $cc, $fc, $78
	db $78, $30, $30, $38, $25, $34, $3b, $58, $4d, $d8, $cf, $be, $85, $ac, $96, $af
	db $92, $df, $a0, $d7, $aa, $d7, $ae, $da, $ad, $d1, $be, $f0, $dd, $77, $59, $7a
	db $f1, $f5, $eb, $40, $06, $86, $69, $06, $79, $00, $8e, $00, $73, $a3, $5c, $a3
	db $54, $00, $63, $40, $06, $86, $69, $06, $79, $00, $8e, $00, $73, $a3, $5c, $a3
	db $54, $00, $63, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $02, $00, $00, $08, $05, $00, $01, $0a, $14, $07, $34
	db $13, $10, $07, $00, $0f, $00, $17, $08, $5b, $0a, $01, $04, $06, $02, $00, $00
	db $00, $00, $00, $00, $00, $00, $42, $00, $37, $64, $1a, $38, $47, $14, $2a, $00
	db $6c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $c7, $c7, $ae, $6e, $fc, $bc, $f0, $a0, $b0, $70, $de, $ee, $0e
	db $f6, $87, $ff, $c7, $ff, $d5, $fd, $69, $e9, $a3, $63, $f6, $76, $94, $94, $20
	db $20, $40, $40, $dc, $dc, $f8, $38, $70, $f0, $f8, $68, $04, $fc, $fc, $fc, $fc
	db $54, $fc, $5c, $df, $37, $ff, $2d, $df, $ff, $9c, $7c, $f8, $e8, $fe, $1e, $ff
	db $e1, $3f, $3f, $00, $00, $00, $00, $00, $63, $00, $63, $00, $6b, $00, $6b, $00
	db $7f, $00, $36, $00, $00, $00, $00, $00, $7c, $00, $66, $00, $66, $00, $7c, $00
	db $60, $00, $60, $ac, $d4, $cc, $bc, $b2, $52, $d7, $b3, $af, $61, $a7, $69, $d7
	db $49, $fb, $05, $eb, $55, $6b, $b5, $bb, $55, $5b, $bd, $af, $5b, $5e, $aa, $af
	db $5e, $46, $bf, $00, $00, $24, $02, $00, $04, $40, $00, $08, $11, $30, $40, $02
	db $10, $00, $41, $00, $00, $24, $02, $00, $04, $40, $00, $08, $11, $30, $40, $02
	db $10, $00, $41, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $08, $09, $22, $00, $40, $69, $04, $10, $00, $50, $40, $c0, $20
	db $80, $40, $40, $10, $30, $00, $80, $00, $50, $68, $60, $84, $28, $10, $79, $46
	db $4e, $10, $14, $00, $01, $00, $01, $01, $16, $01, $2e, $0a, $35, $09, $34, $00
	db $1e, $00, $98, $02, $1c, $04, $30, $00, $3c, $14, $28, $02, $18, $04, $59, $00
	db $0f, $00, $03, $00, $12, $00, $16, $05, $1f, $00, $18, $21, $30, $47, $51, $8f
	db $83, $dd, $85, $71, $4d, $4b, $7a, $47, $7d, $7f, $71, $96, $8a, $fc, $82, $fc
	db $d4, $78, $78, $00, $00, $0b, $0f, $10, $10, $39, $3f, $1e, $46, $ff, $a1, $fd
	db $fa, $ff, $ff, $3f, $3f, $04, $07, $05, $07, $0b, $0f, $1e, $1f, $1f, $10, $0f
	db $0f, $00, $00, $33, $33, $5e, $5e, $b9, $8e, $cc, $bb, $9f, $f8, $57, $74, $0f
	db $3e, $35, $3e, $1c, $1f, $07, $07, $00, $00, $00, $00, $01, $01, $02, $03, $01
	db $06, $0e, $09, $00, $01, $03, $03, $07, $07, $0b, $08, $16, $10, $2d, $2a, $3e
	db $3b, $2f, $2b, $7f, $71, $7f, $63, $6b, $57, $67, $7f, $39, $39, $02, $03, $05
	db $06, $0a, $09, $00, $30, $01, $1d, $03, $0f, $06, $06, $8c, $88, $97, $d8, $7a
	db $76, $8f, $35, $9f, $64, $33, $ce, $ab, $57, $53, $af, $a6, $de, $fc, $fc, $00
	db $00, $00, $00, $07, $07, $0b, $e8, $1f, $7f, $18, $18, $38, $2d, $bf, $b7, $52
	db $7e, $b1, $5c, $5b, $a9, $af, $5f, $7f, $a4, $b3, $5e, $29, $ff, $d5, $ff, $7c
	db $7c, $00, $00, $3b, $75, $b5, $da, $d8, $b5, $8c, $fa, $6e, $6d, $03, $03, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $03, $03, $0c
	db $0d, $3f, $3f, $3b, $75, $b5, $da, $d9, $b4, $8f, $ff, $6e, $69, $19, $16, $32
	db $35, $25, $2b, $2d, $23, $2e, $21, $35, $3a, $12, $15, $0e, $0d, $07, $07, $00
	db $00, $00, $00, $00, $00, $00, $e0, $c0, $c0, $60, $60, $71, $31, $f9, $1b, $fe
	db $4e, $f1, $2c, $f9, $26, $ca, $75, $d5, $ea, $4a, $f5, $65, $7b, $3f, $3f, $00
	db $00, $00, $00, $00, $f0, $e0, $e0, $b0, $f8, $20, $30, $49, $79, $be, $cf, $f9
	db $06, $fc, $93, $fd, $d2, $b8, $d7, $f5, $ba, $ca, $75, $e1, $ff, $9f, $9f, $00
	db $00, $00, $00, $80, $80, $60, $e0, $f8, $38, $fc, $cc, $ac, $74, $f6, $1e, $ff
	db $0a, $f7, $2d, $ff, $65, $eb, $c5, $df, $e9, $8f, $d9, $8f, $b1, $b7, $6b, $6a
	db $d6, $34, $cc, $00, $80, $00, $00, $e0, $e0, $f8, $d8, $f8, $28, $fc, $24, $f4
	db $1c, $ee, $16, $ce, $32, $be, $92, $de, $b2, $a6, $1a, $5e, $32, $be, $66, $e4
	db $dc, $e4, $9c, $00, $00, $f8, $f0, $c8, $98, $f6, $ee, $df, $b5, $dd, $97, $5e
	db $5e, $7e, $3b, $fd, $8f, $fe, $e2, $fa, $33, $bb, $d9, $3f, $39, $07, $09, $1e
	db $1e, $00, $00, $9c, $9c, $72, $e2, $df, $41, $bf, $cf, $fd, $9d, $f8, $38, $f0
	db $70, $f0, $f0, $e0, $e0, $e0, $e0, $f0, $70, $f0, $30, $f0, $90, $7c, $4c, $38
	db $38, $00, $00, $2d, $df, $49, $bf, $ae, $de, $58, $e8, $2e, $76, $02, $be, $bb
	db $d7, $45, $7b, $21, $2f, $3d, $2b, $6b, $67, $52, $5e, $a6, $be, $5c, $fc, $b8
	db $f8, $e0, $e0, $2d, $df, $5f, $af, $be, $5e, $c8, $f8, $f8, $78, $b8, $58, $dc
	db $ec, $fe, $fe, $9a, $7a, $58, $38, $d0, $70, $b0, $f0, $60, $e0, $c0, $c0, $00
	db $00, $00, $00, $7f, $7f, $ff, $c0, $ff, $90, $ff, $80, $fb, $80, $df, $80, $ff
	db $80, $ef, $90, $fe, $81, $fb, $80, $df, $a0, $ff, $84, $ff, $80, $c0, $bf, $c0
	db $ff, $7f, $7f, $00, $00, $00, $00, $00, $1f, $00, $35, $0f, $60, $05, $d2, $09
	db $a4, $68, $92, $00, $ff, $00, $7f, $20, $51, $20, $5f, $3f, $40, $3f, $40, $3f
	db $40, $00, $7f, $00, $31, $00, $67, $03, $ec, $06, $e9, $04, $ab, $40, $ae, $40
	db $27, $00, $2f, $07, $38, $1f, $60, $1f, $60, $13, $2c, $03, $3c, $0e, $11, $19
	db $26, $00, $7f, $0f, $0f, $1f, $10, $3a, $25, $7f, $35, $ff, $4d, $ff, $95, $ff
	db $85, $fa, $4d, $77, $38, $3f, $22, $7f, $42, $ef, $90, $ff, $b0, $57, $58, $08
	db $0f, $07, $07, $99, $99, $3c, $66, $7e, $5a, $ff, $ad, $ff, $bd, $7e, $5a, $3c
	db $66, $99, $99, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $10, $18, $10, $18, $7e, $7e, $10, $7e, $10, $18, $10, $18, $10
	db $18, $10, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $10, $10, $ba, $ba, $fe, $fe, $fe, $fe, $d2, $ae, $fe
	db $fe, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $04, $04, $00, $00, $20, $22, $00, $10, $00, $00, $80, $82, $00
	db $24, $00, $00, $00, $00, $00, $24, $80, $82, $00, $00, $00, $10, $20, $22, $00
	db $00, $04, $04, $fe, $fe, $ff, $03, $79, $07, $d9, $27, $f9, $07, $f9, $07, $a9
	db $17, $f9, $07, $f9, $07, $f9, $27, $f9, $07, $d9, $07, $f1, $0f, $01, $ff, $03
	db $ff, $fe, $fe, $00, $1e, $04, $12, $04, $fa, $80, $3e, $50, $ae, $a8, $57, $50
	db $af, $bc, $43, $00, $ff, $00, $fe, $84, $7a, $b4, $4a, $94, $6a, $b4, $4a, $84
	db $7a, $00, $fe, $00, $fc, $f8, $04, $e0, $18, $30, $c8, $10, $ec, $18, $a4, $18
	db $e6, $3c, $c3, $7e, $81, $dc, $23, $bc, $43, $98, $66, $80, $7e, $c0, $3c, $f8
	db $06, $00, $ff, $80, $80, $c0, $40, $e0, $20, $f0, $70, $f8, $90, $f8, $48, $f8
	db $08, $f8, $90, $70, $f1, $f9, $1b, $ff, $4f, $fe, $83, $fa, $a6, $44, $fc, $18
	db $f8, $e0, $e0, $3c, $3c, $7e, $6e, $7e, $7e, $3c, $3c, $42, $24, $42, $42, $24
	db $42, $18, $3c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $3c, $3c, $5a, $66, $bd, $db, $ff, $a1, $ff, $a1, $ad, $d3, $5a
	db $66, $3c, $3c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $08, $00, $18, $00, $18, $00, $18, $42, $5a, $66, $3c, $18
	db $18, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $a6, $02, $a5, $a7, $ff, $fd, $05, $07, $06
	db $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00

;@ path: gfx/tiles
;@ Background tiles $00-$3E (VRAM $9000-$93EF): the rest of the cell pictures (rock, gravestone, warp, box,
;@ items), the window icons (heart $2C, sword $2D, figure $2E, gold $2F, potion $3C, crown $3D) and the
;@ blank floor tile $3E.
;@ asset: tiles bpp=2 length=$3F0
MapIconTiles::
	db $01, $60, $03, $31, $03, $32, $06, $62, $06, $c4, $0d, $c4, $0d
	db $68, $3a, $0d, $00, $00, $80, $00, $80, $80, $c0, $80, $40, $c0, $60, $c0, $a0
	db $60, $70, $e0, $00, $7f, $3f, $c0, $60, $80, $45, $88, $40, $9b, $40, $96, $48
	db $84, $48, $91, $00, $fe, $fc, $03, $02, $01, $96, $09, $2e, $11, $16, $69, $46
	db $b9, $04, $f9, $00, $00, $00, $07, $03, $08, $07, $10, $0c, $23, $19, $26, $33
	db $4c, $33, $4c, $00, $00, $00, $e0, $c0, $30, $e0, $18, $70, $8c, $b0, $4c, $f8
	db $06, $d8, $06, $00, $00, $00, $07, $00, $0d, $00, $1e, $08, $17, $04, $13, $03
	db $08, $00, $1c, $00, $00, $00, $e0, $00, $f0, $00, $f8, $10, $e8, $20, $c8, $c0
	db $10, $00, $38, $00, $00, $00, $00, $00, $01, $00, $01, $00, $01, $00, $01, $00
	db $01, $00, $01, $00, $00, $00, $80, $80, $40, $00, $40, $00, $40, $00, $40, $00
	db $40, $00, $40, $00, $00, $00, $1f, $1f, $20, $00, $40, $3f, $40, $3f, $40, $31
	db $4e, $00, $7b, $00, $00, $00, $f8, $d8, $24, $3c, $42, $bc, $42, $bc, $42, $bc
	db $42, $00, $fe, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $90, $00
	db $b0, $00, $ff, $00, $00, $00, $00, $00, $00, $00, $70, $00, $58, $00, $3c, $08
	db $e6, $3c, $c2, $00, $00, $00, $07, $01, $04, $00, $03, $00, $3a, $00, $6e, $00
	db $47, $01, $62, $00, $00, $00, $e0, $80, $60, $00, $c0, $00, $dc, $80, $76, $00
	db $e2, $00, $c6, $1b, $10, $34, $1b, $37, $21, $77, $23, $6f, $45, $ef, $45, $df
	db $89, $ff, $ff, $d0, $30, $38, $f0, $e8, $18, $ec, $98, $f4, $4c, $f6, $4c, $fa
	db $26, $fe, $fe, $50, $83, $42, $85, $48, $87, $54, $8b, $44, $9b, $5f, $80, $3e
	db $c0, $00, $7f, $04, $f9, $10, $e9, $14, $e1, $2c, $c1, $14, $c9, $ba, $05, $1c
	db $03, $00, $fe, $33, $4c, $33, $4c, $19, $26, $1c, $22, $0f, $10, $07, $08, $00
	db $07, $00, $00, $d8, $06, $d8, $06, $b0, $0c, $70, $0c, $e0, $18, $c0, $30, $00
	db $e0, $00, $00, $08, $33, $10, $20, $10, $20, $18, $20, $0c, $30, $03, $1c, $00
	db $07, $00, $00, $10, $cc, $08, $04, $08, $04, $18, $04, $30, $0c, $c0, $38, $00
	db $e0, $00, $00, $00, $01, $00, $01, $00, $09, $01, $0e, $00, $07, $00, $01, $00
	db $01, $00, $01, $00, $40, $00, $40, $00, $48, $40, $b8, $80, $70, $00, $c0, $80
	db $40, $00, $c0, $31, $4e, $3f, $40, $00, $7f, $3f, $40, $00, $7f, $00, $7f, $00
	db $7f, $00, $00, $bc, $42, $bc, $42, $3c, $c2, $bc, $42, $00, $fe, $3c, $c2, $00
	db $fe, $00, $00, $00, $ff, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $18, $e6, $00, $3c, $00, $58, $00, $70, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $33, $00, $06, $07, $18, $19, $20, $13, $20, $0f, $30, $00
	db $1f, $00, $00, $00, $cc, $80, $60, $c0, $38, $e0, $1c, $e0, $1c, $80, $7c, $00
	db $f8, $00, $00, $00, $00, $00, $00, $00, $63, $00, $65, $00, $19, $00, $11, $00
	db $23, $00, $45, $00, $00, $00, $00, $00, $8c, $80, $4c, $c0, $30, $e0, $10, $70
	db $88, $38, $c4, $00, $01, $01, $02, $03, $04, $01, $02, $01, $12, $11, $2e, $3f
	db $40, $11, $2e, $00, $80, $00, $c0, $80, $60, $00, $c0, $00, $d0, $10, $ec, $f8
	db $06, $10, $ec, $00, $00, $00, $0f, $00, $10, $07, $20, $0c, $23, $1c, $43, $10
	db $4f, $10, $4f, $00, $00, $00, $f0, $60, $18, $f0, $0c, $f0, $0c, $f8, $06, $38
	db $c6, $38, $c6, $00, $00, $00, $1d, $00, $23, $0d, $42, $1d, $42, $1d, $42, $00
	db $7f, $00, $40, $00, $00, $00, $b8, $00, $c4, $1c, $c2, $1c, $c2, $1c, $c2, $00
	db $fe, $00, $02, $00, $01, $00, $03, $00, $01, $00, $03, $01, $64, $00, $99, $00
	db $aa, $01, $ba, $00, $00, $00, $80, $00, $00, $00, $80, $80, $4c, $c0, $32, $40
	db $aa, $40, $ba, $00, $00, $00, $7f, $3f, $40, $20, $5f, $0f, $50, $00, $57, $03
	db $54, $02, $55, $00, $00, $00, $fe, $fc, $02, $04, $fa, $f0, $0a, $00, $ea, $c0
	db $2a, $40, $aa, $00, $00, $6c, $6c, $ba, $d6, $fe, $82, $fe, $82, $7c, $44, $38
	db $28, $10, $10, $00, $00, $06, $06, $0a, $0a, $d4, $d4, $a8, $e8, $50, $70, $e8
	db $f8, $d8, $d8, $00, $00, $38, $38, $aa, $aa, $aa, $aa, $fe, $fe, $38, $38, $7c
	db $7c, $c6, $c6, $00, $00, $38, $38, $7c, $44, $ce, $b2, $de, $a2, $e6, $82, $7c
	db $44, $38, $38, $00, $7f, $38, $47, $1c, $23, $0e, $11, $06, $19, $02, $65, $00
	db $63, $00, $00, $00, $fc, $20, $dc, $40, $b8, $80, $70, $00, $f0, $00, $cc, $00
	db $8c, $00, $00, $01, $12, $01, $02, $01, $02, $01, $02, $01, $02, $01, $02, $00
	db $07, $00, $00, $00, $d0, $00, $c0, $00, $c0, $00, $c0, $00, $c0, $00, $c0, $00
	db $e0, $00, $00, $1c, $43, $1c, $23, $1c, $23, $0c, $13, $0f, $10, $00, $7f, $4b
	db $80, $00, $ff, $f8, $06, $f0, $0c, $f0, $0c, $e0, $18, $e0, $18, $00, $fe, $fc
	db $03, $00, $ff, $3f, $40, $00, $7f, $1c, $22, $00, $3e, $1c, $23, $1f, $20, $00
	db $3f, $00, $3f, $fc, $02, $00, $fe, $38, $44, $00, $7c, $38, $c4, $f8, $04, $00
	db $fc, $00, $fc, $00, $bb, $20, $9d, $11, $cc, $1b, $64, $00, $3f, $00, $3f, $12
	db $20, $00, $3f, $40, $ba, $84, $72, $88, $66, $b0, $4c, $00, $f8, $00, $f8, $f0
	db $08, $00, $f8, $00, $55, $00, $55, $00, $55, $00, $55, $00, $55, $00, $55, $00
	db $55, $00, $7f, $00, $aa, $00, $aa, $00, $aa, $00, $aa, $00, $aa, $00, $aa, $00
	db $aa, $00, $fe, $00, $00, $7c, $7c, $38, $28, $ba, $aa, $74, $4c, $f2, $8e, $82
	db $fe, $7c, $7c, $00, $00, $10, $10, $ba, $ba, $ee, $fe, $82, $fe, $fe, $82, $fe
	db $fe, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00

;@ path: gfx/tiles
;@ Background tile $3F, a sparse dot pattern. After the dragon's third defeat LoadTile3EOnThirdKill copies it
;@ over the blank tile $3E, so the whole floor turns dotted.
;@ asset: tiles bpp=2 length=$10
DottedFloorTile::
	db $00, $00, $00, $40, $00, $00, $10, $02, $40, $00, $00, $00, $00
	db $10, $01, $00

;@ path: gfx/tiles
;@ Background tiles $40-$7F (VRAM $9400-$97FF), the font: the words PLAYER ($40-$43) and MONSTER ($4B-$4F),
;@ the digits 0-9 ($50-$59), "," $5A, "." $5B, the window frame $5C-$5F, the copyright sign $60, the letters
;@ A-Z ($61-$7A, the ASCII codes of a-z), "-" $7B, "!" $7C, ".," $7D, "?" $7E.
;@ asset: tiles bpp=2 length=$400
FontTiles::
	db $00, $00, $73, $7b, $6b, $6b, $6b, $6b, $6b, $6b, $73, $7b, $63
	db $63, $63, $63, $00, $00, $0c, $0c, $16, $16, $16, $16, $16, $16, $1e, $1e, $16
	db $16, $d6, $d6, $00, $00, $8d, $8d, $dd, $dd, $59, $59, $79, $79, $31, $31, $31
	db $31, $31, $31, $00, $00, $ee, $ef, $8d, $8d, $8d, $8d, $cd, $cd, $8e, $8e, $8d
	db $8d, $ed, $ed, $00, $00, $8d, $8c, $dd, $dd, $fd, $fd, $ad, $ad, $ad, $8d, $8d
	db $8d, $8d, $8d, $00, $00, $f7, $e3, $36, $36, $36, $36, $36, $36, $f6, $f6, $36
	db $36, $37, $33, $00, $00, $de, $9e, $cc, $cc, $0c, $0c, $cc, $cc, $4c, $4c, $4c
	db $4c, $de, $de, $00, $00, $f8, $70, $d8, $d8, $c0, $c0, $c0, $c0, $c0, $c0, $d8
	db $d8, $f8, $70, $00, $00, $8d, $8d, $dd, $dd, $fd, $fd, $ad, $ad, $ad, $8d, $8d
	db $8d, $8d, $8d, $00, $00, $e8, $e8, $8c, $8c, $8e, $8e, $eb, $eb, $89, $89, $88
	db $88, $e8, $e8, $00, $00, $d3, $d3, $d3, $d3, $d3, $d3, $d3, $d3, $d3, $d3, $d3
	db $d3, $df, $ce, $00, $00, $8d, $8c, $dd, $dd, $fd, $fd, $ad, $ad, $ad, $8d, $8d
	db $8d, $8d, $8c, $00, $00, $f4, $e4, $34, $34, $36, $36, $37, $37, $35, $35, $34
	db $34, $f4, $e4, $00, $00, $cf, $ce, $d9, $d9, $d8, $d8, $cf, $ce, $c3, $c3, $d3
	db $d3, $df, $ce, $00, $00, $7b, $7b, $33, $33, $33, $33, $33, $33, $33, $33, $33
	db $33, $33, $33, $00, $00, $de, $de, $1b, $19, $19, $19, $db, $d9, $1e, $1e, $1b
	db $19, $d9, $d9, $00, $00, $7c, $7c, $c6, $c6, $c6, $c6, $c6, $c6, $c6, $c6, $c6
	db $c6, $7c, $7c, $00, $00, $18, $18, $38, $38, $18, $18, $18, $18, $18, $18, $18
	db $18, $7e, $7e, $00, $00, $7c, $7c, $c6, $c6, $06, $06, $7c, $7c, $c0, $c0, $c0
	db $c0, $fe, $fe, $00, $00, $7c, $7c, $c6, $c6, $06, $06, $3c, $3c, $06, $06, $c6
	db $c6, $7c, $7c, $00, $00, $1c, $1c, $3c, $3c, $6c, $6c, $cc, $cc, $fe, $fe, $0c
	db $0c, $1e, $1e, $00, $00, $fc, $fc, $c0, $c0, $fc, $fc, $06, $06, $06, $06, $c6
	db $c6, $7c, $7c, $00, $00, $3c, $3c, $60, $60, $c0, $c0, $fc, $fc, $c6, $c6, $c6
	db $c6, $7c, $7c, $00, $00, $fe, $fe, $06, $06, $06, $06, $0c, $0c, $18, $18, $30
	db $30, $60, $60, $00, $00, $7c, $7c, $c6, $c6, $c6, $c6, $7c, $7c, $c6, $c6, $c6
	db $c6, $7c, $7c, $00, $00, $7c, $7c, $c6, $c6, $c6, $c6, $7e, $7e, $06, $06, $0c
	db $0c, $78, $78, $00, $00, $00, $00, $00, $00, $00, $00, $0c, $0c, $0c, $0c, $0c
	db $0c, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $10, $10, $38
	db $38, $10, $10, $00, $00, $00, $00, $07, $0f, $0f, $18, $1f, $13, $1c, $16, $1c
	db $14, $1c, $14, $00, $00, $00, $00, $ff, $ff, $ff, $00, $ff, $ff, $00, $00, $00
	db $00, $00, $00, $1c, $14, $1c, $14, $1c, $14, $1c, $14, $1c, $14, $1c, $14, $1c
	db $14, $1c, $14, $1c, $14, $1c, $34, $fc, $e4, $f8, $0c, $f0, $f8, $00, $00, $00
	db $00, $00, $00, $00, $00, $7c, $7c, $c6, $c6, $92, $92, $be, $be, $92, $92, $c6
	db $c6, $7c, $7c, $00, $00, $38, $38, $6c, $6c, $c6, $c6, $c6, $c6, $fe, $fe, $c6
	db $c6, $c6, $c6, $00, $00, $fc, $fc, $c6, $c6, $c6, $c6, $fc, $fc, $c6, $c6, $c6
	db $c6, $fc, $fc, $00, $00, $3c, $3c, $66, $66, $c0, $c0, $c0, $c0, $c0, $c0, $66
	db $66, $3c, $3c, $00, $00, $fc, $fc, $ce, $ce, $c6, $c6, $c6, $c6, $c6, $c6, $ce
	db $ce, $fc, $fc, $00, $00, $fe, $fe, $c0, $c0, $c0, $c0, $fc, $fc, $c0, $c0, $c0
	db $c0, $fe, $fe, $00, $00, $fe, $fe, $c0, $c0, $c0, $c0, $fc, $fc, $c0, $c0, $c0
	db $c0, $c0, $c0, $00, $00, $3c, $3c, $66, $66, $c0, $c0, $de, $de, $c6, $c6, $66
	db $66, $7e, $7e, $00, $00, $c6, $c6, $c6, $c6, $c6, $c6, $fe, $fe, $c6, $c6, $c6
	db $c6, $c6, $c6, $00, $00, $7e, $7e, $18, $18, $18, $18, $18, $18, $18, $18, $18
	db $18, $7e, $7e, $00, $00, $1e, $1e, $06, $06, $06, $06, $06, $06, $c6, $c6, $c6
	db $c6, $7c, $7c, $00, $00, $c6, $c6, $cc, $cc, $d8, $d8, $f0, $f0, $f8, $f8, $dc
	db $dc, $ce, $ce, $00, $00, $60, $60, $60, $60, $60, $60, $60, $60, $60, $60, $60
	db $60, $7e, $7e, $00, $00, $c6, $c6, $ee, $ee, $fe, $fe, $fe, $fe, $d6, $d6, $c6
	db $c6, $c6, $c6, $00, $00, $c6, $c6, $e6, $e6, $f6, $f6, $fe, $fe, $de, $de, $ce
	db $ce, $c6, $c6, $00, $00, $7c, $7c, $ee, $ee, $c6, $c6, $c6, $c6, $c6, $c6, $ee
	db $ee, $7c, $7c, $00, $00, $fc, $fc, $c6, $c6, $c6, $c6, $c6, $c6, $fc, $fc, $c0
	db $c0, $c0, $c0, $00, $00, $7c, $7c, $c6, $c6, $c6, $c6, $c6, $c6, $d6, $d6, $cc
	db $cc, $7a, $7a, $00, $00, $fc, $fc, $c6, $c6, $c6, $c6, $ce, $ce, $f8, $f8, $dc
	db $dc, $ce, $ce, $00, $00, $78, $78, $cc, $cc, $c0, $c0, $7c, $7c, $06, $06, $c6
	db $c6, $7c, $7c, $00, $00, $7e, $7e, $18, $18, $18, $18, $18, $18, $18, $18, $18
	db $18, $18, $18, $00, $00, $c6, $c6, $c6, $c6, $c6, $c6, $c6, $c6, $c6, $c6, $c6
	db $c6, $7c, $7c, $00, $00, $c6, $c6, $c6, $c6, $c6, $c6, $ee, $ee, $7c, $7c, $38
	db $38, $10, $10, $00, $00, $c6, $c6, $c6, $c6, $d6, $d6, $fe, $fe, $fe, $fe, $ee
	db $ee, $c6, $c6, $00, $00, $c6, $c6, $ee, $ee, $7c, $7c, $38, $38, $7c, $7c, $ee
	db $ee, $c6, $c6, $00, $00, $66, $66, $66, $66, $66, $66, $3c, $3c, $18, $18, $18
	db $18, $18, $18, $00, $00, $fe, $fe, $0e, $0e, $1c, $1c, $38, $38, $70, $70, $e0
	db $e0, $fe, $fe, $00, $00, $00, $00, $00, $00, $00, $00, $fe, $fe, $00, $00, $00
	db $00, $00, $00, $00, $00, $30, $30, $30, $30, $30, $30, $30, $30, $00, $00, $30
	db $30, $30, $30, $00, $00, $00, $00, $00, $00, $00, $00, $46, $46, $e6, $e6, $46
	db $46, $0c, $0c, $00, $00, $7e, $7e, $c3, $c3, $c3, $c3, $1e, $1e, $18, $18, $00
	db $00, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00

;@ path: gfx/tiles
;@ 28 sprite tiles for the hero once the sword has changed him (hSysFlags bit 6): LoadAltTiles copies them
;@ in pieces to $8000-$83DF, between pieces of GameTiles.
;@ asset: tiles bpp=2 length=$1C0
AltSpriteTiles::
	db $03, $43, $07, $c5, $0f, $cb, $0f, $cf, $0f, $ca, $0f, $ca, $0f
	db $cf, $ec, $ef, $ff, $bb, $ff, $fe, $5d, $5f, $0d, $0f, $16, $1f, $3f, $3b, $0e
	db $0e, $3e, $3e, $03, $03, $07, $45, $0f, $cb, $0f, $cf, $0f, $ca, $0f, $ca, $0f
	db $cf, $0c, $cf, $ef, $eb, $ff, $be, $fd, $ff, $5d, $5f, $16, $1b, $3f, $3f, $3e
	db $3e, $00, $00, $03, $03, $07, $05, $0f, $0b, $0f, $0f, $0f, $0a, $0f, $0a, $0f
	db $0f, $0c, $0f, $0f, $0b, $0f, $0e, $0d, $17, $0d, $37, $16, $7f, $1f, $fb, $0e
	db $ce, $3e, $be, $80, $80, $c0, $c0, $e0, $e0, $e0, $e0, $c0, $40, $c0, $41, $e0
	db $e3, $20, $e7, $c0, $ce, $80, $dc, $f0, $f8, $f0, $d0, $70, $f0, $e0, $e0, $80
	db $80, $e0, $e0, $00, $06, $01, $0d, $03, $1a, $07, $35, $07, $67, $e7, $e5, $e7
	db $a5, $ff, $ff, $6e, $7b, $3f, $3f, $0d, $0e, $0d, $0f, $56, $5f, $7f, $7f, $39
	db $39, $00, $00, $c0, $c2, $e0, $a3, $f0, $93, $f0, $d3, $f0, $f3, $70, $93, $10
	db $f3, $17, $f7, $ff, $fd, $cf, $ff, $9a, $fa, $f0, $f0, $68, $f8, $fc, $dc, $70
	db $70, $7c, $7c, $c0, $c0, $e0, $a2, $f0, $93, $f0, $d3, $f0, $f3, $70, $93, $10
	db $f3, $10, $f3, $ff, $ff, $cf, $fd, $9f, $ff, $f2, $f2, $68, $f8, $dc, $fc, $7c
	db $7c, $00, $00, $80, $80, $c0, $c4, $e0, $e6, $e0, $e6, $c0, $46, $c0, $46, $e0
	db $e6, $20, $e6, $ce, $ce, $be, $fa, $fe, $fe, $e4, $e4, $70, $f0, $e8, $e8, $78
	db $78, $30, $30, $c0, $c0, $e0, $a0, $f0, $90, $f0, $d0, $f0, $f0, $10, $f0, $10
	db $f0, $10, $f1, $f0, $f1, $c8, $fb, $98, $ff, $f0, $fe, $68, $fc, $fc, $dc, $70
	db $70, $7c, $7c, $01, $01, $04, $44, $00, $c0, $09, $c9, $04, $c4, $02, $c2, $00
	db $c0, $ca, $ca, $d4, $d4, $c0, $c0, $55, $55, $00, $00, $09, $09, $26, $26, $00
	db $00, $36, $36, $00, $00, $00, $40, $00, $c0, $00, $c0, $00, $c0, $00, $c0, $00
	db $c0, $c0, $c0, $c0, $c0, $c0, $c0, $40, $40, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $3f, $f0, $f8, $80, $80, $c0, $c0, $e0, $e0, $e0, $e8, $c0, $4c, $c0, $4c, $e0
	db $ec, $20, $ec, $c0, $cc, $e0, $ec, $bc, $fc, $fc, $f4, $7c, $fc, $e8, $e8, $80
	db $80, $e0, $e0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $00
	db $06, $00, $0e, $00, $1c, $00, $38, $60, $70, $e0, $e0, $c0, $c0, $00, $00, $00
	db $00, $00, $00

;@ path: gfx/tiles
;@ Sprite tiles shown after the dragon's fire has hit the hero: LoadFireHitTiles copies 28 tiles from here
;@ to $8000, then two tiles each from $65F2, $6612 and $6632 to $81E0, $8280 and $8380.
;@ asset: tiles bpp=2 length=$220
FireHitTiles::
	db $03, $43, $07, $c7, $0f, $cf, $0f, $cf, $0a, $cd, $0a, $cd, $0f
	db $cf, $ef, $ef, $bb, $ff, $fe, $ff, $5f, $5f, $0f, $0f, $1e, $1f, $3b, $3f, $0e
	db $0e, $3e, $3e, $03, $03, $07, $47, $0f, $cf, $0f, $cf, $0a, $cd, $0a, $cd, $0f
	db $cf, $0f, $cf, $eb, $ef, $be, $ff, $ff, $ff, $5f, $5f, $1b, $1f, $3f, $3f, $3e
	db $3e, $00, $00, $03, $03, $05, $07, $09, $0f, $0b, $0f, $0f, $0f, $39, $3f, $4f
	db $7f, $8f, $ff, $9f, $ff, $bf, $ff, $bf, $ff, $5f, $7f, $3f, $3f, $3b, $3f, $0e
	db $0e, $3e, $3e, $03, $03, $05, $07, $09, $0f, $0b, $0f, $0f, $0f, $09, $0f, $3f
	db $3f, $4f, $7f, $9f, $ff, $bf, $ff, $bf, $ff, $9f, $ff, $5f, $7f, $3f, $3f, $3e
	db $3e, $00, $00, $07, $07, $0d, $0f, $18, $1f, $13, $1f, $14, $1f, $1a, $1f, $1f
	db $1f, $1f, $1f, $1f, $1f, $0e, $0f, $09, $0f, $1f, $1f, $3f, $3f, $7f, $7f, $38
	db $38, $1c, $1c, $03, $03, $07, $07, $0f, $0f, $0f, $0f, $0a, $0d, $0a, $0d, $0f
	db $0f, $0f, $0f, $0b, $0f, $0e, $0f, $07, $1f, $07, $3f, $1f, $7f, $1b, $ff, $0e
	db $ce, $3e, $be, $80, $80, $c0, $c0, $e0, $e0, $e0, $e0, $40, $c0, $40, $c1, $e0
	db $e3, $e0, $e7, $c0, $ce, $c0, $dc, $f0, $f8, $d0, $f0, $f0, $f0, $e0, $e0, $80
	db $80, $e0, $e0, $00, $06, $01, $0d, $03, $1b, $07, $37, $07, $67, $e5, $e6, $a5
	db $e6, $ff, $ff, $7f, $7b, $3f, $3f, $0e, $0f, $0f, $0f, $5f, $5f, $7f, $7f, $39
	db $39, $00, $00, $c0, $c0, $e0, $e0, $f0, $f0, $f0, $f0, $50, $b0, $5c, $bc, $e2
	db $fe, $c9, $ff, $c1, $ff, $5d, $ff, $c9, $ff, $e2, $fe, $f4, $fc, $dc, $fc, $70
	db $70, $7c, $7c, $c0, $c0, $e0, $e0, $f0, $f0, $f0, $f0, $50, $b0, $50, $b0, $fc
	db $fc, $62, $fe, $c9, $ff, $41, $ff, $dd, $ff, $c9, $ff, $e2, $fe, $f4, $fc, $7c
	db $7c, $00, $00, $c0, $c2, $a0, $e3, $90, $f3, $d0, $f3, $f0, $f3, $90, $f3, $f0
	db $f3, $f7, $f7, $fd, $ff, $ff, $ff, $fa, $fa, $f0, $f0, $f8, $f8, $dc, $fc, $70
	db $70, $7c, $7c, $c0, $c0, $a0, $e2, $90, $f3, $d0, $f3, $f0, $f3, $90, $f3, $f0
	db $f3, $f0, $f3, $ff, $ff, $fd, $ff, $ff, $ff, $f2, $f2, $f8, $f8, $fc, $fc, $7c
	db $7c, $00, $00, $80, $80, $c0, $c4, $e0, $e6, $e0, $e6, $40, $c6, $40, $c6, $e0
	db $e6, $e0, $e6, $ce, $ce, $fa, $fe, $fe, $fe, $e4, $e4, $f0, $f0, $e8, $e8, $78
	db $78, $30, $30, $c0, $c0, $a0, $e0, $90, $f0, $d0, $f0, $f0, $f0, $90, $f0, $f0
	db $f0, $f0, $f1, $f0, $f1, $f8, $fb, $f8, $ff, $f0, $fe, $f8, $fc, $dc, $fc, $70
	db $70, $7c, $7c, $02, $02, $e0, $e0, $f1, $f1, $f8, $f8, $f9, $f9, $28, $f8, $3c
	db $fc, $e2, $fe, $c9, $ff, $c1, $ff, $5d, $ff, $c9, $ff, $e2, $fe, $d4, $fc, $e8
	db $e8, $f8, $f8, $07, $07, $0d, $0f, $18, $1f, $13, $1f, $14, $1f, $1a, $1f, $1f
	db $1f, $1f, $1f, $1f, $1f, $0e, $0f, $09, $0f, $1f, $1f, $3f, $3f, $3f, $3f, $03
	db $07, $07, $0f, $80, $80, $c0, $c0, $e0, $e0, $e0, $e8, $40, $cc, $40, $cc, $e0
	db $ec, $e0, $ec, $c0, $cc, $e0, $ec, $fc, $fc, $f4, $fc, $fc, $fc, $e8, $e8, $80
	db $80, $e0, $e0

;@ path: gfx/tiles
;@ 18 sprite tiles for the fly spell: CastFly copies them in three groups of 6 ($6652, $66B2, $6712) to
;@ $8000, $8080 and $8100, after saving the tiles there.
;@ asset: tiles bpp=2 length=$120
FlyTiles::
	db $07, $07, $1f, $18, $1f, $10, $1f, $10, $0f, $08, $3f, $3e, $73
	db $5f, $71, $7e, $71, $7e, $73, $5f, $3f, $3e, $0f, $08, $1f, $10, $1f, $10, $1f
	db $18, $07, $07, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $7b, $7b, $ef
	db $bc, $ef, $f8, $ef, $f8, $ef, $bc, $7b, $7b, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $07, $07, $0f, $08, $3e, $31, $7f
	db $58, $77, $7f, $77, $7f, $7f, $58, $3e, $31, $0f, $08, $07, $07, $00, $00, $00
	db $00, $00, $00, $00, $00, $03, $03, $07, $05, $77, $77, $7c, $4f, $fc, $87, $fe
	db $87, $ff, $82, $d7, $a8, $f7, $88, $df, $a6, $db, $aa, $fb, $8b, $71, $51, $70
	db $50, $20, $20, $03, $03, $07, $05, $07, $07, $04, $07, $07, $07, $03, $02, $07
	db $04, $07, $04, $0f, $08, $0d, $0a, $0d, $0b, $0f, $0b, $0e, $0a, $04, $04, $00
	db $00, $00, $00, $00, $00, $03, $03, $07, $05, $07, $07, $0e, $0b, $1f, $11, $1f
	db $11, $1b, $15, $1d, $12, $1b, $14, $1b, $14, $1f, $16, $1f, $16, $0b, $0b, $01
	db $01, $00, $00, $f8, $f8, $fe, $06, $4f, $b1, $fe, $06, $38, $d8, $e0, $20, $f8
	db $38, $fc, $0c, $fc, $0c, $f8, $38, $e0, $20, $38, $d8, $fe, $06, $4f, $b1, $fe
	db $06, $f8, $f8, $00, $00, $00, $00, $00, $00, $00, $00, $f8, $f8, $fc, $04, $98
	db $78, $f0, $30, $f0, $30, $98, $78, $fc, $04, $f8, $f8, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $f8, $f8, $fc, $04, $98, $78, $7c
	db $9c, $fe, $06, $fe, $06, $7c, $9c, $98, $78, $fc, $04, $f8, $f8, $00, $00, $00
	db $00, $00, $00

;@ path: title/screen
;@ The 88 tiles of the title picture (the DRAGON SLAYER logo and its frame), copied to $8800 (background
;@ tiles $80-$D7) by the title screen.
;@ asset: tiles bpp=2 length=$580
TitleTiles::
	db $ff, $00, $ff, $02, $ff, $0c, $f3, $1d, $e6, $3b, $af, $54, $ff
	db $00, $ff, $00, $ff, $00, $ff, $00, $ff, $38, $cf, $f3, $9c, $6f, $d9, $37, $fb
	db $05, $fd, $02, $ff, $00, $ff, $00, $ff, $00, $ff, $80, $ff, $00, $ff, $00, $ff
	db $58, $87, $fc, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $c0
	db $3f, $df, $20, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $00
	db $ff, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $03
	db $fc, $fb, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
	db $00, $87, $78, $1f, $0f, $70, $30, $40, $40, $cf, $40, $9b, $8c, $95, $88, $99
	db $80, $9f, $80, $f8, $f0, $0e, $0c, $06, $02, $fb, $06, $d9, $67, $a9, $47, $c9
	db $07, $f9, $07, $9f, $80, $9f, $80, $9f, $80, $9f, $80, $9f, $80, $9f, $80, $9f
	db $80, $9f, $80, $f9, $07, $f9, $07, $f9, $07, $f9, $07, $f9, $07, $f9, $07, $f9
	db $07, $f9, $07, $ff, $00, $ff, $00, $ff, $08, $ff, $11, $ff, $33, $ef, $2e, $d3
	db $40, $db, $44, $ff, $0f, $f0, $30, $cf, $c2, $ff, $d5, $fa, $6f, $97, $ff, $8f
	db $fe, $ff, $76, $ff, $f0, $3f, $1c, $ff, $aa, $fd, $17, $fe, $81, $ff, $d4, $ff
	db $72, $ff, $1c, $1f, $f0, $df, $2c, $e3, $1f, $f0, $0f, $f8, $87, $75, $cb, $be
	db $e1, $fd, $63, $ff, $00, $ff, $00, $ff, $00, $ff, $80, $7f, $c0, $7f, $c0, $df
	db $20, $ff, $00, $cf, $00, $e3, $04, $fb, $04, $fb, $04, $fb, $04, $fb, $04, $fb
	db $04, $fb, $04, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
	db $00, $ff, $00, $f3, $00, $c7, $00, $df, $00, $df, $00, $df, $00, $df, $00, $df
	db $00, $df, $00, $ff, $00, $fe, $01, $fc, $02, $f8, $04, $f0, $08, $e1, $10, $c3
	db $20, $86, $41, $07, $88, $01, $0e, $31, $0e, $61, $1e, $c1, $3e, $83, $7c, $07
	db $f8, $0f, $f0, $9f, $80, $9b, $8c, $95, $88, $99, $80, $cf, $40, $50, $4f, $70
	db $3f, $1f, $0f, $f9, $07, $d9, $67, $a9, $47, $c9, $07, $f3, $0e, $02, $fe, $0e
	db $fc, $f8, $f0, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $00, $ff, $00
	db $ff, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $ff, $00, $ff, $00, $ff, $00, $ff
	db $00, $ff, $00, $ff, $00, $ff, $01, $ff, $01, $fe, $02, $ff, $03, $ff, $01, $fe
	db $07, $f9, $08, $b7, $cc, $09, $7b, $63, $07, $ed, $bd, $bb, $f9, $1e, $ff, $6d
	db $fe, $ff, $00, $7f, $e6, $ff, $c6, $ff, $e6, $ff, $a6, $7f, $b6, $bf, $56, $fb
	db $26, $db, $36, $fb, $0a, $fd, $05, $fe, $06, $ff, $03, $fe, $02, $ff, $03, $fe
	db $02, $fe, $02, $fe, $b1, $df, $70, $ce, $39, $df, $38, $cf, $b8, $df, $38, $ee
	db $39, $df, $78, $ff, $80, $7f, $c0, $7f, $c0, $3f, $e0, $1f, $f0, $ef, $90, $ff
	db $40, $ff, $60, $fb, $04, $fb, $04, $fb, $04, $ff, $03, $fc, $0c, $f9, $0b, $f3
	db $17, $f3, $17, $ff, $00, $ff, $00, $ff, $fe, $03, $01, $03, $fc, $f0, $ff, $fc
	db $9f, $ff, $07, $df, $00, $de, $01, $dc, $02, $f8, $84, $7c, $7c, $9d, $1c, $3b
	db $f8, $fe, $f9, $0c, $83, $18, $07, $30, $0f, $60, $1f, $c1, $3e, $83, $7c, $07
	db $f9, $0e, $f3, $1f, $e0, $3f, $c0, $7f, $80, $ff, $00, $ff, $00, $ff, $60, $bf
	db $c0, $3f, $c0, $ff, $02, $ff, $03, $ff, $01, $ff, $01, $ff, $00, $ff, $00, $ff
	db $00, $ff, $00, $ff, $00, $ff, $00, $ff, $80, $ff, $e0, $bf, $bc, $e7, $c7, $f9
	db $69, $ff, $2f, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
	db $e0, $ff, $80, $f7, $10, $ec, $23, $e3, $3f, $f7, $1c, $ff, $18, $ff, $0c, $ff
	db $01, $fd, $03, $bf, $7c, $fe, $ff, $ff, $bf, $fb, $7e, $bf, $74, $7f, $e8, $ff
	db $e8, $7f, $13, $db, $36, $bb, $66, $bb, $e6, $fb, $c6, $fb, $06, $fb, $06, $fb
	db $f6, $5f, $5f, $fe, $02, $fe, $02, $fd, $04, $fd, $04, $f9, $08, $f2, $11, $e6
	db $23, $d9, $c7, $ce, $b9, $9f, $78, $be, $f1, $9f, $70, $bf, $e0, $7f, $e0, $7f
	db $c8, $ff, $9b, $3f, $e0, $1f, $f1, $9f, $62, $5d, $af, $d0, $3f, $95, $6a, $fa
	db $05, $fc, $03, $ff, $04, $7f, $88, $f7, $18, $77, $9d, $f2, $5f, $83, $fc, $af
	db $50, $ff, $00, $f3, $17, $f1, $17, $f8, $0b, $fd, $c4, $7f, $83, $ff, $00, $fe
	db $ed, $ff, $7e, $ff, $01, $ff, $00, $fe, $c1, $3c, $f2, $88, $7c, $c1, $f8, $e2
	db $31, $c5, $23, $fc, $f3, $18, $87, $31, $0f, $63, $1f, $c7, $3f, $03, $ff, $e7
	db $fb, $ff, $f3, $1c, $e7, $38, $cf, $7a, $95, $ff, $00, $ff, $00, $ff, $00, $ff
	db $3c, $ff, $6e, $ff, $1c, $ef, $b0, $4d, $f6, $99, $6f, $d0, $2f, $fa, $05, $ff
	db $00, $ff, $24, $ff, $00, $ff, $18, $ef, $70, $8f, $fc, $17, $f8, $4f, $b6, $f1
	db $0f, $fc, $03, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $f0, $1f
	db $e8, $2f, $d0, $ff, $37, $ff, $1f, $ff, $19, $ff, $10, $ff, $00, $ff, $00, $ff
	db $00, $ff, $01, $ff, $80, $7f, $c0, $ff, $20, $5f, $b0, $bf, $50, $9f, $48, $cf
	db $38, $df, $28, $e3, $1c, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
	db $00, $ff, $00, $fc, $e4, $f9, $4b, $fb, $0b, $ff, $0e, $ff, $04, $ff, $00, $ff
	db $00, $ff, $00, $e8, $88, $1f, $f1, $ea, $fd, $f5, $3f, $ff, $0f, $ff, $00, $ff
	db $00, $ff, $00, $33, $0f, $d7, $7e, $8f, $fc, $7f, $f0, $ff, $80, $ff, $00, $ff
	db $00, $ff, $00, $ff, $1f, $ff, $1c, $ff, $38, $ff, $19, $ff, $1d, $ff, $0d, $ff
	db $01, $ff, $00, $ff, $00, $ff, $30, $ff, $fd, $ff, $b9, $ff, $b3, $ff, $b3, $ff
	db $b9, $ff, $ed, $ff, $07, $ff, $0d, $ff, $cd, $ff, $7d, $ff, $6d, $ff, $6d, $ff
	db $6f, $fe, $ef, $ff, $2e, $ff, $a6, $ff, $a7, $ff, $e3, $fc, $ac, $f0, $93, $e0
	db $e7, $be, $3f, $88, $47, $10, $8f, $21, $1e, $c3, $bc, $77, $78, $4f, $bf, $00
	db $f8, $00, $ff, $ff, $f3, $ff, $5b, $df, $5b, $df, $5b, $9f, $bf, $3f, $7b, $7f
	db $f0, $ff, $e0, $ff, $6c, $ff, $6c, $ff, $6c, $ff, $6f, $ff, $3e, $ff, $80, $ff
	db $00, $ff, $00, $ff, $6e, $ff, $e6, $ff, $66, $ff, $66, $ff, $66, $ff, $76, $ff
	db $1e, $ff, $06, $ff, $70, $ff, $f8, $ff, $cb, $ff, $d3, $ff, $e3, $ff, $cb, $ff
	db $fb, $ff, $73, $ff, $1c, $fb, $07, $fc, $03, $be, $71, $f3, $fc, $e1, $fe, $c2
	db $3d, $fd, $0e, $ff, $85, $f9, $0f, $f5, $9a, $67, $f8, $8c, $73, $f2, $0c, $0f
	db $f1, $37, $cf, $9f, $78, $9f, $58, $bf, $58, $1f, $f0, $7f, $30, $ff, $60, $ff
	db $c0, $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $01, $ff, $01, $ff
	db $01, $ff, $00, $ff, $00, $ff, $2c, $ff, $7f, $ff, $ff, $ff, $f6, $ff, $a6, $ff
	db $66, $ff, $2c, $df, $67, $7f, $e1, $fe, $e2, $ff, $c6, $f9, $09, $f4, $13, $e9
	db $27, $f3, $2f, $39, $cf, $dd, $e6, $ef, $72, $f6, $3b, $fb, $7d, $dc, $ff, $8f
	db $ff, $00, $ff, $8f, $ff, $ff, $7f, $ff, $00, $ff, $00, $ff, $80, $bf, $c0, $1f
	db $e0, $1f, $e0, $ff, $c0, $ff, $00, $df, $00, $df, $00, $df, $00, $df, $00, $df
	db $00, $df, $00, $ff, $02, $ff, $0f, $ff, $1f, $ff, $17, $ff, $0e, $ff, $0c, $ff
	db $05, $ff, $00, $fb, $0e, $ef, $be, $ff, $f8, $ff, $e0, $ff, $60, $ff, $e0, $ff
	db $c0, $ff, $00, $ff, $07, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
	db $00, $ff, $00, $ff, $87, $ff, $01, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
	db $00, $ff, $00, $ff, $fe, $ff, $f8, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
	db $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
	db $00, $ff, $00, $e6, $7f, $ac, $bf, $98, $ff, $f1, $fe, $83, $7c, $87, $78, $ff
	db $00, $ff, $00, $38, $c7, $7b, $84, $fb, $04, $fb, $04, $e3, $1c, $df, $20, $df
	db $20, $c0, $00, $3f, $c0, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
	db $00, $00, $00, $df, $00, $df, $00, $df, $00, $df, $00, $cf, $30, $f3, $0c, $fb
	db $00, $03, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
	db $00, $ff, $00

;@ path: title/screen
;@ The title screen, 20x18 tiles: the framed logo, then "(c) NIHON FALCOM", "(c)1990 EPOCH CO.,LTD." and
;@ "LICENSED BY NINTENDO" in the font tiles, with "GAME START" as the menu line; $FF is blank.
;@ asset: tilemap width=20 height=18 tiles=LoadTiles+CopyBC(de=TitleTiles,hl=$8800,bc=$580) addressing=8800
TitleTilemap::
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $87, $98, $98, $98, $98, $98, $98, $98
	db $98, $98, $98, $98, $98, $98, $98, $98, $98, $88, $ff, $ff, $89, $d7, $d7, $80
	db $81, $82, $d7, $d7, $83, $84, $85, $d7, $86, $d7, $d7, $d7, $d7, $8a, $ff, $ff
	db $89, $d7, $8b, $8c, $8d, $8e, $8f, $d7, $90, $91, $92, $93, $94, $d7, $d7, $d7
	db $d7, $8a, $ff, $ff, $89, $99, $9a, $9b, $9c, $9d, $9e, $d7, $9f, $a0, $a1, $a2
	db $a3, $d7, $a4, $a5, $a6, $8a, $ff, $ff, $89, $a7, $a8, $a9, $aa, $ab, $ac, $ad
	db $ae, $af, $b0, $b1, $b2, $b3, $b4, $b5, $b6, $8a, $ff, $ff, $89, $b7, $b8, $b9
	db $ba, $bb, $bc, $bd, $be, $bf, $c0, $c1, $c2, $c3, $c4, $c5, $c6, $8a, $ff, $ff
	db $89, $d7, $d7, $d7, $d7, $c7, $c8, $c9, $ca, $cb, $cc, $cd, $ce, $cf, $d0, $d1
	db $d2, $8a, $ff, $ff, $89, $d7, $d7, $d7, $d7, $d7, $d7, $d3, $d4, $d5, $d6, $d7
	db $d7, $d7, $d7, $d7, $d7, $8a, $ff, $ff, $95, $97, $97, $97, $97, $97, $97, $97
	db $97, $97, $97, $97, $97, $97, $97, $97, $97, $96, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $67, $61, $6d, $65, $ff, $73, $74, $61, $72, $74, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $60
	db $6e, $69, $68, $6f, $6e, $ff, $66, $61, $6c, $63, $6f, $6d, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $60, $51, $59, $59, $50, $ff, $65, $70, $6f, $63, $68, $ff, $63
	db $6f, $7d, $ff, $6c, $74, $64, $5b, $6c, $69, $63, $65, $6e, $73, $65, $64, $ff
	db $62, $79, $ff, $6e, $69, $6e, $74, $65, $6e, $64, $6f

;@ path: text/screens
;@ "    GAME START" (14 tiles), the title screen's menu line once more; nothing in the code reads
;@ this copy.
;@ asset: tilemap width=14 height=1 tiles=LoadTiles addressing=8800
TextGameStart::
	db $3e, $3e, $3e, $3e, $67
	db $61, $6d, $65, $3e, $73, $74, $61, $72, $74

;@ path: text/screens
;@ "       PHASE  " (14 tiles) for the screen before a phase; the phase digit follows.
;@ asset: tilemap width=14 height=1 tiles=LoadTiles addressing=8800
TextPhase::
	db $3e, $3e, $3e, $3e, $3e, $3e, $3e
	db $70, $68, $61, $73, $65, $3e, $3e

;@ path: text/screens
;@ "       CLEAR !" (14 tiles) for the screen after the dragon is beaten.
;@ asset: tilemap width=14 height=1 tiles=LoadTiles addressing=8800
TextClear::
	db $3e, $3e, $3e, $3e, $3e, $3e, $3e, $63, $6c
	db $65, $61, $72, $3e, $7c

;@ path: text/screens
;@ "     -U.D.L.R.A-" (16 tiles), shown under CLEAR after phase 1: the title screen cheat
;@ (up, down, left, right, A) that starts a game with phase 2.
;@ asset: tilemap width=16 height=1 tiles=LoadTiles addressing=8800
TextCheatHint::
	db $3e, $3e, $3e, $3e, $3e, $7b, $75, $5b, $64, $5b, $6c
	db $5b, $72, $5b, $61, $7b

;@ path: text/screens
;@ "YOU ARE THE GREATEST" (20 tiles), the ending screen after phase 2.
;@ asset: tilemap width=20 height=1 tiles=LoadTiles addressing=8800
TextGreatest::
	db $79, $6f, $75, $3e, $61, $72, $65, $3e, $74, $68, $65
	db $3e, $67, $72, $65, $61, $74, $65, $73, $74

;@ path: text/screens
;@ "   DRAGON SLAYER !" (18 tiles), the ending screen.
;@ asset: tilemap width=18 height=1 tiles=LoadTiles addressing=8800
TextDragonSlayer::
	db $3e, $3e, $3e, $64, $72, $61, $67
	db $6f, $6e, $3e, $73, $6c, $61, $79, $65, $72, $3e, $7c

;@ path: text/screens
;@ Top half of the home picture (cell type 2, tiles $E2/$F2) for the ending screen, centred
;@ by 9 blanks in front.
;@ asset: tilemap width=11 height=1 tiles=LoadTiles addressing=8800
EndingPicTop::
	db $3e, $3e, $3e, $3e, $3e
	db $3e, $3e, $3e, $3e, $e2, $f2

;@ path: text/screens
;@ Bottom half of the home picture (tiles $E3/$F3) for the ending screen.
;@ asset: tilemap width=11 height=1 tiles=LoadTiles addressing=8800
EndingPicBottom::
	db $3e, $3e, $3e, $3e, $3e, $3e, $3e, $3e, $3e, $e3
	db $f3

;@ path: text/screens
;@ " SEE YOU NEXT GAME!" (19 tiles), the last line of the ending screen.
;@ asset: tilemap width=19 height=1 tiles=LoadTiles addressing=8800
TextSeeYou::
	db $3e, $73, $65, $65, $3e, $79, $6f, $75, $3e, $6e, $65, $78, $74, $3e, $67
	db $61, $6d, $65, $7c

;@ path: text/screens
;@ Top half of the gravestone picture (cell type 3, tiles $24/$25) for the game over screen.
;@ asset: tilemap width=11 height=1 tiles=LoadTiles addressing=8800
GravePicTop::
	db $3e, $3e, $3e, $3e, $3e, $3e, $3e, $3e, $3e, $24, $25

;@ path: text/screens
;@ Bottom half of the gravestone picture (tiles $34/$35) for the game over screen.
;@ asset: tilemap width=11 height=1 tiles=LoadTiles addressing=8800
GravePicBottom::
	db $3e
	db $3e, $3e, $3e, $3e, $3e, $3e, $3e, $3e, $34, $35

;@ path: text/screens
;@ "   YOU ARE DEAD !" (17 tiles), the game over screen.
;@ asset: tilemap width=17 height=1 tiles=LoadTiles addressing=8800
TextYouAreDead::
	db $3e, $3e, $3e, $79, $6f, $75
	db $3e, $61, $72, $65, $3e, $64, $65, $61, $64, $3e, $7c

;@ path: text/screens
;@ "      CONTINUE" (14 tiles): the title screen's second line after a game over, and the line
;@ under "PHASE n" when a game goes on.
;@ asset: tilemap width=14 height=1 tiles=LoadTiles addressing=8800
TextContinue::
	db $3e, $3e, $3e, $3e, $3e
	db $3e, $63, $6f, $6e, $74, $69, $6e, $75, $65

;@ path: text/screens
;@ "       START !" (14 tiles), the line under "PHASE n" when a new game begins.
;@ asset: tilemap width=14 height=1 tiles=LoadTiles addressing=8800
TextStart::
	db $3e, $3e, $3e, $3e, $3e, $3e, $3e
	db $73, $74, $61, $72, $74, $3e, $7c

;@ path: map/data
;@ The picture of each cell type: 4 background tile numbers per type (top-left, top-right, bottom-left,
;@ bottom-right), drawn by DrawMetatile; types $00-$1C. Shown here as a strip, one cell per two rows.
;@ asset: tilemap width=2 height=58 tiles=LoadTiles addressing=8800
CellTiles::
	db $3e, $3e, $3e, $3e, $e0, $f0, $e1, $f1, $e2
	db $f2, $e3, $f3, $24, $25, $34, $35, $2a, $2b, $3a, $3b, $0a, $0b, $1a, $1b, $08
	db $09, $18, $19, $04, $05, $14, $15, $0c, $0d, $1c, $1d, $22, $23, $32, $33, $20
	db $21, $30, $31, $06, $07, $16, $17, $28, $29, $38, $39, $0e, $0f, $1e, $1f, $e4
	db $f4, $e5, $f5, $26, $27, $36, $37, $c4, $d4, $c5, $d5, $c0, $d0, $c1, $d1, $c8
	db $d8, $c9, $d9, $a6, $b6, $a7, $b7, $cc, $dc, $cd, $dd, $2c, $2f, $52, $51, $2c
	db $2f, $52, $52, $3e, $3e, $b4, $b5, $a8, $a9, $a8, $a9, $b8, $b9, $b8, $b9, $02
	db $03, $12, $13, $cc, $dc, $cd, $dd, $ce, $de, $cf, $df

;@ path: data
;@ Unused: $FF up to the sound engine at $7038.
CellTilesPadding::
	db $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

;@ def TickSound()
;@ path: sound/api
;@ Entry point (the sound engine's jump table at $7038): advances every music and effect channel by one
;@ frame - reads their next notes when the old ones run out. VBlank calls it after UpdateSoundRegisters.
;@ test: skip runs the whole sequencer
;@ sig: 19e23d12
TickSound::
;> DoTickSound()
	jp DoTickSound


;@ def UpdateSoundRegisters()
;@ path: sound/api
;@ Entry point: writes what last frame's tick decided (new notes, releases, ends) into the sound
;@ registers. VBlank calls it once a frame, just before TickSound.
;@ test: skip writes the sound registers
;@ sig: a2721ed3
UpdateSoundRegisters::
;> DoUpdateSoundRegisters()
	jp DoUpdateSoundRegisters


;@ def InitSound()
;@ path: sound/api
;@ Entry point: switches the sound hardware on, loads the wave samples and silences music and effects.
;@ test: skip writes the sound registers
;@ sig: 797ab17f
InitSound::
;> DoInitSound()
	jp DoInitSound


;@ def PlaySong(song: a)
;@ path: sound/api
;@ Entry point: starts song `song` on the four music channels (see SongTable).
;@ test: song = rand(0, 20)
;@ sig: d6eca335
PlaySong::
;> DoPlaySong(song)
	jp DoPlaySong


;@ def PlaySfx(sfx: a)
;@ path: sound/api
;@ Entry point: starts sound effect `sfx` (see SfxTable); while it plays it takes square channel 1 and
;@ the noise channel from the music.
;@ test: sfx = rand(0, 14)
;@ sig: e54b6f14
PlaySfx::
;> DoPlaySfx(sfx)
	jp DoPlaySfx


;@ def StopSong()
;@ path: sound/api
;@ Entry point: ends the song; the next register update silences its channels.
;@ sig: 8c6619b0
StopSong::
;> DoStopSong()
	jp DoStopSong


;@ def StopSfx()
;@ path: sound/api
;@ Ends the sound effect (only InitSound uses this one; it is not in the jump table).
;@ sig: 61164dc1
StopSfx::
;> DoStopSfx()
	jp DoStopSfx


;@ def DoInitSound()
;@ path: sound/engine
;@ Switches the sound hardware on with full master volume, every channel on both speakers, loads the
;@ wave channel's samples and ends any song and effect.
;@ writes: wSoundPanning
;@ test: skip writes the sound registers
;@ sig: 2cbb12a8
DoInitSound::
;> rNR30 = 0                                  # wave channel off while its samples change
	ld a, $00
	ldh [rNR30], a
;> rNR32 = 0x20                               # wave output at full volume
	ld a, $20
	ldh [rNR32], a
;> rNR50 = 0x77                               # master volume 7 on both sides
	ld a, $77
	ldh [rNR50], a
;> rNR51 = 0xFF                               # every channel to both speakers
	ld a, $ff
	ldh [rNR51], a
;> rNR52 = 0xFF                               # sound on
	ldh [rNR52], a
;> wSoundPanning = 0xFF
	ld [wSoundPanning], a
;> LoadWaveSamples()
	call LoadWaveSamples
;> StopSong()
	call StopSong
;> StopSfx()
	jp StopSfx


;@ def LoadWaveSamples()
;@ path: sound/engine
;@ Copies WaveSamples into the wave channel's sample RAM ($FF30-$FF3F). The game never changes them:
;@ every wave note uses this one waveform.
;@ test: skip writes wave RAM
;@ sig: 5b1602c5
LoadWaveSamples::
;> for i in range(16):
	ld hl, WaveSamples
	ld c, $30
	ld b, $10
.copy
;>     mem[0xFF30 + i] = WaveSamples[i]
	ld a, [hli]
	ldh [c], a
	inc c
	dec b
	jr nz, .copy
	ret

; The wave channel's only waveform: 32 samples of 4 bits, two per byte (high nibble first).


;@ path: sound/data/wave
WaveSamples::
	db $ce, $fe, $b8, $be, $ff, $ff, $fe, $b9, $63, $10, $00, $00, $00, $00, $13, $69

;@ def DoPlaySong(song: a)
;@ path: sound/engine
;@ Starts a song: reads its header from SongTable (tempo, note length table, a note pointer for each
;@ of the four channels) and sets each music channel up to read its first note at the next tick. A
;@ channel without a part (pointer 0) is marked as ended straight away.
;@ writes: wSongChannelsLeft, wSongId, wSongLengths, wSongTempo
;@ test: song = rand(0, 20)
;@ sig: 2e058fe4
DoPlaySong::
;> wSongId = song
	ld [wSongId], a
;> p = SongTable + 2 * song
	ld de, SongTable
	sla a
	add e
	ld e, a
	ld a, d
	adc $00
;> header = mem16[p]
	ld d, a
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	ld h, a
;> rNR30 = 0                                  # wave channel off until its first note
	ld a, $00
	ldh [rNR30], a
;> wSongChannelsLeft = 4                      # (the ld a, 5 before it is a leftover)
	ld a, $05
	ld a, $04
	ld [wSongChannelsLeft], a
;> wSongTempo = mem[header]
	ld a, [hli]
	ld [wSongTempo], a
;> wSongLengths = mem16[header + 1]
	ld a, [hli]
	ld [wSongLengths], a
	ld a, [hli]
	ld [wSongLengths + 1], a
;> for i, ch in enumerate([wSongCh1, wSongCh2, wSongCh3, wSongCh4]):
	ld de, wSongCh1
	ld c, $04
.channel
;>     ch[0] = 1                              # state 1: running, no note sounding yet
	ld a, $01
	ld [de], a
	inc de
;>     mem16[ch + 1] = mem16[header + 3 + 2 * i]   # note pointer
	ld a, [hli]
	ld [de], a
	ld b, a
	inc de
	ld a, [hld]
	ld [de], a
;>     if mem16[ch + 1] != 0:
	or b
	jr z, .unused
;>         mem16[ch + 3] = 0                  # note timer: the first tick reads the first note
	inc e
	ld a, $00
	ld [de], a
	inc e
	ld [de], a
;>         ch[17] = 0                         # no repeat open
	ld a, e
	add $0d
	ld e, a
	ld a, $00
	ld [de], a
;>         ch[30] = mem[header + 3 + 2 * i]   # where the $FE loop command jumps back to: the start
	ld a, e
	add $0d
	ld e, a
	ld a, [hli]
	ld [de], a
	inc e
;>         ch[31] = mem[header + 4 + 2 * i]
	ld a, [hli]
	ld [de], a
	inc e
	dec c
	jr nz, .channel
	ret
;>     else:
.unused
;>         ch[0] = 4                          # no part: "just ended", counted off at the next update
	inc hl
	inc hl
	dec e
	dec e
	ld a, $04
	ld [de], a
;>         continue
	ld a, e
	add $20
	ld e, a
	dec c
	jr nz, .channel
	ret


;@ def DoPlaySfx(sfx: a)
;@ path: sound/engine
;@ Starts a sound effect: reads its header from SfxTable (tempo, note length table, note pointers for
;@ the square 1 and the noise part) and sets both effect channels up. While wSfxChannelsLeft is not 0
;@ the register update gives these two hardware channels to the effect.
;@ writes: wPanningPending, wSfxChannelsLeft, wSfxId, wSfxLengths, wSfxTempo
;@ test: sfx = rand(0, 14)
;@ sig: 289c02f0
DoPlaySfx::
;> wSfxId = sfx
	ld [wSfxId], a
;> p = SfxTable + 2 * sfx
	ld de, SfxTable
	sla a
	add e
	ld e, a
	ld a, d
	adc $00
;> header = mem16[p]
	ld d, a
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	ld h, a
;> wSfxChannelsLeft = 2
	ld a, $02
	ld [wSfxChannelsLeft], a
;> wSfxTempo = mem[header]
	ld a, [hli]
	ld [wSfxTempo], a
;> wSfxLengths = mem16[header + 1]
	ld a, [hli]
	ld [wSfxLengths], a
	ld a, [hli]
	ld [wSfxLengths + 1], a
;> for i, ch in enumerate([wSfxCh1, wSfxCh2]):
	ld de, wSfxCh1
	ld c, $02
.channel
;>     ch[0] = 1                              # state 1: running, no note sounding yet
	ld a, $01
	ld [de], a
	inc de
;>     mem16[ch + 1] = mem16[header + 3 + 2 * i]   # note pointer
	ld a, [hli]
	ld [de], a
	ld b, a
	inc de
	ld a, [hld]
	ld [de], a
;>     if mem16[ch + 1] != 0:
	or b
	jr z, .unused
;>         mem16[ch + 3] = 0                  # note timer: the first tick reads the first note
	inc de
	ld a, $00
	ld [de], a
	inc de
	ld [de], a
;>         ch[17] = 0                         # no repeat open
	ld a, e
	add $0d
	ld e, a
	ld a, $00
	ld [de], a
;>         ch[30] = mem[header + 3 + 2 * i]   # where the $FE loop command jumps back to: the start
	ld a, e
	add $0d
	ld e, a
	ld a, [hli]
	ld [de], a
	inc e
;>         ch[31] = mem[header + 4 + 2 * i]
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .channel
	jr .done
;>     else:
.unused
;>         ch[0] = 4                          # no part: "just ended", counted off at the next update
	inc hl
	inc hl
	dec e
	dec e
	ld a, $04
	ld [de], a
;>         continue
	ld a, e
	add $20
	ld e, a
	dec c
	jr nz, .channel
.done
;> wPanningPending = 2                        # the next tick turns it into 1: square 1 and noise to both sides
	ld a, $02
	ld [wPanningPending], a
	ret


;@ def DoStopSong()
;@ path: sound/engine
;@ Ends the song: state 4 ("just ended") on all four music channels, so the next register update
;@ silences each one and counts wSongChannelsLeft down to 0, which sets wSongId to $FF.
;@ writes: wSongCh1, wSongCh2, wSongCh3, wSongCh4, wSongChannelsLeft
;@ sig: c2f3d00e
DoStopSong::
;> wSongChannelsLeft = 4
	ld a, $04
	ld [wSongChannelsLeft], a
;> wSongCh1[0] = 4                            # state 4: just ended
	ld [wSongCh1], a
;> wSongCh2[0] = 4
	ld [wSongCh2], a
;> wSongCh3[0] = 4
	ld [wSongCh3], a
;> wSongCh4[0] = 4
	ld [wSongCh4], a
;> return
	ret


;@ def DoStopSfx()
;@ path: sound/engine
;@ Ends the sound effect: both effect channels get state 4, so the next register update silences
;@ square 1 and noise and hands them back to the music.
;@ writes: wSfxCh1, wSfxCh2, wSfxChannelsLeft
;@ sig: 078a02a4
DoStopSfx::
;> wSfxChannelsLeft = 2
	ld a, $02
	ld [wSfxChannelsLeft], a
;> wSfxCh1[0] = 4                             # state 4: just ended
	ld a, $04
	ld [wSfxCh1], a
;> wSfxCh2[0] = 4
	ld [wSfxCh2], a
;> return
	ret


;@ def DoTickSound()
;@ path: sound/engine
;@ The sequencer, once a frame for each of the six channels (4 music, 2 effect). It subtracts the tempo
;@ from the channel's note timer; while the note lasts it runs the instrument's volume steps or early
;@ release, and when the timer runs out it reads commands up to the next note. It only fills the
;@ channel structs: UpdateSoundRegisters writes them to the hardware at the next frame.
;@ Channel struct (32 bytes, wSongCh1 ...): +0 state (0 off, 1 running quietly, 2 note sounding;
;@ +4 = registers to write next update: 4 silence the channel, 5 release the note, 6 start the note),
;@ +1/+2 note pointer, +3/+4 note timer, +5 current note, +6..+10 the values for NRx0-NRx4,
;@ +11 instrument mode (0 plain, 1 volume steps, 2 counter, 3+ early release), +12..+16 mode data,
;@ +17 open repeats, +18..+29 three repeat entries (pass, passes, pointer), +30/+31 the part's start.
;@ writes: wNoteByte, wPanningPending, wSoundChannel, wSoundPanning
;@ reads: wNoteByte, wPanningPending, wSfxLengths, wSfxTempo, wSongLengths, wSongTempo, wSoundChannel
;@ test: skip follows song pointers in RAM (random ones can loop forever)
;@ sig: ead3e5ef
DoTickSound::
;> if wPanningPending == 2:                    # an effect has just started
	ld a, [wPanningPending]
	cp $02
	jr nz, .start
;>     wPanningPending = 1                     # its panning goes out at the next register update
	ld a, $01
	ld [wPanningPending], a
.start
;> ch = wSongCh1
	ld hl, wSongCh1
;> wSoundChannel = 0
	ld a, $00
	ld [wSoundChannel], a
.channel
;> while True:
;>     state = mem[ch] & 3
	push hl
	ld a, [hli]
	and $03
;>     if state:                               # the channel is running
	jp z, .skip
;>         ptr = mem16[ch + 1]
	ld c, a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
;>         tempo = wSongTempo if wSoundChannel < 4 else wSfxTempo
	ld a, [wSoundChannel]
	cp $04
	jr nc, .sfxTempo
	ld a, [wSongTempo]
	jr .haveTempo
.sfxTempo
	ld a, [wSfxTempo]
.haveTempo
;>         timer = mem16[ch + 3] - tempo
	ld b, a
	ld a, [hl]
	sub b
	ld [hli], a
	ld a, [hl]
	sbc $00
;>         mem16[ch + 3] = u16(timer)
	ld [hli], a
;>         if timer < 0:                       # the note is over: read on up to the next note
	jp nc, .effects
.read
;>             while True:
;>                 cmd = mem[ptr]
	ld a, [de]
;>                 if cmd == 0xF0:             # $F0 n: instrument n
	cp $f0
	jp nz, .notInstrument
;>                     n = mem[ptr + 1]
	inc de
	ld a, [de]
;>                     ptr += 2
	inc de
;>@ins                     p = InstrumentTable + 2 * n
	sla a
	push de
	push hl
	ld hl, InstrumentTable
	add l
	ld l, a
;=@ins
	ld a, $00
	adc h
	ld h, a
;>                     if wSoundChannel != 3 and wSoundChannel != 5:   # noise parts ignore instruments
	ld a, [wSoundChannel]
	cp $03
	jr z, .instrumentDone
	cp $05
	jr z, .instrumentDone
;>                         instr = mem16[p]
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	pop hl
	push hl
;>                         for k in range(5):  # the values for NRx0-NRx4
	inc l
	ld c, $05
.copyRegisters
;>                             mem[ch + 6 + k] = mem[instr + k]
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .copyRegisters
;>                         mode = mem[instr + 5]
	ld a, [de]
;>                         mem[ch + 11] = mode
	ld [hli], a
;>                         if mode == 1:       # volume steps (mode 0: nothing more)
	and a
	jr z, .instrumentDone
	cp $01
	jr nz, .notVolumeSteps
;>                             mem[ch + 12] = mem[instr + 6]   # frames per step
	inc de
	ld a, [de]
	ld [hli], a
;>                             mem[ch + 13] = mem[instr + 6]   # step counter
	ld [hli], a
;>                             mem16[ch + 14] = instr + 7      # the four volumes follow
	inc de
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
;>                             mem[ch + 16] = 0                # step index
	ld a, $00
	ld [hl], a
;=@instrumentDone
	pop hl
	pop de
	jp .read
.notVolumeSteps
;>                         elif mode == 2:     # a counter (it never changes the sound, see below)
	cp $02
	jr nz, .notCounter
;>                             mem[ch + 12] = mem[instr + 6]
	inc de
	ld a, [de]
	ld [hli], a
;>                             mem[ch + 13] = mem[instr + 6]
	ld [hli], a
	jr .instrumentDone
.notCounter
;>                         else:               # early release: cut the note this long before its end
;>                             steps = mem[instr + 6]
	inc de
	ld a, [de]
	ld c, a
;>                             tempo = wSongTempo if wSoundChannel < 4 else wSfxTempo
	ld a, [wSoundChannel]
	cp $04
	jr nc, .sfxTempo2
	ld a, [wSongTempo]
	jr .haveTempo2
.sfxTempo2
	ld a, [wSfxTempo]
.haveTempo2
;>                             gate = 0
	ld b, a
	ld a, $00
	ld d, a
.multiply
;>                             for _ in range(steps or 256):
;>                                 gate += tempo
	add b
	jr nc, .noCarry
	inc d
.noCarry
	dec c
	jr nz, .multiply
;>                             mem16[ch + 12] = u16(gate)   # in timer units: `steps` frames
	ld [hli], a
	ld a, d
	ld [hl], a
	jr .instrumentDone
.instrumentDone
;>@instrumentDone                     continue
	pop hl
	pop de
	jp .read
.notInstrument
;>                 if cmd < 0xE0:              # a note
	cp $e0
	jp nc, .command
;>                     wNoteByte = cmd         # high nibble: length, low nibble: pitch
	ld [wNoteByte], a
;>                     if cmd >> 4 == 0xD:     # $Dx: a 16-bit length follows
	and $f0
	cp $d0
	jr nz, .lengthFromTable
;>                         length = mem16[ptr + 1]
	inc de
	ld a, [de]
	ld c, a
	inc de
	ld a, [de]
	ld b, a
;>                         ptr += 2            # (the two inc de above)
	jr .haveLength
.lengthFromTable
;>                     elif wSoundChannel < 4:
	push hl
	ld a, [wSoundChannel]
	cp $04
	jr nc, .sfxLengths
;>                         length = mem16[wSongLengths + 2 * (cmd >> 4)]
	ld a, [wSongLengths]
	ld l, a
	ld a, [wSongLengths + 1]
	jr .haveLengths
.sfxLengths
;>                     else:
;>@len                         length = mem16[wSfxLengths + 2 * (cmd >> 4)]
	ld a, [wSfxLengths]
	ld l, a
	ld a, [wSfxLengths + 1]
.haveLengths
;=@len
	ld h, a
	ld a, [de]
	and $f0
	srl a
	srl a
	srl a
;=@len
	add l
	ld l, a
	jr nc, .lengthAddressDone
	inc h
.lengthAddressDone
;=@len
	ld a, [hli]
	ld c, a
	ld a, [hl]
	ld b, a
	pop hl
.haveLength
;>@add                     mem16[ch + 3] = u16(mem16[ch + 3] + 8 * length)   # what the old note overran counts
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
;=@add
	dec l
	dec l
	ld a, [hl]
	add c
	ld [hli], a
	ld a, [hl]
;=@add
	adc b
	ld [hli], a
;>                     low = wNoteByte & 0x0F
	ld a, [wNoteByte]
	and $0f
;>                     if low == 9:            # tie: the sounding note simply lasts longer
	cp $09
	jr nz, .notTie
;>                         ptr += 1
	inc de
	pop hl
	inc hl
	jp .savePointer
.notTie
;>                     else:
;>                         if low != 8:        # 8 is a rest
	cp $08
	jr z, .rest
;>                             if low == 6:    # an absolute note number follows
	cp $06
	jr nz, .relative
;>                                 ptr += 1
	inc de
;>                                 note = mem[ptr]
	ld a, [de]
	jr .setNote
.relative
;>                             else:           # 0-5, 7: that many semitones up; $A-$F: 6-1 down
;>                                 note = u8(mem[ch + 5] + (low if low < 8 else low - 16))
	cp $08
	jr c, .up
	or $f0
.up
	add [hl]
.setNote
;>                             mem[ch + 5] = note
	ld [hli], a
	ld b, a
;>                             if wSoundChannel == 3 or wSoundChannel == 5:   # noise: a drum sound
;>@drum                                 drum = NoiseDrums + 4 * (note - 0x34)
;>@drumcopy                                 copy(ch + 7, drum, 4)   # its values for NR41-NR44
	ld a, [wSoundChannel]
	cp $03
	jr z, .drumSong
	cp $05
	jr z, .drumSfx
;>                             else:
;>@freq                                 p = NoteFrequencies - 0x20 + lo(2 * note)
	ld a, b
	sla a
	ld bc, NoteFrequencies - $20
	add c
	ld c, a
	ld a, b
;=@freq
	adc $00
	ld b, a
;>                                 mem[ch + 9] = mem[p]                     # NRx3: frequency, low 8 bits
	inc l
	inc l
	inc l
	ld a, [bc]
	ld [hli], a
;>@hi                                 mem[ch + 10] = (mem[ch + 10] & 0xF8) | (mem[p + 1] & 7)   # NRx4: high 3 bits
	inc bc
	ld a, [bc]
	and $07
	ld b, a
	ld a, [hl]
	and $f8
;=@hi
	or b
	ld [hli], a
;>                                 mode = mem[ch + 11]
	ld a, [hli]
;>                                 if mode == 1:   # volume steps: start again from the first (mode 0: nothing)
	and a
	jp z, .newNote
	cp $02
	jr nc, .notSteps
;>                                     mem[ch + 13] = mem[ch + 12]
	ld a, [hli]
	ld [hli], a
;>                                     steps = mem16[ch + 14]
	push de
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
;>                                     v = mem[steps]
	ld a, [de]
	ld b, a
;>                                     mem[ch + 16] = 0
	ld a, $00
	ld [hl], a
;>@vol                                     mem[ch + 8] = (mem[ch + 8] & 0x0F) | swap(v)   # NRx2: start volume
	ld a, l
	sub $08
	ld l, a
	ld a, [hl]
	and $0f
	swap b
;=@vol
	or b
	ld [hl], a
	pop de
	jp .newNote
.notSteps
;>                                 elif mode == 2:
	jr nz, .early
;>                                     mem[ch + 13] = mem[ch + 12]
	ld a, [hli]
	ld [hli], a
	jp .newNote
.early
;>                                 else:           # early release: its timer is the note timer minus the gate
;>@t                                     t = mem16[ch + 3]
	push hl
	ld a, l
	sub $09
	ld l, a
	ld a, [hli]
	ld c, a
;=@t
	ld a, [hl]
	ld b, a
	pop hl
;>@t2                                     t -= mem16[ch + 12]
	ld a, c
	sub [hl]
	ld c, a
	inc l
	ld a, b
	sbc [hl]
;=@t2
	ld b, a
	inc l
;>                                     mem16[ch + 14] = u16(t)
	ld a, c
	ld [hli], a
	ld a, b
	ld [hl], a
	jp .newNote
.rest
;=@rest
	ld a, $05
	jp .store
.drumSong
;=@drum
	ld hl, NoiseDrums
	ld a, b
	sub $34
	sla a
	sla a
	add l
;=@drum
	ld l, a
	jr nc, .drumAddressDone
	inc h
.drumAddressDone
;=@drumcopy
	ld bc, wSongCh4 + 7
	jr .copyDrum
.drumSfx
;=@drum
	ld hl, NoiseDrums
	ld a, b
	sub $34
	sla a
	sla a
	add l
;=@drum
	ld l, a
	jr nc, .drumAddressDone2
	inc h
.drumAddressDone2
;=@drumcopy
	ld bc, wSfxCh2 + 7
.copyDrum
;=@drumcopy
	ld a, [hli]
	ld [bc], a
	inc bc
	ld a, [hli]
	ld [bc], a
	inc bc
;=@drumcopy
	ld a, [hli]
	ld [bc], a
	inc bc
	ld a, [hli]
	ld [bc], a
.newNote
;>                             state = 6       # start the note: write all its registers
	ld a, $06
;>                         else:
;>@rest                             state = 5       # rest: release the sounding note
.store
;>                         ptr += 1
	inc de
;>                         mem[ch] = state
	pop hl
	ld [hli], a
.savePointer
;>                     mem16[ch + 1] = ptr
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
;>                     break                   # this channel is done for the frame
;=@last
	ld a, [wSoundChannel]
	cp $05
	ret nc
;=@step2b
	inc a
	ld [wSoundChannel], a
;=@step2
	ld a, l
	add $1d
	ld l, a
	jp .channel
.command
;>                 elif cmd == 0xFF:           # end of the part
	cp $fe
	jp c, .lowCommand
	jr z, .loopBack
;>                     mem[ch] = 4             # silence the channel at the next update
	pop hl
	ld a, $04
	ld [hl], a
;>                     break
	jp .nextChannel
.loopBack
;>                 elif cmd == 0xFE:           # loop: the part starts over
;>@loop                     ptr = mem16[ch + 30]
	push hl
	ld a, $19
	add l
	ld l, a
	ld a, [hli]
	ld e, a
;=@loop
	ld a, [hl]
	ld d, a
;>                     mem[ch + 17] = 0        # no repeat open
	ld a, $f2
	add l
	ld l, a
	ld a, $00
	ld [hl], a
;>                     continue
	pop hl
	jp .read
.lowCommand
;>                 elif cmd == 0xE0:           # $E0 n: repeat start, the part up to $E1 plays n times
	cp $e0
	jp nz, .notRepeat
;>                     depth = mem[ch + 17]
	push hl
	ld a, l
	add $0c
	ld l, a
	ld a, [hl]
;>                     mem[ch + 17] = u8(depth + 1)
	inc a
	ld [hli], a
;>                     entry = ch + 18 + 4 * depth
	dec a
	sla a
	sla a
	add l
	ld l, a
;>                     mem[entry] = 1          # pass 1
	ld a, $01
	ld [hli], a
;>                     mem[entry + 1] = mem[ptr + 1]   # number of passes
	inc de
	ld a, [de]
	ld [hli], a
;>                     ptr += 2
	inc de
;>                     mem16[entry + 2] = ptr  # where each pass starts
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	pop hl
	jp .read
.notRepeat
;>                 elif cmd == 0xE1:           # repeat end
	cp $e1
	jp nz, .notRepeatEnd
;>@entry                     entry = ch + 18 + 4 * (mem[ch + 17] - 1)
	push hl
	ld a, l
	add $0c
	ld l, a
	ld a, [hli]
	dec a
;=@entry
	sla a
	sla a
	add l
	ld l, a
;>                     mem[entry] = u8(mem[entry] + 1)
	inc [hl]
;>                     if mem[entry] <= mem[entry + 1]:   # passes left: back to the start of the part
	ld a, [hli]
	ld b, a
	ld a, [hli]
	sub b
	jr c, .repeatOver
;>                         ptr = mem16[entry + 2]
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	pop hl
	jp .read
.repeatOver
;>                     else:
;>                         ptr += 1
	inc de
.closeRepeat
;>@closeRepeat                         mem[ch + 17] = u8(mem[ch + 17] - 1)   # close the repeat
	pop hl
	push hl
	ld a, l
	add $0c
	ld l, a
	dec [hl]
;=@closeRepeat
	pop hl
	jp .read
.notRepeatEnd
;>                 elif cmd == 0xE2:           # $E2 n: what follows plays in pass n only
	cp $e2
	jp nz, .panning
;>@entry2                     entry = ch + 18 + 4 * (mem[ch + 17] - 1)
	push hl
	ld a, l
	add $0c
	ld l, a
	ld a, [hli]
	dec a
;=@entry2
	sla a
	sla a
	add l
	ld l, a
;>                     n = mem[entry]          # this pass
	ld a, [hli]
	ld b, a
;>                     count = mem[entry + 1]
	ld a, [hl]
	ld c, a
.scan
;>                     while True:             # on to the $E2 of this pass (this one if it matches)
;>                         b = mem[ptr]
	ld a, [de]
;>                         ptr += 1
	inc de
;>                         if b == 0xE2:
	cp $e2
	jr nz, .scanOther
;>                             p = mem[ptr]
	ld a, [de]
;>                             ptr += 1
	inc de
;>                             if p == n: break
	cp b
	jr z, .found
	jr .scan
.scanOther
;>                         elif b >= 0xE0:     # other commands: $E1 alone, the rest with a parameter
	cp $e0
	jr c, .scanNote
;>                             if b != 0xE1: ptr += 1
	cp $e1
	jr z, .scan
	inc de
	jr .scan
.scanNote
;>                         else:               # notes
;>                             if b >= 0xD0: ptr += 2   # with an explicit length
	cp $d0
	jr c, .noLength
	inc de
	inc de
.noLength
;>                             if b & 0x0F == 6: ptr += 1   # with an absolute note number
	and $0f
	cp $06
	jr nz, .scan
	inc de
	jr .scan
.found
;>                     if n == count:          # the last pass: the repeat is over
	ld a, b
	cp c
	jr z, .closeRepeat
;>                         mem[ch + 17] = u8(mem[ch + 17] - 1)   # (the jump goes to the $E1 code above)
;>                     continue
	pop hl
	jp .read
.panning
;>                 else:                       # $E3-$FD (the songs use $F1) n: panning
;>                     ptr += 2                # (the parameter is read on the way)
	inc de
	ld a, [de]
	inc de
;>                     wSoundPanning = mem[ptr - 1]
	ld [wSoundPanning], a
;>                     wPanningPending = 1
	ld a, $01
	ld [wPanningPending], a
	jp .read
.effects
;>         elif state == 2:                    # the note goes on: instrument effects
	ld a, c
	cp $02
	jp nz, .skip
;>             mode = mem[ch + 11]
	ld a, l
	add $06
	ld l, a
	ld a, [hli]
;>             if mode == 1:                   # volume steps (mode 0: nothing)
	and a
	jp z, .skip
	cp $01
	jp nz, .notVolume
;>                 mem[ch + 13] = u8(mem[ch + 13] - 1)
	inc l
	ld a, [hl]
	dec a
	ld [hld], a
;>                 if mem[ch + 13] == 0:       # time for the next step
	jp nz, .skip
;>                     mem[ch + 13] = mem[ch + 12]
	ld a, [hli]
	ld [hli], a
;>@step                     p = mem16[ch + 14] + mem[ch + 16]
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hl]
	add e
;=@step
	ld e, a
	jr nc, .stepAddressDone
	inc d
.stepAddressDone
;>                     if mem[ch + 16] < 3: mem[ch + 16] += 1   # the last volume stays
	ld a, [hl]
	cp $03
	jr nc, .lastStep
	inc [hl]
.lastStep
;>@nvol                     mem[ch + 8] = (mem[ch + 8] & 0x0F) | swap(mem[p])   # NRx2: the new volume
	ld a, [de]
	ld b, a
	ld a, l
	sub $08
	ld l, a
	ld a, [hl]
;=@nvol
	and $0f
	swap b
	or b
	ld [hl], a
	jp .retrigger
.notVolume
;>@retrig                     mem[ch] = 6         # start the note again with it
;>             elif mode == 2:                 # counts down, but never releases: `jp nc` sees the
	cp $02
	jr nz, .release
;>                 mem[ch + 13] = u8(mem[ch + 13] - 1)   # carry of the compare above (dec leaves it alone)
	inc l
	ld a, [hl]
	dec a
	ld [hld], a
	jp nc, .skip
;>                 # (never reached: a release)
	ld a, $05
	jr .storeState
.release
;>             else:                           # early release
;>@rel                 release = mem16[ch + 14] - tempo
	inc l
	inc l
	ld a, [wSoundChannel]
	cp $04
	jr nc, .sfxTempo3
	ld a, [wSongTempo]
;=@rel
	jr .haveTempo3
.sfxTempo3
	ld a, [wSfxTempo]
.haveTempo3
	ld b, a
	ld a, [hl]
	sub b
	ld [hli], a
;>                 mem16[ch + 14] = u16(release)
	ld a, [hl]
	sbc $00
	ld [hl], a
;>                 if release < 0:             # gate reached: release the note
	jr nc, .skip
;>                     mem[ch] = 5             # (stored by the shared code below)
	ld a, $05
	jr .storeState
.retrigger
;=@retrig
	ld a, $06
.storeState
	pop hl
	ld [hl], a
;=@last
	ld a, [wSoundChannel]
	cp $05
	ret nc
;=@step2b
	inc a
	ld [wSoundChannel], a
;=@step2
	ld a, l
	add $20
	ld l, a
	jp .channel
.skip
;>@last     if wSoundChannel >= 5: return       # all six channels done
	pop hl
.nextChannel
	ld a, [wSoundChannel]
	cp $05
	ret nc
;>@step2b     wSoundChannel += 1
	inc a
	ld [wSoundChannel], a
;>@step2     ch += 32
	ld a, l
	add $20
	ld l, a
	jp .channel


;@ def DoUpdateSoundRegisters()
;@ path: sound/engine
;@ Writes what the last tick decided into the sound registers, for each channel whose state has the
;@ "write" value (4-6): 4 silences the channel (and counts the part off: wSongId becomes $FF when all
;@ four have ended), 5 releases the note (volume 0), 6 starts a new note with all its registers.
;@ While a sound effect plays, UpdateRegistersDuringSfx does this instead.
;@ writes: wPanningPending, wSongCh1, wSongCh2, wSongCh3, wSongCh4, wSongChannelsLeft, wSongId
;@ reads: wPanningPending, wSfxChannelsLeft, wSongCh1, wSongCh2, wSongCh3, wSongCh4, wSongChannelsLeft, wSoundPanning
;@ test: skip writes the sound registers
;@ sig: 70830c13
DoUpdateSoundRegisters::
;> if wSfxChannelsLeft:                       # an effect is playing
	ld a, [wSfxChannelsLeft]
	and a
;>     return UpdateRegistersDuringSfx()
	jp nz, UpdateRegistersDuringSfx
;> if wPanningPending == 1:
	ld a, [wPanningPending]
	cp $01
	jr nz, .square1
;>     wPanningPending = 0
	ld a, $00
	ld [wPanningPending], a
;>     rNR51 = wSoundPanning
	ld a, [wSoundPanning]
	ldh [rNR51], a
.square1
;> s = wSongCh1[0] - 4
	ld a, [wSongCh1]
	sub $04
;> if s >= 0:                                 # something to write
	jr c, .square2
;>     wSongCh1[0] = s
	ld [wSongCh1], a
;>     if s == 0:                              # the part has ended: silence the channel
	cp $02
	jr z, .start1
	cp $01
	jr z, .release1
;>         rNR12 = 0x08                         # volume 0
	ld a, $08
	ldh [rNR12], a
;>         rNR14 = 0x80                         # restart: the channel goes quiet
	ld a, $80
	ldh [rNR14], a
;>         wSongChannelsLeft -= 1
	ld a, [wSongChannelsLeft]
	dec a
	ld [wSongChannelsLeft], a
;>         if wSongChannelsLeft == 0: wSongId = 0xFF   # the whole song is over
	jr nz, .square2
	ld a, $ff
	ld [wSongId], a
	jr .square2
.release1
;>     elif s == 1:                            # release: volume 0, the envelope settings stay
;>         rNR12 = wSongCh1[8] & 0x0F
	ld a, [wSongCh1 + 8]
	and $0f
	ldh [rNR12], a
;>         rNR14 = wSongCh1[10]
	ld a, [wSongCh1 + 10]
	ldh [rNR14], a
	jr .square2
.start1
;>     else:                                   # a new note: all its registers
;>         rNR10 = wSongCh1[6]
	ld hl, wSongCh1 + 6
	ld c, $10
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR11 = wSongCh1[7]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR12 = wSongCh1[8]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR13 = wSongCh1[9]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR14 = wSongCh1[10]
	ld a, [hl]
	ldh [c], a
.square2
;> s = wSongCh2[0] - 4
	ld a, [wSongCh2]
	sub $04
;> if s >= 0:                                 # something to write
	jr c, .wave
;>     wSongCh2[0] = s
	ld [wSongCh2], a
;>     if s == 0:                              # the part has ended: silence the channel
	cp $02
	jr z, .start2
	cp $01
	jr z, .release2
;>         rNR22 = 0x08                         # volume 0
	ld a, $08
	ldh [rNR22], a
;>         rNR24 = 0x80                         # restart: the channel goes quiet
	ld a, $80
	ldh [rNR24], a
;>         wSongChannelsLeft -= 1
	ld a, [wSongChannelsLeft]
	dec a
	ld [wSongChannelsLeft], a
;>         if wSongChannelsLeft == 0: wSongId = 0xFF   # the whole song is over
	jr nz, .wave
	ld a, $ff
	ld [wSongId], a
	jr .wave
.release2
;>     elif s == 1:                            # release: volume 0, the envelope settings stay
;>         rNR22 = wSongCh2[8] & 0x0F
	ld a, [wSongCh2 + 8]
	and $0f
	ldh [rNR22], a
;>         rNR24 = wSongCh2[10]
	ld a, [wSongCh2 + 10]
	ldh [rNR24], a
	jr .wave
.start2
;>     else:                                   # a new note: all its registers
;>         rNR21 = wSongCh2[7]
	ld hl, wSongCh2 + 7
	ld c, $16
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR22 = wSongCh2[8]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR23 = wSongCh2[9]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR24 = wSongCh2[10]
	ld a, [hl]
	ldh [c], a
.wave
;> s = wSongCh3[0] - 4
	ld a, [wSongCh3]
	sub $04
;> if s >= 0:
	jr c, .noise
;>     wSongCh3[0] = s
	ld [wSongCh3], a
;>     if s == 0:                              # the part has ended: wave channel off
	cp $02
	jr z, .start3
	cp $01
	jr z, .release3
;>         rNR30 = 0
	ld a, $00
	ldh [rNR30], a
;>         wSongChannelsLeft -= 1
	ld a, [wSongChannelsLeft]
	dec a
	ld [wSongChannelsLeft], a
;>         if wSongChannelsLeft == 0: wSongId = 0xFF   # the whole song is over
	jr nz, .noise
	ld a, $ff
	ld [wSongId], a
	jr .noise
.release3
;>     elif s == 1:                            # release: wave channel off
;>         rNR30 = 0
	ld a, $00
	ldh [rNR30], a
	jr .noise
.start3
;>     elif not rNR52 & 0x04:                  # the wave channel is silent: start the note
	ldh a, [rNR52]
	and $04
	jr nz, .glide3
;>         rNR31 = wSongCh3[7]
	ld hl, wSongCh3 + 7
	ld c, $1b
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR32 = wSongCh3[8]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR33 = wSongCh3[9]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR30 = 0x80                        # wave channel on
	ld a, $80
	ldh [rNR30], a
;>         rNR34 = wSongCh3[10]
	ld a, [hl]
	ldh [c], a
	jr .noise
.glide3
;>     else:                                   # still playing: only the new pitch, no restart
;>         rNR33 = wSongCh3[9]
	ld a, [wSongCh3 + 9]
	ldh [rNR33], a
;>         rNR34 = wSongCh3[10] & 0x7F
	ld a, [wSongCh3 + 10]
	and $7f
	ldh [rNR34], a
.noise
;> s = wSongCh4[0] - 4
	ld a, [wSongCh4]
	sub $04
;> if s >= 0:                                 # something to write
	ret c
;>     wSongCh4[0] = s
	ld [wSongCh4], a
;>     if s == 0:                              # the part has ended: silence the channel
	cp $02
	jr z, .start4
	cp $01
	jr z, .release4
;>         rNR42 = 0x08                         # volume 0
	ld a, $08
	ldh [rNR42], a
;>         rNR44 = 0x80                         # restart: the channel goes quiet
	ld a, $80
	ldh [rNR44], a
;>         wSongChannelsLeft -= 1
	ld a, [wSongChannelsLeft]
	dec a
	ld [wSongChannelsLeft], a
;>         if wSongChannelsLeft == 0: wSongId = 0xFF   # the whole song is over
	ret nz
	ld a, $ff
	ld [wSongId], a
	ret
.release4
;>     elif s == 1:                            # release: volume 0, the envelope settings stay
;>         rNR42 = wSongCh4[8] & 0x0F
	ld a, [wSongCh4 + 8]
	and $0f
	ldh [rNR42], a
;>         rNR44 = wSongCh4[10]
	ld a, [wSongCh4 + 10]
	ldh [rNR44], a
	ret
.start4
;>     else:                                   # a new note: all its registers
;>         rNR41 = wSongCh4[7]
	ld hl, wSongCh4 + 7
	ld c, $20
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR42 = wSongCh4[8]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR43 = wSongCh4[9]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR44 = wSongCh4[10]
	ld a, [hl]
	ldh [c], a
	ret


;@ def UpdateRegistersDuringSfx()
;@ path: sound/engine
;@ The register update while a sound effect plays: the effect's two channels drive square 1 and noise;
;@ the music's square 1 and noise parts keep running but write nothing (they come back with their
;@ next note once the effect is over). Square 2 and wave play the music as usual.
;@ writes: wPanningPending, wSfxCh1, wSfxCh2, wSfxChannelsLeft, wSfxId, wSongCh1, wSongCh2, wSongCh3, wSongCh4, wSongChannelsLeft, wSongId
;@ reads: wPanningPending, wSfxCh1, wSfxCh2, wSfxChannelsLeft, wSongCh1, wSongCh2, wSongCh3, wSongCh4, wSongChannelsLeft, wSoundPanning
;@ test: skip writes the sound registers
;@ sig: eec315b3
UpdateRegistersDuringSfx::
;> if wPanningPending == 1:
	ld a, [wPanningPending]
	cp $01
	jr nz, .musicSquare1
;>     wPanningPending = 0
	ld a, $00
	ld [wPanningPending], a
;>     rNR51 = wSoundPanning | 0x99               # square 1 and noise always on both sides
	ld a, [wSoundPanning]
	or $99
	ldh [rNR51], a
.musicSquare1
;> if wSongCh1[0] != 4:
	ld a, [wSongCh1]
	cp $04
	jr z, .endedSquare1
;>     if wSongCh1[0]: wSongCh1[0] = 1               # keeps time, but writes nothing: the effect has square 1
	and a
	jr z, .doneSquare1
	ld a, $01
	ld [wSongCh1], a
	jr .doneSquare1
.endedSquare1
;> else:
;>     wSongCh1[0] = 0                           # the part has ended: count it off
	xor a
	ld [wSongCh1], a
;>     wSongChannelsLeft -= 1
	ld a, [wSongChannelsLeft]
	dec a
	ld [wSongChannelsLeft], a
;>     if wSongChannelsLeft == 0: wSongId = 0xFF
	jr nz, .doneSquare1
	ld a, $ff
	ld [wSongId], a
.doneSquare1
;> s = wSfxCh1[0] - 4
	ld a, [wSfxCh1]
	sub $04
;> if s >= 0:                                 # something to write
	jr c, .square2
;>     wSfxCh1[0] = s
	ld [wSfxCh1], a
;>     if s == 0:                              # the part has ended: silence the channel
	cp $02
	jr z, .startSfx1
	cp $01
	jr z, .releaseSfx1
;>         rNR12 = 0x08                         # volume 0
	ld a, $08
	ldh [rNR12], a
;>         rNR14 = 0x80                         # restart: the channel goes quiet
	ld a, $80
	ldh [rNR14], a
;>         wSfxChannelsLeft -= 1
	ld a, [wSfxChannelsLeft]
	dec a
	ld [wSfxChannelsLeft], a
;>         if wSfxChannelsLeft == 0:                # the effect is over
	jr nz, .square2
;>             wPanningPending = 1         # the song's panning comes back
	ld a, $01
	ld [wPanningPending], a
;>             wSfxId = 0xFF
	ld a, $ff
	ld [wSfxId], a
	jr .square2
.releaseSfx1
;>     elif s == 1:                            # release: volume 0, the envelope settings stay
;>         rNR12 = wSfxCh1[8] & 0x0F
	ld a, [wSfxCh1 + 8]
	and $0f
	ldh [rNR12], a
;>         rNR14 = wSfxCh1[10]
	ld a, [wSfxCh1 + 10]
	ldh [rNR14], a
	jr .square2
.startSfx1
;>     else:                                   # a new note: all its registers
;>         rNR10 = wSfxCh1[6]
	ld hl, wSfxCh1 + 6
	ld c, $10
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR11 = wSfxCh1[7]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR12 = wSfxCh1[8]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR13 = wSfxCh1[9]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR14 = wSfxCh1[10]
	ld a, [hli]
	ldh [c], a
.square2
;> s = wSongCh2[0] - 4
	ld a, [wSongCh2]
	sub $04
;> if s >= 0:                                 # something to write
	jr c, .wave
;>     wSongCh2[0] = s
	ld [wSongCh2], a
;>     if s == 0:                              # the part has ended: silence the channel
	cp $02
	jr z, .start2
	cp $01
	jr z, .release2
;>         rNR22 = 0x08                         # volume 0
	ld a, $08
	ldh [rNR22], a
;>         rNR24 = 0x80                         # restart: the channel goes quiet
	ld a, $80
	ldh [rNR24], a
;>         wSongChannelsLeft -= 1
	ld a, [wSongChannelsLeft]
	dec a
	ld [wSongChannelsLeft], a
;>         if wSongChannelsLeft == 0: wSongId = 0xFF   # the whole song is over
	jr nz, .wave
	ld a, $ff
	ld [wSongId], a
	jr .wave
.release2
;>     elif s == 1:                            # release: volume 0, the envelope settings stay
;>         rNR22 = wSongCh2[8] & 0x0F
	ld a, [wSongCh2 + 8]
	and $0f
	ldh [rNR22], a
;>         rNR24 = wSongCh2[10]
	ld a, [wSongCh2 + 10]
	ldh [rNR24], a
	jr .wave
.start2
;>     else:                                   # a new note: all its registers
;>         rNR21 = wSongCh2[7]
	ld hl, wSongCh2 + 7
	ld c, $16
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR22 = wSongCh2[8]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR23 = wSongCh2[9]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR24 = wSongCh2[10]
	ld a, [hl]
	ldh [c], a
.wave
;> s = wSongCh3[0] - 4
	ld a, [wSongCh3]
	sub $04
;> if s >= 0:
	jr c, .musicNoise
;>     wSongCh3[0] = s
	ld [wSongCh3], a
;>     if s == 0:                              # the part has ended: wave channel off
	cp $02
	jr z, .start3
	cp $01
	jr z, .release3
;>         rNR30 = 0
	ld a, $00
	ldh [rNR30], a
;>         wSongChannelsLeft -= 1
	ld a, [wSongChannelsLeft]
	dec a
	ld [wSongChannelsLeft], a
;>         if wSongChannelsLeft == 0: wSongId = 0xFF   # the whole song is over
	jr nz, .musicNoise
	ld a, $ff
	ld [wSongId], a
	jr .musicNoise
.release3
;>     elif s == 1:                            # release: wave channel off
;>         rNR30 = 0
	ld a, $00
	ldh [rNR30], a
	jr .musicNoise
.start3
;>     elif not rNR52 & 0x04:                  # the wave channel is silent: start the note
	ldh a, [rNR52]
	and $04
	jr nz, .glide3
;>         rNR31 = wSongCh3[7]
	ld hl, wSongCh3 + 7
	ld c, $1b
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR32 = wSongCh3[8]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR33 = wSongCh3[9]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR30 = 0x80                        # wave channel on
	ld a, $80
	ldh [rNR30], a
;>         rNR34 = wSongCh3[10]
	ld a, [hl]
	ldh [c], a
	jr .musicNoise
.glide3
;>     else:                                   # still playing: only the new pitch, no restart
;>         rNR33 = wSongCh3[9]
	ld a, [wSongCh3 + 9]
	ldh [rNR33], a
;>         rNR34 = wSongCh3[10] & 0x7F
	ld a, [wSongCh3 + 10]
	and $7f
	ldh [rNR34], a
.musicNoise
;> if wSongCh4[0] != 4:
	ld a, [wSongCh4]
	cp $04
	jr z, .endedNoise
;>     if wSongCh4[0]: wSongCh4[0] = 1               # keeps time, but writes nothing: the effect has the noise channel
	and a
	jr z, .doneNoise
	ld a, $01
	ld [wSongCh4], a
	jr .doneNoise
.endedNoise
;> else:
;>     wSongCh4[0] = 0                           # the part has ended: count it off
	xor a
	ld [wSongCh4], a
;>     wSongChannelsLeft -= 1
	ld a, [wSongChannelsLeft]
	dec a
	ld [wSongChannelsLeft], a
;>     if wSongChannelsLeft == 0: wSongId = 0xFF
	jr nz, .doneNoise
	ld a, $ff
	ld [wSongId], a
.doneNoise
;> s = wSfxCh2[0] - 4
	ld a, [wSfxCh2]
	sub $04
;> if s >= 0:                                 # something to write
	ret c
;>     wSfxCh2[0] = s
	ld [wSfxCh2], a
;>     if s == 0:                              # the part has ended: silence the channel
	cp $02
	jr z, .startSfx2
	cp $01
	jr z, .releaseSfx2
;>         rNR42 = 0x08                         # volume 0
	ld a, $08
	ldh [rNR42], a
;>         rNR44 = 0x80                         # restart: the channel goes quiet
	ld a, $80
	ldh [rNR44], a
;>         wSfxChannelsLeft -= 1
	ld a, [wSfxChannelsLeft]
	dec a
	ld [wSfxChannelsLeft], a
;>         if wSfxChannelsLeft == 0:                # the effect is over
	ret nz
;>             wPanningPending = 1         # the song's panning comes back
	ld a, $01
	ld [wPanningPending], a
;>             wSfxId = 0xFF
	ld a, $ff
	ld [wSfxId], a
	ret
.releaseSfx2
;>     elif s == 1:                            # release: volume 0, the envelope settings stay
;>         rNR42 = wSfxCh2[8] & 0x0F
	ld a, [wSfxCh2 + 8]
	and $0f
	ldh [rNR42], a
;>         rNR44 = wSfxCh2[10]
	ld a, [wSfxCh2 + 10]
	ldh [rNR44], a
	ret
.startSfx2
;>     else:                                   # a new note: all its registers
;>         rNR41 = wSfxCh2[7]
	ld hl, wSfxCh2 + 7
	ld c, $20
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR42 = wSfxCh2[8]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR43 = wSfxCh2[9]
	ld a, [hli]
	ldh [c], a
	inc c
;>         rNR44 = wSfxCh2[10]
	ld a, [hl]
	ldh [c], a
	ret


; Frequency values for the notes: note $10 (C2, 65 Hz) to $6C, a semitone apart, 11-bit numbers for
; NRx3/NRx4 (frequency = 131072 / (2048 - value) Hz). TickSound reads entry note - $10.
;@ path: sound/data/notes
NoteFrequencies::
	dw $002c, $009d, $0107, $016b, $01c9, $0223, $0277, $02c7, $0312, $0358, $039b, $03da ; C2-B2
	dw $0416, $044e, $0483, $04b5, $04e5, $0511, $053b, $0563, $0589, $05ac, $05cd, $05ed ; C3-B3
	dw $060b, $0627, $0642, $065b, $0672, $0689, $069e, $06b2, $06c4, $06d6, $06e7, $06f7 ; C4-B4
	dw $0706, $0714, $0721, $072d, $0739, $0744, $074f, $0759, $0762, $076b, $0773, $077b ; C5-B5
	dw $0783, $078a, $0790, $0797, $079d, $07a2, $07a7, $07ac, $07b1, $07b6, $07ba, $07be ; C6-B6
	dw $07c1, $07c5, $07c8, $07cb, $07ce, $07d1, $07d4, $07d6, $07d9, $07db, $07dd, $07df ; C7-B7
	dw $07e1, $07e2, $07e4, $07e6, $07e7, $07e9, $07ea, $07eb, $07ec, $07ed, $07ee, $07ef ; C8-B8
	dw $07f0, $07f1, $07f2, $07f3, $07f4, $07f4, $07f5, $07f6, $07f6 ; C9-G#9

; The instruments ($F0 n in a part picks instrument n); 9 and 12 do not exist. See InstrumentData.

;@ path: sound/data/instruments
InstrumentTable::
	dw Instrument00, Instrument01, Instrument02, Instrument03, Instrument04, Instrument05, Instrument06, Instrument07, Instrument08, 0
	dw Instrument0A, Instrument0B, 0, Instrument0D, Instrument0E, Instrument0F, Instrument10, Instrument11, Instrument12, Instrument13

; Instruments: five values for the channel's registers NRx0-NRx4 (NRx0 = sweep, square 1 only; NRx1 =
; duty / length; NRx2 = volume and envelope; NRx3 and the low bits of NRx4 are replaced by the note's
; frequency; NRx4 bit 6 = stop after the length), then a mode byte: 0 plain; 1 volume steps (a byte:
; frames per step, then four volumes the note steps through, the last one stays); 2 a counter that
; changes nothing (a byte); 3 and up early release (a byte: the note is cut that many frames before
; its end). Instruments $10-$13 are for the wave channel (NR30-NR34; $11-$13 stop after a length).

;@ path: sound/data/instruments
InstrumentData::
Instrument00:
	db $08, $40, $f4, $00, $80, $00 ; duty 25%, volume 15, envelope down every 4/64 s
Instrument01:
	db $08, $00, $a0, $00, $80, $00 ; duty 12.5%, volume 10, steady
Instrument02:
	db $08, $80, $f4, $00, $80, $00 ; duty 50%, volume 15, envelope down every 4/64 s
Instrument03:
	db $08, $40, $a0, $00, $80, $00 ; duty 25%, volume 10, steady
Instrument04:
	db $08, $40, $f1, $00, $80, $00 ; duty 25%, volume 15, envelope down every 1/64 s
Instrument05:
	db $08, $40, $f2, $00, $80, $00 ; duty 25%, volume 15, envelope down every 2/64 s
Instrument06:
	db $08, $00, $f0, $00, $80, $00 ; duty 12.5%, volume 15, steady
Instrument07:
	db $1e, $80, $f0, $00, $80, $00 ; duty 50%, volume 15, steady, sweep down by 1/64 every 1/128 s (square 1)
Instrument08:
	db $08, $40, $f0, $00, $80, $00 ; duty 25%, volume 15, steady
Instrument0A:
	db $08, $40, $f0, $00, $80, $01, $04, $0a, $06, $03, $02 ; duty 25%, volume 15, steady; volume steps every 4 frames: 10, 6, 3, 2
Instrument0B:
	db $08, $00, $f0, $00, $80, $01, $04, $05, $03, $02, $02 ; duty 12.5%, volume 15, steady; volume steps every 4 frames: 5, 3, 2, 2
Instrument0D:
	db $7c, $40, $f2, $00, $80, $00 ; duty 25%, volume 15, envelope down every 2/64 s, sweep down by 1/16 every 7/128 s (square 1)
Instrument0E:
	db $4d, $80, $f4, $00, $80, $00 ; duty 50%, volume 15, envelope down every 4/64 s, sweep down by 1/32 every 4/128 s (square 1)
Instrument0F:
	db $08, $80, $f0, $00, $80, $01, $04, $0f, $09, $05, $02 ; duty 50%, volume 15, steady; volume steps every 4 frames: 15, 9, 5, 2
Instrument10:
	db $80, $00, $20, $00, $80, $03, $02 ; wave, length off, volume full; released 2 frames before the end
Instrument11:
	db $80, $d0, $20, $00, $c0, $00, $00 ; wave, length 48, volume full; (the last byte is not used)
Instrument12:
	db $80, $e0, $20, $00, $c0, $00, $00 ; wave, length 32, volume full; (the last byte is not used)
Instrument13:
	db $80, $f0, $20, $00, $c0, $00, $00 ; wave, length 16, volume full; (the last byte is not used)

; Drum sounds for the noise channel: a noise part's note $34 + n plays drum n, four values for
; NR41-NR44 (length, volume and envelope, noise frequency and width, restart / stop after the length).

;@ path: sound/data/drums
NoiseDrums::
	db $3c, $f0, $01, $c0 ; drum 0 (note $34): volume 15, steady, noise $01, stops after 4/256 s
	db $00, $f0, $62, $80 ; drum 1 (note $35): volume 15, steady, noise $62
	db $3c, $f0, $04, $c0 ; drum 2 (note $36): volume 15, steady, noise $04, stops after 4/256 s
	db $00, $f3, $52, $80 ; drum 3 (note $37): volume 15, envelope down every 3/64 s, noise $52
	db $3c, $f0, $07, $c0 ; drum 4 (note $38): volume 15, steady, noise $07, stops after 4/256 s
	db $00, $f2, $00, $80 ; drum 5 (note $39): volume 15, envelope down every 2/64 s, noise $00
	db $00, $f1, $51, $80 ; drum 6 (note $3A): volume 15, envelope down every 1/64 s, noise $51
	db $00, $f1, $47, $80 ; drum 7 (note $3B): volume 15, envelope down every 1/64 s, noise $47
	db $00, $f0, $00, $80 ; drum 8 (note $3C): volume 15, steady, noise $00
	db $00, $93, $34, $80 ; drum 9 (note $3D): volume 9, envelope down every 3/64 s, noise $34
	db $00, $f0, $00, $80 ; drum A (note $3E): volume 15, steady, noise $00
	db $00, $b6, $37, $80 ; drum B (note $3F): volume 11, envelope down every 6/64 s, noise $37

; PlaySong's song numbers $00-$14 -> song headers. Most numbers that the game never plays point to
; the field music. A header: tempo (subtracted from each note timer once a frame), the note length
; table, a note pointer for each channel (square 1, square 2, wave, noise; 0 = no part).
; Part bytes: $00-$DF a note: high nibble = length (an index into the song's length table; the timer
; gets length x 8, so a note lasts length x 8 / tempo frames; $Dx: a 16-bit length follows instead),
; low nibble = pitch: 0-5 and 7 that many semitones up from the last note, $A-$F 6 to 1 down, 6 an
; absolute note number follows (NoteFrequencies; on the noise channel note $34 + n = drum n), 8 rest,
; 9 tie (the sounding note just lasts longer). Commands: $F0 n instrument, $F1 n panning (rNR51),
; $E0 n repeat the part up to $E1 n times, $E2 n the following plays in pass n only (the last pass
; closes the repeat), $FE start the part over, $FF end of the part.

;@ path: sound/music
SongTable::
	dw SongFieldHeader, SongFieldHeader, SongFieldHeader, SongFieldHeader
	dw SongFieldHeader, SongFieldHeader, SongDragonHeader, SongFieldHeader
	dw SongFlyingHeader, SongFieldHeader, SongFieldHeader, SongPhaseStartHeader
	dw SongPhaseClearHeader, SongFieldHeader, SongFieldHeader, SongPauseHeader
	dw SongWarpOutHeader, SongWarpInHeader, SongTransformHeader, SongWarpLandingHeader
	dw SongTakeOffHeader

; Song $01: Field music. PlayFieldMusic: on the map (also ids $00-$05, $07, $09, $0A, $0D, $0E: they point to this song).

;@ path: sound/music/field
SongFieldHeader::
	db 16 ; tempo
	dw SongFieldData ; note lengths
	dw SongFieldSquare1, SongFieldSquare2, SongFieldWave, 0 ; parts: square 1, square 2, wave, noise

; Song $06: Dragon music. PlayFieldMusic after the dragon has been beaten three times (hDragonKills = 3), first after its third defeat.

;@ path: sound/music/dragon
SongDragonHeader::
	db 4 ; tempo
	dw SongDragonData ; note lengths
	dw SongDragonSquare1, SongDragonSquare2, SongDragonWave, 0 ; parts: square 1, square 2, wave, noise

; Field music: the note lengths (x 8 timer units; at tempo 16 one unit of the table is 8 / 16 frames),
; then the parts. Comments: pitch / length index (- rest, ~ tie, dN drum N).

;@ path: sound/music/field
SongFieldData::
	dw $0060, $0030, $0018, $0024, $000c, $0048, $00c0
SongFieldSquare1:
	db $f1, $ff ; panning $FF
	db $f0, $06 ; instrument $06
	db $e0, $02 ; repeat 2 times:
	db $08 ; -/0
	db $f0, $04 ; instrument $04
	db $16, $36, $16, $2f, $22, $21, $1d, $16, $36, $16, $2f, $22 ; D5/1 G4/1 A4/2 A#4/2 G4/1 D5/1 G4/1 A4/2
	db $21, $32, $42, $2e, $2e, $2f, $2e, $1e ; A#4/2 C5/3 D5/4 C5/2 A#4/2 A4/2 G4/2 F4/1
	db $36, $34, $42, $2e, $2e, $2f, $2c, $12, $33 ; C5/3 D5/4 C5/2 A#4/2 A4/2 F4/2 G4/1 A#4/3
	db $42, $2e, $2f, $2e, $2e, $12, $33, $42 ; C5/4 A#4/2 A4/2 G4/2 F4/2 G4/1 A#4/3 C5/4
	db $2e, $2f, $2e, $2e, $1e, $24, $2e, $1e ; A#4/2 A4/2 G4/2 F4/2 D#4/1 G4/2 F4/2 D#4/1
	db $24, $2e, $20, $2e, $2f, $2e, $1e, $24 ; G4/2 F4/2 F4/2 D#4/2 D4/2 C4/2 A#3/1 D4/2
	db $2e, $1e, $12, $1d, $11 ; C4/2 A#3/1 C4/1 A3/1 A#3/1
	db $e1 ; end of repeat
	db $e0, $02 ; repeat 2 times:
	db $f0, $05 ; instrument $05
	db $16, $36, $1e, $1e, $1f, $1e, $16, $28, $05 ; D5/1 C5/1 A#4/1 A4/1 G4/1 C4/1 F4/0
	db $e1 ; end of repeat
	db $e0, $02 ; repeat 2 times:
	db $f0, $00 ; instrument $00
	db $26, $32, $24, $2c, $24, $26, $2f, $23, $2d, $23 ; A#4/2 D5/2 A#4/2 D5/2 G4/2 A#4/2 G4/2 A#4/2
	db $26, $2b, $24, $26, $28, $23, $2f, $23, $26, $26, $28 ; D#4/2 G4/2 C4/2 D#4/2 D4/2 F4/2 A#3/2 -/2
	db $e1 ; end of repeat
	db $fe ; loop: back to the start
SongFieldSquare2:
	db $f0, $08 ; instrument $08
	db $e0, $02 ; repeat 2 times:
	db $e0, $02 ; repeat 2 times:
	db $f0, $04 ; instrument $04
	db $16, $42, $16, $3b, $22, $21, $1d ; D6/1 G5/1 A5/2 A#5/2 G5/1
	db $e1 ; end of repeat
	db $e0, $02 ; repeat 2 times:
	db $36, $40, $42, $2e, $2e, $2f, $2e, $1e ; C6/3 D6/4 C6/2 A#5/2 A5/2 G5/2 F5/1
	db $e1 ; end of repeat
	db $e0, $02 ; repeat 2 times:
	db $36, $3e, $42, $2e, $2f, $2e, $2e, $1e ; A#5/3 C6/4 A#5/2 A5/2 G5/2 F5/2 D#5/1
	db $e1 ; end of repeat
	db $24, $2e, $1e, $24, $2e, $1e, $2f, $2e ; G5/2 F5/2 D#5/1 G5/2 F5/2 D#5/1 D5/2 C5/2
	db $1e, $24, $2e, $1e, $12, $1d, $08 ; A#4/1 D5/2 C5/2 A#4/1 C5/1 A4/1 -/0
	db $e1 ; end of repeat
	db $e0, $02 ; repeat 2 times:
	db $f0, $04 ; instrument $04
	db $26, $3e, $44, $4c, $20, $44, $4c, $2d, $43 ; A#5/2 D6/4 A#5/4 A#5/2 D6/4 A#5/4 G5/2 A#5/4
	db $4d, $20, $43, $4d, $2c, $44, $4c, $4d ; G5/4 G5/2 A#5/4 G5/4 D#5/2 G5/4 D#5/4 C5/4
	db $42, $41, $42, $2d, $2e, $1e ; D5/4 D#5/4 F5/4 D5/2 C5/2 A#4/1
	db $e1 ; end of repeat
	db $e0, $02 ; repeat 2 times:
	db $f0, $00 ; instrument $00
	db $e0, $02 ; repeat 2 times:
	db $46, $3d, $41, $44, $4c ; A5/4 A#5/4 D6/4 A#5/4
	db $e1 ; end of repeat
	db $e0, $02 ; repeat 2 times:
	db $46, $3a, $41, $43, $4d ; F#5/4 G5/4 A#5/4 G5/4
	db $e1 ; end of repeat
	db $4b, $41, $44, $4c, $4f, $41, $42, $42 ; D5/4 D#5/4 G5/4 D#5/4 D5/4 D#5/4 F5/4 G5/4
	db $4b, $41 ; D5/4 D#5/4
	db $e2, $01 ; pass 1 only:
	db $46, $39, $4d, $2c, $28 ; F5/4 D5/4 A#4/2 -/2
	db $e1 ; end of repeat
	db $e2, $02 ; pass 2 only:
	db $46, $36, $4e, $2e, $28 ; D5/4 C5/4 A#4/2 -/2
	db $fe ; loop: back to the start
SongFieldWave:
	db $f0, $10 ; instrument $10
	db $e0, $02 ; repeat 2 times:
	db $f0, $12 ; instrument $12
	db $e0, $04 ; repeat 4 times:
	db $16, $2f, $16, $36 ; G4/1 D5/1
	db $e1 ; end of repeat
	db $e0, $04 ; repeat 4 times:
	db $16, $2d, $16, $34 ; F4/1 C5/1
	db $e1 ; end of repeat
	db $e0, $05 ; repeat 5 times:
	db $16, $2b, $16, $32 ; D#4/1 A#4/1
	db $e1 ; end of repeat
	db $16, $2b, $16, $32, $16, $26, $16, $2d, $16, $26, $16, $2d, $1e, $1d ; D#4/1 A#4/1 A#3/1 F4/1 A#3/1 F4/1 D#4/1 C4/1
	db $12, $1c ; D4/1 A#3/1
	db $e1 ; end of repeat
	db $e0, $02 ; repeat 2 times:
	db $f0, $13 ; instrument $13
	db $26, $3b, $23, $2d, $23, $26, $37, $24, $2c, $24 ; G5/2 A#5/2 G5/2 A#5/2 D#5/2 G5/2 D#5/2 G5/2
	db $26, $34, $23, $26, $2d, $26, $34, $26, $26, $26, $32, $26, $26, $26, $32 ; C5/2 D#5/2 F4/2 C5/2 A#3/2 A#4/2 A#3/2 A#4/2
	db $e1 ; end of repeat
	db $e0, $02 ; repeat 2 times:
	db $f0, $10 ; instrument $10
	db $26, $2f, $26, $3b, $26, $2d, $26, $39, $26, $2b, $26, $37, $26, $2a, $26, $36 ; G4/2 G5/2 F4/2 F5/2 D#4/2 D#5/2 D4/2 D5/2
	db $26, $28, $26, $34, $26, $2d, $26, $39 ; C4/2 C5/2 F4/2 F5/2
	db $e2, $01 ; pass 1 only:
	db $26, $26, $26, $32, $26, $26, $26, $32 ; A#3/2 A#4/2 A#3/2 A#4/2
	db $e1 ; end of repeat
	db $e2, $02 ; pass 2 only:
	db $26, $32, $20, $20, $28 ; A#4/2 A#4/2 A#4/2 -/2
	db $fe ; loop: back to the start

; Dragon music: the note lengths (x 8 timer units; at tempo 4 one unit of the table is 8 / 4 frames),
; then the parts. Comments: pitch / length index (- rest, ~ tie, dN drum N).

;@ path: sound/music/dragon
SongDragonData::
	dw $0018, $0008, $0030, $000c, $0024, $0006, $0004, $0060
SongDragonSquare1:
	db $f1, $ff ; panning $FF
	db $f0, $0b ; instrument $0B
	db $06, $1c, $16, $28, $16, $37, $1d, $10, $1b, $10, $1c ; C3/0 C4/1 D#5/1 C5/1 C5/1 G4/1 G4/1 D#4/1
	db $1d, $10, $0b ; C4/1 C4/1 G3/0
	db $e0, $02 ; repeat 2 times:
	db $16, $2a, $16, $36, $1d, $1c, $1e, $10, $1d, $1d ; D4/1 D5/1 B4/1 G4/1 F4/1 F4/1 D4/1 B3/1
	db $10 ; B3/1
	db $e2, $01 ; pass 1 only:
	db $06, $1b ; B2/0
	db $e1 ; end of repeat
	db $e2, $02 ; pass 2 only:
	db $06, $1c, $16, $2b, $16, $37, $1d, $10, $1b, $10, $1c ; C3/0 D#4/1 D#5/1 C5/1 C5/1 G4/1 G4/1 D#4/1
	db $1d, $10, $2b, $21, $0b, $16, $2f, $16, $3b, $1c ; C4/1 C4/1 G3/2 G#3/2 D#3/0 G4/1 G5/1 D#5/1
	db $10, $1b, $10, $1d, $1c, $10, $06, $1e, $16, $2a ; D#5/1 A#4/1 A#4/1 G4/1 D#4/1 D#4/1 D3/0 D4/1
	db $16, $36, $1c, $10, $1b, $10, $1d, $1c, $10 ; D5/1 A#4/1 A#4/1 F4/1 F4/1 D4/1 A#3/1 A#3/1
	db $3d, $45, $36, $21, $46, $28, $3b, $35, $16, $1f, $16, $2b ; G3/3 C4/4 F3/3 C4/4 G3/3 C4/3 D#3/1 D#4/1
	db $1d, $10, $1b, $10, $1c, $1d, $10 ; C4/1 C4/1 G3/1 G3/1 D#3/1 C3/1 C3/1
	db $fe ; loop: back to the start
SongDragonSquare2:
	db $f0, $0b ; instrument $0B
	db $06, $28, $16, $2f, $16, $3b, $1c, $10, $1d, $10, $1b ; C4/0 G4/1 G5/1 D#5/1 D#5/1 C5/1 C5/1 G4/1
	db $10, $1c ; G4/1 D#4/1
	db $e0, $02 ; repeat 2 times:
	db $06, $2a, $13, $16, $39, $1d, $1d, $1c, $10, $1e ; D4/0 F4/1 F5/1 D5/1 B4/1 G4/1 G4/1 F4/1
	db $1d, $10 ; D4/1 D4/1
	db $e1 ; end of repeat
	db $01, $14, $16, $3b, $1c, $10, $1d, $10, $1b ; D#4/0 G4/1 G5/1 D#5/1 D#5/1 C5/1 C5/1 G4/1
	db $1c, $10, $2b, $22, $0e, $16, $32, $16, $3e, $1d ; D#4/1 D#4/1 A#3/2 C4/2 A#3/0 A#4/1 A#5/1 G5/1
	db $10, $1c, $10, $1b, $1d, $10, $0e, $10 ; G5/1 D#5/1 D#5/1 A#4/1 G4/1 G4/1 F4/0 F4/1
	db $16, $39, $1d, $10, $1c, $10, $1b, $1d, $10 ; F5/1 D5/1 D5/1 A#4/1 A#4/1 F4/1 D4/1 D4/1
	db $56, $3b, $5c, $4d, $56, $3c, $5d, $4b, $56, $3b, $5c ; G5/5 D#5/5 C5/4 G#5/5 F5/5 C5/4 G5/5 D#5/5
	db $3d, $16, $23, $16, $2f, $1c, $10, $1d, $10, $1b ; C5/3 G3/1 G4/1 D#4/1 D#4/1 C4/1 C4/1 G3/1
	db $1c, $10 ; D#3/1 D#3/1
	db $fe ; loop: back to the start
SongDragonWave:
	db $f0, $10 ; instrument $10
	db $06, $3b, $05, $00, $50, $52, $31, $0f, $06, $3b ; G5/0 C6/0 C6/0 C6/5 D6/5 D#6/3 D6/0 G5/0
	db $00, $60, $61, $6f, $5f, $51, $00, $06, $42 ; G5/0 G5/6 G#5/6 G5/6 F#5/5 G5/5 G5/0 D6/0
	db $00, $50, $51, $32, $0e, $0d, $00, $60 ; D6/0 D6/5 D#6/5 F6/3 D#6/0 C6/0 C6/0 C6/6
	db $62, $6e, $5f, $51, $23, $20, $24, $0e ; D6/6 C6/6 B5/5 C6/5 D#6/2 D#6/2 G6/2 F6/0
	db $0e, $7f, $2e, $3f, $31, $32, $3d, $71 ; D#6/0 D6/7 C6/2 B5/3 C6/3 D6/3 B5/3 C6/7
	db $fe ; loop: back to the start

; Song $08: Flying. CastFly: plays while the hero flies, until he lands.

;@ path: sound/music/flying
SongFlyingHeader::
	db 12 ; tempo
	dw SongFlyingData ; note lengths
	dw SongFlyingSquare1, SongFlyingSquare2, SongFlyingWave, 0 ; parts: square 1, square 2, wave, noise

; Song $0B: Phase start. StartGame / ContinueGame: the "PHASE n / START !" screen.

;@ path: sound/music/phase_start
SongPhaseStartHeader::
	db 15 ; tempo
	dw SongPhaseStartData ; note lengths
	dw SongPhaseStartSquare1, SongPhaseStartSquare2, 0, 0 ; parts: square 1, square 2, wave, noise

; Song $0C: Phase clear. PhaseClear: played twice while the phase-clear screen waits.

;@ path: sound/music/phase_clear
SongPhaseClearHeader::
	db 32 ; tempo
	dw SongPhaseClearData ; note lengths
	dw SongPhaseClearSquare1, SongPhaseClearSquare2, SongPhaseClearWave, SongPhaseClearNoise ; parts: square 1, square 2, wave, noise

; Song $0F: Pause. PauseGame: pausing and unpausing.
;@ path: sound/music/pause
SongPauseHeader::
	db 32 ; tempo
	dw SongPauseData ; note lengths
	dw SongPauseSquare1, SongPauseSquare2, 0, 0 ; parts: square 1, square 2, wave, noise

; Flying: the note lengths (x 8 timer units; at tempo 12 one unit of the table is 8 / 12 frames),
; then the parts. Comments: pitch / length index (- rest, ~ tie, dN drum N).

;@ path: sound/music/flying
SongFlyingData::
	dw $0018, $0120, $0090, $0048, $0030, $00c0, $01b0, $0108
SongFlyingSquare1:
	db $f1, $ff ; panning $FF
	db $f0, $0a ; instrument $0A
	db $e0, $02 ; repeat 2 times:
	db $06, $25, $06, $35, $00, $06, $25, $06, $35, $00, $06, $2c, $06, $36 ; A3/0 C#5/0 C#5/0 A3/0 C#5/0 C#5/0 E4/0 D5/0
	db $00, $06, $25, $06, $35, $00 ; D5/0 A3/0 C#5/0 C#5/0
	db $e2, $01 ; pass 1 only:
	db $06, $25, $06, $35, $00, $06, $25, $06, $35, $00, $06, $29, $06, $35 ; A3/0 C#5/0 C#5/0 A3/0 C#5/0 C#5/0 C#4/0 C#5/0
	db $00, $06, $22, $06, $35, $00 ; C#5/0 F#3/0 C#5/0 C#5/0
	db $e1 ; end of repeat
	db $e2, $02 ; pass 2 only:
	db $06, $1d, $06, $35, $00, $06, $29, $06, $35, $00, $0b, $06, $37 ; C#3/0 C#5/0 C#5/0 C#4/0 C#5/0 C#5/0 G#4/0 D#5/0
	db $00, $06, $29, $06, $38, $02 ; D#5/0 C#4/0 E5/0 F#5/0
	db $fe ; loop: back to the start
SongFlyingSquare2:
	db $f0, $0b ; instrument $0B
	db $e0, $02 ; repeat 2 times:
	db $06, $38, $06, $44, $0e, $0f, $0e, $0e, $0f, $01 ; E5/0 E6/0 D6/0 C#6/0 B5/0 A5/0 G#5/0 A5/0
	db $02, $0e, $0b, $00, $00, $06, $44 ; B5/0 A5/0 E5/0 E5/0 E5/0 E6/0
	db $e2, $01 ; pass 1 only:
	db $06, $42, $0f, $0e, $0e, $0f, $01, $02, $0e ; D6/0 C#6/0 B5/0 A5/0 G#5/0 A5/0 B5/0 A5/0
	db $0d, $00 ; F#5/0 F#5/0
	db $e1 ; end of repeat
	db $e2, $02 ; pass 2 only:
	db $06, $43, $0e, $0e, $0e, $0f, $02, $02, $03 ; D#6/0 C#6/0 B5/0 A5/0 G#5/0 A#5/0 C6/0 D#6/0
	db $0e, $00 ; C#6/0 C#6/0
	db $fe ; loop: back to the start
SongFlyingWave:
	db $f0, $10 ; instrument $10
	db $66, $44, $31, $41, $0b, $73, $02, $42, $0e ; E6/6 F6/3 F#6/4 C#6/0 E6/7 F#6/0 G#6/4 F#6/0
	db $0e, $0f, $0e, $0f, $01, $02, $03, $0e ; E6/0 D#6/0 C#6/0 C6/0 C#6/0 D#6/0 F#6/0 E6/0
	db $02 ; F#6/0
	db $fe ; loop: back to the start

; Phase start: the note lengths (x 8 timer units; at tempo 15 one unit of the table is 8 / 15 frames),
; then the parts. Comments: pitch / length index (- rest, ~ tie, dN drum N).

;@ path: sound/music/phase_start
SongPhaseStartData::
	dw $000c, $0018, $0024, $0030
SongPhaseStartSquare1:
	db $f1, $ff ; panning $FF
	db $f0, $0a ; instrument $0A
	db $08, $16, $1e, $15, $16, $2a, $15, $16, $36, $15, $16, $42 ; -/0 D3/1 G3/1 D4/1 G4/1 D5/1 G5/1 D6/1
	db $15, $26, $4e ; G6/1 D7/2
	db $ff ; end
SongPhaseStartSquare2:
	db $f0, $0a ; instrument $0A
	db $16, $1a, $16, $21, $15, $16, $2d, $15, $16, $39, $15, $16, $45 ; A#2/1 F3/1 A#3/1 F4/1 A#4/1 F5/1 A#5/1 F6/1
	db $35 ; A#6/3
	db $ff ; end

; Phase clear: the note lengths (x 8 timer units; at tempo 32 one unit of the table is 8 / 32 frames),
; then the parts. Comments: pitch / length index (- rest, ~ tie, dN drum N).

;@ path: sound/music/phase_clear
SongPhaseClearData::
	dw $0018, $0024, $0009, $0003, $0030, $0060
SongPhaseClearSquare1:
	db $f1, $7e ; panning $7E
	db $f0, $05 ; instrument $05
	db $e0, $02 ; repeat 2 times:
	db $06, $34, $02, $12, $29, $38, $40, $41, $5f ; C5/0 D5/0 E5/1 ~/2 -/3 E5/4 F5/4 E5/5
	db $10, $29, $38, $10, $29, $38, $40, $4e ; E5/1 ~/2 -/3 E5/1 ~/2 -/3 E5/4 D5/4
	db $5e, $0d, $02, $11, $29, $38, $40, $42 ; C5/5 A4/0 B4/0 C5/1 ~/2 -/3 C5/4 D5/4
	db $5e, $4f, $11, $29, $38, $40 ; C5/5 B4/4 C5/1 ~/2 -/3 C5/4
	db $e2, $01 ; pass 1 only:
	db $46, $30, $5c ; G#4/4 E4/5
	db $e1 ; end of repeat
	db $e2, $02 ; pass 2 only:
	db $46, $2d, $52 ; F4/4 G4/5
	db $ff ; end
SongPhaseClearSquare2:
	db $f0, $05 ; instrument $05
	db $e0, $02 ; repeat 2 times:
	db $06, $38, $01, $12, $29, $38, $40, $42, $5e ; E5/0 F5/0 G5/1 ~/2 -/3 G5/4 A5/4 G5/5
	db $45, $1b, $29, $38, $40, $4e, $5f, $0c ; C6/4 G5/1 ~/2 -/3 G5/4 F5/4 E5/5 C5/0
	db $02, $12, $29, $38, $40, $41, $5f, $43 ; D5/0 E5/1 ~/2 -/3 E5/4 F5/4 E5/5 G5/4
	db $1d, $29, $38, $40, $4e, $5e ; E5/1 ~/2 -/3 E5/4 D5/4 C5/5
	db $e1 ; end of repeat
	db $ff ; end
SongPhaseClearWave:
	db $f0, $10 ; instrument $10
	db $e0, $02 ; repeat 2 times:
	db $56, $34, $50, $50, $44, $4c, $40, $4b, $55 ; C5/5 C5/5 C5/5 E5/4 C5/4 C5/4 G4/4 C5/5
	db $5d, $50, $50, $4e, $45, $40 ; A4/5 A4/5 A4/5 G4/4 C5/4 C5/4
	db $e2, $01 ; pass 1 only:
	db $46, $38, $56, $31 ; E5/4 A4/5
	db $e1 ; end of repeat
	db $e2, $02 ; pass 2 only:
	db $46, $2f, $55 ; G4/4 C5/5
	db $ff ; end
SongPhaseClearNoise:
	db $e0, $04 ; repeat 4 times:
	db $56, $36, $50, $50, $40, $40, $40, $40, $53 ; d2/5 d2/5 d2/5 d2/4 d2/4 d2/4 d2/4 d5/5
	db $e1 ; end of repeat
	db $ff ; end

; Pause: the note lengths (x 8 timer units; at tempo 32 one unit of the table is 8 / 32 frames),
; then the parts. Comments: pitch / length index (- rest, ~ tie, dN drum N).

;@ path: sound/music/pause
SongPauseData::
	dw $000c, $0018, $0060
SongPauseSquare1:
	db $f0, $0a ; instrument $0A
	db $08, $16, $37, $06, $3e, $29 ; -/0 D#5/1 A#5/0 ~/2
	db $ff ; end
SongPauseSquare2:
	db $f1, $ff ; panning $FF
	db $f0, $0a ; instrument $0A
	db $16, $34, $16, $3b, $26, $42 ; C5/1 G5/1 D6/2
	db $ff ; end

; Song $10: Into a warp. EnterWarp: the hero vanishes.

;@ path: sound/music/warp_out
SongWarpOutHeader::
	db 21 ; tempo
	dw SongWarpOutData ; note lengths
	dw SongWarpOutSquare1, SongWarpOutSquare2, SongWarpOutWave, 0 ; parts: square 1, square 2, wave, noise

; Song $11: Out of a warp. EnterWarp: the hero appears at the other end.

;@ path: sound/music/warp_in
SongWarpInHeader::
	db 21 ; tempo
	dw SongWarpInData ; note lengths
	dw SongWarpInSquare1, SongWarpInSquare2, SongWarpInWave, 0 ; parts: square 1, square 2, wave, noise

; Song $12: The hero changes. TakeOrDropItem: the item on cell 6 changes the hero for good.

;@ path: sound/music/transform
SongTransformHeader::
	db 24 ; tempo
	dw SongTransformData ; note lengths
	dw SongTransformSquare1, SongTransformSquare2, SongTransformWave, 0 ; parts: square 1, square 2, wave, noise

; Song $13: Jump / return spell landing. WarpHeroTo: the end of the jump and return spells.

;@ path: sound/music/warp_landing
SongWarpLandingHeader::
	db 48 ; tempo
	dw SongWarpLandingData ; note lengths
	dw SongWarpLandingSquare1, SongWarpLandingSquare2, SongWarpLandingWave, 0 ; parts: square 1, square 2, wave, noise

; Song $14: Fly spell take-off. CastFly: the hero lifts off.

;@ path: sound/music/take_off
SongTakeOffHeader::
	db 34 ; tempo
	dw SongTakeOffData ; note lengths
	dw SongTakeOffSquare1, SongTakeOffSquare2, 0, 0 ; parts: square 1, square 2, wave, noise

; Into a warp: the note lengths (x 8 timer units; at tempo 21 one unit of the table is 8 / 21 frames),
; then the parts. Comments: pitch / length index (- rest, ~ tie, dN drum N).

;@ path: sound/music/warp_out
SongWarpOutData::
	dw $000c, $0018, $0060
SongWarpOutSquare1:
	db $f1, $ff ; panning $FF
	db $f0, $0a ; instrument $0A
	db $08, $16, $3d, $16, $37, $16, $31, $06, $2b, $29 ; -/0 A5/1 D#5/1 A4/1 D#4/0 ~/2
	db $ff ; end
SongWarpOutSquare2:
	db $f0, $0a ; instrument $0A
	db $16, $40, $16, $3a, $16, $34, $16, $2e, $26, $28 ; C6/1 F#5/1 C5/1 F#4/1 C4/2
	db $ff ; end
SongWarpOutWave:
	db $f0, $10 ; instrument $10
	db $06, $43, $0d, $0d, $0d, $0d, $0d, $0d, $0d ; D#6/0 C6/0 A5/0 F#5/0 D#5/0 C5/0 A4/0 F#4/0
	db $2d ; D#4/2
	db $ff ; end

; Out of a warp: the note lengths (x 8 timer units; at tempo 21 one unit of the table is 8 / 21 frames),
; then the parts. Comments: pitch / length index (- rest, ~ tie, dN drum N).

;@ path: sound/music/warp_in
SongWarpInData::
	dw $000c, $0018, $0090, $0006
SongWarpInSquare1:
	db $f1, $ff ; panning $FF
	db $f0, $0a ; instrument $0A
	db $08, $16, $2b, $16, $31, $16, $37, $06, $3d, $0c, $26, $40 ; -/0 D#4/1 A4/1 D#5/1 A5/0 F5/0 C6/2
	db $ff ; end
SongWarpInSquare2:
	db $f0, $0a ; instrument $0A
	db $16, $28, $16, $2e, $16, $34, $16, $3a, $38, $33, $29 ; C4/1 F#4/1 C5/1 F#5/1 -/3 A5/3 ~/2
	db $ff ; end
SongWarpInWave:
	db $f0, $10 ; instrument $10
	db $06, $2b, $03, $03, $03, $03, $03, $03, $03 ; D#4/0 F#4/0 A4/0 C5/0 D#5/0 F#5/0 A5/0 C6/0
	db $26, $39 ; F5/2
	db $ff ; end

; The hero changes: the note lengths (x 8 timer units; at tempo 24 one unit of the table is 8 / 24 frames),
; then the parts. Comments: pitch / length index (- rest, ~ tie, dN drum N).

;@ path: sound/music/transform
SongTransformData::
	dw $000c, $0060, $0030
SongTransformSquare1:
	db $f1, $ff ; panning $FF
	db $f0, $0a ; instrument $0A
	db $06, $39, $01, $0f, $01, $1f, $28 ; F5/0 F#5/0 F5/0 F#5/0 F5/1 -/2
	db $ff ; end
SongTransformSquare2:
	db $f0, $0a ; instrument $0A
	db $06, $42, $0f, $01, $0f, $11, $28 ; D6/0 C#6/0 D6/0 C#6/0 D6/1 -/2
	db $ff ; end
SongTransformWave:
	db $f0, $10 ; instrument $10
	db $06, $32, $06, $26, $06, $32, $06, $26, $16, $32, $28 ; A#4/0 A#3/0 A#4/0 A#3/0 A#4/1 -/2
	db $ff ; end

; Jump / return spell landing: the note lengths (x 8 timer units; at tempo 48 one unit of the table is 8 / 48 frames),
; then the parts. Comments: pitch / length index (- rest, ~ tie, dN drum N).

;@ path: sound/music/warp_landing
SongWarpLandingData::
	dw $000c, $0018, $0030, $0060
SongWarpLandingSquare1:
	db $f1, $ff ; panning $FF
	db $f0, $0a ; instrument $0A
	db $08 ; -/0
	db $e0, $07 ; repeat 7 times:
	db $16, $39, $1f ; F5/1 E5/1
	db $e1 ; end of repeat
	db $11, $0f, $21 ; F5/1 E5/0 F5/2
	db $ff ; end
SongWarpLandingSquare2:
	db $f0, $0a ; instrument $0A
	db $e0, $08 ; repeat 8 times:
	db $16, $3c, $1f ; G#5/1 G5/1
	db $e1 ; end of repeat
	db $31, $28 ; G#5/3 -/2
	db $ff ; end
SongWarpLandingWave:
	db $f0, $10 ; instrument $10
	db $e0, $08 ; repeat 8 times:
	db $16, $35, $1f ; C#5/1 C5/1
	db $e1 ; end of repeat
	db $3f ; B4/3
	db $ff ; end

; Fly spell take-off: the note lengths (x 8 timer units; at tempo 34 one unit of the table is 8 / 34 frames),
; then the parts. Comments: pitch / length index (- rest, ~ tie, dN drum N).

;@ path: sound/music/take_off
SongTakeOffData::
	dw $000c, $0018, $0024
SongTakeOffSquare1:
	db $f1, $ff ; panning $FF
	db $f0, $0a ; instrument $0A
	db $08 ; -/0
	db $e0, $0a ; repeat 10 times:
	db $16, $3d, $10 ; A5/1 A5/1
	db $e1 ; end of repeat
	db $10, $10, $20 ; A5/1 A5/1 A5/2
	db $ff ; end
SongTakeOffSquare2:
	db $f0, $0a ; instrument $0A
	db $e0, $06 ; repeat 6 times:
	db $16, $31, $16, $49, $16, $31, $16, $49 ; A4/1 A6/1 A4/1 A6/1
	db $e1 ; end of repeat
	db $ff ; end

; PlaySfx's effect numbers $00-$0E -> effect headers: tempo, note length table, the square 1 part and
; the noise part (0 = none). The parts use the song format.

;@ path: sound/sfx
SfxTable::
	dw SfxCrumbleHeader, SfxBumpHeader, SfxFreezeHeader, SfxFlashHeader
	dw SfxItemHeader, SfxFindHeader, SfxMarkerHeader, SfxThiefHeader
	dw SfxPitHeader, SfxMonsterAttackHeader, SfxWeakBlowHeader, SfxBlowHeader
	dw SfxLightHitHeader, SfxHitHeader, SfxVanishHeader

; Effect $00: A wall crumbles. CrumbleWallAhead.
;@ path: sound/sfx/crumble
SfxCrumbleHeader::
	db 80 ; tempo
	dw SfxCrumbleData ; note lengths
	dw SfxCrumbleSquare, SfxCrumbleNoise ; parts: square 1, noise

; Effect $01: The hero pushes against a wall. KickWallAhead.

;@ path: sound/sfx/bump
SfxBumpHeader::
	db 64 ; tempo
	dw SfxBumpData ; note lengths
	dw SfxBumpSquare, 0 ; parts: square 1, noise

; Effect $02: Freeze spell. CastFreeze.

;@ path: sound/sfx/freeze
SfxFreezeHeader::
	db 64 ; tempo
	dw SfxFreezeData ; note lengths
	dw SfxFreezeSquare, SfxFreezeNoise ; parts: square 1, noise

; Effect $03: Flash spell. CastFlash.

;@ path: sound/sfx/flash
SfxFlashHeader::
	db 80 ; tempo
	dw SfxFlashData ; note lengths
	dw SfxFlashSquare, SfxFlashNoise ; parts: square 1, noise

; Effect $04: Item taken or used up. TakeOrDropItem.

;@ path: sound/sfx/item
SfxItemHeader::
	db 21 ; tempo
	dw SfxItemData ; note lengths
	dw SfxItemSquare, 0 ; parts: square 1, noise

; Effect $05: A find or gold; the dragon flashes. TakeOrDropItem, DragonFlash.

;@ path: sound/sfx/find
SfxFindHeader::
	db 48 ; tempo
	dw SfxFindData ; note lengths
	dw SfxFindSquare, 0 ; parts: square 1, noise

; Effect $06: The marker wakes up. AfterHeroStep.

;@ path: sound/sfx/marker
SfxMarkerHeader::
	db 16 ; tempo
	dw SfxMarkerData ; note lengths
	dw SfxMarkerSquare, 0 ; parts: square 1, noise

; Effect $07: A thief comes into view. BuildSprites.

;@ path: sound/sfx/thief
SfxThiefHeader::
	db 10 ; tempo
	dw SfxThiefData ; note lengths
	dw SfxThiefSquare, 0 ; parts: square 1, noise

; A wall crumbles: note lengths, then the parts (same format as the songs).

;@ path: sound/sfx/crumble
SfxCrumbleData::
	dw $000c, $0030, $0090
SfxCrumbleSquare:
	db $f0, $04 ; instrument $04
	db $06, $29, $01, $01, $01, $11, $16, $25 ; C#4/0 D4/0 D#4/0 E4/0 F4/1 A3/1
	db $ff ; end
SfxCrumbleNoise:
	db $26, $3b ; d7/2
	db $ff ; end

; The hero pushes against a wall: note lengths, then the parts (same format as the songs).

;@ path: sound/sfx/bump
SfxBumpData::
	dw $000c
SfxBumpSquare:
	db $f0, $02 ; instrument $02
	db $06, $2d, $08, $06, $34 ; F4/0 -/0 C5/0
	db $ff ; end

; Freeze spell: note lengths, then the parts (same format as the songs).

;@ path: sound/sfx/freeze
SfxFreezeData::
	dw $0030, $00c0, $0120
SfxFreezeSquare:
	db $f0, $0d ; instrument $0D
	db $06, $40, $00, $10 ; C6/0 C6/0 C6/1
	db $ff ; end
SfxFreezeNoise:
	db $26, $3d ; d9/2
	db $ff ; end

; Flash spell: note lengths, then the parts (same format as the songs).

;@ path: sound/sfx/flash
SfxFlashData::
	dw $000c, $00c0
SfxFlashSquare:
	db $f0, $02 ; instrument $02
	db $e0, $03 ; repeat 3 times:
	db $06, $1c, $03, $03, $03, $03, $03, $03, $03 ; C3/0 D#3/0 F#3/0 A3/0 C4/0 D#4/0 F#4/0 A4/0
	db $03, $03, $03, $03, $03, $03, $03, $03 ; C5/0 D#5/0 F#5/0 A5/0 C6/0 D#6/0 F#6/0 A6/0
	db $e1 ; end of repeat
	db $ff ; end
SfxFlashNoise:
	db $16, $3f, $19, $10 ; dB/1 ~/1 dB/1
	db $ff ; end

; Item taken or used up: note lengths, then the parts (same format as the songs).

;@ path: sound/sfx/item
SfxItemData::
	dw $0006, $0060
SfxItemSquare:
	db $f0, $0f ; instrument $0F
	db $06, $44, $04, $03, $15 ; E6/0 G#6/0 B6/0 E7/1
	db $ff ; end

; A find or gold; the dragon flashes: note lengths, then the parts (same format as the songs).

;@ path: sound/sfx/find
SfxFindData::
	dw $000c, $00c0
SfxFindSquare:
	db $f0, $0f ; instrument $0F
	db $06, $47, $03, $06, $43, $0b, $16, $45 ; G6/0 A#6/0 D#6/0 A#5/0 F6/1
	db $ff ; end

; The marker wakes up: note lengths, then the parts (same format as the songs).

;@ path: sound/sfx/marker
SfxMarkerData::
	dw $0030
SfxMarkerSquare:
	db $f0, $0d ; instrument $0D
	db $06, $2c ; E4/0
	db $ff ; end

; A thief comes into view: note lengths, then the parts (same format as the songs).

;@ path: sound/sfx/thief
SfxThiefData::
	dw $000c, $0018
SfxThiefSquare:
	db $f0, $0d ; instrument $0D
	db $06, $3b, $05, $0b, $05, $0b, $15 ; G5/0 C6/0 G5/0 C6/0 G5/0 C6/1
	db $ff ; end

; Effect $08: The hero falls into a pit. StepOnPit.

;@ path: sound/sfx/pit
SfxPitHeader::
	db 48 ; tempo
	dw SfxPitData ; note lengths
	dw SfxPitSquare, 0 ; parts: square 1, noise

; Effect $09: A monster attacks. TurnEnd.

;@ path: sound/sfx/monsterattack
SfxMonsterAttackHeader::
	db 10 ; tempo
	dw SfxMonsterAttackData ; note lengths
	dw SfxMonsterAttackSquare, SfxMonsterAttackNoise ; parts: square 1, noise

; Effect $0A: The hero's blow does no damage (it counts as 1). AttackObject.

;@ path: sound/sfx/weakblow
SfxWeakBlowHeader::
	db 32 ; tempo
	dw SfxWeakBlowData ; note lengths
	dw SfxWeakBlowSquare, 0 ; parts: square 1, noise

; Effect $0B: The hero's blow hits. AttackObject.

;@ path: sound/sfx/blow
SfxBlowHeader::
	db 80 ; tempo
	dw SfxBlowData ; note lengths
	dw SfxBlowSquare, SfxBlowNoise ; parts: square 1, noise

; Effect $0C: The hero is hit lightly (no damage, or a potion stolen). TurnEnd.

;@ path: sound/sfx/lighthit
SfxLightHitHeader::
	db 32 ; tempo
	dw SfxLightHitData ; note lengths
	dw SfxLightHitSquare, 0 ; parts: square 1, noise

; Effect $0D: The hero is hit. TurnEnd.

;@ path: sound/sfx/hit
SfxHitHeader::
	db 80 ; tempo
	dw SfxHitData ; note lengths
	dw SfxHitSquare, SfxHitNoise ; parts: square 1, noise

; Effect $0E: A monster vanishes. AttackObject (defeated), PhaseClear (all monsters at the end).
;@ path: sound/sfx/vanish
SfxVanishHeader::
	db 48 ; tempo
	dw SfxVanishData ; note lengths
	dw SfxVanishSquare, 0 ; parts: square 1, noise

; The hero falls into a pit: note lengths, then the parts (same format as the songs).

;@ path: sound/sfx/pit
SfxPitData::
	dw $000c
SfxPitSquare:
	db $f0, $00 ; instrument $00
	db $06, $34, $01, $01, $01, $0d, $01, $02, $01 ; C5/0 C#5/0 D5/0 D#5/0 C5/0 C#5/0 D#5/0 E5/0
	db $0c, $01, $03, $01, $0b, $01, $04, $01 ; C5/0 C#5/0 E5/0 F5/0 C5/0 C#5/0 F5/0 F#5/0
	db $ff ; end

; A monster attacks: note lengths, then the parts (same format as the songs).

;@ path: sound/sfx/monsterattack
SfxMonsterAttackData::
	dw $0006, $0030
SfxMonsterAttackSquare:
	db $f0, $0e ; instrument $0E
	db $e0, $04 ; repeat 4 times:
	db $06, $23, $06, $1c ; G3/0 C3/0
	db $e1 ; end of repeat
	db $16, $23 ; G3/1
	db $ff ; end
SfxMonsterAttackNoise:
	db $16, $35, $12 ; d1/1 d3/1
	db $ff ; end

; The hero's blow does no damage (it counts as 1): note lengths, then the parts (same format as the songs).

;@ path: sound/sfx/weakblow
SfxWeakBlowData::
	dw $000c, $0018
SfxWeakBlowSquare:
	db $f0, $07 ; instrument $07
	db $06, $2c, $0d, $1d ; E4/0 C#4/0 A#3/1
	db $ff ; end

; The hero's blow hits: note lengths, then the parts (same format as the songs).

;@ path: sound/sfx/blow
SfxBlowData::
	dw $000c, $0024, $0090
SfxBlowSquare:
	db $f0, $0d ; instrument $0D
	db $06, $15, $05, $05, $05, $05, $05, $05, $05 ; F2/0 A#2/0 D#3/0 G#3/0 C#4/0 F#4/0 B4/0 E5/0
	db $05, $03, $0d, $1b ; A5/0 C6/0 A5/0 E5/1
	db $ff ; end
SfxBlowNoise:
	db $26, $3a ; d6/2
	db $ff ; end

; The hero is hit lightly (no damage, or a potion stolen): note lengths, then the parts (same format as the songs).

;@ path: sound/sfx/lighthit
SfxLightHitData::
	dw $000c, $0018
SfxLightHitSquare:
	db $f0, $07 ; instrument $07
	db $06, $3b, $0d, $1d ; G5/0 E5/0 C#5/1
	db $ff ; end

; The hero is hit: note lengths, then the parts (same format as the songs).
;@ path: sound/sfx/hit
SfxHitData::
	dw $000c, $0024, $0090
SfxHitSquare:
	db $f0, $0d ; instrument $0D
	db $06, $1c, $05, $05, $05, $05, $05, $05, $05 ; C3/0 F3/0 A#3/0 D#4/0 G#4/0 C#5/0 F#5/0 B5/0
	db $05, $03, $0d, $1b ; E6/0 G6/0 E6/0 B5/1
	db $ff ; end
SfxHitNoise:
	db $26, $3a ; d6/2
	db $ff ; end

; A monster vanishes: note lengths, then the parts (same format as the songs).

;@ path: sound/sfx/vanish
SfxVanishData::
	dw $0006
SfxVanishSquare:
	db $f0, $00 ; instrument $00
	db $06, $3a, $08, $04, $08, $03, $08, $05 ; F#5/0 -/0 A#5/0 -/0 C#6/0 -/0 F#6/0
	db $ff ; end
	db $ff, $ff ; unused (the end of the ROM)
