.data
    str_n:
    .asciiz "Enter positive integer: "
    .align 8

    str_res:
    .asciiz "Subsets are:\n"
    .align 8

    str_space:
    .asciiz " "
    .align 8

    str_newline:
    .asciiz "\n"
    .align 8

    str_empty:
    .asciiz "(empty)"
    .align 8

.text
.globl main

# s0 holds address to stack subset
# s1 holds counter for number of elements in stack subset
# s2 holds n
main:
    # INPUT
    la $a0, str_n
    li $v0, 4
    syscall

    li $v0, 5
    syscall

    # Sanity check
    ble $v0, 0, main
    move $s2, $v0
    
    # Allocate memory for array 'subset' which will store elements to print.
    mul $a0, $v0, 4
    li $v0, 9
    syscall

    move $s0, $v0
    li $s1, 0

    la $a0, str_res
    li $v0, 4
    syscall

    # Recursion
    li $a0, 1
    jal function

    li $v0, 10
    syscall

    function:
        # Entering recursive function
        addi $sp, $sp, -8
        sw $a0, 4($sp)
        sw $ra, ($sp)
        bgt $a0, $s2, print_sub         # Base case: argument (i) > n. So print.

        # Append i into 'subset' array and recursively call function
        sw $a0, ($s0)
        addu $s0, $s0, 4
        addi $s1, $s1, 1
        addi $a0, $a0, 1
        jal function

        # Pop from subset array, which pops i, and recursively call function
        addi $s1, $s1, -1
        addi $s0, $s0, -4
        jal function

        j function_return

    print_sub:
        # Get starting pointer of array and store in t1
        # t0 is the number of elements printed
        mul $t0, $s1, 4
        sub $t1, $s0, $t0
        li $t0, 0

        print_loop:
            beq $s1, 0, zero_case       # Case of empty subset
            bge $t0, $s1, end_loop      # Loop end condition, t0 >= s1

            lw $a0, ($t1)
            li $v0, 1
            syscall

            la $a0, str_space
            li $v0, 4
            syscall

            move $a0, $t3
            addi $t1, $t1, 4
            addi $t0, $t0, 1

            j print_loop

        zero_case:
            la $a0, str_empty
            li $v0, 4
            syscall

        # loop ends, print newline
        end_loop:
            la $a0, str_newline
            li $v0, 4
            syscall

    # Return from recursive function
    function_return:
        lw $a0, 4($sp)
        lw $ra, ($sp)
        addi $sp, $sp, 8
        jr $ra