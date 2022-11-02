#
# Program Name: mph2KphMain.s
# An assembly program to calculate Miles per hour to Kilometers per hour
# Author: Ryosuke Inaba
# Date: 2022/7/24
# Purpose: Calculate the conversion of Miles per hour to Kilometers per hour
# Inputs:
#    - milesInput: miles value that the users want to convert into kilometers
#    - hoursInput: hours value that the users want to convert into kilometers per hour
# Outputs:
#    - convertedMessage: converted output of kilometers per hour
#
.text
.global main

main:

    # save return to as on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # prompt for an input in miles
    LDR r0, =milesPrompt
    BL printf

    # scan miles
    LDR r0, =milesInput
    LDR r1, =milesValue
    BL scanf
    LDR r1, =milesValue
    LDR r5, [r1, #0]

    # prompt for an input of hours
    LDR r0, =hoursPrompt
    BL printf

    # scan hours
    LDR r0, =hoursInput
    LDR r1, =hoursValue
    BL scanf
    LDR r1, =hoursValue
    LDR r1, [r1, #0]

    # load parameters into r0 and r1 to pass to kph function
    MOV r0, r5

    # convert to kph
    BL kph
    MOV r1, r0

    # print kilometers per hour result
    LDR r0, =convertedMessage
    BL printf

    # return to the os
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    milesPrompt: .asciz "Enter distance in miles you want in kilometers: "
    hoursPrompt: .asciz "Enter the hours to convert speed to kilometers per hour: "
    convertedMessage: .asciz "\nConversion result: %d km/hr \n"
    milesInput: .asciz "%d"
    hoursInput: .asciz "%d"
    milesValue: .word 0
    hoursValue: .word 0
