/*
    Semester - 5
    Assignment 7 Part 4
    Grp 47
    Anit Mangal
    Omair Alam
*/
`timescale 1ps/1ps
module test();
    reg INT, clk;
    wire signed [31:0] testREGval;
    top T(testREGval, INT, clk);
    always begin
        #1 clk = ~clk;
    end
    initial begin
        $dumpfile("test.vcd");
        $dumpvars;
        clk = 1;
        INT = 0;
        $monitor($time, " REG15 = %d", testREGval);
        #7000 $finish;
    end
endmodule