	ORG $8000
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSERTION

NEX:    equ 1   ;  1=Create nex file, 0=create sna file
DEBUG:	EQU 0

    IF NEX == 0
        ;DEVICE ZXSPECTRUM128
        DEVICE ZXSPECTRUM48
        ;DEVICE NOSLOT64K
    ELSE
        DEVICE ZXSPECTRUMNEXT
    ENDIF	

DIFF:		equ 6; mainbase2-main

ROM_CLS                 EQU  0x0DAF             ; Clears the screen and opens channel 2
ROM_OPEN_CHANNEL        EQU  0x1601             ; Open a channel
ROM_PRINT               EQU  0x203C             ; Print a string 

	IF DEBUG == 0
		LD HL, reloc-main			; The size of the base part, for the tool
	ENDIF
main:
	LD	DE, reloc-program		; the size of the binary
mainbase:
    call 82				; The ZX Rom contains a RET command here
mainbase2:
	
	LD  IX,0
	ADD IX,SP
	LD	L,(IX-2)
	LD	H,(IX-1)		; HL contains the address of mainbase
	LD	IX,HL
	ADD HL,DE
	LD	DE, mainbase1-mainbase
	ADD HL,DE
mainbase1
	JP	(HL)

program:
	IF DEBUG==1 
	LD	HL, debugData

	LD	A,(HL)

debugData:
	db		0xC9

	ENDIF


reloc:	
; Start loading the table 
; The first entry contains the original .ORG of the machine code program
; The next entries contain relativ offsets which contain absolute addresses

; patch the start to have a jr to the start
	LD	DE, 6
	LD	HL,IX
	SUB	HL,DE
	LD	(HL),0x1b
	INC HL
	LD	(HL),program-main


    LD	DE, data-reloc
	ADD HL,DE	
	LD	IX, HL	; IX points to the start of the reloc data
	LD	C,(IX+0)	; BC is the original address
	INC	IX		; IX Points to the first reloc offset
	LD	B,(IX+0)
	INC	IX
	
; Get the start of the machine code program by popping the return address of the call

	POP 	HL		; HL = Address after the call e.g. the start of the program
	PUSH	HL		; Push it so we can return


; And calculate the offset between the .ORG and the real address
	SBC     HL, BC		; HL contains the offset
	PUSH 	HL
	POP 	BC		; BC = offset to add to the code


rlloop:	LD	E, (IX+0)
	INC	IX
	LD	D, (IX+0)
	INC	IX

; if we loaded 0, terminate
	LD	A,D
	CP	0
	JR	NZ, rlloop2
	LD	A,E
	CP	0
	JR	NZ, rlloop2
	RET
rlloop2:
; DE = Offset from base to the code we must modify
; BC = Offset to add
; HL = Start of code
	PUSH 	HL
	PUSH IY
	POP HL
	ADD	HL, DE
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	PUSH 	HL


	PUSH	DE
	POP 	HL
	ADD	HL, BC
	PUSH	HL
	POP	DE
	POP	HL	
	LD	(HL), D
	DEC	HL
	LD	(HL), E


	POP 	HL

	JR	rlloop

data:	;defw	$1234		; First word: the original .ORG of the program
	;defw	0	

stack_bottom:   ; 100 bytes of stack
    ;defs    100, 0
stack_top	

 IF NEX == 0
        SAVESNA "z80-sample-program.sna", main
    ELSE
        SAVENEX OPEN "z80-sample-program.nex", main, stack_top
        SAVENEX CORE 3, 1, 5
        SAVENEX CFG 7   ; Border color
        SAVENEX AUTO
        SAVENEX CLOSE
    ENDIF

