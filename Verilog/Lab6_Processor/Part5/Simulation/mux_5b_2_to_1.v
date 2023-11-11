module mux_5b_2_to_1(output [4:0] out, input [4:0] in_0, input [4:0] in_1, input contr);
    assign out = (contr == 0)?(in_0):(in_1);
endmodule