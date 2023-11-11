module mux_32b_2_to_1(output [31:0] out, input [31:0] in_0, input [31:0] in_1, input contr);
    assign out = (contr == 0)?(in_0):(in_1);
endmodule