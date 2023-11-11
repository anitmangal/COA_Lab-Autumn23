module data_mem(output reg [31:0] out, input [31:0] in_add, input [31:0] in_data, input MemRead, input MemWrite);
    reg [7:0] mem [0:4095];  // 2^12 bytes, allows 2^9 (512) 32-bit data blocks
    integer i;
    initial begin
        $readmemh("data_mem.txt", mem);
        out <= 0;
    end

    // Input address is a 32-bit word, we have one byte per address. So we need to take 4 consecutive addresses and concatenate them to get the 32-bit instruction
    always @(*) begin
        if (MemRead) begin
            out <= {mem[in_add[11:0]], mem[in_add[11:0]+1], mem[in_add[11:0]+2], mem[in_add[11:0]+3]};
        end
        if (MemWrite) begin
            {mem[in_add[11:0]], mem[in_add[11:0]+1], mem[in_add[11:0]+2], mem[in_add[11:0]+3]} <= in_data;
        end
    end
endmodule