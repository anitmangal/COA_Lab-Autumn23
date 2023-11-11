module data_mem(output reg [31:0] out, input [31:0] in_add, input [31:0] in_data, input MemRead, input MemWrite);
    reg [0:65535] mem;  // 2^16 bits, allows 2^11 (2048) 32-bit data blocks
    integer i;
    initial begin
        mem <= 0;
        out <= 0;
    end

    // Input address is a 32-bit word, but we only need 13 bits of it for current mem size, which address a byte. So we multiply by 8 to go to corresponding bit and output 32 bits (1 word) at once.
    always @(*) begin
        if (MemRead) begin
            out <= mem[(in_add[12:0]<<3)+:32];
        end
        if (MemWrite) begin
            mem[(in_add[12:0]<<3)+: 32] <= in_data;
        end
    end
endmodule