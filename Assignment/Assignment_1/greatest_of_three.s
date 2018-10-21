	   AREA    appcode, CODE, READONLY
    EXPORT __main
       ENTRY 
__main  FUNCTION
	    MOV R0 , #0X00000010
		MOV R1 , #0X00000005
		MOV R2 , #0X00000011
		
        CMP R0 , R1
		
		ITE PL             ;CHECKING N FLAG CLEAR
		MOVPL R3 , R0
		MOVMI R3 , R1
		
		CMP R2 , R3
		ITE PL
		MOVPL R4 , R2
		MOVMI R4 , R3
		
		
			
stop B stop ; stop program
     ENDFUNC
 