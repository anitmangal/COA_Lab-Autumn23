module my_sub(res, out_b, in_y, in_x, in_b);
    output [7:0] res;
    output out_b;
    input [7:0] in_y, in_x;
    input in_b;
    assign {out_b,res} = in_y - in_x - in_b;
endmodule