.data
    str_getn:
    .asciiz "Enter a positive integer n: "
    .align 8

    str_res:
    .asciiz "Result is: "
    .align 8

.text
.globl main
# s0 holds n
main:
    # Get input
    la $a0, str_getn
    li $v0, 4
    syscall

    li $v0, 5
    syscall

    # Sanity check
    ble $v0, 0, main

    # Prepare to run function
    move $s0, $v0
    li $a0, 1
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

        # t0 holds i^k, t1 is a counter k
        move $t0, $a0
        li $t1, 1
        ble $a0, $s0, calc      # If i > n, end recursion
        j ret_function

    # loop to calculate i^i
    calc:
        beq $t1, $a0, calc_end
        mul $t0, $t0, $a0
        addi $t1, $t1, 1
        j calc

    # loop ends, add i^i to v0 and go to next recursion step
    calc_end:
        addi $a0, $a0, 1
        add $v0, $v0, $t0
        jal function

    # return from function
    ret_function:
        lw $a0, 4($sp)
        lw $ra, ($sp)
        addi $sp, $sp, 8
        jr $ra