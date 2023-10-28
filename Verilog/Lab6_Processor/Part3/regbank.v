module regbank(output reg [31:0] regA, output reg [31:0] regB, input [4:0] readport1, input [4:0] readport2, input [4:0] writeport, input [31:0] writedata, input RegRead, input RegWrite, input clk, input rst);
    reg signed [31:0] regfile [0:15];
    reg [31:0] sp;
    integer i;

    /*init values to test operations*/
    initial begin
        regfile[0] = 0;
        regfile[1] = 1;
        regfile[2] = 2;
        regfile[3] = 3;
        regfile[4] = 4;
        regfile[5] = 5;
        regfile[6] = 6;
        regfile[7] = 7;
        regfile[8] = 8;
    end

    always @(posedge clk) begin
        // Reset every register to 0
        if (rst) begin
            for (i = 0; i <= 15; i=i+1) regfile[i] <= 32'b00000000000000000000000000000000;
            sp <= 32'b11111111111111111111111111111100;
        end
        // If Control Signal for writing is enabled, write into specific register, except for R0
        else if (RegWrite && writeport > 0) begin
            if (writeport < 16) regfile[writeport[3:0]] <= writedata;
            else sp <= writedata;
        end
    end

    always @(*) begin
        // On change of input, if Control Signal for reading is enabled, read the regsiters
        if (RegRead) begin
            if (readport1 < 16) regA <= regfile[readport1[3:0]];
            else regA <= sp;

            if (readport2 < 16) regB <= regfile[readport2[3:0]];
            else regB <= sp;
        end
    end
endmodule