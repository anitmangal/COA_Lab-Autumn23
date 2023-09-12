module my_add(out, in1, in2);
    output [7:0] out;
    input [7:0] in1, in2;

    // Parallel carry calculation
    wire [7:0] carry;
    assign carry[0] = 0;
    assign carry[1] = (in1[0]&in2[0])|((in1[0]^in2[0])&carry[0]);
    assign carry[2] = (in1[1]&in2[1])|((in1[1]^in2[1])&(in1[0]&in2[0]))|((in1[0]^in2[0])&carry[0]);
    assign carry[3] = (in1[2]&in2[2])|((in1[2]^in2[2])&(in1[1]&in2[1]))|((in1[1]^in2[1])&(in1[0]&in2[0]))|((in1[0]^in2[0])&carry[0]);
    assign carry[4] = (in1[3]&in2[3])|((in1[3]^in2[3])&(in1[2]&in2[2]))|((in1[2]^in2[2])&(in1[1]&in2[1]))|((in1[1]^in2[1])&(in1[0]&in2[0]))|((in1[0]^in2[0])&carry[0]);
    assign carry[5] = (in1[4]&in2[4])|((in1[4]^in2[4])&(in1[3]&in2[3]))|((in1[3]^in2[3])&(in1[2]&in2[2]))|((in1[2]^in2[2])&(in1[1]&in2[1]))|((in1[1]^in2[1])&(in1[0]&in2[0]))|((in1[0]^in2[0])&carry[0]);
    assign carry[6] = (in1[5]&in2[5])|((in1[5]^in2[5])&(in1[4]&in2[4]))|((in1[4]^in2[4])&(in1[3]&in2[3]))|((in1[3]^in2[3])&(in1[2]&in2[2]))|((in1[2]^in2[2])&(in1[1]&in2[1]))|((in1[1]^in2[1])&(in1[0]&in2[0]))|((in1[0]^in2[0])&carry[0]);
    assign carry[7] = (in1[6]&in2[6])|((in1[6]^in2[6])&(in1[5]&in2[5]))|((in1[5]^in2[5])&(in1[4]&in2[4]))|((in1[4]^in2[4])&(in1[3]&in2[3]))|((in1[3]^in2[3])&(in1[2]&in2[2]))|((in1[2]^in2[2])&(in1[1]&in2[1]))|((in1[1]^in2[1])&(in1[0]&in2[0]))|((in1[0]^in2[0])&carry[0]);
    assign out = in1^in2^carry;
endmodule