module pc(output reg [31:0] out, input [31:0] in, input pc_in, input clk);
    initial out <= 0;
    always @(posedge clk) begin
        if (pc_in) out <= in;
    end
endmodule