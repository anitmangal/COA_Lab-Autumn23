module signex_28_to_32(output [31:0] out, input [27:0] in);
    assign out = {{4{in[27]}}, in};
endmodule