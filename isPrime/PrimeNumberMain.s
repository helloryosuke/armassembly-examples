#
# Program Name: PrimeNumberMain.s
# An assembly program to allow user to check whether a number is a prime number
# Author: Ryosuke Inaba
# Date: 2022/7/29
# Purpose: to check whether a value is a prime number by calculating the remainder of the n+1 and n-1 values
# divided by 6 and checking if the its is equal to zero
#
# Inputs:
#    - numValue: user input value to check whether number is a prime number
# Outputs:
#    - (is/not)PrimeMessage: message to inform whether the value is a prime number
#    - errorMessage: message to inform user if invalid value is entered

.text
.global main

main:

    # save return to as on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # initialize
    # prompt for an input of number
    LDR r0, =numPrompt
    BL printf

    # scan the max number
    LDR r0, =numFormat
    LDR r1, =numValue
    BL scanf
    LDR r1, =numValue
    LDR r5, [r1]

    startLoop:
        # if the value is less than or equal to -2, throw an error
        CMP r5, #-2
        BLE error
            # if the value is equal to -1, go to exit operation
            CMP r5, #-1
            BEQ exit
                # if the value is less than or equal to 2 (and greater than -1 from proceeding logic), then throw error
                CMP r5, #2
                BLE error
                    # all else is a valid number
                    B validNumber
        
        # if an invalid value is entered display error message
        error:
            LDR r0, =errorMessage
            BL printf
            B continueLoop

        validNumber:
            # calculate the +1 number
            ADD r6, r5, #1
            
            # calculate the -1 number
            SUB r7, r5, #1
            
            # modular operation for +1 number
            MOV r0, r6
            MOV r1, #6
            BL __aeabi_idiv
            MOV r1, #6
            MUL r2, r0, r1
            SUB r6, r6, r2
            
           # modular operation for -1 number
            MOV r0, r7
            MOV r1, #6
            BL __aeabi_idiv
            MOV r1, #6
            MUL r2, r0, r1
            SUB r7, r7, r2
            
            # check if the remainder of either n+1 or n-1 value is 0, then number is prime
            CMP r6, #0
            BEQ isPrime
                CMP r7, #0
                BEQ isPrime
                    B notPrime

        # inform user that value is a prime number
        isPrime:
            LDR r0, =isPrimeMessage
            BL printf
            B continueLoop
        # inform user that value is not a prime number
        notPrime:
            LDR r0, =notPrimeMessage
            BL printf

        # continue loop and prompt the user to enter a number again
	continueLoop:
            LDR r0, =numPrompt
            BL printf
            LDR r0, =numFormat
            LDR r1, =numValue
            BL scanf
            LDR r1, =numValue
            LDR r5, [r1]
            B startLoop
        
    exit:

    # return to the os
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr    

.data
    numPrompt: .asciz "Enter a number to check if it is a prime number (enter -1 to exit) : "
    numFormat: .asciz "%d"
    numValue: .word 0
    isPrimeMessage: .asciz "Number is a prime number\n"
    notPrimeMessage: .asciz "Number is not a prime number\n"
    errorMessage: .asciz "Invalid value entered\n"
