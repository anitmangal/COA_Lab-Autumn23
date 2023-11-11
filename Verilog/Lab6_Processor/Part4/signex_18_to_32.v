module signex_18_to_32(output [31:0] out, input [17:0] in);
    assign out = {{14{in[17]}}, in};
endmodule