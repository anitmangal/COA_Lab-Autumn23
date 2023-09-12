/*
    Verilog Assignment 2 Question 2
    Autumn Semester 2023-24
    Group 47
    Anit Mangal, Omair Alam
*/
`timescale 1ns / 1ns
module testbench;
    // ASSUMPTIONS: 
    // a and b are always positive integers (used euclidean algorithm by subtraction for gcd).
    // Output remains high impedance till the gcd is computed.
    reg [7:0] a, b; // INPUTS
    reg clk;        // CLOCK
    wire [7:0] out; // OUTPUT
    gcd TEST(out, a, b, clk);
    initial
        clk = 1;
    always
        #1 clk = ~clk;
    initial 
    begin
        $dumpfile("gcd.vcd");
        $dumpvars(0, testbench);
        $monitor("a=%d, b=%d, out=%d", a, b, out);
        // Delays given keeping in mind the algorithm is O(n) and n is 8 bits.
        a = 0; b = 0;
        #512 a = 1; b = 1;
        #512 a = 4; b = 2;
        #512 a = 5; b = 3;
        #512 a = 255; b = 3;
        #512 a = 7; b = 1;
        #512 $finish;
    end
endmodule