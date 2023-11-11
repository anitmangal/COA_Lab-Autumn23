module ALU(
    output reg signed [31:0] out,
    output reg zero,
    output reg sign,
    output reg over,
    input [31:0] a,
    input [31:0] b,
    input [3: 0] func);
    // func:
    //     0: add a and b
    //     1: sub b from a
    //     2: a and b
    //     3: a or b
    //     4: a xor b
    //     5: not a
    //     6: a << b
    //     7: a >> b (arithmetic)
    //     8: a>>b (logical)
    // zero is set if result is 0
    // sign is set if result is negative
    // over is set if there is an overflow
    initial begin
        out <= 0;
        zero <= 0;
        sign <= 0;
        over <= 0;
    end
    always @(*) begin
        case(func)
            0: out <= a+b;
            1: out <= a-b;
            2: out <= a&b;
            3: out <= a|b;
            4: out <= a^b;
            5: out <= ~a;
            6: out <= a<<(b[0]);
            7: out <= a>>>(b[0]);
            8: out <= a>>(b[0]);
        endcase
        if (func <= 8) begin
            zero <= (out == 0);
            sign <= (out < 0);
            over <= (a[31]&(b[31]^(func==1)))^out[31];
        end
    end
endmodule