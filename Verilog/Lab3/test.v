`timescale 1 ns / 1 ns
module test();
    reg [31:0] x;
    reg clk;
    wire [31:0] y;
    top TEST(y, x);
    always #1 clk = ~clk;
    initial begin
        clk = 0;
        x = 0;
        #10 x = 255;
        #10 x = 510;
        #10 x = 765;
        #10 x = 1275;
        $finish;
    end
endmodule