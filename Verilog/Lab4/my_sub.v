module my_sub(out, in1, in2);
    output [7:0] out;
    input [7:0] in1, in2;
    wire [7:0] r1;
    my_comp S1(r1, in2);
    my_add S2(out, in1, r1);
endmodule