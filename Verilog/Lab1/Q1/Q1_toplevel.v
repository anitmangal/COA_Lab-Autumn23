`timescale 10ns / 1ns
module top(out_16, source, dest, move_in, in_16, clk);
    input [2:0] source, dest;
    input move_in, clk;
    input [15:0] in_16;
    output [15:0] out_16;
    wire [15:0] input_bus;
    wire [15:0] out [0:7];      // Output of each register
    reg [0:7] L, E;             // Registers to store load and enable signals for each register
    // Instantiate 8 registers
    myreg R0(out[0], input_bus, L[0], E[0]);
    myreg R1(out[1], input_bus, L[1], E[1]);
    myreg R2(out[2], input_bus, L[2], E[2]);
    myreg R3(out[3], input_bus, L[3], E[3]);
    myreg R4(out[4], input_bus, L[4], E[4]);
    myreg R5(out[5], input_bus, L[5], E[5]);
    myreg R6(out[6], input_bus, L[6], E[6]);
    myreg R7(out[7], input_bus, L[7], E[7]);
    // Multiplexer to select output from the source register
    assign out_16 = (move_in == 0)?out[source]:16'bzzzzzzzzzzzzzzzz;
    // Multiplexer to select input line for the destination register
    assign input_bus = (move_in == 0)?out[source]:in_16;

    always @(source or dest or move_in or in_16)
    begin
        L <= 0;
        E <= 0;
    end
    always @(posedge clk)
    begin
        if (move_in == 1)
        begin
            L[dest] = 1;
        end
        else
        begin
            // Included delays for value to be copied into bus and then from bus into destination register. Without delays (and using non blocking assignments), the simulator was giving incorrect results.
            #0.1 E[source] <= 1;
            #0.1 L[dest] <= 1;
        end
    end
endmodule