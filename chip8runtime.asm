; next board 4A10
    SLDOPT COMMENT WPMEM, LOGPOINT, ASSERTION

	include "chip8macros.asm"
DEBUG:  equ 0
NEX:    equ 1   ;  1=Create nex file, 0=create sna file

START   equ 24500

fakeinterrupt   equ 20         ; all x commands
reg_v0          equ 0
reg_v1          equ 1
reg_v2          equ 2
reg_v3          equ 3
reg_v4          equ 4
reg_v5          equ 5
reg_v6          equ 6
reg_v7          equ 7
reg_v8          equ 8
reg_v9          equ 9
reg_va          equ 10
reg_vb          equ 11
reg_vc          equ 12
reg_vd          equ 13
reg_ve          equ 14
reg_vf          equ 15
reg_i           equ 16
reg_sound       equ 18
reg_delay       equ 19
reg_pc          equ 22
reg_sp          equ 24
reg_fakeir      equ 26
reg_stack       equ 28
reg_hasBreakpoint equ 30

reg_stacktop    equ reg_stack + 34
reg_quit        equ reg_stacktop+1
reg_size        equ reg_stacktop+2



    IF NEX == 0
        ;DEVICE ZXSPECTRUM128
        DEVICE ZXSPECTRUM48
        ;DEVICE NOSLOT64K
    ELSE
		ORG 0x4000
		;defs 0x6000 - $    ; move after screen area
		;defs 0x8000 - $
        DEVICE ZXSPECTRUMNEXT
    ENDIF

screen_top: defb    0   ; WPMEMx

; All Sprites are 8x8 Pixels ins size without color
; Prepare Sprite lays the sprite out in 8x16 Pixel so that the sprite is shifted in 8 different positions
; For bigger sprites, more than one 8x8 Pixel Sprite must be used


; The tool is called with A = Method

MAXSPRITE				EQU 	8
OPXOR					EQU		0				; Draws the sprite with XOR
OPPOKE					EQU 	1				; Draws directly to screen
OPOR					EQU		2				; OR with screen
OPAND					EQU		3				; OR with screen

DIRLEFT					EQU		0
DIRRIGHT				EQU 	1
DIRUP					EQU		2
DIRDOWN					EQU		3

CALCLINES				EQU  	0				; NO Param
PREPARESPRITE			EQU  	1				; Prepares all Sprites A = Count
SPRITEADR				EQU 	2				; Returns pointer to Sprites
SPRITECOUNT				EQU		3				; Returns the max count of sprites in HL
DRAWSPRITE				EQU  	4				; Draws sprite. 
												; L = Number
												; B=x, C=Y, 
												; H=Operation
PREPSPRITEDATA			EQU		5				; Returns the Address of a prepared sprite

CLEARSCREEN				EQU 	6				; B = Color, C = Pixeldata

DEMO					EQU		7

PLOT					EQU		8				; PLOT B=x/C=Y
												; H = Operation

LINE					EQU		9				; B=x;C=Y;D=x1;E=y1;h=Op

SCROLL					EQU		10				; B = Direction

PRINTA 					EQU 	11				; A = Char
PRINTHL					EQU		12				; HL Points to text end with 0
LOCATE					EQU		13				; b=x;c=y


ROM_CLS                 EQU  0x0DAF             ; Clears the screen and opens channel 2
ROM_OPEN_CHANNEL        EQU  0x1601             ; Open a channel
ROM_PRINT               EQU  0x203C             ; Print a string 


	ORG START
	
main:	
; bp = ec3
	IF DEBUG == 1 
	
		ld 		sp,stack_top

	ENDIF
   

   		di
		PUSHA	
		PUSH	IX
		PUSH	IY
		call	startMain
		POP		IY
		POP		IX
		POPA
		LD		BC,chip8Memory
		ei
		ret

chip8beep:
		push	af
		push	hl
		push	bc
		push	de
		ld		hl,2
		ld		bc,30
		call	beep
		pop		de
		pop		bc
		pop		hl
		pop		af
		ret
		; bc = pause (frequency)
		; hl = duration

f0fast:
                ld      a,0
                ld      (screenOnOff),a
                ld      a,1
                ld      (updateOnInterrupt),a
                ret

f0redraw:        call    updateGameScreenDirtyLinesForce
                ret

f0slow:
               ld      a,1
                ld      (screenOnOff),a
                ret




startMain:	

	call	calcLines
	call	cls
    call    setCurrentScreenAttributes
	call	chip8Game
	ld		bc,chip8Memory

	ret

printcpu:
    PUSHA   
    ld      a,$16*8
    call    clearTextLine
    ld      a,$17*8
    call    clearTextLine
    ld      a,18*8
    call    clearTextLine
    ld      a,0
    ld      (charX),a
    ld      a,17
    ld      (charY),a
    call    printtext
    db      "0=step 9=over 8=go 7=run p=list",0
    call    newline
printcpunodb:
    ld      a,0
    ld      (charX),a
    ld      a,18
    ld      (charY),a
    call    newline


    ld      hl,cpu_registers+reg_i
    ld      b,0
    ld      c,6
printcpuloop1:
    ld      a,b
    call    printNibble
    ld      a,':'
    call    printA 
    ld      hl,cpu_registers+reg_v0
    ld      e,b
    ld      d,0
    add     hl,de
    ld      a,(hl)
    call    printHex2
    ld      a,' '
    call    printA 
    inc     b
    dec     c
    jr      nz, printcpuloop2
    ld      c,6
    call    newline
printcpuloop2:
    ld      a,b
    cp      $10
    jr      nz,printcpuloop1
    call    printtext
    db      "D:",0
    ld      a,(ix+reg_delay)
    call    printHex2
    call    printtext
    db      " S:",0
    ld      a,(ix+reg_sound)
    call    printHex2

    call    newline
    call    printtext
    db      "I:",0
    ld      bc,(ix+reg_i)
    call    printHex4
    ld      a,'>'
    call    printA

    ld      b,4
    ld      hl,(ix+reg_i)

printcpuLoopI:
    ld      a,(hl)
    inc     hl
    call    printHex2
    ld      a,' '
    call    printA
    djnz    printcpuLoopI
    POPA
    ret

bcd 
                ; convert vx to decimal and store in i+0, i+1, i+2
                push    iy
                ld      hl,iy
                ld      de,2
                add     hl,de
                ld      iy,hl                   ; iy = i+3.

                ; we work backwards, hl=hl/10; de=hl*10, hl-de = last digit

                ld      b,3
                ld      l,a
                ld      h,0                     ; hl = vx
chip8f33_loop:  push    bc              
                ld      d,10
                push    hl
                call    DivHLxD
                ld      bc,hl
                ld      de,hl
                ld      a,10
                call    MulHleqDExA:
                ld      de,hl
                pop     hl
                sub     hl,de
                ld      a,l
                ld      hl,bc
                pop     bc
chip8fStore:    ld      (iy),a
                dec     iy                
                djnz    chip8f33_loop
                pop     iy
                ret    

checkKey:       call    checkMultipleHexKeyA
                cp      1
                      ret


	include	"tools/math.asm"
	include "tools/print.asm"	
	include "tools/graphics.asm"
	include "tools/zxspectrum.asm"
	include "chip8gpu.asm"
	include "chip8Z80Game.asm"
	


ballsprite:
	;DB	$80, $80, $80, $80, $80, $80, $80, $80
	DB	$00, $18, $3C, $7E, $7E, $3C, $18, $00

chip8Screen:    defs 1024       ; 128*64 Pixels / 8 
chip8ScreenBytes:
                defs 256*4      ; Enlarged bytes from 00..FF map to 00000000 to ffffffff
schip8ScreenBytes:
                defs 256*2      ; Enlarged bytes from 00..ff map to 0000 to ffff


				db 		"$chip8memory$"
chip8Memory:      

chip8Font:
				db $F0, $90, $90, $90, $F0; 0
				db $20, $60, $20, $20, $70; 1
				db $F0, $10, $F0, $80, $F0; 2
				db $F0, $10, $F0, $10, $F0; 3
				db $90, $90, $F0, $10, $10; 4
				db $F0, $80, $F0, $10, $F0; 5
				db $F0, $80, $F0, $90, $F0; 6
				db $F0, $10, $20, $40, $40; 7
				db $F0, $90, $F0, $90, $F0; 8
				db $F0, $90, $F0, $10, $F0; 9
				db $F0, $90, $F0, $90, $90; A
				db $E0, $90, $E0, $90, $E0; B
				db $F0, $80, $80, $80, $F0; C
				db $E0, $90, $90, $90, $E0; D
				db $F0, $80, $F0, $80, $F0; E
				db $F0, $80, $F0, $80, $80; F

bigfont:
				db	$00, $18, $24, $42, $42, $42, $42, $24, $18, $00	;	0
				db	$00, $08, $18, $28, $08, $08, $08, $08, $3E, $00	;	1
				db	$00, $3C, $42, $02, $04, $18, $20, $40, $7E, $00	;	2
				db	$00, $3C, $42, $02, $0C, $02, $02, $42, $3C, $00	;	3
				db	$00, $0C, $14, $14, $24, $24, $44, $7E, $04, $00 	;	4
				db	$00, $7E, $40, $70, $0C, $02, $02, $46, $38, $00 	;	5
				db	$00, $1C, $62, $40, $40, $7C, $42, $42, $3C, $00	;	6
				db	$00, $3E, $02, $04, $04, $08, $08, $10, $10, $00	;	7
				db	$00, $3C, $42, $42, $3C, $42, $42, $42, $3C, $00 	;	8
				db	$00, $3C, $42, $42, $3C, $02, $02, $42, $3C, $00 	;	9
				db	$00, $18, $24, $42, $42, $42, $7E, $42, $42, $00	;	A
				db	$00, $78, $44, $42, $42, $7C, $42, $42, $7C, $00	;	B
				db	$00, $38, $44, $40, $40, $40, $40, $44, $38, $00 	;	C
				db	$00, $78, $44, $42, $42, $42, $42, $44, $78, $00	;	D
				db	$00, $7C, $40, $40, $78, $40, $40, $40, $7C, $00 	;	E
				db	$00, $7C, $40, $40, $78, $40, $40, $40, $40, $00	;	F
fontsize 		equ  $-chip8Font


romCollection: db 0
romCollectionSize equ 1

charAttrib:
        ret
getKempstonKey:
        ret        
vinterrupt:
        ld  a,(ix+reg_delay)
        cp  0
        jr  z, vinterrupt_1
        dec     (ix+reg_delay)
vinterrupt_1:
        ld  a,(ix+reg_sound)
        cp  0
        jr  z,vinterrupt_2
        dec     (ix+reg_sound)
vinterrupt_2:        
        ld      a,fakeinterrupt
        ld      (ix+reg_fakeir),a

        ret    
cpu_registers:
    defs    reg_size

  
scroll: ret



stack_bottom:   ; 100 bytes of stack
    defs    500, 0
stack_top	
GAME			MACRO text, filename
name:			db		text,0
				db		0
.start			dw		.end-.start
				incbin	filename
				db		0
.end 	
				ENDM				






; total size of code block
code_size   EQU     $ - main
	MakeTape "chip8native.tap", "zx chip8", START, code_size

 IF NEX == 0
        SAVESNA "z80-sample-program.sna", main
    ELSE
        SAVENEX OPEN "z80-sample-program.nex", main, stack_top
        SAVENEX CORE 3, 1, 5
        SAVENEX CFG 7   ; Border color
        SAVENEX AUTO
        SAVENEX CLOSE
    ENDIF

