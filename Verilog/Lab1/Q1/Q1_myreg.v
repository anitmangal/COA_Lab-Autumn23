module myreg(outline, inline, load, enable);
    input[15:0] inline;
    input load, enable;
    output [15:0] outline;
    reg [15:0] r;
    // Output wire set according to enable control signal
    assign outline = (enable)?r:16'bzzzzzzzzzzzzzzzz;
    initial
        r = 0;
    always @(load)
            // Register value set according to load control signal
            if (load) r <= inline;
endmodule