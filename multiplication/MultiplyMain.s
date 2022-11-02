#
# Program Name: MultiplyMain.s
# An assembly program to allow user to multiply two numbers using a recursion
# Author: Ryosuke Inaba
# Date: 2022/8/7
# Purpose: to multiply two numbers using a recursion
#
# Inputs:
#    - num1: user input value for multiplying a number
#    - num2: user input value for multiplying num1 by
# Outputs:
#    - resultOutput: message to show the result of the multiplication
#

.text
.global main

main:

    # save return to as on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # prompt for first number
    LDR r0, =num1Prompt
    BL printf

    # scan the number input
    LDR r0, =numFormat
    LDR r1, =numValue
    BL scanf
    LDR r1, =numValue
    LDR r4, [r1]

    # prompt for second number to multiply by
    LDR r0, =num2Prompt
    BL printf

    # scan the number input
    LDR r0, =numFormat
    LDR r1, =numValue
    BL scanf
    LDR r1, =numValue
    LDR r5, [r1]

    # execute Mult
    MOV r0, r4
    MOV r1, r5
    BL Mult
    MOV r1, r0

    # print result
    LDR r0, =resultOutput
    BL printf

    # return to the os
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

#END main

.text
Mult:

    # save return on stack
    SUB sp, sp, #8
    STR lr, [sp]
    STR r4, [sp, #4]

    # save argument m in r4 and n in r5
    MOV r4, r0
    MOV r5, r1

    # if (n==1) then return m
    CMP r5, #1
    BNE Else
        MOV r0, r4
        B Return

    # else return m + (n-1)
    Else:
        SUB r1, r5, #1
        BL Mult
        ADD r0, r4, r0
        B Return

    EndIf:

    Return:
    LDR lr, [sp]
    LDR r4, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr

# END Mult

.data
    num1Prompt: .asciz "Enter a number to multiply: "
    num2Prompt: .asciz "Enter a number to multiply by: "
    numFormat: .asciz "%d"
    numValue: .word 0
    resultOutput: .asciz "Result is: %d\n"
