     AREA     Encryption, CODE, READONLY
     export __main	 
	 ENTRY 
__main  function
	MOV r0,r2;    starting address in r2
	MOV r4,0
	MOV r3,#0x20000000
Loop
	LDRB r1,[r0],#4  ; offset=4, post indexed so that value of location keeps incrementing
	EORS r1,r1,#0x00000024	; r3 i temp
	EORS r1,r1,#0x00000001	;to negate the LSB
	STRB r1,[r3],#4			;post indexed
	ADD r4,r4,#1
	CMP r4,#614400
	IT LS
	BLS Loop

STOP B STOP
	
 
endfunc
END
