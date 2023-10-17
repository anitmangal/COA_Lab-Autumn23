`timescale 1 ns/ 1ns
module test;
    wire [31:0] res;
    wire zero, sign, over;
    reg [31:0] a, b;
    reg [3:0] func;
    ALU TEST(res, zero, sign, over, a, b, func);
    /*  func:
        0: add
        1: sub
        2: and
        3: or
        4: xor
        5: 2s complement
        6: Left shift
        7: Right shift arithmetic
        8: Right shift logical
    */
    initial begin
        a = 1; b = 23; func = 0;
        #1 a = 1; b = 23; func = 1;
        #1 a = 1; b = 1; func = 2;
        #1 a = 3; b = 7; func = 3;
        #1 a = 1; b = 3; func = 4;
        #1 a = 2; b = 5; func = 5;
        #1 a = 3; b = 1; func = 6;
        #1 a = -5; b = 1; func = 7;
        #1 a = -5; b = 1; func = 8;
        #1 $finish;
    end
endmodule