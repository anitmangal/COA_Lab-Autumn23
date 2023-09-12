#####DATA SEGMENT#####
.data
    string_prompt:
    .asciiz "\nEnter string: "
    my_str:
    .space 100
    out_str:
    .space 100
    done_str:
    .asciiz "\n\nDONE.\n\n"
    choice_char:
    .space 2
    get_string:
    .asciiz "%s"
    exit_string:
    .asciiz "Want to exit? "
    newline:
    .asciiz "\n"
#####CODE SEGMENT#####
.text
.globl main
main:
par_loop:
    la $a0,string_prompt
    li $v0,4
    syscall

    la $a0,my_str
    li $a1,100
    li $v0,8
    syscall

    la $t0,my_str
    la $t1,out_str

    loop:
        lb $t2,($t0)
        beq $t2,0x0A exit_loop
        beqz $t2, exit_loop
        beq $t2,'0' for_0
        beq $t2,'1' for_1
        beq $t2,'2' for_2
        beq $t2,'3' for_3
        beq $t2,'4' for_4
        beq $t2,'5' for_5
        beq $t2,'6' for_6
        beq $t2,'7' for_7
        beq $t2,'8' for_8
        beq $t2,'9' for_9
        b write_string
    
    for_0:
        li $t2,'4'
        b write_string

    for_1:
        li $t2,'6'
        b write_string

    for_2:
        li $t2,'9'
        b write_string

    for_3:
        li $t2,'5'
        b write_string

    for_4:
        li $t2,'0'
        b write_string

    for_5:
        li $t2,'3'
        b write_string

    for_6:
        li $t2,'1'
        b write_string

    for_7:
        li $t2,'8'
        b write_string

    for_8:
        li $t2,'7'
        b write_string

    for_9:
        li $t2,'2'
        b write_string
        
    write_string:
        sb $t2,($t1)
        addu $t0,$t0,1
        addu $t1,$t1,1
        b loop

    exit_loop:
        li $t2,0
        sb $t2,($t1)
        la $a0,out_str
        li $v0,4
        syscall

        la $a0,newline
        syscall

        la $a0,exit_string
        syscall

        la $a0,choice_char
        li $a1,2
        li $v0,8
        syscall

        lb $t4,($a0)
        beq $t4,'y' exit_prog
        beq $t4,'Y' exit_prog
        b par_loop

    exit_prog:
        la $a0,done_str
        li $v0,4
        syscall
        li $v0,10
        syscall


