     AREA     appcode, CODE, READONLY
     export __main	 
	 ENTRY 
__main  function
	          MOV R1 , #56	  ;value of a	
			  MOV R2 , #16    ;value of b
			  
loop       	CMP R1 , R2
              IT EQ 
              BEQ stop	
              ITE PL			  
			  SUBPL R1 , R1 , R2 			  
			  SUBMI R2, R2 , R1
              B loop
			  
stop		  B stop  ; stop program
       endfunc
      end
