`timescale 1ps/1ps

module test();
    wire [15:0] out;
    reg clk, INT, myclk;
    always #1 clk = ~clk;
    fpga_top T1(out, clk, INT, myclk);
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, test);
        clk = 0;
        INT = 0;
        myclk = 1;
        #7000 $finish;
    end
endmodule