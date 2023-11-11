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
    wire [31:0] testREGval;
    top T(testREGval, INT, clk);
    always begin
        #1 clk = ~clk;
    end
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, test);
        clk = 1;
        INT = 0;
        $monitor($time, " REG15 = %d", testREGval);
        #150 INT = 1;     // HALT instruction needs INT = 1  
        #50 INT = 0;        // After some time, another HALT is called but INT = 0 so the program will stay halted
        #700 $finish;
    end
endmodule