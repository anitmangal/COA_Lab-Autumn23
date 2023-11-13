module data_mem(output reg [31:0] out, input [31:0] in_add, input [31:0] in_data, input MemRead, input MemWrite);
    reg [7:0] mem [0:1023];  // 2^10 bytes, allows 2^8 (256) 32-bit data blocks
    integer i, j;
    initial begin
        $readmemh("data_mem.txt", mem);
        out <= 0;
    end

    // Input address is a 32-bit word, we have one byte per address. So we need to take 4 consecutive addresses and assign relevant bits to get the 32-bit instruction
    always @(*) begin
        if (MemRead) begin
            for (i = 0; i < 4; i=i+1) begin
                for (j = 0; j < 8; j=j+1) begin
                    out[8*i+j] <= mem[in_add[9:0]+3-i][j];
                end
            end
        end
        if (MemWrite) begin            
            for (i = 0; i < 4; i=i+1) begin
                for (j = 0; j < 8; j=j+1) begin
                    mem[in_add[9:0]+3-i][j] <= in_data[8*i+j];
                end
            end
        end
    end
endmodule