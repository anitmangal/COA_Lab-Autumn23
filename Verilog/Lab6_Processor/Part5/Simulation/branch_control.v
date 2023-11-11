module branch_control(
    output reg brsignal,
    
    input [2:0] BrOp,

    input zero,
    input sign,
    input carry);
    initial brsignal <= 0;
    /*
        BrOp = 000: No branch
        BrOp = 001: Branch always
        BrOp = 010: Branch on -ve
        BrOp = 011: Branch on +ve
        BrOp = 100: Branch on zero
    */
    always @(*) begin
        case(BrOp)
            3'b000: brsignal <= 0;
            3'b001: brsignal <= 1;
            3'b010: brsignal <= sign;
            3'b011: brsignal <= ((~sign)&(~zero));
            3'b100: brsignal <= zero;
        endcase
    end
endmodule