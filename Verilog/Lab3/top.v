module top(y, x);
    // IO
    input [31:0] x;
    output [31:0] y;
    // Borrow handlers
    wire out_borrow[3:0];
    reg in_borrow;
    reg [7:0] y0;   // Used as 0 value for Least Significant Byte of 256y
    my_sub S0(y[7:0], out_borrow[0], y0, x[7:0], in_borrow);        // y0 = -x0, get b0
    my_sub S1(y[15:8], out_borrow[1], y[7:0], x[15:8], out_borrow[0]);  // y1 = y0-x1-b0, get b1
    my_sub S2(y[23:16], out_borrow[2], y[15:8], x[23:16], out_borrow[1]);   // y2 = y1-x2-b1, get b2
    my_sub S3(y[31:24], out_borrow[3], y[23:16], x[31:24], out_borrow[2]);  // y3 = y2-x3-b2, get b3
    initial begin
        in_borrow = 0;
        y0 = 8'b00000000;
    end
endmodule