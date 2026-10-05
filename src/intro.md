# From power-on to the first step

What the code does between switching the Game Boy on and the hero taking his first step on the
map, in the order it happens.

## Power on

The CPU starts at `Boot`, which jumps to `Init`: it sets the stack, copies the OAM DMA routine into
HRAM (`OAMDMARoutine`; during a DMA the CPU can only run code from there) and goes on to `Start`.
`Start` sets up the hardware and a fresh game and shows the title screen. A reset and the end of a
game come back to `Start` too.

There is no `halt` anywhere in the game. The code waits for a frame by watching flags the VBlank
interrupt changes (`WaitFrame`, `DelayFrames`).

Two interrupts do the work behind it:

- **VBlank** (`VBlankHandler`) copies the sprite buffer to OAM when the game asks for it
  (`hSysFlags` bit 7), runs the screen flashes, counts down the frame delay and a long timer, and
  reads the joypad.
- **The LCD interrupt** (`LCDStatHandler`, at a set line) runs the sound engine at line 0 of every
  frame. While the status bar is on screen it comes a second time, at line 95, and switches the
  background to the other half of the tile memory for the lines below. That is how the playfield and
  the status bar can each have a full set of tiles.

## The title screen

`TitleScreen` draws the title into the window map and runs its menu: GAME START, and after a game
over also CONTINUE. Without CONTINUE, `TitleNoContinue` simply waits for A. It also watches for a
cheat: Up, Down, Left, Right, then A starts in phase 2 instead of phase 1. The end of phase 1 gives
this away with "U.D.L.R.A".

## A new game

`NewGame` clears the map, the monster tables and HRAM. It places the home and the hero at their
starting cells and sets up the monsters (`InitObjects`), the 13 thieves (`InitThieves`) and the
dragon's four parts (`InitDragon`). The hero starts with strength 50 and a maximum of 20 hit points.
`LoadTiles` loads all the game's tiles in one go, puts the view at the map's top-left corner and sets
the hit points to 100.

`StartGame` then shows "PHASE 1 / START !" (`ShowPhaseScreen`) with its jingle and unpacks the phase's
map (`UnpackMap`). The world is 80 cells wide and 100 high, each cell 16 x 16 pixels. It is stored as
a bit stream: one bit after each cell says "the same again" or "a new value follows". A new value
takes 2 bits for floor or rock, the common cases, or 6 bits for any other type. Unpacked, the map
takes 4 bits a cell in RAM (`wMap`). Types 15 and up (the dragon, the pit, the warp signs) are kept
in side tables (`wBigCellTable`, `wBigCellList`). Unpacking the 8000 cells takes the game several
hundred frames.

## The turn

`EnterPhase` puts the hero on screen, starts the field music (`PlayFieldMusic`) and enters `MainLoop`.
From here the player is in control. The game is played in turns, and the player's half comes first:

- B against a wall breaks or kicks it, if the hero has the power for it.
- B alone opens the magic menu, Start pauses, and A takes or drops an item.
- A direction moves the hero one cell. A monster ahead is attacked (`AttackObject`). Any other cell
  is handled by its type through `CellActionTable` (`CellAction`): walk on, push a rock, enter the
  home, a warp, a pit.

Every step ends in `TurnEnd`, the monsters' half. The step is animated (`AnimateStep`): the background
scrolls 16 pixels, one pixel a frame, and the sprites move along. Only the row and the column of cells
that come into view are written to the background map (`ScrollView`), because the map in VRAM is a ring
of 16 x 16 cells. Then the thieves and monsters move, and every monster that ran into the hero gets
its attack (`ObjectTurn`). `BuildSprites` sorts the monsters on screen into near, middle and far lists
and merges them into two sprite buffers that are shown in turn, so where too many crowd onto one line
they flicker instead of vanishing. Then the turn goes back to `MainLoop` for the next button.
