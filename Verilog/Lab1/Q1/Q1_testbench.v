/*
    Verilog Assignment 2 Question 1
    Autumn Semester 2023-24
    Group 47
    Anit Mangal, Omair Alam
*/
`timescale 10ns / 1ns
module testbench;
    reg [2:0] src, dest;    // 3-bit source and destination register
    reg move_in, clk;       // move_in: 0 for move, 1 for input. clk: clock
    reg [15:0] in_16;       // input data
    wire [15:0] out_16;     // output data
    top TEST(out_16, src, dest, move_in, in_16, clk);   // instantiate the top-level module
    // Clock
    always
        #1 clk = !clk;
    initial
    begin
        $dumpfile("test.vcd");
        $dumpvars(0, testbench);
        clk = 1;
        $monitor($time, " src_reg = %d, dest_reg = %d, move_in = %b, in_16 = %d,      out_16 = %d", src, dest, move_in, in_16, out_16);
        src = 0; dest = 0; move_in = 1; in_16 = 0;
        #4 move_in = 1; dest = 0; in_16 = 5;                // Set value of R0 to 5
        #4 move_in = 0; src = 0; dest = 1; in_16 = 2;       // Move value of R0 to R1, outputs 5 (Set random input to test)
        #4 move_in = 0; src = 1; dest = 2; in_16 = 4;       // Move value of R1 to R2, outputs 5 (Set random input to test)
        #4 move_in = 1; dest = 1; in_16 = 3;                // Set value of R1 to 3
        #4 move_in = 0; src = 1; dest = 2; in_16 = 100;     // Move value of R1 to R2, outputs 3 (Set random input to test)
        #4 $finish;
    end
endmodule