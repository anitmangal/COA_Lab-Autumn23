module regbank(
    output reg [31:0] regA,
    output reg [31:0] regB,
    output [31:0] reg15val,
    input [4:0] readport1,
    input [4:0] readport2,
    input [4:0] writeport,
    input [31:0] writedata,
    input RegRead,
    input RegWrite,
    input rst,
    input clk);
    
    reg signed [31:0] regfile [0:15];
    reg [31:0] sp;
    integer i;

    assign reg15val = regfile[15];

    initial begin
        for (i = 0; i <= 15; i=i+1) regfile[i] <= 32'b00000000000000000000000000000000;
        sp <= 32'b00000000000000010000000000000000;
    end

    always @(posedge clk) begin
        // Reset every register to 0
        if (rst) begin
            for (i = 0; i <= 15; i=i+1) regfile[i] <= 32'b00000000000000000000000000000000;
            sp <= 32'b00000000000000000000000000000000;
        end
        // If Control Signal for writing is enabled, write into specific register, except for R0
        else if (RegWrite && writeport > 0) begin
            if (writeport < 16) regfile[writeport[3:0]] <= writedata;
            else if (writeport == 16) sp <= writedata;
        end
    end

    always @(*) begin
        // On change of input, if Control Signal for reading is enabled, read the regsiters
        if (RegRead) begin
            if (readport1 < 16) regA <= regfile[readport1[3:0]];
            else if (readport1 == 16) regA <= sp;

            if (readport2 < 16) regB <= regfile[readport2[3:0]];
            else if (readport2 == 16) regB <= sp;
        end
    end
endmodule