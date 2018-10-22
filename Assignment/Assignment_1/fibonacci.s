     AREA     appcode, CODE, READONLY
     export __main	 
	 ENTRY 
__main  function
	          MOV R0 , #0        ;INITIAL VALUE OF FIBONACCI SERIES
			  MOV R1 , #1        ;INITIAL VALUE OF FIBONACCI SERIES
			  MOV R3 , #8        ;ELEMENT NUMBER OF SERIES TO BE EVALUATED AND ALSO LOOP COUNT
			  
LOOP			  CBZ R3 , stop
			  ADD R2 , R1 , R0   
			  MOV R4 , R2        ;OUTPUT VALUE IN R4
			  MOV R0 , R1        ;SWAPPING REGISTER VALUES TO CALCULATE NEW VALUE
			  MOV R1 , R2        ;SWAPPING REGISTER VALUES TO CALCULATE NEW VALUE
			  SUB R3 , R3 , #1   ;DECREMENTING LOOP COUNT
			  B LOOP

			  
stop		  B stop  ; stop program
       endfunc
      end
