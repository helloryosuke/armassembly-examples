#
# Program Name: FindMaxMain.s
# An assembly program to find the maximum value of 3 values
# Author: Ryosuke Inaba
# Date: 2022/7/24
# Purpose: find the maximum value of 3 values
# Inputs:
#    - num1: first user input value
#    - num2: second user input value
#    - num3: third user input value
# Outputs:
#    - largestNumMessage: largest value of 3 values
#

.text
.global main

main:

    # save return to as on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # prompt for an input of character
    LDR r0, =numPrompt
    BL printf

    # prompt for first number
    LDR r0, =nthNumPrompt
    MOV r1, #1
    BL printf

    # scan the first number
    LDR r0, =numInput
    LDR r1, =num1
    BL scanf
    LDR r0, =num1
    LDR r4, [r0]

    # prompt for second number
    LDR r0, =nthNumPrompt
    MOV r1, #2
    BL printf

    # scan the second number
    LDR r0, =numInput
    LDR r1, =num2
    BL scanf
    LDR r0, =num2
    LDR r5, [r0]

    # prompt for third number
    LDR r0, =nthNumPrompt
    MOV r1, #3
    BL printf

    # scan the third number
    LDR r0, =numInput
    LDR r1, =num3
    BL scanf
    LDR r0, =num3
    LDR r6, [r0]

    # allocate all three value to appropriate registers for BL to findMaxOf3 function
    MOV r0, r4
    MOV r1, r5
    MOV r2, r6
    
    # find maximum value
    BL findMaxOf3

    # display max number
    MOV r1, r0
    LDR r0, =largestNumMessage
    BL printf    

    # return to the os
    LDR lr, [sp, #0]
    ADD sp, sp, #4

    MOV pc, lr

.data
    numPrompt: .asciz "Enter three numbers\n"
    nthNumPrompt: .asciz "Enter number %d: "
    largestNumMessage: .asciz "Largest value is %d\n"
    numInput: .asciz "%d"
    num1: .word 0
    num2: .word 0
    num3: .word 0
