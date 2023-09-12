`timescale 10ps / 1ps
/*
Assignment 8, Q1
Group 47
Sem-5
Anit Mangal, Omair Alam
*/
module test();
    reg [7:0] m, q;
    reg clk;
    wire [15:0] result;
    top TEST(result, m, q, clk);
    always #1 clk = ~clk;
    initial begin
        clk = 1;
        m = 0;
        q = 0;
        $monitor ("m = %d, q = %d, result = %d", m, q, result);
        // Make sure delay is enough for the algorithm to run (at least 16 clock pulses.)
        #50 m = 1; q = 1;               // result = 1
        #50 m = 2; q = 2;               // result = 4
        #50 m = -1; q = 1;              // result = -1
        #50 m = -2; q = 5;              // result = -10
        #50 $finish;
    end
endmodule