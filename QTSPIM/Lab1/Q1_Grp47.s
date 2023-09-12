# Assignment 1
# Problem 1
# Semester 5
# Group 47
# Anit Mangal, Omair Alam


# Scheme
# t0: x
# t1: sum
# t2: counter
# t3: old sum
# t4: term
# Every iteration:
#   old sum = sum
#   counter++
#   term = term*x/counter
# Print sum and counter

.data
    x_string:
    .asciiz "Enter x: "
    newline:
    .asciiz "\n"
    print_string:
    .asciiz "\nApproximate e^x: "
    print_count:
    .asciiz "\nNumber of iterations: "

.text
.globl main
main:
    # I/O for x
    la $a0,x_string
    li $v0,4
    syscall
    li $v0,5
    syscall

    # Save x and initiliase
    move $t0,$v0
    li $t1,1
    li $t2,0
    li $t3,1
    li $t4,1

    # Loop for series
    main_loop:
        move $t3,$t1                    # old sum = sum
        addiu $t2,$t2,1                 # counter++
        mul $t4,$t4,$t0                 # term = term*x
        div $t4,$t2                     # lo = term/counter
        mflo $t4                        # term = lo
        addu $t1,$t1,$t4                # sum += term
        bne $t1,$t3 main_loop           # if old sum != sum, loop

    # Loop ends, print results
    la $a0,print_string
    li $v0,4
    syscall
    move $a0,$t1
    li $v0,1
    syscall
    la $a0,newline
    li $v0,4
    syscall
    la $a0,print_count
    syscall
    sub $t2,$t2,1
    move $a0,$t2
    li $v0,1
    syscall

    # Exit program
    li $v0,10
    syscall
