#
# Program Name: CToF_InchesToFt_TestMain.s
# An assembly program to test functions for converting celcius to fahreinheit and inches to feet
# Author: Ryosuke Inaba
# Date: 2022/7/24
# Purpose: Calcuate celcius to fahreinheit and inches to feet
# Inputs:
#    - celciusInput: celcius value that the user wants to convert to fahreinheit
#    - inchInput: inch value that the user wants to convert to feet
# Outputs:
#    - convertedTempMessage: converted output of fahreinheit
#    - convertedLengthMessage: converted outut of feet
#
.text
.global main

main:

    # save return to as on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # prompt for an input of celcius
    LDR r0, =celciusPrompt
    BL printf

    # scan celcius
    LDR r0, =celciusInput
    LDR r1, =celciusValue
    BL scanf
    LDR r1, =celciusValue
    LDR r0, [r1, #0]

    # convert to kph
    BL CToF
    MOV r1, r0

    # print kilometers per hour result
    LDR r0, =convertedTempMessage
    BL printf

    # prompt for an input of inches
    LDR r0, =inchPrompt
    BL printf

    # scan inch
    LDR r0, =inchInput
    LDR r1, =inchValue
    BL scanf
    LDR r1, =inchValue
    LDR r0, [r1, #0]

    # convert inches to feet
    BL InchesToFeet
    MOV r1, r0

    # print feet
    LDR r0, =convertedLengthMessage
    BL printf

    # return to the os
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    celciusPrompt: .asciz "Enter temperature in Celcius you want to convert to Fareinheit: "
    inchPrompt: .asciz "Enter inches you want to convert to feet: "
    convertedTempMessage: .asciz "\nConversion result for Celcius: %d F\n"
    convertedLengthMessage: .asciz "\nConversion result for Feet: %d ft\n"
    celciusInput: .asciz "%d"
    inchInput: .asciz "%d"
    celciusValue: .word 0
    inchValue: .word 0
