; P5 Assignment
; Author: <RyanBlocker>
; Date:   <12/04/2001>
; Email:  <rblocker.colostate.edu>
; Class:  CS270
;
; Description: Implements the arithmetic, bitwise, and shift operations

;------------------------------------------------------------------------------
; Begin reserved section: do not change ANYTHING in reserved section!

                .ORIG x3000
                BR Main

Functions       .FILL IntAdd         ; Address of IntAdd routine          (option 0)
                .FILL IntSub         ; Address of IntSub routine          (option 1)
                .FILL IntMul         ; Address of IntMul routine          (option 2)
                .FILL BinaryOr       ; Address of BinaryOr routine        (option 3)
                .FILL BinaryXOr      ; Address of BinaryXOr routine       (option 4)
                .FILL LeftShift      ; Address of LeftShift routine       (option 5)
                .FILL RightArithShift; Address of RightArithShift routine (option 6)

Main            LEA R0,Functions     ; The main routine calls one of the 
                LD  R1,Option        ; subroutines below based on the value of
                ADD R0,R0,R1         ; the Option parameter.
                LDR R0,R0,0          ;
                JSRR R0              ;
EndProg         HALT                 ;

; Parameters and return values for all functions
; Try changing the .BLKW 1 to .FILL xNNNN where N is a hexadecimal value or #NNNN
; where N is a decimal value, this can save you time by not having to set these 
; values in the simulator every time you run your code. This is the only change 
; you should make to this section.
Option          .FILL #0             ; Which function to call
Param1          .BLKW 1              ; Space to specify first parameter
Param2          .BLKW 1              ; Space to specify second parameter
Result          .BLKW 1              ; Space to store result

; End reserved section: do not change ANYTHING in reserved section!
;------------------------------------------------------------------------------

; You may add variables and functions after here as you see fit.

;------------------------------------------------------------------------------
IntAdd                               ; Result is Param1 + Param2
		LD R1,Param1 	     ; Your code goes here (~4 lines)
		LD R2,Param2         ;
		ADD R2,R1,R2         ;
		ST R2,Result         ; Store the Result in R0 
                RET
;------------------------------------------------------------------------------
IntSub
                LD R1,Param1         ; Result is Param1 - Param2
		LD R2,Param2         ; Your code goes here (~6 lines)
		NOT R2,R2            ;
		ADD R2,R2,#1         ;
		ADD R0,R1,R2         ;
		ST  R0,Result        ;
                RET
;------------------------------------------------------------------------------
IntMul 
                AND R3,R3,#0         ; Result is Param1 * Param2
		LD R1,Param1         ; Your code goes here (~9 lines)
		BRz Stop             ;
		LD R2,Param2         ;
		BRz Stop             ;
LoopMultiply
		ADD R3,R3,R1         ;
		ADD R2,R2,#-1        ;
		BRp LoopMultiply     ;
Stop
		ST R3,Result         ;
		RET
;------------------------------------------------------------------------------
BinaryOr
		LD R1,Param1         ; Result is Param1 | Param2
                LD R2,Param2         ; Your code goes here (~7 lines)
		NOT R1,R1            ; Not R1 and R2
		NOT R2,R2            ;
		AND R0,R1,R2         ;
		NOT R0,R0            ;
		ST R0,Result         ; Store Result in R0
                RET
;------------------------------------------------------------------------------
BinaryXOr
                LD R1,Param1         ; Result is Param1 ^ Param2
                LD R2,Param2         ; Your code goes here
		NOT R1,R1            ; 
		AND R3,R1,R2         ;
		NOT R1,R1            ;
		NOT R2,R2            ;
		AND R4,R1,R2         ;
		NOT R2,R2            ;
		NOT R3,R3            ;
		NOT R4,R4            ;
		AND R3,R3,R4         ;
		NOT R3,R3            ;
		ST R3,Result         ;
                RET
;------------------------------------------------------------------------------
LeftShift 
                LD R1,Param1         ; Result is Param1 << Param2
                LD R2,Param2         ; (Fill vacant positions with 0's)
                AND R0,R0,#0         ; Your code goes here (~7 lines)
		AND R0,R0,R1         ;
LoopLeftShift
		ADD R0,R0,R0         ;
		ADD R2,R2,#-1        ;
		BRp LoopLeftShift    ;
		ST R0,Result         ;
                RET
;------------------------------------------------------------------------------
RightArithShift
                                     ; Result is Param1 >> Param2 with sign extension
                                     ; Your code goes here (~23 lines)
                RET
;------------------------------------------------------------------------------
                .END
