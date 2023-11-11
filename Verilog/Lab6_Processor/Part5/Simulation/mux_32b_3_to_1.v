module mux_32b_3_to_1(output [31:0] out, input [31:0] in_0, input [31:0] in_1, input [31:0] in_2, input [1:0] contr);
    assign out = ((contr == 0)?(in_0):((contr == 1)?(in_1):(in_2)));
endmodule