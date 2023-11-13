LD R1, 0(R0)            // Load a
LD R2, 4(R0)            // Load b
CALL #8                  // Call find_gcd(a,b)
HALT                    // End of program
// find_gcd(a,b)
PUSH R1                 // Save a
PUSH R2                 // Save b
SUB R14, R1, R2
BMI R14,#20               // If a < b
BZ R14,#28                    // If a == b
// a > b
SUB R1,R1,R2
CALL #-24                  // Call find_gcd(a-b,b)
BR #20                    // branch to end of func
// a < b
SUB R2,R2,R1
CALL #-36                  // Call find_gcd(a,b-a)
BR #8                    // branch to end of func
// a == b
MOVE R15,R1                // Move a to R15 (Output)
// end of func
POP R2                  // Restore b
POP R1                  // Restore a
RET                     // Return to caller