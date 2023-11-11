module pc_adder(output [31:0] out, input [31:0] in_0, input [31:0] in_1);
    assign out = in_0+in_1;
endmodule