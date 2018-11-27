   	 AREA	Hamming, CODE, READONLY
	 import printMsg
	 export __main	 
	 ENTRY 
__main  function
	
	MOV R8,#0X20000000
	ADD R8,#4
	MOV R10,R8; R10 contains the decoded byte which has tobe stored
	MOV R9,#0; counter for no of bytes to be processed
Loop
	LDRB R3,[R8],#1
	AND R3, R0, R3



	; Generate check bit c0
	
	EOR	R2, R3, R3, LSR #2	; Generate c0 parity bit using parity tree
	EOR	R2, R2, R2, LSR #4	; ... second iteration ...
	EOR	R2, R2, R2, LSR #8	; ... final iteration
	
	AND	R2, R2, #0x1		; Clear all but check bit c0
	ORR	R3, R3, R2		    ; Combine check bit c0 with result
	
	; Generate check bit c1
	
	EOR	R2, R3, R3, LSR #1	; Generate c1 parity bit using parity tree
	EOR	R2, R2, R2, LSR #4	; ... second iteration ...
	EOR	R2, R2, R2, LSR #8	; ... final iteration
	
	AND	R2, R2, #0x2		; Clear all but check bit c1
	ORR	R3, R3, R2		; Combine check bit c1 with result
	
	; Generate check bit c2
	
	EOR	R2, R3, R3, LSR #1	; Generate c2 parity bit using parity tree
	EOR	R2, R2, R2, LSR #2	; ... second iteration ...
	EOR	R2, R2, R2, LSR #8	; ... final iteration
	
	AND	R2, R2, #0x8		; Clear all but check bit c2
	ORR	R3, R3, R2		; Combine check bit c2 with result	
	
	; Generate check bit c3
	
	EOR	R2, R3, R3, LSR #1	; Generate c3 parity bit using parity tree
	EOR	R2, R2, R2, LSR #2	; ... second iteration ...
	EOR	R2, R2, R2, LSR #4	; ... final iteration
	
	AND	R2, R2, #0x80		; Clear all but check bit c3
	ORR	R3, R3, R2		; Combine check bit c3 with result


	
	;Compare the original value (with error) and the recalculated value using exclusive-OR
	EOR R1, R0, R3


	;Isolate the results of the EOR operatation to result in a 4-bit calculation

	;Clearing all bits apart from c7 and shifting bit 4 positions right
	LDR R4, =0X80
	AND R4, R4, R1
	MOV R4, R4, LSR #4

	;Clearing all bits apart from c3 and shifting the 3rd bit 1 position right
	LDR R5, =0X8
	AND R5, R5, R1
	MOV R5, R5, LSR #1

	;Clearing all bits apart from c0 and c1  
	LDR R6, =0X3
	AND R6, R6, R1


	;Adding the 4 registers together 
	ADD R1, R4, R5
	ADD R1, R1, R6 

	;Subtracting 1 from R1 to determine the bit position of the error
	SUB R1, R1, #1

	;Store tmp register with binary 1. Then moves the 1, 8 bit positions left.  We use '8' because R1 contains 8 bits
	LDR R7, =0X1
	MOV R7, R7, LSL R1

	;Flips the bit in bit 8 of R0
	EOR R0, R0, R7;result in R0
	
	STRB R0,[R10],#1;

	BL printMsg	

	ADD r9,#1
	CMP r9,#614400
	IT LS
	BLS Loop

stop	B	stop
    endfunc
	 END		
