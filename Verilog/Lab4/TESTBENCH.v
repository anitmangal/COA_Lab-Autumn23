`timescale 10ns/1ns
module test;
    reg [7:0] in1, in2;
    reg [2:0] func;
    reg clk;
    wire [7:0] result;
    // ALU module
    ALU TEST(result, in1, in2, func);
    always
        #1 clk = ~clk;
    initial begin
        clk = 1;
        $monitor ("in1 = %d, in2 = %d, function = %d => output = %d", in1, in2, func, result);
        in1 = 2; in2 = 5; func = 0;             // add, out = 7
        #2 in1 = 125; in2 = 2;                  // add, out = 127
        #2 in1 = 4; in2 = 2; func = 1;          // sub, out = 2
        #2 in1 = 5; func = 2;                   // assign, out = 5
        #2 in1 = 2; func = 3;                   // shift left, out = 4
        #2 in1 = 2; func = 4;                   // shift right, out = 1
        #2 in1 = 7; in2 = 3; func = 5;          // and, out = 3
        #2 in1 = 20; func = 6;                  // not, out = -21
        #2 in1 = 4; in2 = 3; func = 7;          // or, out = 7
        #2 $finish;
    end
endmodule