module mux_5b_3_to_1(output [4:0] out, input [4:0] in_0, input [4:0] in_1, input [4:0] in_2, input [1:0] contr);
    assign out = ((contr == 0)?(in_0):((contr == 1)?(in_1):(in_2)));
endmodule