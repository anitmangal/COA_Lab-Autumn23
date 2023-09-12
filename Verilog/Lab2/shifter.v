module my_shifter(out_a, out_q, out_q1, a, q, clk);
    output [7:0] out_a, out_q;
    output out_q1;
    input [7:0] a, q;
    input clk;
    reg [7:0] out_a, out_q;
    reg out_q1;
    // Shift according to algorithm
    always @(posedge clk) begin
        out_q1 = q[0];
        out_q = q>>1;
        out_q[7] = a[0];
        out_a = a>>1;
        out_a[7] = out_a[6];    // Sign extension
    end
endmodule;