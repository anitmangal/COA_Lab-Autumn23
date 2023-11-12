LD R1, 0(R0)
LD R2, 4(R0)
CALL #12                  // WRITE function header line
HALT
PUSH R1
PUSH R2
SUB R14, R1, R2
BMI R14,#20               // branch to less than 0
BZ R14,#28                    // branch to end
SUB R1,R1,R2
CALL #-24                  // WRITE function header line
BR #20                    // branch to end
SUB R2,R2,R1
CALL #-36                  // WRITE function header line
BR #8                    // branch to end
MOVE R15,R1
POP R2
POP R1
RET