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
    reg [0:65535] mem;  // 2^16 bits, allows 2^11 (2048) 32-bit instructions
    reg [31:0] readreg;
    initial begin
        // Sample program
        mem[0:31] <= 32'b00000000100000000000000000101001;      // ADDI R1, 1
        mem[32:63] <= 32'b00100000000000000000000000000001;     // ST R1, 0(R0)
        mem[64:95] <= 32'b11110000000000000000000000000000;     // NOP
        mem[96:127] <= 32'b01010000000000000000000000001000;    // BR #8
        mem[128:159] <= 32'b00010000000000000000000000001111;   // LD R15, 0(R0) is skipped due to branch
        mem[160:191] <= 32'b10110000000000000000000000100100;   // CALL #36
        mem[192:223] <= 32'b00000000101111011110000000000000;   // ADD R15, R1, R15
        mem[224:255] <= 32'b01100111111111111111111100000000;   // BMI R15 #-8
        mem[256:287] <= 32'b10010000001111000000000000000000;   // PUSH R15
        mem[288:319] <= 32'b10100000000000000100000000000000;   // POP R2
        mem[320:351] <= 32'b00000001001111011110000000000001;   // SUB R15, R2, R15
        mem[352:383] <= 32'b11010000100000000000000000001111;   // MOVE R15, R1
        mem[384:415] <= 32'b11100000000000000000000000000000;   // HALT
        mem[416:447] <= 32'b01110111111111111111110010000000;   // BPL R15 #-28
        mem[448:479] <= 32'b11000000000000000000000000000000;   // RET
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

    // Input address is a 32-bit word, but we only need 13 bits of it for current mem size, which address a byte. So we multiply by 8 to go to corresponding bit and output 32 bits (1 word) at once.
    always @(*) begin
        if (InstrRead) begin
            readreg <= mem[(instr_add[12:0]<<3)+:32];
        end
    end
endmodule