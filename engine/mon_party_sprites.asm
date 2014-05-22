AnimatePartyMon_ForceSpeed1: ; 716f7 (1c:56f7)
	xor a
	ld [wCurrentMenuItem], a ; $cc26
	ld b, a
	inc a
	jr GetAnimationSpeed

; $cf1f contains the party mon's health bar colors
; 0: green
; 1: yellow
; 2: red
AnimatePartyMon: ; 716ff (1c:56ff)
	ld hl, $cf1f
	ld a, [wCurrentMenuItem]
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]

GetAnimationSpeed: ; 7170a (1c:570a)
	ld c, a
	ld hl, PartyMonSpeeds
	add hl, bc
	ld a, [$cf1b]
	xor $1
	add [hl]
	ld c, a
	add a
	ld b, a
	ld a, [W_SUBANIMTRANSFORM] ; $d08b
	and a
	jr z, .resetSprites
	cp c
	jr z, .animateSprite
.incTimer
	inc a
	cp b
	jr nz, .resetTimer
	xor a
.resetTimer
	ld [W_SUBANIMTRANSFORM], a ; $d08b
	jp DelayFrame
.resetSprites
	push bc
	ld hl, $cc5b
	ld de, wOAMBuffer
	ld bc, $60
	call CopyData
	pop bc
	xor a
	jr .incTimer
.animateSprite
	push bc
	ld hl, $c302 ; OAM tile id
	ld bc, $10
	ld a, [wCurrentMenuItem]
	call AddNTimes
	ld c, $40 ; amount to increase the tile id by
	ld a, [hl]
	cp $4 ; tile ID for SPRITE_BALL_M
	jr z, .editCoords
	cp $8 ; tile ID for SPRITE_HELIX
	jr nz, .editTileIDS
; SPRITE_BALL_M and SPRITE_HELIX only shake up and down
.editCoords
	dec hl
	dec hl ; dec hl to the OAM y coord
	ld c, $1 ; amount to increase the y coord by
; otherwise, load a second sprite frame
.editTileIDS
	ld b, $4
	ld de, $4
.loop
	ld a, [hl]
	add c
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop
	pop bc
	ld a, c
	jr .incTimer

PartyMonSpeeds: ; 71769 (1c:5769)
	db $05,$10,$20

Func_7176c: ; 7176c (1c:576c)
	ld hl, MonPartySpritePointers ; $57c0
	ld a, $1c

Func_71771: ; 71771 (1c:5771)
	ld bc, $0
.asm_71774
	push af
	push bc
	push hl
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call CopyVideoData
	pop hl
	pop bc
	ld a, $6
	add c
	ld c, a
	pop af
	dec a
	jr nz, .asm_71774
	ret

Func_71791: ; 71791 (1c:5791)
	call DisableLCD
	ld hl, MonPartySpritePointers ; $57c0
	ld a, $1c
	ld bc, $0
.asm_7179c
	push af
	push bc
	push hl
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push de
	ld a, [hli]
	ld c, a
	swap c
	ld b, $0
	ld a, [hli]
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	call FarCopyData2
	pop hl
	pop bc
	ld a, $6
	add c
	ld c, a
	pop af
	dec a
	jr nz, .asm_7179c
	jp EnableLCD

MonPartySpritePointers: ; 717c0 (1c:57c0)
	dw SlowbroSprite + $c0
	db $40 / $10 ; 40 bytes
	db BANK(SlowbroSprite)
	dw $8000

	dw BallSprite
	db $80 / $10 ; $80 bytes
	db BANK(BallSprite)
	dw $8040

	dw ClefairySprite + $c0
	db $40 / $10 ; $40 bytes
	db BANK(ClefairySprite)
	dw $80C0

	dw BirdSprite + $c0
	db $40 / $10 ; $40 bytes
	db BANK(BirdSprite)
	dw $8100

	dw SeelSprite
	db $40 / $10 ; $40 bytes
	db BANK(SeelSprite)
	dw $8140

	dw MonPartySprites + $40
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $8180

	dw MonPartySprites + $50
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $81A0

	dw MonPartySprites + $60
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $81C0

	dw MonPartySprites + $70
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $81E0

	dw MonPartySprites + $80
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $8200

	dw MonPartySprites + $90
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $8220

	dw MonPartySprites + $A0
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $8240

	dw MonPartySprites + $B0
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $8260

	dw MonPartySprites + $100
	db $40 / $10 ; $40 bytes
	db BANK(MonPartySprites)
	dw $8380

	dw SlowbroSprite
	db $40 / $10 ; $40 bytes
	db BANK(SlowbroSprite)
	dw $8400

	dw BallSprite
	db $80 / $10 ; $80 bytes
	db BANK(BallSprite)
	dw $8440

	dw ClefairySprite
	db $40 / $10 ; $40 bytes
	db BANK(ClefairySprite)
	dw $84C0

	dw BirdSprite
	db $40 / $10 ; $40 bytes
	db BANK(BirdSprite)
	dw $8500

	dw SeelSprite + $C0
	db $40 / $10 ; $40 bytes
	db BANK(SeelSprite)
	dw $8540

	dw MonPartySprites
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $8580

	dw MonPartySprites + $10
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $85A0

	dw MonPartySprites + $20
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $85C0

	dw MonPartySprites + $30
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $85E0

	dw MonPartySprites + $C0
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $8600

	dw MonPartySprites + $D0
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $8620

	dw MonPartySprites + $E0
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $8640

	dw MonPartySprites + $F0
	db $10 / $10 ; $10 bytes
	db BANK(MonPartySprites)
	dw $8660

	dw MonPartySprites + $140
	db $40 / $10 ; $40 bytes
	db BANK(MonPartySprites)
	dw $8780

Func_71868: ; 71868 (1c:5868)
	push hl
	push de
	push bc
	ld a, [H_DOWNARROWBLINKCNT2] ; $ff8c
	ld hl, W_PARTYMON1 ; $d164
	ld e, a
	ld d, $0
	add hl, de
	ld a, [hl]
	call GetPartyMonSpriteID
	ld [$cd5b], a
	call Func_718c3
	pop bc
	pop de
	pop hl
	ret

Func_71882: ; 71882 (1c:5882)
	xor a
	ld [H_DOWNARROWBLINKCNT2], a ; $ff8c
	ld a, [$cd5d]
	call GetPartyMonSpriteID
	ld [$cd5b], a
	jr Func_718c3

Func_71890: ; 71890 (1c:5890)
	ld a, [$cf91]
	call GetPartyMonSpriteID
	push af
	ld hl, $8000
	call Func_718ac
	pop af
	add $54
	ld hl, $8040
	call Func_718ac
	xor a
	ld [$cd5d], a
	jr Func_71882

Func_718ac: ; 718ac (1c:58ac)
	push hl
	add a
	ld c, a
	ld b, $0
	ld hl, MonPartySpritePointers
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	pop hl
	jp CopyVideoData

Func_718c3: ; 718c3 (1c:58c3)
	push af
	ld c, $10
	ld h, $c3
	ld a, [H_DOWNARROWBLINKCNT2] ; $ff8c
	swap a
	ld l, a
	add $10
	ld b, a
	pop af
	cp $8
	jr z, .asm_718da
	call Func_712a6
	jr .asm_718dd
.asm_718da
	call Func_71281
.asm_718dd
	ld hl, wOAMBuffer
	ld de, $cc5b
	ld bc, $60
	jp CopyData

GetPartyMonSpriteID: ; 718e9 (1c:58e9)
	ld [$d11e], a
	ld a, $3a
	call Predef ; indirect jump to IndexToPokedex (41010 (10:5010))
	ld a, [$d11e]
	ld c, a
	dec a
	srl a
	ld hl, MonPartyData ; $590d
	ld e, a
	ld d, $0
	add hl, de
	ld a, [hl]
	bit 0, c
	jr nz, .asm_71906
	swap a
.asm_71906
	and $f0
	srl a
	srl a
	ret

INCLUDE "data/mon_party_sprites.asm"

MonPartySprites: ; 71959 (1c:5959)
	INCBIN "gfx/mon_ow_sprites.2bpp"