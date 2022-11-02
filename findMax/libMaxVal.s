#
# Program Name: libMaxVal.s
# Author: Ryosuke Inaba
# Date: 07/29/2022 
#
.text
.global findMaxOf3

#
# Purpose: To find the maximum value of 3 values
# Inputs: (r0, r1, r2 are allowed)
# Outputs: (r0 is allowed)
#
findMaxOf3:

    # push stack
    SUB sp, sp, #4
    STR lr, [sp]

    # if r0 is greater than or equal to r1
    CMP r0, r1
    # if not branch to elseif
    BLT elseif
        # if r0 is greater than or equal to r2
        CMP r0, r2
        # if not branch to else
        BLT else
            # r0 is the greatest, so move to endIf
            B endIf

    # if r1 is greater than r0
    elseif:
        # if r1 is greater than or equal to r2
        CMP r1, r2
        BLT else
            # r1 is the greatest, so allocate value to r0 and move to endIf
            MOV r0, r1
            B endIf
    
    # if r0 and r1 are not greater than r2
    else:
        MOV r0, r2

    endIf:

    # pop the stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

#END isCharLogicalVar

   
.data

