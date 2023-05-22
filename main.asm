include 'emu8086.inc'
.model small
org 100h

.data   
                                                                 
            num1 dw 00h
            num2 dw 00h
            ovrflw db 00h
   
.code      
            mov ax, @data                                      
            mov ds, ax                                          
            
            
            
            
    calculator: 
     
            call input                                          ;calling input proc
    
            call parser                                         ;calling parser proc
    
            call operation                                      ;calling operation proc
            
            mov [si],'&'                                        ;to indicate the end of result in DS
                                                                  
            call reverse_parser                                 ;calling reverse_parser proc
            
            call print_result                                   ;calling print_result proc
 


 
 
 input  proc                                                    
                
      message1:
                mov [si], '&'                                   ;to mark end of input1 in segment
                print "Enter first  Number : "                  ;print text
                
       
                                                                ;take first input
        input1:          
                mov ah, 1                                       ;function to read input from the keyboard
                int 21h
                                                                
                cmp al, 13                                      ;to check if enter is pressed
                je  message2                                    ;if yes, jump to 2nd input
                
                mov ah, al
                sub ah, '0'                                     ;to check if entered number is between 0 to 9
                jc invalid                                      ;if not, jump to show Invalid
                
                mov ah, al 
                mov dh, '9'
                sub dh, ah                                      ;to check if entered number is between 0 to 9
                jc invalid                                      ;if not, jump to invalid
                
                sub al, '0'                                     ;to SUB the ASCII value 0 to convert the character into corresponding number
                inc si                                          ;increment si
                                                                
                mov [si], al                                    ;store the input value at incremented si
                jmp input1                                      ;jump back to input1 if enter is not pressed   
                
               
                
      message2:
                inc si                                          ;increment si
                mov [si], '&'                                   ;The end of input2
                
                printn                                          ;print new line
                print "Enter Second Number : "                  ;print text
                
                                   
        input2:
                mov ah, 1                                       ;function to read input from the keyboard
                int 21h
                                                                
                cmp al, 13                                      ;to check if enter is pressed
                jz  exit                                        ;if yes, jump to exit
                
                mov ah, al
                sub ah, '0'                                     ;to check if entered number is between 0 to 9
                jc invalid                                      ;if not, jump to invalid
                
                mov ah, al 
                mov dh, '9'
                sub dh, ah                                      ;to check if entered number is between 0 to 9
                jc invalid                                      ;if not, jump to invalid
                
                sub al, '0'                                     ;to SUB the ASCII value 0 to convert the character into corresponding number
                inc si                                          ;increment si
                                                                
                mov [si], al                                    ;store the input value at incremented si
                jmp input2                                      ;jump back to input2 if enter is not pressed 
                
        exit:              
                ret
                
                
       invalid:                                                 ;if the text entered is not a digit between 0 and 9
                printn
                print "Invalid Input"                           ;print text
                hlt
                
                
 endp                                                           




 parser proc                                                    
    
  
                mov cx, 1                                       ;initializing cx 
                mov bx, 00h                                     ;initializing bx   
                
        parse2:
          
                mov ax, 00h                                     ;initializing ax
                
                mov al, [si]                                    ;store the digit at [si] to al
                
                mul cx                                          ;multiply ax with cx
                
                add bx, ax                                      ;store the result of multiplication in bx
                
                mov ax, cx                                      ;store the contents of cx in ax
                
                mov cx, 10                                      ;initializing cx with 10
                mul cx                                          ;multiply ax with cx
                
                mov cx, ax                                      ;store contents of ax in cx
                
                dec si                                          ;decrement si
                cmp [si], '&'                                   ;check if the end of segment is reached or not
                
                jnz parse2                                      ;if not, jump back to parse2
                
                mov [num2],bx                                   ;storing the parsed number as num2
                
                mov bx,00H                                      ;clearing bx         
                mov dx,00h                                      ;clearing dx
                
                dec si                                          ;decrement si
                
                mov cx, 1                                       ;setting cx value to 1
                
         parse1:
           
                mov ax,00h                                      ;initializing ax
                
                mov al,[si]                                     ;store the digit stored at [si] to al
                
                mul cx                                          ;multiplying ax with cx
                
                add bx,ax                                       ;add the multiplication with bx
                
                mov ax,cx                                       ;store cx into ax
                
                mov cx,10                                       ;initializing cx with 10
                mul cx                                          ;multiplying ax with cx
                
                mov cx,ax                                       ;store ax into cx
                dec si                                          ;decrement si
                
                cmp [si],'&'                                    ;checkl if end of segment has been reached or not
                jnz parse1                                      ;if not, jump back to parse1
                
                mov [num1],bx                                   ;store the parsed first number at num1
                mov ax,[num1]                                   ;store the parsed first number in ax
                mov bx,[num2]                                   ;store the parsed second number in bx
                 
                
        ret                                                                                                     
 endp                                                           
       
       
        
  
  
  
       

       
       
 operation proc                                                
    
    
               mov cx,ax                                        ;storing the value of ax in cx
               printn
               print "Enter operator (+,-,*,/,%,^) :  "         ;print text to choose operator
                
                
               mov ah,1                                         ;function to read input from the keyboard
               int 21h                                          
               
               cmp al,'+'                                       ;check if the entered operator is '+'
               je addition                                      ;jump to addition if entered operator is '+'
               
               cmp al,'-'                                       ;check if the entered operator is '-'
               je subtraction                                   ;jump to subtraction if entered operator is '-'
               
               cmp al,'*'                                       ;check if the entered operator is '*'
               je multiplication                                ;jump to multiplication if entered operator is '*'
               
               cmp al,'/'                                       ;check if the entered operator is '/'
               je division                                      ;jump to division if entered operator is '/'
               
               cmp al,'%'                                       ;check if the entered operator is '%'
               je mod                                           ;jump to mod if entered operator is '%' 
               
               cmp al,'^'                                       ;check if the entered operator is '^'
               je pow                                           ;jump to pow if entered operator is '^'
           
               print "Invalid Input"                            ;To display invaid message (If operatot entered is NOT '+' OR '-' OR '*' OR '/' OR '^')
               hlt
               
       
       addition:
                mov ax,cx                                       ;copy number1 to ax from cx
                
                mov dx,00h                                      ;clearing dx
                
                add ax,bx                                       ;add input 1 and 2
                adc ax,dx                                       ;add carry to ax and storing the result in ax
                
                ret
                
    subtraction:
                
                mov ax,cx                                       ;copy number1 to ax from cx
                
                sub ax,bx                                       ;subtract input 2 from input 1 
                
                jc overflow                                     ;if negative, go to overflow
                jnc notflw                                      ;if not, jump to ntflw
                
       overflow:
       
                neg ax                                          ;store 01h to ovrflw variable
                mov [ovrflw],01h
                
                ret
                
            notflw:
                ret
             
                
 multiplication:
                
                mov ax,cx                                       ;copy number1 to ax from cx
                mov dx,00h                                      ;clearing dx
                
                mul bx                                          ;multiply input 1 and 2
                ret
                
       division:
                
                mov ax,cx                                       ;copy number1 to ax from cx
                mov dx,00h                                      ;clearing dx
                
                add bx,dx                                       ;add bx with dx
                jz zero                                         ;if result is zero, then jump to zero
                
                div bx                                          ;if not, divide input 1 by input 2
                ret
                
         zero:  
                                                                ;if dividing with zero is attempted
                print "ERROR : can not divide by zero"
                printn
                
                jmp calculator
                              
                              
          mod:
                mov ax,cx                                       ;copy number1 to ax from cx
                mov dx,00H                                      ;clearing dx
                
                add bx,dx                                       ;add bx with dx
                jz dzero                                        ;if result is zero, then jump to dzero
                
                div bx                                          ;if not, divide input 1 by input 2
                mov ax,dx                                       ;moving remainder in ax from dx
         dzero: 
         
                ret
           
           pow:
                mov ax,cx                                       ;copy input 1 to ax from cx
                mov cx,bx                                       ;store input 2 in cx
                
                add cx,00h                                      ;add cx with 00h
                jz lc                                           ;if zero jump to lc
                   
                sub cx,01h                                      ;sub 01h from cx 
                jz la                                           ;if zero, jump to la
                                                                
                jnz lb                                          ;if not, jump to lb
                
                
           la:  
           
                ret
                                            
           lb:  mov bx,ax                                       ;storing value of ax in bx
                mov dx,00h                                      ;clearing dx
                
           ld:  mul bx                                          ;multiply with bx
           
                loop ld                                         ;continue loop
                ret
                
           lc:  mov ax,01h
                ret                                     
                                  
 endp                                                         
                  









                
 reverse_parser proc                                           
     
        r_parse:
                mov dx,00h                                      ;clearing dx
                
                mov bx,10                                       ;store 10 in bx
                
                div bx                                          ;divide ax with 10 
                
                add dl,'0'                                      ;add ASCII value of 0 to convert from number to character   
                                        
                inc si             
                mov [si],dl                                        
                
                add ax,00h                                         
                
                jnz r_parse                                     ;repeat the reverse_parse       
                           
            
endp                                                           
 
 
 
 





 
 
 
 print_result proc                                             
              
              printn
              print "Result is: "
              
              mov cl,01h                                        ;initailizing CL with 01h
              cmp cl,[ovrflw]                                   ;to check the overflow  
              
              mov [ovrflw],00h
              
              jz print_minus                                    ;if there is over flow, jump to print_minus
              jnz print                                         ;if not, jump to print
                                                                          
                                                                          
 print_minus:                                                   ;to print a minus in case of overflow
 
              mov dl,'-'                                           
              mov ah,2                                             
              int 21h                                            
 
       print: 
              mov dl,[si]                                       
              mov ah,2                                          
              int 21h                                           
              
              dec si                                            ;decrement si
              
              cmp [si],'&'                                      ;to check if end of segment is reached or not
              jnz print                                         ;if not, jump back to print the next digit
              
              printn
              printn 
     
              jmp calculator                                    ;jump back to calculator to restart the calculator
 
endp                            
