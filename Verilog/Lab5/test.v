`timescale 1 ns / 1 ns;

/*
    Verilog Assignment - 6
    Group 47
    Anit Mangal
    Omair Alam
*/
module test();
    reg clk, enable;
    reg [0:9] instr;
    wire [3:0] result;
    
    top TEST(result, instr, enable, clk);
    always #1 clk = ~clk;
    initial begin
        $monitor();
        clk = 0;
        enable = 0;
        instr = 0;
        #6 instr = 10'b0000101100; enable = 1;  // mem[2] = 12
        #6 enable = 0; instr = 10'b0000101111;  // nothing changes
        #6 instr = 10'b0000110001; enable = 1;  // mem[3] = 1
        #6 enable = 1; instr = 10'b1000100010;  // reg[1] = mem[2] = 12
        #6 enable = 1; instr = 10'b0100010011;  // mem[1] = reg[1] = 12
        #6 enable = 1; instr = 10'b1100110000;  // get mem[3] = 1
        #6 enable = 1; instr = 10'b1100010000;  // get mem[1] = 12
        $finish;
    end
endmodule