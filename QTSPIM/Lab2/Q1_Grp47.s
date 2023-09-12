.data
    # Allocate space for 10 integers in each array (40 bytes)
    arr1:
    .space 40
    arr2:
    .space 40
    vis:
    .space 40
    # Strings to be used
    str_get_num_cycles:
    .asciiz "\nEnter number of cycles in permutation: "
    str_get_cycle:
    .asciiz "\nEnter cycle (use -1 to continue): "
    str_perm:
    .asciiz "\nProduct permutation cycle "
    str_is:
    .asciiz " is: "
    str_space:
    .asciiz " "
    str_newline:
    .asciiz "\n"

.text
.globl main
# t0 holds number of cycles
# t7 for holding iteration count (multiplied by 4)
# t3 for holding iteration count
# t6 for start
# t5 for curr
# t4 for prev
# s0 pointer to arr1
# s1 pointer to arr2
# s2 to store temp pointer locations to be accessed
# s3 pointer to vis
main:
    # INITIALIZE ALL ARRAYS
    la $s0,arr1
    la $s1,arr2
    la $s3,vis

    li $t7,0
    li $t3,0
    init_loop1:         # arr1[i] = i
        add $s2,$s0,$t7
        sw $t3,($s2)
        addi $t7,$t7,4
        addi $t3,$t3,1
        blt $t7,40,init_loop1

    li $t7,0
    li $t3,0
    init_loop2:         # arr2[i] = i
        add $s2,$s1,$t7
        sw $t3,($s2)
        addi $t7,$t7,4
        addi $t3,$t3,1
        blt $t7,40,init_loop2

    li $t7,0
    init_loop3:         # vis[i] = 0
        add $s2,$s3,$t7
        sw $0,($s2)
        addi $t7,$t7,4
        blt $t7,40,init_loop3

    # INPUT STARTS HERE

    la $a0,str_get_num_cycles
    li $v0,4
    syscall

    li $v0,5
    syscall
    move $t0,$v0
    li $t7,0

    beq $t0,$t7,input_perm2     # If number of cycles is 0, skip

    input_perm1:                # Cycles loop for first permutaion
        la $a0,str_get_cycle
        li $v0,4
        syscall

        li $v0,5
        syscall

        move $t6,$v0
        move $t4,$t6
        input_loop1:            # Takes a cycle as input and processes. Press enter whenever you write an integer and -1 to exit.
            li $v0,5
            syscall
            move $t5,$v0
            beq $t5,-1, exit_loop1
            mul $t4,$t4,4
            add $s2,$s0,$t4
            sw $t5,($s2)
            move $t4,$t5
            b input_loop1

        exit_loop1:             # Do final changes when loop ends
            mul $t4,$t4,4
            add $s2,$s0,$t4
            sw $t6,($s2)
        
        addi $t7,$t7,1
        blt $t7,$t0,input_perm1

    
    la $a0,str_get_num_cycles
    li $v0,4
    syscall

    li $v0,5
    syscall
    move $t0,$v0
    li $t7,0

    beq $t0,$t7,output
    input_perm2:                # Cycles loop for first permutaion
        la $a0,str_get_cycle
        li $v0,4
        syscall

        li $v0,5
        syscall

        move $t6,$v0
        move $t4,$t6
        input_loop2:            # Takes a cycle as input and processes. Press enter whenever you write an integer and -1 to exit.
            li $v0,5
            syscall
            move $t5,$v0
            beq $t5,-1, exit_loop2
            mul $t4,$t4,4
            add $s2,$s1,$t4
            sw $t5,($s2)
            move $t4,$t5
            b input_loop2

        exit_loop2:                # Do final changes when loop ends
            mul $t4,$t4,4
            add $s2,$s1,$t4
            sw $t6,($s2)
        
        addi $t7,$t7,1
        blt $t7,$t0,input_perm2

    output:
        # t0 for cyclecount
        # t7 for iterations of a
        # t4 holds arr1[a]
        # t5 holds arr2[arr1[a]]
        # t6 holds t7/4 = a (actual)
        # t1 holds res
        # t2 holds res*4
        # t3 holds 1
        # s4 holds arr1[res]
    li $t0,1
    li $t7,0
    b loop_a            # Unconditionally go to loop_a

    cond_2:
        la $a0,str_perm
        li $v0,4
        syscall

        move $a0,$t0
        li $v0,1
        syscall

        la $a0,str_is
        li $v0,4
        syscall

        move $t1,$t6

        out_loop:                       # PRINT CYCLE
            move $a0,$t1
            li $v0,1
            syscall
            la $a0,str_space
            li $v0,4
            syscall

            mul $t2,$t1,4
            add $s2,$s0,$t2
            lw $s4,($s2)
            mul $s4,$s4,4
            add $s2,$s4,$s1
            lw $t1,($s2)

            mul $s4,$t1,4
            add $s2,$s4,$s3
            li $t3,1
            sw $t3,($s2)

            bne $t1,$t6,out_loop
        add $t0,$t0,1
        b inc_a
    cond_1:
        add $s2,$s0,$t7
        lw $t4,($s2)
        mul $t4,$t4,4
        add $s2,$s1,$t4
        lw $t5,($s2)
        li $t3,4
        div $t7,$t3
        mflo $t6
        bne $t6,$t5,cond_2            # SECOND IF CONDITION
    inc_a:
        add $t7,$t7,4
        la $a0,str_newline
        li $v0,4
        syscall
        b loop_a                    # GO TO LOOP AND CONTINUE
    loop_a:
        beq $t7,40,exit_loop
        add $s2,$s3,$t7
        lw $s5,($s2)
        beq $s5,0,cond_1            # FIRST IF CONDITION

    exit_loop:
    li $v0,10
    syscall