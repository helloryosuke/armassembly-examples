#
# Program Name: libValCheck.s
# Author: Ryosuke Inaba
# Date: 07/29/2022 
#
.text
.global isCharLogicalVar
.global isCharBranch

#
# Purpose: To check whether a variable value is a character or not using logical variables
# Inputs: (r0 for value is allowed)
# Outputs: (r0 is allowed)
#
isCharLogicalVar:

    # push stack
    SUB sp, sp, #4
    STR lr, [sp]

    # check that the value is greater than or equal to 0x41: A for upper case
    MOV r2, #0
    CMP r0, #0x41
    ADDGE r2, #1
    
    # and check also that the value is less or equal to 0x5A: Z for upper case
    MOV r3, #0
    CMP r0, #0x5A
    ADDLE r3, #1
    AND r2, r2, r3

    # check that the value is greater than or equal to 0x61: a for lower case
    MOV r3, #0
    CMP r0, #0x61
    ADDGE r3, #1

    # and check also that the value is less than or equal to 0x7A: z for lower case
    MOV r4, #0
    CMP r0, #0x7A
    ADDLE r4, #1
    AND r3, r3, r4
    
    # check that value is GE 0x41 and LE 0x5A OR GE 0x61 and LE 0x7A
    ORR r2, r2, r3
    
    # move the final logical variable to r0 register
    MOV r0, r2

    # pop the stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

#END isCharLogicalVar

#
# Purpose: To check whether a variable value is a character or not using branching method
# Inputs: (r0 for value is allowed)
# Outputs: (r0 is allowed)
isCharBranch:
   
    # push the stack
    SUB sp, sp, #4
    STR lr, [sp]

    # check if value is greater than or equal to 0x41: A
    CMP r0, #0x41
    # if not move to lower case check
    BLT elseif
        # check also that value is less than or equal to 0x5A: Z
        CMP r0, #0x5A
        # if not move to lower case check
        BGT elseif
            # mark as true for is character upper case
            MOV r0, #1
            B endIf

    # check if value matches a lower case value check
    elseif:
        # check if value is greater than or equal to 0x61: a
        CMP r0, #0x61
        # if not move to else
        BLT else
            # check that value is also less than or equal to 0x7A: z
            CMP r0, #0x7A
            # if not move to else
            BGT else
                # mark as true for is character lower case
                MOV r0, #1
                B endIf
    else:
        # mark as not a character
        MOV r0, #0

    endIf:
       

    # pop the stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

# END isCharBranch

.data

