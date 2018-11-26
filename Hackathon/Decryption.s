     AREA     Decryption, CODE, READONLY
     export __main	 
	 ENTRY 
__main  function
	MOV r0,#0x20000000;    starting address in r2
	MOV r4,#0; just a counter
	MOV r3,#0x20000000;
Loop
	LDRB r1,[r0],#4
	EORS r1,r1,#0x00000001	;to negate the LSB
	EORS r1,r1,#0x00000024	; r3 i temp
	STRB r1,[r3],#4 ; store to the same location
	ADD r4,r4,#1
	CMP r4,#614400
	IT LS
	BLS Loop

stop		  B stop  ; stop program
       endfunc
      end