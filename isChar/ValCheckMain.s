#
# Program Name: ValCheckMain.s
# An assembly program to check whether a user input value is a character or not
# Author: Ryosuke Inaba
# Date: 2022/7/24
# Purpose: check whether a user input value is a character or not
# Inputs:
#    - charInput: user input to check whether it is a character or not
# Outputs:
#    - isCharMessage (LogicalVar/Branch): output message to inform user that the input value is a character
#    - notCharMessage (Logical/Branch): output message to inform user that the input value is not a character
#

.text
.global main

main:

    # save return to as on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # prompt for an input of character
    LDR r0, =charPrompt
    BL printf

    # scan character
    LDR r0, =charInput
    LDR r1, =charValue
    BL scanf
    LDR r0, =charValue
    LDR r5, [r0]

    # branch to isCharLogicalVar method for character check
    MOV r0, r5
    BL isCharLogicalVar
   
    # display output prompt based on the function return value 
    CMP r0, #1
    BNE notCharLogicalVar
        LDR r0, =isCharMessageLogicalVal
        B endIfLogicalVar
    notCharLogicalVar:
        LDR r0, =notCharMessageLogicalVal
    endIfLogicalVar:

    BL printf

    # branch to isCharBranch method for character check
    MOV r0, r5
    BL isCharBranch
    
    # display output prompt based on the function return value
    CMP r0, #1
    BNE else
        LDR r0, =isCharMessageBranch
        B endIfBranch
    else:
        LDR r0, =notCharMessageBranch
    endIfBranch:

    BL printf
 
    # return to the os
    LDR lr, [sp, #0]
    ADD sp, sp, #4

    MOV pc, lr

.data
    charPrompt: .asciz "Enter a value to check if it's a character: "
    isCharMessageLogicalVal: .asciz "Logical Value: The entered value is a character\n"
    notCharMessageLogicalVal: .asciz "Logical Value: The entered value is not a character\n"
    isCharMessageBranch: .asciz "Branching: The entered value is a character\n"
    notCharMessageBranch: .asciz "Branching: The entered value is not a character\n"
    charInput: .asciz "%s"
    charValue: .space 1
