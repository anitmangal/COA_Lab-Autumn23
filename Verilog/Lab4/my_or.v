module my_or(out, in1, in2);
    output [7:0] out;
    input [7:0] in1, in2;
    assign out = in1|in2;
endmodule