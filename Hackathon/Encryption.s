         AREA     Encryption, CODE, READONLY
    	 import printMsg
	 export __main	 
	 ENTRY 
__main  function
	MOV r2,#0x20000000
	ADD r2,r2,#4
	MOV r3,r2
	MOV r0,r2;    starting address in r2
	MOV r4,#0
Loop

	LDRB r1,[r0],#1  ; offset=4, post indexed so that value of location keeps incrementing
	EORS r1,r1,#0x00000024	; r3 i temp
	EORS r1,r1,#0x00000001	;to negate the LSB
	STRB r1,[r3],#1		;post indexed
	MOV r0,r1
	BL printMsg
	ADD r4,r4,#1
	CMP r4,#614400
	IT LS
	BLS Loop

STOP    B STOP
	endfunc
	end
