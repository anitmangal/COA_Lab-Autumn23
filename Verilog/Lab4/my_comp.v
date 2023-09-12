module my_comp(out, in);
    input [7:0] in;
    output [7:0] out;
    wire [7:0] const1 = 1;
    wire [7:0] t1;
    my_not C1(t1, in);
    my_add C2(out, t1, const1);
endmodule