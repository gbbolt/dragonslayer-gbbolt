"""The whole world map: 80 x 100 cells, unpacked by the game itself (UnpackMap) when a game starts, each cell
asked from the game's GetCell and drawn with its four tiles from CellTiles - the tiles the game has loaded."""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from _game import Machine  # noqa: E402

GROUP = 'map'
W, H = 80, 100
A_BUTTON = 0x01


TYPES = {0: 'floor', 1: 'rock', 2: 'home', 3: 'grave', 4: 'warp', 5: 'box', 6: 'sword', 7: 'gold', 8: 'key',
         9: 'cross', 0x0A: 'jewel', 0x0B: 'jar', 0x0C: 'crown piece', 0x0D: 'potion', 0x0E: 'sleeping marker',
         0x0F: 'filler', 0x10: 'dragon', 0x11: 'dragon', 0x12: 'dragon', 0x13: 'dragon', 0x14: 'pit',
         0x17: 'WP sign'}
MARK_MAX = 20                                   # mark the rare cells; the common ones are counted in the text


def started_game(ctx, phase=0):
    m = Machine(ctx)
    for _ in range(150):
        m.frame()
    m.buttons = A_BUTTON                        # A on the title screen: a new game
    for _ in range(20):
        m.frame()
    m.buttons = 0
    for _ in range(40):                         # StartGame reads hPhase after the phase jingle: phase 2 is
        m.set('hPhase', phase)                  # what the title-screen cheat would have set
        m.frame()
    for _ in range(3000):                       # UnpackMap takes several hundred frames: wait for the last row
        m.frame()
        if any(m.mem[0xC000 + 4000 - 80 + i] & 0x0F for i in range(80)):
            break
    for _ in range(60):
        m.frame()
    return m


def tile_rows(mem, tile):
    """8 rows of 8 colour indices of a background tile ($8800 addressing: tiles 0-127 at $9000)."""
    base = 0x9000 + tile * 16 if tile < 128 else 0x8800 + (tile - 128) * 16
    out = []
    for y in range(8):
        lo, hi = mem[base + 2 * y], mem[base + 2 * y + 1]
        out.append([((hi >> (7 - x)) & 1) << 1 | ((lo >> (7 - x)) & 1) for x in range(8)])
    return out


def build(ctx):
    return [phase_map(ctx, 0), phase_map(ctx, 1)]


def phase_map(ctx, phase):
    m = started_game(ctx, phase)
    mem = m.mem
    bgp = mem[0xFF47]
    shade = [(bgp >> (2 * c)) & 3 for c in range(4)]
    cell_tiles = ctx.syms['CellTiles']
    types = []
    for pos in range(W * H):
        m.run.call('GetCell', hl=0xC000 + pos)
        types.append(m.cpu.a)
    pictures = {}
    rows = [bytearray(W * 16) for _ in range(H * 16)]
    for i, t in enumerate(types):
        if t not in pictures:
            tl, tr, bl, br = (tile_rows(mem, ctx.project.rom[cell_tiles + 4 * t + k]) for k in range(4))
            pictures[t] = [a + b for a, b in zip(tl, tr)] + [a + b for a, b in zip(bl, br)]
        cy, cx = divmod(i, W)
        for y, line in enumerate(pictures[t]):
            row = rows[cy * 16 + y]
            for x, c in enumerate(line):
                row[cx * 16 + x] = shade[c]
    counts = {}
    for t in types:
        counts[t] = counts.get(t, 0) + 1
    marks = []
    for i, t in enumerate(types):
        if counts[t] <= MARK_MAX:
            cy, cx = divmod(i, W)
            marks.append({'x': cx * 16, 'y': cy * 16, 'w': 16, 'h': 16,
                          'label': TYPES.get(t, 'type ${:02X}'.format(t)),
                          'text': 'row {}, column {} (map position ${:04X})'.format(cy, cx, 0xC000 + i)})
    name = 'Phase{}Map'.format(phase + 1)
    return {
        'name': 'world-map-{}'.format(phase + 1), 'type': 'image', 'title': 'World map, phase {}'.format(phase + 1),
        'width': W * 16, 'height': H * 16, 'packed': 'zlib', 'pixels': ctx.packed_pixels(rows),
        'scale': 1, 'scroll': True, 'marks': marks,
        'doc': ['The whole world of phase {}, 80 cells wide and 100 high, as the game holds it in wMap after '
                'UnpackMap has unpacked {} at the start of the phase: each cell asked from the game\'s own GetCell '
                'and drawn with its picture from CellTiles (four tiles per cell). The screen shows a window of '
                '10 x 9 cells of it at a time and scrolls cell by cell (ScrollView). The rare cells are marked.'
                .format(phase + 1, name),
                'Cells on this map: ' + ', '.join('{} {}'.format(n, TYPES.get(t, 'type ${:02X}'.format(t)))
                                                  for t, n in sorted(counts.items(), key=lambda x: -x[1])) + '.'],
        'users': ['UnpackMap', name, 'GetCell', 'CellTiles', 'DrawMetatile', 'wMap'],
    }
