; Named RAM / IO addresses.
; Format: DEF name EQU $addr ;@ type description
;   type: u8 | u16 (little endian) | u8[N] | code[N] | const
; Lines without ";@" are plain constants.

DEF wSongId EQU $D100 ;@ u8 The song playing (PlaySong's number); $FF once every channel of it has ended
DEF wSfxId EQU $D101 ;@ u8 The sound effect playing (PlaySfx's number); $FF once it has ended
DEF wSongChannelsLeft EQU $D102 ;@ u8 Music channels still running: 4 when a song starts, the song is over at 0
DEF wSfxChannelsLeft EQU $D103 ;@ u8 Effect channels still running: 2 when an effect starts, 0 = no effect (the music has all four channels)
DEF wSongTempo EQU $D104 ;@ u8 Music tempo: subtracted from each music channel's note timer once a frame
DEF wSfxTempo EQU $D105 ;@ u8 Effect tempo: subtracted from each effect channel's note timer once a frame
DEF wSoundPanning EQU $D106 ;@ u8 The rNR51 value the song or effect asked for (which channel goes to which speaker)
DEF wPanningPending EQU $D107 ;@ u8 1 = write wSoundPanning to rNR51 at the next register update; PlaySfx sets 2, which the next tick turns into 1
DEF wSoundChannel EQU $D108 ;@ u8 The channel TickSound is working on: 0-3 music (square 1, square 2, wave, noise), 4-5 effect (square 1, noise)
DEF wSongCh1 EQU $D109 ;@ u8[32] Music channel 1 (square 1): state, note pointer, timers, register values, effect and repeat data (see TickSound)
DEF wSongCh2 EQU $D129 ;@ u8[32] Music channel 2 (square 2), laid out like wSongCh1
DEF wSongCh3 EQU $D149 ;@ u8[32] Music channel 3 (wave), laid out like wSongCh1
DEF wSongCh4 EQU $D169 ;@ u8[32] Music channel 4 (noise), laid out like wSongCh1
DEF wSfxCh1 EQU $D189 ;@ u8[32] Sound effect channel on square 1, laid out like wSongCh1
DEF wSfxCh2 EQU $D1A9 ;@ u8[32] Sound effect channel on noise, laid out like wSongCh1
DEF wNoteByte EQU $D1C9 ;@ u8 The note byte TickSound is decoding
DEF wSongLengths EQU $D1D1 ;@ u16 The playing song's note length table
DEF wSfxLengths EQU $D1D3 ;@ u16 The playing effect's note length table
DEF hHeroPosHi EQU $FF92 ;@ u8 The hero's map position (big-endian with hHeroPosLo): address of his cell, $C000 + row*80 + column
DEF hHeroPosLo EQU $FF93 ;@ u8 Low byte of the hero's map position
DEF hViewPosHi EQU $FF94 ;@ u8 Map position of the top-left cell on screen (big-endian with hViewPosLo)
DEF hViewPosLo EQU $FF95 ;@ u8 Low byte of the top-left cell's map position
DEF hOldViewPosHi EQU $FF96 ;@ u8 hViewPosHi before the last scroll step
DEF hOldViewPosLo EQU $FF97 ;@ u8 hViewPosLo before the last scroll step
DEF hScrollRow EQU $FF98 ;@ u8 Background scroll in whole cells (16 pixels) down, 0-15
DEF hScrollCol EQU $FF99 ;@ u8 Background scroll in whole cells (16 pixels) right, 0-15
DEF hOldScrollRow EQU $FF9A ;@ u8 hScrollRow before the last scroll step
DEF hOldScrollCol EQU $FF9B ;@ u8 hScrollCol before the last scroll step
DEF wScrollDY EQU $D9BA ;@ u8 Rows the view moved in the last step: -1 ($FF) up, 0, 1 down
DEF wScrollDX EQU $D9BB ;@ u8 Columns the view moved in the last step: -1 ($FF) left, 0, 1 right
DEF wNewRowTop EQU $D400 ;@ u8[$20] Top tile row of a freshly built row of cells (22 tiles used)
DEF wNewRowBottom EQU $D420 ;@ u8[$20] Bottom tile row of a freshly built row of cells (22 tiles used)
DEF wNewColumn EQU $D440 ;@ u8[$24] A freshly built column of 9 cells, 4 tiles each (top-left, top-right, bottom-left, bottom-right)
DEF wMap EQU $C000 ;@ u8[$FA0] The world map, 80x100 cells of 4 bits: cell addresses $C000-$CF9F use the high nibble of their byte, $CFA0-$DF3F the low nibble of the byte $0FA0 lower
DEF wBigCellList EQU $CFA0 ;@ u8[$60] Overflow list for cell types 15 and up: 3-byte entries (address high, low, type), $FF = free
DEF wBigCellTable EQU $D200 ;@ u8[$200] Cell types 15 and up, by the low byte of the cell address: 2 bytes each (address high & $1F, type), $FF = free
DEF hCarriedItem EQU $FFA5 ;@ u8 The item the hero carries (0 = none)
DEF hPiecesCarried EQU $FFA9 ;@ u8 How many pieces (cell type $0C) the hero carries
DEF hHomePosHi EQU $FF90 ;@ u8 Map position of the hero's home (big-endian with hHomePosLo)
DEF hHomePosLo EQU $FF91 ;@ u8 Low byte of the home's map position
DEF hHPHi EQU $FFC6 ;@ u8 Hit points, high byte (big-endian with hHPLo)
DEF hHPLo EQU $FFC7 ;@ u8 Hit points, low byte
DEF hMaxHPHi EQU $FFCA ;@ u8 Maximum hit points, high byte (big-endian with hMaxHPLo)
DEF hMaxHPLo EQU $FFCB ;@ u8 Maximum hit points, low byte
DEF hTemp1 EQU $FFB7 ;@ u8 Scratch byte shared by several routines
DEF hTemp2 EQU $FFB8 ;@ u8 Scratch byte shared by several routines
DEF hTemp3 EQU $FFBD ;@ u8 Scratch byte shared by several routines
DEF hCurObjHi EQU $FFC4 ;@ u8 Address of the object record being handled (big-endian with hCurObjLo)
DEF hCurObjLo EQU $FFC5 ;@ u8 Low byte of the current object record's address
DEF hCurObjPosHi EQU $FFCC ;@ u8 Address of the current object's position field (big-endian with hCurObjPosLo)
DEF hCurObjPosLo EQU $FFCD ;@ u8 Low byte of the current object's position field address
DEF wObjects EQU $D57A ;@ u8[$380] 64 records of 14 bytes, one per monster on the map: +1 kind (bits 0-5) and flags (bit 7 = peaceful this step, bit 6 = fighting the hero), +4/+5 map position, +6/+7 the position before the last step (UndoObjectSteps puts it back)
DEF hPushedCell EQU $FFD9 ;@ u8 Cell type of the block the hero pushed last
DEF hPushFromHi EQU $FFDA ;@ u8 Map position the pushed block left (big-endian with hPushFromLo)
DEF hPushFromLo EQU $FFDB ;@ u8 Low byte of the position the pushed block left
DEF hPushToHi EQU $FFDC ;@ u8 Map position the pushed block moved to (big-endian with hPushToLo)
DEF hPushToLo EQU $FFDD ;@ u8 Low byte of the position the pushed block moved to
DEF wSavedObjSprites EQU $DBBA ;@ u8[$98] Copy of the object sprites, put back by RestoreObjectSprites
DEF wDragon EQU $D48C ;@ u8[$38] The dragon, 4 object records of 14 bytes (kinds $21-$24): the head and the three parts of its body in the row below
DEF wThieves EQU $D4C4 ;@ u8[$B6] 13 thief records of 14 bytes (kind $20): they fly over walls, pick up items and steal what the hero carries; +8 turn timer, +9 cell type of the item carried
DEF hObjRow EQU $FF9E ;@ u8 Row of the object ObjDistance looked at, on the 13x13 grid around the view (rows 2-10 visible, the hero at 6)
DEF hObjCol EQU $FF9F ;@ u8 Column of the object ObjDistance looked at, on the 13x13 grid around the view (columns 2-11 visible, the hero at 7)
DEF hCellYX EQU $FFBB ;@ u8 Screen cell being drawn or tested: row+1 in the high nibble, column+1 in the low (grid of hObjRow/hObjCol); UpdateMonsters uses it as its slot counter
DEF hThiefCount EQU $FFD0 ;@ u8 How many thieves are out: grows with the hero's strength, all 13 from stage 3 on
DEF hMonsterParity EQU $FFD1 ;@ u8 Flips with every step the hero takes; while he walks only the monsters of one parity move each frame
DEF hVisibleObjects EQU $FFD2 ;@ u8 Objects on screen that BuildSprites still has to draw (counted while the objects move)
DEF hOffscreenMoves EQU $FFD3 ;@ u8 Off-screen monsters moved in this UpdateMonsters call (at most 8)
DEF hNextMonster EQU $FFD4 ;@ u8 Slot UpdateMonsters starts with (even; advances past the off-screen monsters it moved)
DEF hMarkRow EQU $FFD5 ;@ u8 Screen row (0-8) of the marker sprite (tile $E4); 0 = none, $FF = place it on the hero
DEF hMarkCol EQU $FFD6 ;@ u8 Screen column (0-9) of the marker sprite
DEF hMarkDY EQU $FFD7 ;@ u8 Rows the marker sprite still slides (its motion for the scroll animation)
DEF hMarkDX EQU $FFD8 ;@ u8 Columns the marker sprite still slides
DEF hSpriteSlot EQU $FFDE ;@ u8 Last sprite slot BuildSprites filled in the first sprite list (slot 0 is the hero)
DEF hMergeTarget EQU $FFDF ;@ u8 Where BuildSprites puts the sprite being merged: 0 = first OAM buffer, 1 = second
DEF hOAMCount EQU $FFE0 ;@ u8 Sprite pairs in the first OAM buffer wOAMBuffer (at most 20)
DEF hOAM2Count EQU $FFE1 ;@ u8 Sprite pairs in the second OAM buffer (at most 20); the two buffers are shown in turn, so crowded rows flicker
DEF hMergeList EQU $FFE2 ;@ u8 Sprite list BuildSprites is merging into the OAM buffers: 0 near, 1 middle, 2 far
DEF hMergeLeft EQU $FFE3 ;@ u8 Sprites of the current list still to merge
DEF hMergeIndex EQU $FFE4 ;@ u8 Number (1-based) of the sprite being merged in the current list
DEF hRowRoom EQU $FFE5 ;@ u8[9] Sprite pairs still allowed in each of the 9 screen rows in the first OAM buffer (5 each: 10 hardware sprites a line)
DEF hRowRoom2 EQU $FFEE ;@ u8[9] Sprite pairs still allowed in each screen row in the second OAM buffer
DEF hNearCount EQU $FFF7 ;@ u8 Sprites in the near list (objects next to the hero)
DEF hMidCount EQU $FFF8 ;@ u8 Sprites in the middle list (two cells away)
DEF hFarCount EQU $FFF9 ;@ u8 Sprites in the far list (three or more cells away)
DEF hMotionPtrHi EQU $FFFB ;@ u8 Where the near list's sprite motions start in wSpriteMotion (big-endian with hMotionPtrLo)
DEF hMotionPtrLo EQU $FFFC ;@ u8 Low byte of the near list's motion pointer
DEF hDragonTile EQU $FFCE ;@ u8 Tile of the dragon head's left half; flips between $C4 and $D4 every frame to animate the head
DEF hDragonFlip EQU $FFCF ;@ u8 Attributes of the dragon head's left half; its X-flip bit toggles every frame with hDragonTile
DEF hSysFlags EQU $FFA0 ;@ u8 System flags: bit 7 = copy the sprite buffer to OAM at the next VBlank; bit 6 = the hero is powered up (his attacks do full damage); bit 0 = the VBlank handler skips the joypad and timers (a VRAM copy is under way)
DEF hDelayFrames EQU $FF8F ;@ u8 Frame countdown, decremented by the VBlank interrupt; waits poll it down to 0
DEF hButtonsNew EQU $FF8B ;@ u8 Buttons pressed since they were last taken (bit 0 A, 1 B, 2 Select, 3 Start, 4 Right, 5 Left, 6 Up, 7 Down)
DEF hButtonsHeld EQU $FF8C ;@ u8 Buttons held down at the last VBlank (same bits as hButtonsNew)
DEF hHeroDir EQU $FFA2 ;@ u8 The direction the hero moves, as joypad bits (4 right, 5 left, 6 up, 7 down; two may combine diagonally), 0 = standing
DEF hModeFlags EQU $FFA1 ;@ u8 Game flags: bit 7 = the view has been drawn (ScrollView then scrolls), bit 4 = monsters do not attack (set while RedrawMonsters runs), bit 0 = enough pieces brought home
DEF wSpriteFrame2 EQU $DA62 ;@ u8[$50] Second animation frame of each sprite pair in the first OAM buffer: 4 bytes a slot (left tile, attributes, right tile, attributes)
DEF wSpriteMotion2 EQU $D9E2 ;@ u8[$28] Motion (rows, columns: -1/0/1) of each sprite pair in the second OAM buffer, for the step animation
DEF wSpriteFrame2B EQU $DAB2 ;@ u8[$50] Second animation frame of each sprite pair in the second OAM buffer, laid out like wSpriteFrame2
DEF wOAMBuffer2 EQU $DC52 ;@ u8[$A0] Second OAM buffer (20 sprite pairs of 8 bytes), shown in turn with the first; BuildSprites also uses it for the middle list
DEF wFarMotion EQU $DA0A ;@ u8[$28] Far sprite list: motion of each sprite pair (rows, columns)
DEF wFarFrame2 EQU $DB02 ;@ u8[$50] Far sprite list: second animation frame of each sprite pair
DEF wFarSprites EQU $DCF2 ;@ u8[$A0] Far sprite list: the sprite pairs (8 bytes each) waiting to be merged into the OAM buffers
DEF wNearRows EQU $DE32 ;@ u8[8] Screen row (0-based cell row) of each sprite in the near list
DEF wMidRows EQU $DE3A ;@ u8[$10] Screen row of each sprite in the middle list
DEF wFarRows EQU $DE4A ;@ u8[$14] Screen row of each sprite in the far list
DEF wDragonVRAM EQU $D486 ;@ u8[6] Background-map addresses (big-endian) of the dragon's head and two body parts, 0 = not on screen
DEF hOAMDMA EQU $FF80 ;@ code[10] The OAM DMA routine, copied here at boot (the CPU can only run HRAM while the DMA runs); copies wOAMBuffer to OAM
DEF hPhase EQU $FF8A ;@ u8 The phase being played: 0 = phase 1, 1 = phase 2 (a cheat on the title screen starts with phase 2)
DEF hTimerHi EQU $FF8D ;@ u8 Long countdown, high byte: every time hTimerLo runs out it is decremented and hTimerLo restarts at 255
DEF hTimerLo EQU $FF8E ;@ u8 Long countdown, low byte: frames, decremented by the VBlank handler
DEF hHeroFlags EQU $FFA3 ;@ u8 Hero state flags: bit 6 resting at home, bit 5 hit by the dragon's fire, bit 4 came home this turn, bit 3 fighting the dragon, bit 2 in a fight, bits 0-1 kind of block in front of him
DEF hTurnWait EQU $FFA4 ;@ u8 Polled by the turn loop until it is 0 (never set: the loop does not actually wait)
DEF hGoldHi EQU $FFA7 ;@ u8 Gold, high byte (big-endian with hGoldLo); every gold piece becomes 50 hit points at home
DEF hGoldLo EQU $FFA8 ;@ u8 Low byte of the gold
DEF hPotionsHi EQU $FFAA ;@ u8 Potions, high byte (big-endian with hPotionsLo); one fends off an attack of a kind-4 monster, and each spell costs one
DEF hPotionsLo EQU $FFAB ;@ u8 Low byte of the potions
DEF hDragonKills EQU $FFAC ;@ u8 How often the dragon was beaten this phase (0-3); at 3 the dragon music plays
DEF hRandom EQU $FFAE ;@ u8 Random number state (Random)
DEF hFlashRounds EQU $FFB3 ;@ u8 Further 256-frame rounds of screen flashing after hFlashTimer runs out
DEF hFlashTimer EQU $FFB4 ;@ u8 Frames of screen flashing left: the VBlank handler inverts the palette every 8 frames
DEF hSavedSCY EQU $FFB5 ;@ u8 rSCY saved by SaveScroll; also borrowed as the magic menu's line count and a kicked block's position
DEF hSavedSCX EQU $FFB6 ;@ u8 rSCX saved by SaveScroll; also borrowed by the magic menu and the kick spell
DEF hCount EQU $FFB9 ;@ u8 Loop counter of the turn loop (objects left to handle) and of short animations
DEF hStrHi EQU $FFC8 ;@ u8 Strength, high byte (big-endian with hStrLo): the attack power, shown with a sword
DEF hStrLo EQU $FFC9 ;@ u8 Low byte of the strength
DEF hMenuCursor EQU $FFFD ;@ u8 Title menu cursor: 0 GAME START, 2 CONTINUE
DEF wOAMBuffer EQU $D000 ;@ u8[160] Sprite attributes copied to OAM by hOAMDMA: 40 sprites of 4 bytes (Y, X, tile, flags); the hero is sprites 0 and 1
DEF wMenuLast EQU $DE3C ;@ u8 Cursor value of the last title menu line (2: CONTINUE)
DEF hTemp7 EQU $FFBA ;@ u8 Scratch byte shared by several routines
DEF hTemp8 EQU $FFBC ;@ u8 Scratch byte shared by several routines
DEF hCarriedCell EQU $FFA6 ;@ u8 Map cell type of the item the hero carries; it goes back onto the map when he drops it or a thief steals it
DEF hStepCount EQU $FFAD ;@ u8 Counts the hero's steps (wraps at 256)
DEF hJumpPosHi EQU $FFAF ;@ u8 Map position the jump spell takes the hero to (big-endian with hJumpPosLo)
DEF hJumpPosLo EQU $FFB0 ;@ u8 Low byte of the jump spell's target position
DEF hFlyTime EQU $FFB1 ;@ u8 Flight left while the fly spell lasts: counts down once a second and once a step (0 = walking)
DEF hKickRange EQU $FFB2 ;@ u8 Cells an off-screen kicked block may still slide
DEF wMarkCellHi EQU $D8FA ;@ u8 Map position where the marker goes back on the map as cell $0E (big-endian with wMarkCellLo): the hero's cell after each step
DEF wMarkCellLo EQU $D8FB ;@ u8 Low byte of the marker's map position
DEF wMarkWokeCell EQU $D8FC ;@ u8 Cell type that lay under the cell $0E when the marker woke up
DEF wHiddenCells EQU $D8FD ;@ u8[$BD] What lies under the sleeping markers (cells $0E): 63 entries of map position (big-endian, 0 = free) and cell type
DEF wSavedOAM EQU $DD92 ;@ u8[$A0] Copy of wOAMBuffer kept while the map spell shows the whole map
DEF wMapSavedSCX EQU $DE33 ;@ u8 rSCX saved while the map spell shows the whole map
DEF wMapCellHi EQU $DE34 ;@ u8 Map spell: map position of the next cell to draw (big-endian with wMapCellLo)
DEF wMapCellLo EQU $DE35 ;@ u8 Low byte of wMapCellHi
DEF wMapCountHi EQU $DE36 ;@ u8 Map spell: cells drawn so far (big-endian with wMapCountLo)
DEF wMapCountLo EQU $DE37 ;@ u8 Low byte of wMapCountHi
DEF wMapTilesHi EQU $DE38 ;@ u8 Map spell: tiles written to VRAM so far (big-endian with wMapTilesLo)
DEF wMapTilesLo EQU $DE39 ;@ u8 Low byte of wMapTilesHi
DEF wMapHomeX EQU $DE3B ;@ u8 Map spell: sprite X of the home marker
DEF wMapHeroX EQU $DE3D ;@ u8 Map spell: sprite X of the hero marker
DEF wMapVram8Hi EQU $DE3E ;@ u8 Map spell: where the next tile goes in VRAM $8000-$8FFF (big-endian with wMapVram8Lo)
DEF wMapVram8Lo EQU $DE3F ;@ u8 Low byte of wMapVram8Hi
DEF wMapVram9Hi EQU $DE40 ;@ u8 Map spell: where the next tile goes in VRAM $9000-$97FF (big-endian with wMapVram9Lo)
DEF wMapVram9Lo EQU $DE41 ;@ u8 Low byte of wMapVram9Hi
DEF wMapBGHi EQU $DE42 ;@ u8 Map spell: next tile-map row in the $9C00 map (big-endian with wMapBGLo)
DEF wMapBGLo EQU $DE43 ;@ u8 Low byte of wMapBGHi
DEF wMapRowTiles EQU $DE44 ;@ u8[$140] Map spell: the 20 tiles of the tile row being drawn (16 bytes each)
DEF wMapLineHi EQU $DF84 ;@ u8 Map spell: start of the pixel-line pair being drawn in wMapRowTiles (big-endian with wMapLineLo)
DEF wMapLineLo EQU $DF85 ;@ u8 Low byte of wMapLineHi
DEF wMapTileHi EQU $DF86 ;@ u8 Map spell: the bytes of the current tile being drawn in wMapRowTiles (big-endian with wMapTileLo)
DEF wMapTileLo EQU $DF87 ;@ u8 Low byte of wMapTileHi
DEF wOAMCopy EQU $DBB2 ;@ u8[$A0] Copy of wOAMBuffer that AnimateStep moves pixel by pixel and shows from; wSavedObjSprites is its part from slot 1 on
DEF hStepMovers EQU $FFE6 ;@ u8 During a step: sprite pairs of the first list that move with it (borrows the hRowRoom area)
DEF hStepShowList2 EQU $FFE8 ;@ u8 During a step: 1 = show the second sprite list this frame, 0 = the first (they take turns)
DEF hStepMovers2 EQU $FFEF ;@ u8 During a step: sprite pairs of the second list that move with it
DEF DRAGON_HEAD_POS EQU $DBC5 ;@ const Map position of the dragon's head (row 88, column 69)
DEF DRAGON_LEFT_POS EQU $DC14 ;@ const Map position of the dragon's left body part (row 89, column 68)
DEF DRAGON_RIGHT_POS EQU $DC16 ;@ const Map position of the dragon's right body part (row 89, column 70)
DEF hPictureOverride EQU $FFC3 ;@ u8 1 + the picture number the object drawing code uses instead of the current object kind; 0 = use the kind
DEF hMagicCursor EQU $FFFE ;@ u8 Line of the cursor in the magic menu (1 = quit, 2 = jump, ... 9 = fly); kept between casts
DEF hStatusWinLeft EQU $FFBF ;@ u8 Tiles of each status window row left of the background map's wrap (DrawWindow's d), for closing it
DEF hStatusWinRight EQU $FFC0 ;@ u8 Tiles of each status window row after the wrap (DrawWindow's e)
DEF hMonsterWinLeft EQU $FFC1 ;@ u8 Tiles of each monster window row left of the background map's wrap, for closing it
DEF hMonsterWinRight EQU $FFC2 ;@ u8 Tiles of each monster window row after the wrap
DEF wWindowUnder2 EQU $DD5A ;@ u8[$40] A throwaway save of the background under a window that is redrawn while it is already open (borrows the far sprite list)
DEF A_BUTTON EQU $01 ;@ const The A button's bit in hButtonsHeld / hButtonsNew
DEF B_BUTTON EQU $02 ;@ const The B button's bit in hButtonsHeld / hButtonsNew
DEF SELECT EQU $04 ;@ const The Select button's bit in hButtonsHeld / hButtonsNew
DEF START EQU $08 ;@ const The Start button's bit in hButtonsHeld / hButtonsNew
DEF RIGHT EQU $10 ;@ const Right on the D-pad: its bit in hButtonsHeld / hButtonsNew (and in hHeroDir)
DEF LEFT EQU $20 ;@ const Left on the D-pad: its bit in hButtonsHeld / hButtonsNew (and in hHeroDir)
DEF UP EQU $40 ;@ const Up on the D-pad: its bit in hButtonsHeld / hButtonsNew (and in hHeroDir)
DEF DOWN EQU $80 ;@ const Down on the D-pad: its bit in hButtonsHeld / hButtonsNew (and in hHeroDir)
