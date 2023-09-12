module top(out, inst, enable, clk);
    output [3:0] out;
    input enable, clk;
    input [0:9] inst;

    /*
    10-bit instruction: 2-bit opcode, 4-bit memory location, 4-bit data/3-bit register address
    00  _ _ _ _   _ _ _ _ (mem <- data)
    01  _ _ _ _   _ _ _ (mem <- reg)
    10  _ _ _ _   _ _ _ (mem -> reg)
    11  _ _ _ _ (display mem)
    */

    reg [3:0] regbank [0:7];    // Register array (8x4)

    // Write enable (depends on first bit of instruction)
    wire write_en;
    assign write_en = ~inst[0];

    // Input data for memory, decide between immediate block of instruction or register.
    wire [3:0] d_in;
    assign d_in = (inst[1] == 0)?inst[6:9]:regbank[inst[6:8]];

    // Memory module. Single port 16x4 RAM (Write first)
    my_mem MEM (
    .clka(clk),    // input wire clka
    .ena(enable),      // input wire ena
    .wea(write_en),      // input wire [0 : 0] wea
    .addra(inst[2:5]),  // input wire [3 : 0] addra
    .dina(d_in),    // input wire [3 : 0] dina
    .douta(out)  // output wire [3 : 0] douta
    );

    // Check if data needs to be transferred from memory output to specified register
    always @(posedge clk) begin
        if (enable && inst[0:1] == 2'b10) regbank[inst[6:8]] <= out;
    end
endmodule