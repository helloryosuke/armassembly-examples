#
# Program Name: FibonacciMain.s
# An assembly program to allow user to calculate the Fibonacci number recursively
# Author: Ryosuke Inaba
# Date: 2022/8/7
# Purpose: to calculate the Fibonacci number
#
# Inputs:
#    - numValue: user input value for calcuating the Fibonacci value
# Outputs:
#    - resultOutput: message to show the result of the Fibonacci calculation
#

.text
.global main

main:

    # save return to as on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # prompt for first number
    LDR r0, =numPrompt
    BL printf

    # scan the number input
    LDR r0, =numFormat
    LDR r1, =numValue
    BL scanf
    LDR r1, =numValue
    LDR r0, [r1]

    # execute Fibonacci
    BL Fib
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
Fib:
    # save returns on stack
    SUB sp, sp, #24
    STR lr, [sp]
    STR r4, [sp, #4]
    STR r5, [sp, #8]
    STR r6, [sp, #16]
    
    # save argument in r4
    MOV r4, r0

    # if (n<=2) return 1
    CMP r4, #2
    BGT Else
        MOV r0, #1
        B Return

    # else return Fib(n-1) + Fib(n-2)
    Else:
        # calculate Fib(n-1)
        SUB r0, r4, #2
        BL Fib
        MOV r5, r0

        # calculate Fib(n-2)
        SUB r0, r4, #1
        BL Fib

        # add Fib(n-1) and Fib(n-2)
        ADD r0, r0, r5
        B Return

    EndIf:

    Return:
    LDR lr, [sp]
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    LDR r6, [sp, #16]
    ADD sp, sp, #24
    MOV pc, lr

# END Fib

.data
    numPrompt: .asciz "Enter a number to calculate the Fibonacci: "
    numFormat: .asciz "%d"
    numValue: .word 0
    resultOutput: .asciz "Result is: %d\n"
