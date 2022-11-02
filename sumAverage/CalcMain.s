#
# Program Name: CalcMain.s
# An assembly program to allow user to enter multiple numbers and it will calculate the sum and average
# Author: Ryosuke Inaba
# Date: 2022/8/23
# Purpose: to calculate the count, total, and average of all the numbers inputted by the user
#
# Inputs:
#    - numValue: user input value to append additional values to include in the calculation
# Outputs
#    - resultMessage: resulting output showing the total number of values entered, sum, and average of all the numbers
#
.text
.global main

main:

    # save return to as on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # initialize store values of sum and count
    # r5 for total, r6 for count
    MOV r5, #0
    MOV r6, #0

    startLoop:

        # prompt for an input of number to include in caclulation
        LDR r0, =numPrompt
        BL printf

        # scan the number
        LDR r0, =numFormat
        LDR r1, =numValue
        BL scanf
        LDR r1, =numValue
        LDR r4, [r1] 

        # If input is -1, branch to exit
        CMP r4, #-1
        BEQ exit
            # if the value is not equal to -1, 
            # consider the input as number to include in calculation by adding number to total
	    ADD r5, r5, r4
            # add 1 to counter
            ADD r6, r6, #1
            B startLoop
        
    exit:
        # calculate average by dividing sum by count of numbers
        MOV r0, r5
        MOV r1, r6
        BL __aeabi_idiv

        # output result
        MOV r3, r0
        LDR r0, =resultMessage
        MOV r1, r6
        MOV r2, r5
        BL printf

    # return to the os
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr    

.data
    numPrompt: .asciz "Enter a number to include in calculation (enter -1 to exit and show result) : "
    numFormat: .asciz "%d"
    numValue: .word 0
    resultMessage: .asciz "Number of values: %d | Sum: %d | Average: %d\n"
