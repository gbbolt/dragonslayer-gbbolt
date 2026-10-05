# Dragon Slayer I (Game Boy) - gbbolt disassembly

**Open it: <https://gbbolt.lingora.org/dragonslayer/>**

A complete, matching disassembly of *Dragon Slayer I* for the Game Boy (Nihon Falcom / Epoch, 1990,
Japan), with pseudo-code written next to every function and checked against the original code in an
emulator. It is read with [gbbolt](https://github.com/gbbolt/gbbolt): code and pseudo-code
side by side, each short piece of Python directly above the few instructions that do it.

- **306 of 306 code units** have pseudo-code. 110 are verified by differential testing: the
  pseudo-code and the original code give identical results on 64 random machine states. The other
  196 are checked: they wait for frames, draw whole screens or run the turn loop, so they can't run
  in isolation.
- **Every routine, table and RAM variable is named**, and everything sits in a virtual folder
  (`game/turn`, `map/unpack`, `monsters/thieves`, `player/magic/map`, `sound/music`, ...).
- **Both world maps, unpacked by the game itself**: 80 x 100 cells each, with the home, the graves,
  the warps, the sword, the key, the pit and the dragon marked. The packing (a bit stream of runs, two
  bits for floor or rock, six for anything else) is fully decoded.
- **The 32 monster kinds** with their two animation frames and their values.
- **Sound**: the sound engine is fully annotated. Its 11 songs and 15 sound effects are rendered from
  it, with a piano roll and mute / solo per channel.

Some things the code shows:

- Up, Down, Left, Right, then A on the title screen starts in phase 2; the end of phase 1 gives it
  away as "U.D.L.R.A".
- The game never halts. A turn is the hero's move, then every monster's; the screen scrolls a whole
  16-pixel cell with every step.
- The background map in VRAM is a ring of 16 x 16 cells: a step only writes the row and the column of
  cells that come into view.
- Two sprite buffers are shown in turn, five sprite pairs per line each, so crowded monsters flicker
  instead of disappearing.
- The LCD interrupt switches the tile set in the middle of the screen, so the playfield and the status
  bar each have a full set of tiles.
- Thieves fly over walls, wrap around the edges of the map and steal what the hero carries.
- Cell types from 15 up are kept in side tables, but the search in one of them can never succeed: it
  compares against a different form of the address than the one stored.
- One of the sound engine's instrument modes never releases its note: the check tests a flag that the
  instruction before it doesn't set.

## Building

The disassembly rebuilds the original ROM byte for byte. You need
[RGBDS](https://rgbds.gbdev.io) 1.0.1, Python 3.9+ with numpy, and gbbolt next to this folder:

```
git clone https://github.com/gbbolt/gbbolt
git clone https://github.com/gbbolt/dragonslayer-gbbolt
cd dragonslayer-gbbolt
python ../gbbolt/tools/audio.py             # render the music (needs ffmpeg)
python ../gbbolt/tools/gbbolt.py            # build, verify, write out/site/index.html
```

The build is checked against the SHA1 of the original ROM
(`7d987446f67d8bee42482a4932d0fa60318238e4`, *Dragon Slayer I (Japan)*). No ROM is needed to build it.
If you put your own dump next to `game.json` as `dragonslayer.gb`, it is compared byte by byte.

## Layout

```
game.json           what gbbolt needs to know about the game
src/game.asm        the main file
src/bank_000.asm    the disassembly with its annotations
src/ram.inc         RAM variables: names, types, descriptions
src/hardware.inc    hardware registers
src/folders.txt     the virtual folders
src/intro.md        the book's first chapter: from power-on to the first step
src/sound.json      how to drive the sound engine
assets/*.py         asset plugins: title screen, world maps, monsters
```

## Legal

Dragon Slayer and its code, graphics and music are the property of their respective owners (Nihon
Falcom; published on the Game Boy by Epoch). This repository contains no ROM. It is a research and
documentation project in the tradition of other community disassemblies; please buy the game.

The annotations, names, pseudo-code, descriptions, plugins and configuration written for this project
are available under the MIT license (see [LICENSE](LICENSE)), as far as they are separable from the
game itself.
