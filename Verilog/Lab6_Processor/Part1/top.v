// For testing on FPGA
module top(output reg [15:0] out, input [7:0] sw, input rst, input myclk, input clk);
    reg [31:0] a, b;
    reg [3:0] func;
    reg signed [4:0] state;
    reg [25:0] counter;
    wire clkslow;
    wire [31:0] res;
    wire zero, sign, over;
    
    ALU TEST(res, zero, sign, over, a, b, func);
    initial begin
        a <= 0;
        b <= 0;
        func <= 0;
        state <= -1;
        out <= 1;
        counter <= 0;
    end
    always @(posedge clk) begin
        counter <= counter + 1;
    end
    assign clkslow = counter[25];
    always @(posedge clkslow) begin
        if (rst) begin
            a <= 0;
            b <= 0;
            func <= 0;
            state <= -1;
            out <= 0;
        end
        if (myclk) begin
            case(state)
                0: begin		// Take ALU function as input
                    func <= sw[3:0];
                    out <= 1;
                end
                1: begin		// Take a as input byte-wise from Most significant to least significant byte
                    a[31:24] <= sw[7:0];
                    out <= 2;
                end
                2: begin
                    a[23:16] <= sw[7:0];
                    out <= 3;
                end
                3: begin
                    a[15:8] <= sw[7:0];
                    out <= 4;
                end
                4: begin
                    a[7:0] <= sw[7:0];
                    out <= 5;
                end
                5: begin		// Take b as input byte-wise from Most significant to least significant byte
                    b[31:24] <= sw[7:0];
                    out <= 6;
                end
                6: begin
                    b[23:16] <= sw[7:0];
                    out <= 7;
                end
                7: begin
                    b[15:8] <= sw[7:0];
                    out <= 8;
                end
                8: begin
                    b[7:0] <= sw[7:0];
                    out <= 9;
                end
				// Print result in LEDs 16 bits at a time from MSB to LSB repeatedly
                9: out <= res[31:16];
                10: out <= res[15:0];
                default: begin
                    state <= 8;
                    out <= 16'b1111111111111111;	// Signifies that result is printed and will be printed again
                end
            endcase
            state <= state+1;
        end
    end
endmodule
