module gcd(out, in_a, in_b, clk);
    // INPUT OUTPUT
    output [7:0] out;
    input [7:0] in_a, in_b;
    input clk;
    reg [2:0] state;        // Register for state machine
    reg [7:0] out, a, b;
    initial
    begin
        state = 0;
        out = 8'bzzzzzzzz;
    end
    // When input changes, reset the state machine.
    always @(in_a or in_b)
    begin
        a = in_a;
        b = in_b;
        out = 8'bzzzzzzzz;
    end
    // Since it was asked to use clock for operations, this event is triggered on every positive edge of clock. It should have been triggered on every change in state.
    always @(posedge clk)
    begin
        case(state)
            0: begin
                if (a == b)
                    state <= 3;
                else if (a > b)
                    state <= 1;
                else
                    state <= 2;
            end
            1: begin
                out <= 8'bzzzzzzzz;
                a <= a - b;
                state <= 0;
            end
            2: begin
                out <= 8'bzzzzzzzz;
                b <= b - a;
                state <= 0;
            end
            3: begin
                out <= a;
                state <= 0;
            end
        endcase
    end
endmodule