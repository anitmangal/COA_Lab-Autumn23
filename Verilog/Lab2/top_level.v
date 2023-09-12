module top(result, in_m, in_q, clk);
    // PORTS
    output [15:0] result;
    input [7:0] in_m, in_q;
    input clk;

    // REGISTERS as stated in data path
    reg [7:0] a, q, m;
    reg [3:0] count;
    reg q1, func, state;        // Function select for ADDER (0 == add, 1 == sub), state for addition or shift
    assign result = -{a, q};
    wire [7:0] add_out, shift_a, shift_q;
    wire shift_q1;
    // Define modules
    my_add ADD(add_out, a, m, func);
    my_shifter SHIFT(shift_a, shift_q, shift_q1, a, q, clk);
    // When input changes, reset
    always @(in_m or in_q) begin
        q <= in_q;
        m <= in_m;
        a <= 0;
        q1 <= 0;
        func <= 0;
        count <= 8;
        state <= 0;
    end
    // At negative edge, update. Positive edge is used for calculations
    always @(negedge clk) begin
        if (count > 0) begin
            case (state)
                // Add/subtract
                0: begin
                    case({q[0], q1})
                        2'b01: begin
                            func <= 0;
                            a <= add_out;
                        end
                        2'b10: begin
                            func <= 1;
                            a <= add_out;
                        end
                    endcase
                    state <= ~state;
                end
                // Shift
                1: begin
                    a <= shift_a;
                    q <= shift_q;
                    q1 <= shift_q1;
                    count <= count-1;
                    state <= ~state;
                end
            endcase
        end
    end
endmodule