XOR R1,R1,R1
ADDI R1,#10         // outer loop limit is 10
XOR R2,R2,R2        // outer loop counter
// Entering outer loop
SUB R14,R2,R1
BZ R14,#72          // Check if outer loop is done, then end
SUB R3,R1,R2
ADDI R3,#-1        // Inner loop limit is outer loop limit - outer loop counter - 1
XOR R4,R4,R4        // inner loop counter
XOR R5,R5,R5        // for mem references, 0 is the base address, 4 bytes per int
// Entering inner loop
SUB R14,R4,R3
BZ R14,#40           // Check if inner loop is done, then go to next iteration of outer loop
LD R6,0(R5)         // Load arr[R4]
LD R7,4(R5)         // Load arr[R4+1]
SUB R14,R6,R7
BMI R14,#12          // If R6 < R7 (arr[R4] < arr[R4+1]), then skip swap
ST R7,0(R5)
ST R6,4(R5)          // Swap (store in reverse order)
// End of inner loop
ADDI R5,#4          // Increment mem address by 4 bytes
ADDI R4,#1          // Increment inner loop counter
BR,#-40            // Go to start of inner loop: SUB R14,R4,R3
// End of outer loop
ADDI R2,#1          // Increment outer loop counter
BR,#-72            // Go to start of outer loop: SUB R14,R2,R1
// Output array at R15
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