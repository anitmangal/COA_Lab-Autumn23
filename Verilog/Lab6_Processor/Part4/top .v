module top(output [31:0] testREGval, output [5:0] st, input INT, input clk);
    // FROM CU
    wire PCSel;
    wire PCIn;
    wire InstrRead;
    wire Read1Sel;
    wire [1:0] Read2Sel;
    wire [1:0] WriteRegSel;
    wire WriteInfoSel;
    wire RegRead;
    wire RegWrite;
    wire ImmSel;
    wire [1:0] ALUin2;
    wire [3:0] ALUOp;
    wire DataSel;
    wire MemRead;
    wire MemWrite;
    wire [2:0] BrOp;

    // FROM DP
    wire [3:0] i31_28;
    wire [4:0] i4_0;
    wire zero;
    wire sign;
    wire carry;

    // FROM BC
    wire brsignal;

    control_unit cu(
        st,
        PCSel,
        PCIn,
        InstrRead,
        Read1Sel,
        Read2Sel,
        WriteRegSel,
        WriteInfoSel,
        RegRead,
        RegWrite,
        ImmSel,
        ALUin2,
        ALUOp,
        DataSel,
        MemRead,
        MemWrite,
        BrOp,
        INT,
        i31_28,
        i4_0,
        clk
    );

    data_path dp(
        i31_28,
        i4_0,
        zero,
        sign,
        carry,
        testREGval,
        PCSel,
        PCIn,
        InstrRead,
        Read1Sel,
        Read2Sel,
        WriteRegSel,
        WriteInfoSel,
        RegRead,
        RegWrite,
        ImmSel,
        ALUin2,
        ALUOp,
        DataSel,
        MemRead,
        MemWrite,
        brsignal,
        clk
    );

    branch_control bc(
        brsignal,
        BrOp,
        zero,
        sign,
        carry
    );
endmodule