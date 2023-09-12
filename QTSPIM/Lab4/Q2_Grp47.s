.data
    str_n:
    .asciiz "Enter positive integer: "
    .align 8
    str_res:
    .asciiz "Result is: "
    .align 8

.text
.globl main
main:
    # Get input
    la $a0, str_n
    li $v0, 4
    syscall

    li $v0, 5
    syscall

    # Sanity check
    ble $v0, 0, main

    # Prepare for recursion
    move $a0, $v0
    li $v0, 0
    jal function

    # Print output
    move $t0, $v0
    la $a0, str_res
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    li $v0, 10
    syscall

    function:
        # stack operations on entering function
        addi $sp, $sp, -8
        sw $a0, 4($sp)
        sw $ra, ($sp)
        bne $a0, 1, calc        # if i == 1, end recursion
        j funct_return

        # i != 1 case
        calc:
            # Get i/2 and i%2
            li $t1, 2
            div $a0, $t1
            mfhi $t0
            bne $t0, 0, odd_case    # if i is odd, go to odd_case

            even_case:
                mflo $a0            # get i/2 as argument
                j case_end

            odd_case:
                mul $a0, $a0, 3
                addi $a0, $a0, 1       # get 3*i+1 as argument

            case_end:
                addi $v0, $v0, 1        # add 1 to result
                jal function            # recursive call

    # return from function
    funct_return:
        lw $a0, 4($sp)
        lw $ra, ($sp)
        addi $sp, $sp, 8
        jr $ra