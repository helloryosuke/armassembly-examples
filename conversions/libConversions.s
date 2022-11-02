#
# Program Name: libConversion.s
# Author: Ryosuke Inaba
# Date: 07/24/2022 
#
.text
.global miles2kilometers
.global kph
.global CToF
.global InchesToFeet

#
# Purpose: To convert miles value to kilometer using MUL operation for multiplication and branch linking to __aeabi_idiv (miles * 16 /10)
# Inputs: (r0 for miles value is allowed)
# Outputs: (r0 is allowed)
#
miles2kilometers:

    # push stack
    SUB sp, sp, #4
    STR lr, [sp]

    # calculate conversion of miles to kilometers (miles * 16 / 10)
    MOV r1, #16
    MUL r0, r0, r1
    MOV r1, #10
    BL __aeabi_idiv

    # pop the stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

#END miles2kilometers

#
# Purpose: To convert kilometers distance value into kilometers per hour by dividing kilometers by hours
# Inputs: (r0 for kilometers value, r1 for hours value are allowed)
# Outputs: (r0 is allowed)
# 
kph:

   # push stack
   SUB sp, sp, #4
   STR lr, [sp]

   # store hours value in r5 as r1 will be used by miles2kilometers function
   MOV r5, r1

   # calculate conversion of miles to kilometers
   BL miles2kilometers

   # relocate r5 hours value into r1
   MOV r1, r5
   # divide kilometer value by hours to calculate kilometers per hour
   BL __aeabi_idiv

   # pop the stack
   LDR lr, [sp]
   ADD sp, sp, #4
   MOV pc, lr

# END kph

#
# Purpose: To convert Celcius to Fahreinheit by multiplying by 9, dividing by 5, then adding 32
# Inputs: (r0 for Celcius value allowed)
# Outputs: (r0 is allowed)
#
CToF:
    # push stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # calculate Celcius to Fahreinheit
    MOV r1, #9
    MUL r0, r0, r1
    MOV r1, #5
    BL __aeabi_idiv
    ADD r0, r0, #32

    # pop stack
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

# END CToF

#
# Purpose: To convert Inches to Feet
# Inputs: (r0 for inch value is allowed)
# Outputs: (r0 is allowed)
#
InchesToFeet:
    # push stack
    SUB sp, sp, #4
    STR lr, [sp,#0]

    # calculate converting inches to feet by diving by 12
    MOV r1, #12
    BL __aeabi_idiv
    
    # pop stack
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

# END InchesToFeet

.data

