module instr_mem(
    output [3:0] i31_28, 
    output [4:0] i4_0, 
    output [4:0] i27_23, 
    output [4:0] i22_18, 
    output [4:0] i17_13, 
    output [27:0] i27_0, 
    output [17:0] i22_5, 
    input [31:0] instr_add, 
    input InstrRead);
    integer i;
    reg [7:0] mem [0:4095]; // 2^12 bytes, allows 2^9 (512) 32-bit instructions
    reg [31:0] readreg;
    initial begin
        /* Sample program
        00000000100000000000000000101001;      // ADDI R1, 1
        00100000000000000000000000000001;     // ST R1, 0(R0)
        11110000000000000000000000000000;     // NOP
        01010000000000000000000000001000;    // BR #8
        00010000000000000000000000001111;   // LD R15, 0(R0) is skipped due to branch
        10110000000000000000000000100100;   // CALL #36
        00000000101111011110000000000000;   // ADD R15, R1, R15
        01100111111111111111111100000000;   // BMI R15 #-8
        10010000001111000000000000000000;   // PUSH R15
        10100000000000000100000000000000;   // POP R2
        b00000001001111011110000000000001;   // SUB R15, R2, R15
        11010000100000000000000000001111;   // MOVE R15, R1
        11100000000000000000000000000000;   // HALT
        01110111111111111111110010000000;   // BPL R15 #-28
        11000000000000000000000000000000;   // RET
        */
        $readmemb("instr_mem.txt", mem);
        readreg <= 0;
    end

    // Slicing the readreg into the different parts of the instruction
    assign i31_28 = readreg[31:28];
    assign i4_0 = readreg[4:0];
    assign i27_23 = readreg[27:23];
    assign i22_18 = readreg[22:18];
    assign i17_13 = readreg[17:13];
    assign i27_0 = readreg[27:0];
    assign i22_5 = readreg[22:5];

    // Input address is a 32-bit word, we have one byte per address. So we need to take 4 consecutive addresses and concatenate them to get the 32-bit instruction
    always @(*) begin
        if (InstrRead) begin
            readreg <= {mem[instr_add[11:0]], mem[instr_add[11:0]+1], mem[instr_add[11:0]+2], mem[instr_add[11:0]+3]};
        end
    end
endmodule