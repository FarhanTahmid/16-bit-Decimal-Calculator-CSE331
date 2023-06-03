.STACK 100H 
.DATA 

	PORT_A DB 0
    PORT_B DB 0
    PORT_C DB 0  
    

    MYSTR	DB	"CSE 311 LAB GROUP 4$"   
    NUT DB "NUT 16$"    
    INF DB "INF$"
    SANS DB "ANS$"   
    ERROR   DB  "ERROR$" 
    TRY_STR DB "PLEASE TRY AGAIN$" 
 
    PA EQU 00H 	
	PB EQU 02H 	   
	PC EQU 04H                    
	
	CWR   EQU 06H	

	
    NUM1 DW 0     
    
    NUM2 DW 0

	RESULT DW 0 
	
	ANS DW 0  
	
	CANS DW 0 
    
    
    BD DB 0   
    
    SYMBOL DB 0 
    
    KEY DW 0  
    
    SIGN DW 0 
    
    FFLAG DB 0 
    
    SIGN_FLAG DB 0

    
    N_COUNT DB 0  
   
    CRESULT DW 0 
    CDOT DB 0     
    
    N DW 0  



.CODE
 
PROC MAIN

    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX  

    
 
    MOV DX,CWR
    MOV AL,88H   

    OUT DX,AL  

	CALL LCD_INIT           ; Calling LCD function	
	
    
    
    
	MOV DL,1   
	MOV DH,3  
	CALL LCD_SET_CUR        ; Calling function to set cursor on LCD screen     	
	LEA SI,MYSTR            ; Write Welcome Message
	CALL LCD_WRITE_STR      ; Calling function that write message to LCD screen

	
	MOV DL,2 
	MOV DH, 6 
	CALL LCD_SET_CUR        ; Calling function to set cursor on LCD screen  
	LEA SI,NUT              ; Write Welcome Message
	CALL LCD_WRITE_STR      ; Calling function to set cursor on LCD screen  
	

    MOV CX, 60000
    CALL DELAY              ; Calling function to Delay 
    
    MOV CX, 60000           
    CALL DELAY              ; Calling function to Delay 
    CALL LCD_CLEAR          ; Calling function to Clear LCD screen
    
    
    
    
    MOV DL,1 
    MOV DH,1 
    CALL LCD_SET_CUR
    





KEYPAD:                     ;---------- Keypad Segment ----------

    
    ; Here we can assign each keypad key to their corresponding character and being pressed it will be written and shown on the LCD screen

    
    MOV AL, 11111110B
    OUT PC, AL
    MOV CX, 250
    CALL DELAY 

    IN AL,PC
    
    
   
    CMP AL, 11101110b 
    JNE N7
    
        CMP BD, 1
        JE  KEYPAD
        
            MOV AH, '7'
            CALL LCD_WRITE_CHAR 
            MOV FFLAG, 1
            
            MOV KEY, 7
            MOV BD, 1
            JMP INPUT_NUM   

   
N7: ; For Keypad Number 7

    CMP AL, 11011110b
    JNE N8   
    
        CMP BD, 1
        JE  KEYPAD
        
            MOV AH, '8'
            CALL LCD_WRITE_CHAR
            MOV FFLAG, 1
            
            MOV KEY, 8
            MOV BD, 1
            JMP INPUT_NUM
           
   
N8: ; For Keypad Number 8

    CMP AL, 10111110b 
    JNE N9  
    
        CMP BD, 1
        JE  KEYPAD
        
            MOV AH, '9'
            CALL LCD_WRITE_CHAR 
            MOV FFLAG, 1
            
            MOV KEY, 9
            MOV BD, 1
            JMP INPUT_NUM
        
N9: ; For Keypad Number 7

    CMP AL, 01111110b 
    JNE NDIVIDE 
    
        CMP BD, 1
        JE  KEYPAD  
        
            MOV AH, '/'
            CALL LCD_WRITE_CHAR 
            CMP SYMBOL, 0 
            JNE IMPORT_WORD
            
            
            MOV SYMBOL, '/'     
            
            MOV BD, 1  
        
            JMP KEYPAD
      
    
NDIVIDE: ; For Keypad Divide Symbol 

    MOV AL, 11111101b
    OUT PC, AL
    MOV CX, 250
    CALL DELAY 

    IN AL,PC    
    
    
   
    CMP AL, 11101101b 
    JNE N4
    
        CMP BD, 1
        JE  KEYPAD
        
        MOV AH, '4'
        CALL LCD_WRITE_CHAR  
        MOV FFLAG, 1
        
        MOV KEY, 4
        MOV BD, 1
        JMP INPUT_NUM   

   
N4: ; For Keypad Number 4

    CMP AL, 11011101b
    JNE N5
        CMP BD, 1
        JE  KEYPAD
        
        MOV AH, '5'
        CALL LCD_WRITE_CHAR 
        MOV FFLAG, 1
        
        MOV KEY, 5
        MOV BD, 1
        JMP INPUT_NUM
           
   
N5: ; For Keypad Number 5

    CMP AL, 10111101b
    JNE N6
    
        CMP BD, 1
        JE  KEYPAD
        
        MOV AH, '6'
        CALL LCD_WRITE_CHAR
        MOV FFLAG, 1
        
        MOV KEY, 6
        MOV BD, 1
        JMP INPUT_NUM
        
N6: ; For Keypad Number 6

    CMP AL, 01111101b
    JNE NCORE
    
    CMP BD, 1
    JE  KEYPAD
        MOV AH, '*'
        CALL LCD_WRITE_CHAR 
        
        CMP SYMBOL, 0 
        JNE IMPORT_WORD
        
        MOV SYMBOL, '*'     
        
        MOV BD, 1  
    
        JMP KEYPAD
        
        
 

NCORE: 

    MOV AL, 11111011b
    OUT PC, AL
    MOV CX, 250
    CALL DELAY 

    IN AL,PC    
    
    
   
    CMP AL, 11101011b
    JNE N1
    
        CMP BD, 1
        JE  KEYPAD
        
        MOV AH, '1'
        CALL LCD_WRITE_CHAR  
        MOV FFLAG, 1
        
        MOV KEY, 1
        MOV BD, 1
        JMP INPUT_NUM   

  
N1: ; For Keypad Number 1

    CMP AL, 11011011b 
    JNE N2
        CMP BD, 1
        JE  KEYPAD
        
        MOV AH, '2'
        CALL LCD_WRITE_CHAR
        MOV FFLAG, 1
        
        MOV KEY, 2
        MOV BD, 1
        JMP INPUT_NUM
           

   
N2: ; For Keypad Number 2

    CMP AL, 10111011b 
    JNE N3
    
        CMP BD, 1
        JE  KEYPAD
        
            MOV AH, '3'
            CALL LCD_WRITE_CHAR
            MOV FFLAG, 1
            
            MOV KEY, 3
            MOV BD, 1
            JMP INPUT_NUM

        
N3: ; For Keypad Number 3

    CMP AL, 01111011b 
    JNE NTRU
    
        CMP BD, 1
        JE  KEYPAD 
        
            MOV AH, '-'
            CALL LCD_WRITE_CHAR  
            
            CMP FFLAG, 0
            JNE N_I_S 
            
            
            MOV SIGN_FLAG, 1
            MOV SYMBOL, 0
            MOV BD, 1  
            
            JMP KEYPAD
            
            
        N_I_S: 
            
            CMP SYMBOL, '+'
            JNE KT_TRU
            MOV SYMBOL, '-' 
            MOV BD, 1
            JMP KEYPAD   
            
             
        KT_TRU:  
           
            CMP SYMBOL, '-'  
            JNE KT_CORE     
            MOV SYMBOL, '+'  
            MOV BD, 1     
            JMP KEYPAD 
            
        KT_CORE: 
            CMP SYMBOL, '*' 
            JNE KT_D 
            
            JMP IMPORT_WORD    
            
        KT_D:
            CMP SYMBOL, '/' 
            JNE  N_D_S          
            JMP IMPORT_WORD  
                
        N_D_S:     
            MOV SYMBOL, '-'       
            MOV BD, 1       
            JMP KEYPAD   
            
            
                 
NTRU:    

    MOV AL, 11110111b
    OUT PC, AL
    MOV CX, 250
    CALL DELAY 

    IN AL,PC 
    
    
   
    CMP AL, 11100111b
    JNE NC  
    
        C:
    
        CALL LCD_CLEAR           
        
      
        MOV NUM1, 0 
        MOV NUM2, 0 
        MOV RESULT, 0 
        MOV SYMBOL, 0 
        MOV KEY, 0       
        MOV SIGN,0         
        MOV CRESULT, 0 
        MOV N_COUNT, 0        
        MOV CDOT, 0 
        MOV FFLAG, 0   
        MOV BD, 1          
        JMP KEYPAD    
            
NC:
    CMP AL, 11010111b
    JNE N0   
    
        CMP BD, 1
        JE  KEYPAD
        
            MOV AH, '0'
            CALL LCD_WRITE_CHAR 
            MOV FFLAG, 1
            
            MOV KEY, 0
            MOV BD, 1
            JMP INPUT_NUM
               
   
N0:
    CMP AL, 10110111b 
    JNE NEQUAL
    
        CMP BD, 1
        JE  KEYPAD
        
            MOV BD, 1    
            JMP CALCULATE
        
NEQUAL: ; For Keypad Equal Sign
    CMP AL, 01110111b 
    JNE NC
    
    CMP BD, 1
    JE  KEYPAD 
    
        MOV AH, '+'
        CALL LCD_WRITE_CHAR
        
        CMP SYMBOL, '-'
        
        JNE TRU_CONG
        
        MOV SYMBOL, '-' 
        MOV BD, 1
        JMP KEYPAD 
         
    TRU_CONG:    
        MOV SYMBOL, '+'     
        
        MOV BD, 1  
    
        JMP KEYPAD    
NC1:   ; For Keypad clear
    
    MOV BD, 0 
    JMP KEYPAD  
    

IMPORT_WORD:    

    LEA SI, ERROR
    CALL LCD_WRITE_STR
    
    
    
    MOV DL,2  
	MOV DH,1   
	CALL LCD_SET_CUR     	
	LEA SI,TRY_STR   
	CALL LCD_WRITE_STR  
	
	MOV CX, 60000 
	CALL DELAY
	
	JMP C
    
      


INPUT_NUM: ;The input numbers

    CMP SYMBOL, 0
    
    JE LNUM1 ;First input
    
    
    JMP LNUM2 ;Second input    


                                          
LNUM1:                                     
    CMP NUM1, 0                            
                                           
    JNE NOT0N1                             
                                           
        MOV AX, KEY                        
                                           
        MOV NUM1, AX                       
                                           
        JMP EXITN1                         
                                           
    NOT0N1:                                
                                           
        MOV AX, NUM1                       
                                           
        MOV BX, 10                         
                                           
        MUL BX                             
                                           
        ADD AX, KEY                        
                                           
        MOV NUM1, AX                       
                                          
    EXITN1:                                
        JMP KEYPAD                         
                                           
                                   
                                           
LNUM2:                                     
    CMP NUM2, 0                            
                                           
    JNE NOT0N2                            
                                          
        MOV AX, KEY                       
                                           
        MOV NUM2, AX                       
                                           
        JMP EXITN2                         
                                           
    NOT0N2:                                
                                           
        MOV AX, NUM2                       
                                           
        MOV BX, 10                         
                                           
        MUL BX                             
                                           
        ADD AX, KEY                        
                                           
        MOV NUM2, AX                       
                                           
    EXITN2:                                
        JMP KEYPAD                         
                                                                                 
 

                 
CALCULATE: ;To perform different calculations



    CMP SIGN_FLAG, 1  
    
    JNE N_C_S 
    
    
    CMP SYMBOL,'+' 
    JNE N_C 
    
    
    
    MOV CX, NUM1 
    
    MOV BX, NUM2
    
    MOV NUM1, BX
    
    MOV NUM2, CX 
    MOV SIGN, 0
    MOV SIGN_FLAG, 0 
    JMP TRU
    
N_C:
    CMP SYMBOL, '-'
    JNE N_DIV
    
    MOV SIGN, 1  
    MOV SIGN_FLAG, 0 
    JMP CONG
N_DIV: 
    CMP SYMBOL, '*' 
    JNE N_MUL 
    
    MOV SIGN, 1
    MOV SIGN_FLAG, 0
    JMP NHAN 
    
N_MUL:
    CMP SYMBOL, '/'
    JNE IFNOT
    
    MOV SIGN, 1
    MOV SIGN_FLAG, 0 
    JMP CHIA    
    
    
N_C_S: 
        
    CMP SYMBOL, '+' 
    JE CONG      
    
    CMP SYMBOL, '-' 
    JE TRU
    
    CMP SYMBOL, '*' 
    JE NHAN
    
    CMP SYMBOL, '/' 
    JE CHIA  
    
IFNOT:    
	LEA SI,ERROR
	CALL LCD_WRITE_STR 
	
	JMP KEYPAD




CONG: 

    MOV AX, NUM1
    
    MOV BX, NUM2
    
    ADD AX, BX
     
    MOV RESULT, AX
    
    MOV ANS, AX
    
    JMP HNUM



TRU:
    CMP SIGN, 1  
    
    JNE THAN 
    
    MOV CX, NUM1 
    
    MOV BX, NUM2
    
    MOV NUM1, BX
    
    MOV NUM2, CX
    
    
    XOR CX, CX 
    XOR BX, BX    
    
THAN: 
    MOV AX, NUM1 
    
    MOV BX, NUM2 
        
    
    CMP AX, BX
    
    JB TR  
    
    SUB AX, BX
     
    MOV RESULT, AX
    
    MOV ANS, AX 
    
    MOV SIGN, 0
    
    JMP HNUM 
    
    
        
TR: 
    MOV AX, NUM2 
    MOV BX, NUM1
    
    SUB AX, BX
    
    MOV RESULT, AX  
    
    MOV ANS, AX
    
    MOV SIGN, 1 

    
    JMP HNUM  
     

    
NHAN:    
    
    MOV AX, NUM1 
    
    MOV BX, NUM2 
    
    MUL BX
     
    MOV RESULT, AX 
    
    MOV ANS, AX
    
    JMP HNUM

   
CHIA:   
    
    MOV DX, 0  
      
    MOV AX, NUM1   
    
    CMP NUM2, 0 
    
    JNE TPC 
    
   
    
    MOV DL, 2
    
    MOV DH, 14
    
    CALL LCD_SET_CUR 
    
    LEA SI, INF
    
    CALL LCD_WRITE_STR
    
    JMP KEYPAD
    
TPC: 
    
    MOV BX, NUM2 
    
    DIV BX    
    
    MOV RESULT, AX
    
    MOV ANS, AX
    
    MOV CRESULT, DX    
    
    
    CMP CRESULT, 0  
    
    JNE FLOAT    
     
     
     
    JMP HNUM        

  
FLOAT: 
    MOV CDOT, 1
    
    JMP HNUM
    
   
   
HNUM:  
    
    CMP RESULT, 10000    
    JNB SOL5  


    CMP RESULT, 1000  
    JNB SOL4
    
    
    CMP RESULT, 100
    JNB SOL3
    
    
    CMP RESULT, 10
    JNB SOL2  
    
    
    
    MOV N_COUNT, 1 
    
    
    CMP CDOT, 1
    JNE NF1     
    
    
    MOV DL,2
	MOV DH,11
	CALL LCD_SET_CUR 
	
	CMP SIGN, 0 
    
    JE SSOL1   
	
	MOV AH, '-'
    
    CALL LCD_WRITE_CHAR     

SSOL1:
	
	MOV AX, RESULT 
	
	ADD AX, 0030H 
	
	MOV AH, AL 
	
	CALL LCD_WRITE_CHAR 
	
	CALL PRINT 
	MOV CDOT, 0  
	
	JMP JUMP
    
        
NF1:             
    MOV DL,2
	MOV DH,15
	CALL LCD_SET_CUR   
	
	
	CMP RESULT, 0
	
	JNE TSO0 
	
	MOV SIGN, 0; 

TSO0: 	
    CMP SIGN, 0  
    
    JE EXIT1  
	
	MOV AH, '-'
    
    CALL LCD_WRITE_CHAR     

EXIT1: 	
	MOV AX, RESULT 
	
	ADD AX, 0030H 
	
	MOV AH, AL 
	
	CALL LCD_WRITE_CHAR
	
	JMP JUMP
	
    
	 
SOL5: 
    MOV N_COUNT, 5
    
    CMP CDOT, 1  
    JNE NF5     
    
    CMP SIGN, 1  
    JNE NF5
    
    MOV DL,2
	MOV DH,7
	CALL LCD_SET_CUR 
	
	CMP SIGN, 0  
    
    JE SSOL5     
	
	MOV AH, '-'
    
    CALL LCD_WRITE_CHAR     

SSOL5:
	
	CALL PRINT 
	MOV CDOT, 0
	JMP JUMP

NF5:     
    
    MOV DL,2
	MOV DH,11
	CALL LCD_SET_CUR  
	
	CMP SIGN, 0
	JE SNF5
	MOV AH, '-'
	CALL LCD_WRITE_CHAR		
SNF5:
	
	CALL PRINT 
		
	JMP JUMP 

	  
    
SOL4:  
    MOV N_COUNT, 4

    CMP CDOT, 1  
    JNE NF4    
    
    
    MOV DL,2
	MOV DH,8
	CALL LCD_SET_CUR  
	
	CMP SIGN, 0  
    
    JE SSOL4    
	
	MOV AH, '-'
    
    CALL LCD_WRITE_CHAR     

SSOL4:
	
	CALL PRINT 
	MOV CDOT, 0
	JMP JUMP

NF4:   
    MOV DL,2
	MOV DH,12
	CALL LCD_SET_CUR 
	
	CMP SIGN, 0
	JE SNF4
	MOV AH, '-'
	CALL LCD_WRITE_CHAR		
SNF4:
	
	CALL PRINT 
	
	JMP JUMP


	       
SOL3: 
    MOV N_COUNT, 3

    CMP CDOT, 1  
    JNE NF3    
    
    
    MOV DL,2
	MOV DH,9
	CALL LCD_SET_CUR
	
	CMP SIGN, 0  
    
    JE SSOL3    
	
	MOV AH, '-'
    
    CALL LCD_WRITE_CHAR     

SSOL3: 
	
	CALL PRINT 
	MOV CDOT, 0
	JMP JUMP

NF3:  
    
    MOV DL,2
	MOV DH,13
	CALL LCD_SET_CUR 
	MOV N_COUNT, 3 
	
	CMP SIGN, 0
	JE SNF3
	MOV AH, '-'
	CALL LCD_WRITE_CHAR		
SNF3:
	CALL PRINT 
	
	JMP JUMP

	
	
SOL2: 
  
    MOV N_COUNT, 2

    CMP CDOT, 1  
    JNE NF2    
    
    
    MOV DL,2
	MOV DH,10
	CALL LCD_SET_CUR 
	
	                                             
    CMP SIGN, 0  
    
    JE SSOL2     
	
	MOV AH, '-'
    
    CALL LCD_WRITE_CHAR     

SSOL2:
	
	CALL PRINT 
	MOV CDOT, 0
	JMP JUMP

NF2: 

    MOV DL,2
	MOV DH,14
	CALL LCD_SET_CUR 
	
	
	MOV N_COUNT, 2 
	
	CMP SIGN, 0
	JE SNF2
	MOV AH, '-'
	CALL LCD_WRITE_CHAR		
SNF2:

	CALL PRINT 
	
	JMP JUMP


JUMP:
         
    
    MOV AL, 11111110B
    OUT PC, AL 
    MOV CX, 250
    CALL DELAY     
    IN AL, PC  
        
                      
    CMP AL, 01111110b
    JNE N_CHIA
    
    CALL LCD_CLEAR
    LEA SI, SANS
    CALL LCD_WRITE_STR
    MOV AH, '/' 
    CALL LCD_WRITE_CHAR 
    
    MOV SYMBOL,'/' 
    MOV NUM2, 0 
    MOV AX, ANS
    MOV NUM1, AX
    
    
    JMP KEYPAD     
    
     
N_CHIA: 

    MOV AL, 11111101b
    OUT PC, AL     
    MOV CX, 250
    CALL DELAY    
    IN AL, PC   
    
      
    
    CMP AL, 01111101b 
    JNE N_NHAN
    
    
    CALL LCD_CLEAR
    LEA SI, SANS
    CALL LCD_WRITE_STR
    MOV AH, '*' 
    CALL LCD_WRITE_CHAR
    
    MOV SYMBOL,'*' 
    MOV NUM2, 0 
    MOV AX, ANS
    MOV NUM1, AX
    
    JMP KEYPAD   
    
    
    
N_NHAN:      
    MOV AL, 11111011b
    OUT PC, AL  
    
    MOV CX, 250 
    CALL DELAY  
    
    IN AL, PC   
    
    CMP AL, 01111011b  
    JNE N_TRU
    
    
    CALL LCD_CLEAR
    LEA SI, SANS
    CALL LCD_WRITE_STR
    
    MOV AH, '-'  
    CALL LCD_WRITE_CHAR 
    
   
    MOV SYMBOL,'-'
    
    CMP SIGN, 1   
    
    JNE NTR
    
    MOV SYMBOL, '+'  
    
NTR:       
    MOV NUM2, 0 
    MOV AX, ANS
    MOV NUM1, AX
    
    JMP KEYPAD      
    
    
   
N_TRU:     
    MOV AL, 11110111b
    OUT PC, AL    
    MOV CX, 250
    CALL DELAY    
    IN AL, PC    
    
    CMP AL, 11100111b
    JE C
      
    CMP AL, 01110111b 
    
    JNE CHO_TIEP 
    
    CALL LCD_CLEAR
    LEA SI, SANS
    CALL LCD_WRITE_STR
    MOV AH, '+' 
    CALL LCD_WRITE_CHAR 
    
    MOV SYMBOL,'+'
    
    CMP SIGN, 1 
    
    JNE NCAM
    
    MOV SYMBOL, '-'  
    
NCAM:
    
    MOV NUM2, 0 
    MOV AX, ANS
    MOV NUM1, AX
    
    JMP KEYPAD 
    
CHO_TIEP: 
    JMP JUMP
         

    
    
HLT  
 
 
ENDP MAIN


;------------- Print Segment -------------

PROC PRINT  
    
    CMP N_COUNT, 5
    
    JE EXIT5 
    
    CMP N_COUNT, 4
    
    JE EXIT4
    
    CMP N_COUNT, 3
    
    JE EXIT3
    
    CMP N_COUNT, 2
    
    JE EXIT2
           
           
    CMP N_COUNT, 1
    JE CHECKF 

    

EXIT5: 
    
    
    XOR DX, DX
           
    MOV AX, RESULT 
    
    MOV BX, 10000 
    
    DIV BX
    
    ADD AX, 0030H 
    
    MOV RESULT, DX
    
    MOV AH, AL 
    
    CALL LCD_WRITE_CHAR
    



EXIT4:     
    XOR DX, DX
           
    MOV AX, RESULT 
    
    MOV BX, 1000 
    
    DIV BX
    
    ADD AX, 0030H 
    
    MOV RESULT, DX
    
    MOV AH, AL 
    
    CALL LCD_WRITE_CHAR
      

EXIT3:            
    XOR DX, DX
           
    MOV AX, RESULT 
    
    MOV BX, 100 
    
    DIV BX
    
    ADD AX, 0030H 
    
    MOV RESULT, DX
    
    MOV AH, AL 
    
    CALL LCD_WRITE_CHAR 
    
    
EXIT2: 
    
    XOR DX, DX
           
    MOV AX, RESULT 
    
    MOV BX, 10 
    
    DIV BX
    
    ADD AX, 0030H 
    
    MOV RESULT, DX
    
    MOV AH, AL 
    
    CALL LCD_WRITE_CHAR    
    
       
    MOV AX, RESULT
    
    ADD AX, 0030H 
    
    MOV AH, AL 
    
    CALL LCD_WRITE_CHAR  
    


CHECKF:     
    CMP CDOT, 1
    
    JNE NFOAT
    
    MOV AH, '.'
    
    CALL LCD_WRITE_CHAR 
    
    MOV N, 3
    
    SAUCHAM:
        MOV AX, CRESULT
        
        MOV BX, 10
        MUL BX
        
        XOR DX, DX 
        MOV BX, NUM2 
        
        DIV BX
        
        MOV CRESULT, DX 
         
        
        ADD AX, 0030H 
        
        MOV AH, AL 
        
        CALL LCD_WRITE_CHAR
    
        MOV CX, N
        
        SUB CX, 1
        
        MOV N, CX
        
        CMP N, 0 
        
        JNE SAUCHAM
      
NFOAT:                    
        
    RET  
    
ENDP PRINT


;Delay Proc

PROC DELAY
	JCXZ @DELAY_END
	@DEL_LOOP:
	LOOP @DEL_LOOP	
	@DELAY_END:
	RET
ENDP DELAY


;----------- LCD Segment -----------

PROC LCD_INIT
 

	MOV AL,0
	CALL OUT_B  
	

	MOV CX,1000
	CALL DELAY   
	

	MOV AH,30H
	CALL LCD_CMD
	MOV CX,250
	CALL DELAY
	
	MOV AH,30H
	CALL LCD_CMD
	MOV CX,50
	CALL DELAY
	
	MOV AH,30H
	CALL LCD_CMD
	MOV CX,500
	CALL DELAY

	MOV AH,38H  
	CALL LCD_CMD
	
	MOV AH,0CH 
	CALL LCD_CMD
	
	MOV AH,01H 
	CALL LCD_CMD
	
	MOV AH,06H 
	CALL LCD_CMD
	
	RET	
ENDP LCD_INIT



PROC LCD_CMD

 

	PUSH DX
	PUSH AX


	MOV AL,PORT_B
	AND AL,0FDH		
	CALL OUT_B  
	

	MOV AL,AH
	CALL OUT_A 


	MOV AL,PORT_B
	OR	AL,100B		
	CALL OUT_B  
	

	MOV CX,50
	CALL DELAY 
	

	MOV AL,PORT_B
	AND AL,0FBH		
	CALL OUT_B 
	

	MOV CX,50
	CALL DELAY 
	

	POP AX
	POP DX	
	RET
ENDP LCD_CMD




PROC LCD_CLEAR
	MOV AH,1
	CALL LCD_CMD
	RET	
ENDP LCD_CLEAR




PROC LCD_WRITE_CHAR



	PUSH AX   
	

	MOV AL,PORT_B
	OR	AL,10B		
	CALL OUT_B       
	

	MOV AL,AH
	CALL OUT_A


	MOV AL,PORT_B
	OR	AL,100B		
	CALL OUT_B 
	

	MOV CX,50
	CALL DELAY
	

	MOV AL,PORT_B
	AND	AL,0FBH		
	CALL OUT_B 


	POP AX
	RET	
ENDP LCD_WRITE_CHAR






PROC LCD_WRITE_STR

	PUSH SI
	PUSH AX
	
	
	@LCD_PRINTSTR_LT:
		LODSB 
		
		
		CMP AL,'$'  
		
		JE @LCD_PRINTSTR_EXIT 
		
		MOV AH,AL
		CALL LCD_WRITE_CHAR	
	JMP @LCD_PRINTSTR_LT
	


	@LCD_PRINTSTR_EXIT:
	POP AX
	POP SI
	RET	
ENDP LCD_WRITE_STR




PROC LCD_SET_CUR 
    
    

	PUSH AX

	DEC DH

	CMP DL,1
	JE	@ROW1
	CMP DL,2
	JE	@ROW2
	JMP @LCD_SET_CUR_END

	@ROW1:
		MOV AH,80H
	JMP @LCD_SET_CUR_ENDCASE
	
	
	@ROW2:
		MOV AH,0C0H
	JMP @LCD_SET_CUR_ENDCASE
		

	@LCD_SET_CUR_ENDCASE:	
	ADD AH,DH
	CALL LCD_CMD
	
	
	@LCD_SET_CUR_END:
	POP AX
	RET
ENDP LCD_SET_CUR






PROC LCD_SHOW_CUR 
	PUSH AX
	MOV AH,0FH
	CALL LCD_CMD
	POP AX
	RET
ENDP LCD_SHOW_CUR




PROC LCD_HIDE_CUR

	PUSH AX
	MOV AH,0CH
	CALL LCD_CMD
	POP AX
	RET
ENDP LCD_HIDE_CUR



PROC OUT_A
	PUSH DX
	MOV DX,PA
	OUT DX,AL
	MOV PORT_A,AL
	POP DX
	RET	
ENDP OUT_A


PROC OUT_B

	PUSH DX
	MOV DX,PB
	OUT DX,AL
	MOV PORT_B,AL
	POP DX
	RET
ENDP OUT_B

PROC OUT_C
	PUSH DX
	MOV DX,PC
	OUT DX,AL
	MOV PORT_C,AL
	POP DX
	RET
ENDP OUT_C