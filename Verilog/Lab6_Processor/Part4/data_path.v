module data_path(
    output [3:0] i31_28,
    output [4:0] i4_0,

    output zero,
    output sign,
    output carry,

    output [31:0] testREGval,

    input PCSel,
    input PCIn,
    input InstrRead,
    input Read1Sel,
    input [1:0] Read2Sel,
    input [1:0] WriteRegSel,
    input WriteInfoSel,
    input RegRead,
    input RegWrite,
    input ImmSel,
    input [1:0] ALUin2,
    input [3:0] ALUOp,
    input DataSel,
    input MemRead,
    input MemWrite,
    
    input brsignal,
    
    input clk);


    // Wires to connect modules
    wire [31:0] PCADDERval;
    wire [31:0] DATAMEMval;
    wire [31:0] PCSELval;
    wire [31:0] PCval;
    wire [31:0] BRSIGNALval;
    wire [31:0] IMMSELval;
    wire [4:0] i27_23; 
    wire [4:0] i22_18; 
    wire [4:0] i17_13; 
    wire [27:0] i27_0; 
    wire [17:0] i22_5;
    wire [31:0] SIGNEX2832val;
    wire [31:0] SIGNEX1832val;
    wire [4:0] READ2SELval;
    wire [4:0] READ1SELval;
    wire [4:0] WRITEREGSELval;
    wire [31:0] READREG1val;
    wire [31:0] READREG2val;
    wire [31:0] WRITEINFOSELval;
    wire [31:0] ALUval;
    wire [31:0] ALUIN2val;
    wire [31:0] DATASELval;

    mux_32b_2_to_1 MUX_PCSel(
        PCSELval,
        PCADDERval,
        DATAMEMval,
        PCSel
    );

    pc_adder PCADDER(
        PCADDERval,
        BRSIGNALval,
        PCval
    );

    pc PC(
        PCval,
        PCSELval,
        PCIn,
        clk
    );

    mux_32b_2_to_1 MUX_BRSINGAL(
        BRSIGNALval,
        32'b00000000000000000000000000000100,
        IMMSELval,
        brsignal
    );

    instr_mem INSTRMEM(
        i31_28,
        i4_0,
        i27_23, 
        i22_18, 
        i17_13, 
        i27_0, 
        i22_5,
        PCval,
        InstrRead
    );

    signex_28_to_32 SIGNEX2832(
        SIGNEX2832val,
        i27_0
    );

    signex_18_to_32 SIGNEX1832(
        SIGNEX1832val,
        i22_5
    );

    mux_5b_3_to_1 MUX_READ2SEL(
        READ2SELval,
        5'b00000,
        i22_18,
        i4_0,
        Read2Sel
    );

    mux_5b_2_to_1 MUX_READ1SEL(
        READ1SELval,
        i27_23,
        5'b10000,
        Read1Sel
    );

    mux_5b_3_to_1 MUX_WRITEREGSEL(
        WRITEREGSELval,
        READ1SELval,
        i4_0,
        i17_13,
        WriteRegSel
    );

    mux_32b_2_to_1 MUX_IMMSEL(
        IMMSELval,
        SIGNEX2832val,
        SIGNEX1832val,
        ImmSel
    );

    regbank REGBANK(
        READREG1val,
        READREG2val,
        testREGval,
        READ1SELval,
        READ2SELval,
        WRITEREGSELval,
        WRITEINFOSELval,
        RegRead,
        RegWrite,
        1'b0,
        clk
    );

    mux_32b_2_to_1 MUX_WRITEINFOSEL (
        WRITEINFOSELval,
        ALUval,
        DATAMEMval,
        WriteInfoSel
    );

    mux_32b_3_to_1 MUX_ALUIN2 (
        ALUIN2val,
        READREG2val,
        IMMSELval,
        32'b00000000000000000000000000000100,
        ALUin2
    );

    ALU alu (
        ALUval,
        zero,
        sign,
        carry,
        READREG1val,
        ALUIN2val,
        ALUOp
    );

    mux_32b_2_to_1 MUX_DATASEL (
        DATASELval,
        READREG2val,
        PCSELval,
        DataSel
    );

    data_mem DATAMEM (
        DATAMEMval,
        ALUval,
        DATASELval,
        MemRead,
        MemWrite
    );
endmodule
