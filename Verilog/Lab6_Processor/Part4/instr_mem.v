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
    reg [7:0] mem[0:127];  // 2^16 bits, allows 2^11 (2048) 32-bit instructions
    reg [31:0] readreg;
    initial begin
        // Sample program
        {mem[0], mem[1], mem[2], mem[3]} <= 32'b00000000100000000000000000101001;      // ADDI R1, 1
        {mem[4], mem[5], mem[6], mem[7]} <= 32'b00100000000000000000000000000001;     // ST R1, 0(R0)
        {mem[8], mem[9], mem[10], mem[11]} <= 32'b11110000000000000000000000000000;     // NOP
        {mem[12], mem[13], mem[14], mem[15]} <= 32'b01010000000000000000000000001000;    // BR #8
        {mem[16], mem[17], mem[18], mem[19]} <= 32'b00010000000000000000000000001111;   // LD R15, 0(R0) is skipped due to branch
        {mem[20], mem[21], mem[22], mem[23]} <= 32'b10110000000000000000000000100100;   // CALL #36
        {mem[24], mem[25], mem[26], mem[27]} <= 32'b00000000101111011110000000000000;   // ADD R15, R1, R15
        {mem[28], mem[29], mem[30], mem[31]} <= 32'b01100111111111111111111100000000;   // BMI R15 #-8
        {mem[32], mem[33], mem[34], mem[35]} <= 32'b10010000001111000000000000000000;   // PUSH R15
        {mem[36], mem[37], mem[38], mem[39]} <= 32'b10100000000000000100000000000000;   // POP R2
        {mem[40], mem[41], mem[42], mem[43]} <= 32'b00000001001111011110000000000001;   // SUB R15, R2, R15
        {mem[44], mem[45], mem[46], mem[47]} <= 32'b11010000100000000000000000001111;   // MOVE R15, R1
        {mem[48], mem[49], mem[50], mem[51]} <= 32'b11100000000000000000000000000000;   // HALT
        {mem[52], mem[53], mem[54], mem[55]} <= 32'b01110111111111111111110010000000;   // BPL R15 #-28
        {mem[56], mem[57], mem[58], mem[59]} <= 32'b11000000000000000000000000000000;   // RET
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
            readreg <= {mem[instr_add[6:0]], mem[instr_add[6:0]+1], mem[instr_add[6:0]+2], mem[instr_add[6:0]+3]};
        end
    end
endmodule