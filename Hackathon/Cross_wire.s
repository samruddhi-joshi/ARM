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
			 
			  
stop		  B stop  ; stop program
       endfunc
      end