module ALU(result, in1, in2, func);
    output [7:0] result;
    input [7:0] in1, in2;
    input [2:0] func;

    wire [7:0] out [0:7];
    // Multiplexer to assign output according to selected func
    assign result = out[func];

    // Modules for operations
    my_add O1(out[0], in1, in2);
    my_sub O2(out[1], in1, in2);
    assgn O3(out[2], in1);
    shiftl O4(out[3], in1);
    shiftr O5(out[4], in1);
    my_and O6(out[5], in1, in2);
    my_not O7(out[6], in1);
    my_or O8(out[7], in1, in2);
endmodule