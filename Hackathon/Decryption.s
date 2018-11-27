         AREA     Decryption, CODE, READONLY
	import printMsg     
	export __main	 
	 ENTRY 
__main  function
	MOV r2,#0x20000000;    starting address in r0
	ADD r2,#4;
	MOV r4,#0; just a counter
	MOV r3,r2;
Loop
	LDRB r1,[r2],#1
	EORS r1,r1,#0x00000001	;to negate the LSB
	EORS r1,r1,#0x00000024	; r3 i temp
	STRB r1,[r3],#1 ; store to the same location

	MOV r0,r1
	BL printMsg

	ADD r4,r4,#1
	CMP r4,#614400  ; that is 320*240 
	IT LS
	BLS Loop

STOP    B STOP
	endfunc
	END
