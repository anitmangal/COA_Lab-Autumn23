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
    integer i, j;
    reg [7:0] mem [0:1023]; // 2^10 bytes, allows 2^8 (256) 32-bit instructions
    reg [31:0] readreg;
    initial begin
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

    // Input address is a 32-bit word, we have one byte per address. So we need to take 4 consecutive addresses and assign relevant bits to get the 32-bit instruction
    always @(*) begin
        if (InstrRead) begin
            for (i = 0; i < 4; i=i+1) begin
                for (j = 0; j < 8; j=j+1) begin
                    readreg[8*i+j] <= mem[instr_add[9:0]+3-i][j];
                end
            end
        end
    end
endmodule