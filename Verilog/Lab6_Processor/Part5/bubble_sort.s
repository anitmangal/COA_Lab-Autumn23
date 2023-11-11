XOR R1,R1,R1
ADDI R1,#10
XOR R2,R2,R2        // outer loop counter

SUB R14,R2,R1
BZ R14,#72           // WRITE where to go for end
SUB R3,R1,R2        // Inner loop limit
ADDI R3,#-1
XOR R4,R4,R4        // inner loop counter
XOR R5,R5,R5        // for mem references, 0 is the base address, 4 bytes per int

SUB R14,R4,R3
BZ R14,#40           // WRITE where to go for inner loop end
LD R6,0(R5)
LD R7,4(R5)
SUB R14,R6,R7
BMI R14,#12          // WRITE where to go for no swap
ST R7,0(R5)
ST R6,4(R5)

ADDI R5,#4
ADDI R4,#1
BR,#-40            // Go to start of inner loop: SUB R14,R4,R3

ADDI R2,#1
BR,#-72            // Go to start of outer loop: SUB R14,R2,R1

LD R15,0(R0)
LD R15,4(R0)
LD R15,8(R0)
LD R15,12(R0)
LD R15,16(R0)
LD R15,20(R0)
LD R15,24(R0)
LD R15,28(R0)
LD R15,32(R0)
LD R15,36(R0)
LD R15,40(R0)
NOP