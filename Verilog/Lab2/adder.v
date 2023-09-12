`timescale 10ns / 1ns
module my_add(result, a, m, func);
    output [7:0] result;
    input [7:0] a, m;
    input func;
    assign result = (func == 0)?(a+m):(a-m);
endmodule