 PRESERVE8
     THUMB
     AREA     appcode, CODE, READONLY
	 IMPORT printMsg
     EXPORT __main
	 ENTRY 
	 
sigmoid PROC
	
	VLDR.F32 S2, =60 ; Number of terms in e^y expansion
	VMOV.F32 S3, #1  ; count
	VMOV.F32 S4, #1  ; temp
	VMOV.F32 S5, #1  ; result
	VMOV.F32 S7, #1  ; register to hold one
Loop 
	 VCMP.F32 S2, S3 ; Comparison done for excuting taylor series expansion of e^x for s2 number of terms

	 VMRS.F32 APSR_nzcv,FPSCR ; Used to copy FPSRC to APSR
	 BLT output;
	 VDIV.F32 S6, S1, S3 ; temp1=y/count
	 VMUL.F32 S4, S4, S6 ; temp=temp*temp1;
	 VADD.F32 S5, S5, S4 ; result=result+temp;
	 VADD.F32 S3, S3, S7 ; incrementing count
	 B Loop; 
output	
	 VADD.F32 S8,S5,S7   ;Calculating denominator for sigmoid function 1+ e^y
	 VDIV.F32 s9,s5,s8   ;Calculating sigmoid function s9
	
	BX LR
	ENDP


		
__main  FUNCTION

	 VLDR.F32 S10, =1  ;x1 INPUT 1
	 VLDR.F32 S11, =0  ;x2 INPUT 2
	 VLDR.F32 S12, =1  ;x3 INPUT 3
	 VLDR.F32 S13, =1  ;x4 BIAS
	 ADR.W R2,case     ;switch case
	 MOV R1,#5         ;Row value of table
	 TBB[R2,R1]        ; table to store cases of switch
	 
and_l 
	 VLDR.F32 S14, =-0.1  ;W1
	 VLDR.F32 S15, =0.2  ;W2
	 VLDR.F32 S16, =0.2  ;W3
	 VLDR.F32 S17, =-0.2  ;W4 Bias
	 B z_comp
		 
or_l  
	 VLDR.F32 S14, =-0.1  ;W1
	 VLDR.F32 S15, =0.7  ;W2
	 VLDR.F32 S16, =0.7  ;W3
	 VLDR.F32 S17, =-0.1  ;W4 Bias
	 B z_comp
		 
nand_l 
     VLDR.F32 S14, =0.6  ;W1
	 VLDR.F32 S15, =-0.8  ;W2
	 VLDR.F32 S16, =-0.8  ;W3
	 VLDR.F32 S17, =0.3  ;W4 Bias
	 B z_comp
		 
nor_l 	
     VLDR.F32 S14, =0.5  ;W1
     VLDR.F32 S15, =-0.7  ;W2
	 VLDR.F32 S16, =-0.7  ;W3
	 VLDR.F32 S17, =0.1  ;W4 Bias
	 B z_comp
		 
not_1
     VLDR.F32 S14, =-0.5  ;W1
	 VLDR.F32 S15, =0  ;W2
	 VLDR.F32 S16, =0  ;W3
	 VLDR.F32 S17, =0.1  ;W4 Bias
	 B z_comp		  
		 		 
xor_1
	 VLDR.F32 S14, =5  ;W1
     VLDR.F32 S15, =-20  ;W2
	 VLDR.F32 S16, =-10  ;W3
	 VLDR.F32 S17, =-1  ;W4 Bias
	 B z_comp
		 
xnor_1	 
	 VLDR.F32 S14, =-5  ;W1
     VLDR.F32 S15, =20  ;W2
	 VLDR.F32 S16, =10  ;W3
	 VLDR.F32 S17, =1  ;W4 Bias
	 B z_comp

case		                      ; offset calculation
	DCB   0		  
	DCB   ((or_l - and_l)/2)	
	DCB   ((nand_l - and_l)/2)	
	DCB   ((nor_l - and_l)/2)
	DCB   ((not_1 - and_l)/2)
	DCB   ((xor_1 - and_l)/2)
	DCB   ((xnor_1 - and_l)/2)

z_comp  VMUL.F32 S18, S10, S14  ; X1*W1
	    VMUL.F32 S19, S11, S15  ; X2*W2
        VMUL.F32 S20, S12, S16  ; X3*W3
		VMUL.F32 S21, S13, S17  ; X4*W4
		VADD.F32 S22,S18,S19    ; S22= X1*W1 + X2*W2
		VADD.F32 S23,S20,S21    ; S23= X3*W3 + X4*W4
		VADD.F32 S1,S22,S23     ; S1= X1*W1 + X2*W2 + X3*W3 + X4*W4
	 
	 BL sigmoid                 ; 
	 
	 VMOV.F32 R0,S9   
	 BL printMsg	 ; Refer to ARM Procedure calling standards.
stop B stop ; stop program
	 ENDFUNC
	 END
		
		


