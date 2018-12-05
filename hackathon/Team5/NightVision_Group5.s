; (0,0) --------- x -------->
;	|				B
;	|
;	y	A
;	|
;	|
;	v
; On horizontal line, y is same So, we pushed y cordinate first and then x cordinates(which are changing)
; On vertical line, x is same So, we pushed x cordinate first and then y cordinates(which are changing)
; We are considering pixel size as 320x240.	 
	 
	 
	 
	 AREA     appcode, CODE, READONLY
     IMPORT printMsg
     export __main	 
	 ENTRY 
	 
DrawCrossWire   PROC
	           
			   PUSH {R8,LR}
			   
			   ; CODE TO DRAW CROSS LINE
              
			   BX LR
			   ENDP

__main  function
	          MOV R1,#160    ; a
              MOV R2,#120   ; b
			  MOV R3,#320    ; COLUMN
			  MOV R4,#240    ; ROW
			  MOV R7,#0X20000000  ; ADDRESS
			  MOV R8,R7
			  MOV R5,R3    ; COLUMN
			  MOV R6,R4   ; ROW
			  
			  STR R2, [R7] ,#1  ; STORING B IN MEMORY 
			  
			  LDR R0, [R7 ,#0] 
			  BL printMsg
			  
L1			  CBZ R5, STOP1
			  STR R5, [R7] ,#1  ; NEXT STORING CORRESPONDING COLUMN VALUES
			  
			  LDR R0, [R7 ,#0] 
			  BL printMsg
			  
			  SUB R5,R5,#1
			  B L1
STOP1         
              STR R1, [R7] ,#1  ; STORING A IN MEMORY
			  
			  LDR R0, [R7 ,#0] 
			  BL printMsg
			  
L2			  CBZ R6, STOP2
			  STR R6, [R7] ,#1	; NEXT STORING CORRESPONDING ROW VALUES
			  
			  LDR R0, [R7 ,#0] 
			  BL printMsg
			  
			  SUB R6,R6,#1
			  B L2
			  
STOP2		
              SUB R10,R3,R1  ; R10=320-a
			  SUB R6,R4,R2  ; R6=240-b
			  MOV R9,#2 
			  UDIV R10,R10,R9 ; (320-a) /2
			  UDIV R6,R6,R9 ; (240-b) /2
			  
			  ADD R9,R10,R1  ; a + (320-a) /2
			  STR R9, [R7] ,#1  ; STORE a + (320-a) /2 IN MEMORY
			  
			  LDR R0, [R7 ,#0] 
			  BL printMsg
			  
			  MOV R5,#0X28
L3			  CBZ R5, STOP3
			  ADD R11,R2,R5  ; b + 40
			  STR R11, [R7] ,#1  ; NEXT STORING CORRESPONDING COLUMN VALUES
			  
			  LDR R0, [R7 ,#0] 
			  BL printMsg
			  
			  SUB R5,R5,#1 
			  B L3
			  
STOP3         
              ADD R9,R6,R2  ; b + (240-b) /2
			  STR R9, [R7] ,#1  ; STORE b + (b) /2 IN MEMORY
			  
			  LDR R0, [R7 ,#0] 
			  BL printMsg
			  
			  MOV R5,#0X1E
L4			  CBZ R5, STOP4
			  ADD R11,R2,R5  ; a + 30
			  STR R11, [R7] ,#1  ; NEXT STORING CORRESPONDING COLUMN VALUES
			  
			  LDR R0, [R7 ,#0] 
			  BL printMsg
			  
			  SUB R5,R5,#1
			  B L4

STOP4         
              UDIV R10,R1,R9 ; (a) /2
			  UDIV R6,R2,R9 ; (b) /2 
			  
			  SUB R9,R1,R10  ; a - (a) /2
			  STR R9, [R7] ,#1  ; STORE a - (a) /2 IN MEMORY
			  
			  LDR R0, [R7 ,#0] 
			  BL printMsg
			  
			  MOV R5,#0X28
L5			  CBZ R5, STOP5
			  ADD R11,R2,R5  ; b + 40
			  STR R11, [R7] ,#1  ; NEXT STORING CORRESPONDING COLUMN VALUES
			  
			  LDR R0, [R7 ,#0] 
			  BL printMsg
			  
			  SUB R5,R5,#1
			  B L5

STOP5
              SUB R9,R2,R6  ; b - (b) /2
			  STR R9, [R7] ,#1  ; STORE b - (a) /2 IN MEMORY
			  
			  LDR R0, [R7 ,#0] 
			  BL printMsg
			  
			  MOV R5,#0X1E
L6			  CBZ R5, STOP6
			  ADD R11,R2,R5  ; a + 30
			  STR R11, [R7] ,#1  ; NEXT STORING CORRESPONDING COLUMN VALUES
			  
			  LDR R0, [R7 ,#0] 
			  BL printMsg
			  
			  SUB R5,R5,#1
			  B L6
			  
STOP6         
			BL DrawCrossWire 
			
			
			
			
			;Encryption
			
			MOV r2,#0x20000000
			MOV r0,r2;    starting address in r2
			MOV r4,#0
			MOV r3,#0x20000000
Loop_7
			LDRB r1,[r0],#1  ; offset=4, post indexed so that value of location keeps incrementing
			EORS r1,r1,#0x00000024	; r3 i temp
			EORS r1,r1,#0x00000001	;to negate the LSB
	
			MOV R0,R1
			BL printMsg
	
			STRB r1,[r3],#1			;post indexed
			ADD r4,r4,#1
			CMP r4,#3
			IT LS
			BLS Loop_7


			;Hamming Code
			
			MOV R8,#0X20000000
	
LOOP_8
			LDRB R1, [R8],#4

	; Begin by expanding the 8-bit value to 12-bits, inserting
	; zeros in the positions for the four check bits (bit 0, bit 1, bit 3
	; and bit 7).
	
			AND	R2, R1, #0x1		; Clear all bits apart from d0
			MOV	R0, R2, LSL #2		; Align data bit d0
	
	
			AND	R2, R1, #0xE		; Clear all bits apart from d1, d2, & d3
			ORR	R0, R0, R2, LSL #3	; Align data bits d1, d2 & d3 and combine with d0
	
			AND	R2, R1, #0xF0		; Clear all bits apart from d3-d7
			ORR	R0, R0, R2, LSL #4	; Align data bits d4-d7 and combine with d0-d3
	
	; We now have a 12-bit value in R0 with empty (0) check bits in
	; the correct positions
	

	; Generate check bit c0
	
			EOR	R2, R0, R0, LSR #2	; Generate c0 parity bit using parity tree
			EOR	R2, R2, R2, LSR #4	; ... second iteration ...
			EOR	R2, R2, R2, LSR #8	; ... final iteration
	
			AND	R2, R2, #0x1		; Clear all but check bit c0
			ORR	R0, R0, R2		; Combine check bit c0 with result
	
	; Generate check bit c1
	
			EOR	R2, R0, R0, LSR #1	; Generate c1 parity bit using parity tree
			EOR	R2, R2, R2, LSR #4	; ... second iteration ...
			EOR	R2, R2, R2, LSR #8	; ... final iteration
	
			AND	R2, R2, #0x2		; Clear all but check bit c1
			ORR	R0, R0, R2		; Combine check bit c1 with result
	
	; Generate check bit c2
	
			EOR	R2, R0, R0, LSR #1	; Generate c2 parity bit using parity tree
			EOR	R2, R2, R2, LSR #2	; ... second iteration ...
			EOR	R2, R2, R2, LSR #8	; ... final iteration
	
			AND	R2, R2, #0x8		; Clear all but check bit c2
			ORR	R0, R0, R2		; Combine check bit c2 with result	
	
	; Generate check bit c3
	
			EOR	R2, R0, R0, LSR #1	; Generate c3 parity bit using parity tree
			EOR	R2, R2, R2, LSR #2	; ... second iteration ...
			EOR	R2, R2, R2, LSR #4	; ... final iteration
	
			AND	R2, R2, #0x80		; Clear all but check bit c3
			ORR	R0, R0, R2		; Combine check bit c3 with result
			
			BL printMsg
	
			B LOOP_8
			
			
			
			
			;Hamming_Decode

			MOV R8,#0X20000000
	
LOOP
			LDRB R3, [R8],#4
	
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
			EOR R0, R0, R7
			
			BL printMsg
			
			
			; Decryption

			MOV r2,#0x20000000;    starting address in r2
			MOV r4,#0; just a counter
			MOV r3,#0x20000000;
Loop
			LDRB r1,[r2],#4
			EORS r1,r1,#0x00000001	;to negate the LSB
			EORS r1,r1,#0x00000024	; r3 i temp
			STRB r1,[r3],#4 ; store to the same location
			
			MOV r0,r1
			BL printMsg
			
			ADD r4,r4,#1
			CMP r4,#614400
			IT LS
			BLS Loop
						
		 
			  
stop		  B stop  ; stop program
       endfunc
      end