# Assignment 3
# Problem 1
# Semester 5
# Group 47
# Anit Mangal, Omair Alam

# Strings to be printed
.data
    str_numel:
    .asciiz "Enter number of elements: "
    .align 8
    str_el:
    .asciiz "Enter elements of array one in each line.\n"
    .align 8
    str_res:
    .asciiz "Max sum is: "
    .align 8

# CODE
.text
.globl main
# s0 holds n
# s1 holds pointer to arr
# s2 holds maxsum
# s4 holds i in for loop
# s5 holds maxsum returned by func

# t0 iterator for number of array elements
# t1 pointer to arr+t0
# t2 arr[i]
main:
    # INPUT
    la $a0, str_numel
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $s0, $v0

    sll $a0, $s0, 2
    li $v0, 9
    syscall
    move $s1, $v0

    la $a0, str_el
    li $v0, 4
    syscall

    li $t0, 0
    move $t1, $s1
    loop:
        li $v0, 5
        syscall
        sw $v0,($t1)

        addi $t0, $t0, 1
        addi $t1, $t1, 4
        blt $t0, $s0, loop
    
    # PROCESSING
    li $s2, 0
    li $s4, 0
    move $t1, $s1
    mainloop:
        beq $s4, $s0, exit_mainloop  # if i == n, exit for loop
        # enter function, argument is 'start'
        move $a0, $s4
        jal funct
        bgt $v0, $s2, update_max        # update maxsum according to function's return value
        addi $s4, $s4, 1
        b mainloop

    update_max:
        move $s2, $v0
        b mainloop

    # OUTPUT
    exit_mainloop:
        la $a0, str_res
        li $v0, 4
        syscall

        move $a0, $s2
        li $v0, 1
        syscall

        li $v0, 10
        syscall


    # FUNCTION

    # $t1: holds (arr+i)
    # $t2: return maxsum, starting at start
    # $t3: holds arg start in funct
    # $t4: holds iterator i of funct
    # $t5: temp calc
    # $t6: holds currsum
    # $t7: get arr[i]
    funct:
        move $t3, $a0
        move $t1, $s1
        sll $t5, $t3, 2
        add $t1, $t1, $t5

        # init curr sum
        lw $t6, ($t1)
        move $t2, $t6

        # i = (start+1)%n
        addi $t4, $t3, 1
        div $t4, $s0
        mfhi $t4

        funct_loop:
            beq $t4, $t3, exit_functloop
            
            # Set t1 as pointer to arr+i
            move $t1, $s1
            sll $t5, $t4, 2
            add $t1, $t1, $t5

            lw $t7, ($t1)
            add $t6, $t6, $t7
            bgt $t6, $t2, update                # currsum > maxsum
            b inc_floop
        update:
            move $t2, $t6
        inc_floop:
            addi $t4, $t4, 1
            div $t4, $s0
            mfhi $t4
            b funct_loop
        # return from function
        exit_functloop:
            move $v0, $t2
            jr $ra