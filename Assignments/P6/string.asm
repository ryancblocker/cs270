; Begin reserved section: do not change ANYTHING in reserved section!
; The ONLY exception to this is that you MAY change the .FILL values for
; Option, Value1 and Value2. This makes it easy to initialize the values in the
; program, so that you do not need to continually re-enter them. This
; makes debugging easier as you need only change your code and re-assemble.
; Your test value(s) will already be set.
;------------------------------------------------------------------------------
; Author: Ryan Blocker
;
; Description: Tests the implementation of a simple string library and I/O
;

            .ORIG x3000
            BR Main
Functions
            .FILL Test_pack         ; (option 0)
            .FILL Test_unpack       ; (option 1)
            .FILL Test_printCC      ; (option 2)
            .FILL Test_strlen       ; (option 3)
            .FILL Test_strcpy       ; (option 4)
            .FILL Test_strcat       ; (option 5)
            .FILL Test_strcmp       ; (option 6)

; Parameters and return values for all functions
Option      .FILL 0                 ; which function to call
String1     .FILL x4000             ; default location of 1st string
String2     .FILL x4100             ; default location of 2nd string
Result      .BLKW 1                 ; space to store result
Value1      .FILL 0                 ; used for testing pack/unpack
Value2      .FILL 0                 ; used for testing pack/unpack
lowerMask   .FILL 0x00FF            ; mask for lower 8 bits
upperMask   .FILL 0xFF00            ; mask for upper 8 bits

Main        LEA R0,Functions        ; get base of jump table
            LD  R1,Option           ; get option to use, no error checking
            ADD R0,R0,R1            ; add index of array
            LDR R0,R0,#0            ; get address to test
            JMP R0                  ; execute test

Test_pack   
            LD R0,Value1            ; load first character
            LD R1,Value2            ; load second character
            JSR pack                ; pack characters
            ST R0,Result            ; save packed result
End_pack    HALT                    ; done - examine Result

Test_unpack 
            LD R0,Value1            ; value to unpack
            JSR unpack              ; test unpack
            ST R0,Value1            ; save upper 8 bits
            ST R1,Value2            ; save lower 8 bits
End_unpack  HALT                    ; done - examine Value1 and Value2

Test_printCC    
            LD R0,Value1            ; get the test value
            .ZERO R1                ; reset condition codes
            JSR printCC             ; print condition code
End_printCC HALT                    ; done - examine output

Test_strlen 
            LD R0,String1           ; load string pointer
            GETS                    ; get string
            LD R0,String1           ; load string pointer
            JSR strlen              ; calculate length
            ST R0,Result            ; save result
End_strlen  HALT                    ; done - examine memory[Result]

Test_strcpy 
            LD R0,String1           ; load string pointer
            GETS                    ; get string
            LD R0,String2           ; R0 is dest
            LD R1,String1           ; R1 is src
            JSR strcpy              ; copy string
            PUTS                    ; print result of strcpy
            NEWLN                   ; add newline
End_strcpy  HALT                    ; done - examine output

Test_strcat 
            LD R0,String1           ; load first pointer
            GETS                    ; get first string
            LD R0,String2           ; load second pointer
            GETS                    ; get second string
            LD R0,String1           ; dest is first string
            LD R1,String2           ; src is second string
            JSR strcat              ; concatenate string
            PUTS                    ; print result of strcat
            NEWLN                   ; add newline
End_strcat  HALT                    ; done - examine output

Test_strcmp 
            LD R0,String1           ; load first pointer
            GETS                    ; get first string
            LD R0,String2           ; load second pointer
            GETS                    ; get second string
            LD R0,String1           ; dest is first string
            LD R1,String2           ; src is second string
            JSR strcmp              ; compare strings
            JSR printCC             ; print result of strcmp
End_strcmp  HALT                    ; done - examine output

;------------------------------------------------------------------------------
; End of reserved section
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; on entry R0 contains first value, R1 contains second value
; on exit  R0 = (R0 << 8) | (R1 & 0xFF)
placeholder	.BLKW 1
pack			      		; fill in your code, ~11 lines of code
		AND R2, R2, #0
		AND R3, R3, #0
		AND R4, R4, #0
		LD R3, lowerMask
		ADD R4, R4, #8
		AND R0, R0, R3
		AND R1, R1, R3
loop
	    	ADD R0, R0, R0
		ADD R4, R4, #-1
		Brp loop
		ADD R2, R0, R1
		AND R0, R0, #0
		ADD R0, R2, #0
		ST R0, Result
                		RET

;------------------------------------------------------------------------------
; on entry R0 contains a value
; on exit  (see instructions)

unpack
		AND R1, R1, #0
		LD R2, lowerMask
		LD R3, upperMask
		AND R1, R1, #0
		AND R1, R0, R2
                ST R1, placeholder      ;R1 value placeholder
		AND R4, R0, R3
		.Zero R0
		ADD R0, R4, #0
		AND R4, R4, #0
		AND R2, R2, #0
		AND R3, R3, #0
		AND R1, R1, #0
		ADD R3, R3, #8		;set to 8
		ADD R4, R4, #1		;set to 1
		ADD R1, R1, #1		;set to 1
loopone
		ADD R4, R4, R4
		ADD R3, R3, #-1
		Brp loopone
looptwo
		AND R3, R0, R4
		BRz fix
		ADD R2, R2, R1
fix
		ADD R1, R1, R1
		ADD R4, R4, R4
		Brnp looptwo
        	AND R0, R0, #0
		AND R3, R3, #0
		ADD R0, R2, #0
		LD R1, placeholder
		ST R0, Value1
		ST R1, Value2
				RET

;------------------------------------------------------------------------------
; on entry R0 contains value
; on exit  (see instructions)

StringNEG   .STRINGZ "NEGATIVE\n"   ; output strings
StringZERO  .STRINGZ "ZERO\n"
StringPOS   .STRINGZ "POSITIVE\n"

printCC                       		; fill in your code, ~11 lines of code
		AND R3, R3, #0
		ADD R3, R7, #0
		AND R2, R2, #0
		ADD R2, R0, #0
		Brp addition
		Brn subtraction
		Brz zeroOut
addition
		LEA R0, StringPOS
		PUTS
		Br above
subtraction
		LEA R0, StringNEG
		PUTS
		Br above
zeroOut
		LEA R0, StringZERO
		PUTS
		Br above
above
		AND R7, R7, #0
		ADD R7, R3, #0
		AND R0, R0, #0
		ADD R0, R2, #0
				RET

;------------------------------------------------------------------------------
; size_t strlen(char *s)
; on entry R0 points to string
; on exit  (see instructions)

strlen      .Zero R1
            LD R3, ffff

Loop2       LDR R2, R0, #0
            AND R4, R2, R3
            BRnp add1
            BRz skip
 
Add1        ADD R1, R1, #1
            ADD R0, R0, #1
            BRp Loop2
            
            
skip        ADD R0, R1, #0
            ST R0, Result
            		RET

ffff        .FILL       0xffff
;------------------------------------------------------------------------------
; char *strcpy(char *dest, char *src)
; on entry R0 points to destination string, R1 points to source string
; on exit  (see instructions)

strcpy          ST R0, address  
                .Zero R0
                LD R0, address  
                ADD R3, R0, #0
                ST R0, address  
                ADD R0, R3, #0  
                .Zero R3
                ADD R3, R3, #1  
                LD R4, ffff

duplicate       .Zero R2
                LDR R2, R1, #0  
                STR R2, R0, #0     
                ADD R1, R1, R3  
                ADD R0, R0, R3 
                LDR R2, R1, #-1
                AND R2, R2, R4 
                BRnp duplicate
                
                .Zero R2       
                LD R2, final
                STR R2, R0, #-1
                .Zero R2
                LDR R2, R0, #-1
                ADD R2, R2, #-1
                STR R2, R0, #-1
                AND R0, R0, #0
                LD R0, address
            			RET

final            .FILL 0001    
address         .BLKW 1
;------------------------------------------------------------------------------
; char *strcat(char *dest, char *src)
; on entry R0 points to destination string, R1 points to source string
; on exit  (see instructions)

strcat_RA   .BLKW 1                 ; space for return address
strcat_dest .BLKW 1                 ; space for dest
strcat_src  .BLKW 1                 ; space for src

strcat      ST R7,strcat_RA         ; save return address
            ST R0,strcat_dest       ; save dest
            ST R1,strcat_src        ; save src
            
            ;LD R0, strcat_dest
            JSR strlen              
            .Zero R2                
            LD R2, strcat_dest      
            ADD R0, R0, R2          
            LD R1, strcat_src
            JSR strcpy

            LD R0,strcat_dest       
            LD R7,strcat_RA         
            			RET

;------------------------------------------------------------------------------
; int strcmp(char *s1, char *s2)
; on entry R0 points to first string, R1 points to second string
; on exit  (see instructions)

strcmp      ST R0, address      
            ST R1, address2    
            JSR strlen
            .Zero R2
            ADD R2,R0,#0       
            ST R2, count1
            .Zero R0
            LD R1, address2
            ADD R0, R1,#0       
            JSR strlen             
            .Zero R3
            ADD R3, R0, #0      
            ST R3, count2
            LD R0, address     
            .Zero R4            
            .Zero R1
            LD R2, count1

sone        LDR R1, R0, #0
            ADD R4, R1, R4
            ADD R0, R0, #1
            ADD R2, R2, #-1
            BRp sone
            ;R4 has s1 value
            LD R1, address2     
            .Zero R0            
            .Zero R2            
            LD R3, count2
            ;calculating S2 value
            ;need R3 -> length R1

stwo        LDR R0, R1,#0
            ADD R2, R0, R2
            ADD R1, R1, #1
            ADD R3, R3, #-1
            BRp stwo
            ;R2 has s2 value 
            .Zero R0
            .Zero R1
            .Zero R3
	    NOT R2, R2							
	    ADD R2, R2, #1						
            ADD R4, R4, R2         
            BRp pos
            BRz zer
            Brn neg

pos         ADD R0, R0, #1
            Br done
            
zer         .Zero R0
            Br done
            
neg         ADD R0, R0, #-1
            Br done
            
done            
            		RET

address2         .BLKW 1
count1           .BLKW 1
count2           .BLKW 1
;------------------------------------------------------------------------------
            .END
