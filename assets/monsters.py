"""The monsters: every kind's two animation frames (ObjectSpriteTiles, drawn with the sprite tiles the game
loads) next to its values from ObjectKindStats."""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from worldmap import started_game  # noqa: E402

GROUP = 'monsters'
KINDS = 32


def half(mem, tile, attr, obp):
    """An 8x16 sprite half (tile pair tile & $FE, tile | 1) as 16 rows of 8 shades; colour 0 transparent."""
    rows = []
    for y in range(16):
        r = (15 - y) if attr & 0x40 else y
        base = 0x8000 + (tile & 0xFE) * 16 + 2 * r
        lo, hi = mem[base], mem[base + 1]
        line = []
        for x in range(8):
            b = x if attr & 0x20 else 7 - x
            c = ((hi >> b) & 1) << 1 | ((lo >> b) & 1)
            line.append(255 if c == 0 else (obp >> (2 * c)) & 3)
        rows.append(line)
    return rows


def sprite(ctx, mem, entry):
    """16x16 picture of one frame: left half, right half."""
    obp = mem[0xFF48]
    lt, la, rt, ra = entry
    left, right = half(mem, lt, la, obp), half(mem, rt, ra, obp)
    rows = [bytes(a + b) for a, b in zip(left, right)]
    return {'width': 16, 'height': 16, 'pixels': ctx.pixels(rows), 'scale': 2}


def build(ctx):
    m = started_game(ctx)
    mem, rom = m.mem, ctx.project.rom
    tiles, stats = ctx.syms['ObjectSpriteTiles'], ctx.syms['ObjectKindStats']
    rows = []
    for k in range(KINDS):
        e = rom[tiles + 8 * k: tiles + 8 * k + 8]
        words = [rom[stats + 6 * k + 2 * i] << 8 | rom[stats + 6 * k + 2 * i + 1] for i in range(3)]
        rows.append([k, {'image': sprite(ctx, mem, e[0:4])}, {'image': sprite(ctx, mem, e[4:8])}] + words)
    return [{
        'name': 'monster-kinds', 'type': 'table', 'title': 'The 32 monster kinds',
        'columns': ['kind', 'frame 1', 'frame 2', 'life', 'attack', 'defence'],
        'rows': rows,
        'doc': ['Every monster kind with its two animation frames, as BuildSprites puts them on screen: '
                'ObjectSpriteTiles gives the tile and attributes of the left and the right 8x16 half for each '
                'frame, drawn here with the sprite tiles the game has loaded. The numbers are the kind\'s three '
                'big-endian words in ObjectKindStats, copied into each new monster\'s record: its life, its attack '
                '(MonsterAttack: the hero loses the attack minus his maximum hit points, at least 1) and its '
                'defence (AttackObject: a powered-up hero takes his strength minus it off the monster\'s life; '
                'otherwise every blow does just 1).'],
        'users': ['ObjectSpriteTiles', 'ObjectKindStats', 'BuildSprites', 'UpdateMonsters', 'AttackObject', 'MonsterAttack'],
    }]
