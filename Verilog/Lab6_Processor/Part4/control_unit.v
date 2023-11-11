module control_unit(
    output reg [5:0] state,
    output PCSel,
    output PCIn,
    output InstrRead,
    output Read1Sel,
    output [1:0] Read2Sel,
    output [1:0] WriteRegSel,
    output WriteInfoSel,
    output RegRead,
    output RegWrite,
    output ImmSel,
    output [1:0] ALUin2,
    output [3:0] ALUOp,
    output DataSel,
    output MemRead,
    output MemWrite,

    output [2:0] BrOp,

    input INT,
    input [3:0] opcode,
    input [4:0] func,
    input clk);

    // OPCODES
    parameter ALU = 4'b0000;
    parameter LD = 4'b0001;
    parameter ST = 4'b0010;
    parameter LDSP = 4'b0011;
    parameter STSP = 4'b0100;
    parameter BR = 4'b0101;
    parameter BMI = 4'b0110;
    parameter BPL = 4'b0111;
    parameter BZ = 4'b1000;
    parameter PUSH = 4'b1001;
    parameter POP = 4'b1010;
    parameter CALL = 4'b1011;
    parameter RET = 4'b1100;
    parameter MOVE = 4'b1101;
    parameter HALT = 4'b1110;
    parameter NOP = 4'b1111;

    // ALU FUNCTIONS
    parameter ADD = 5'b00000;
    parameter SUB = 5'b00001;
    parameter AND = 5'b00010;
    parameter OR = 5'b00011;
    parameter XOR = 5'b00100;
    parameter NOT = 5'b00101;
    parameter SLA = 5'b00110;
    parameter SRA = 5'b00111;
    parameter SRL = 5'b01000;
    parameter ADDI = 5'b01001;
    parameter SUBI = 5'b01010;
    parameter ANDI = 5'b01011;
    parameter ORI = 5'b01100;
    parameter XORI = 5'b01101;
    parameter NOTI = 5'b01110;
    parameter SLAI = 5'b01111;
    parameter SRAI = 5'b10000;
    parameter SRLI = 5'b10001;

    reg [23:0] combine; // To assign all control signals (total span is 24 bits) at once
    assign {PCSel, PCIn, InstrRead, Read1Sel, Read2Sel, WriteRegSel, WriteInfoSel, RegRead, RegWrite, ImmSel, ALUin2, ALUOp, BrOp, DataSel, MemRead, MemWrite} = combine;

    initial begin
        state <= 0;
        combine <= 0;
    end
    always @(posedge clk) begin
        if (clk) begin
            case (state)
                0: begin
                    combine <= 24'b001000000000001111000000;
                    state <= 1;
                end
                1: begin
                    combine <= 24'b000000000000001111000000;
                    case(opcode)
                        ALU: begin
                            if (func < ADDI) state <= 2;
                            else state <= 14;
                        end
                        LD: state <= 14;
                        ST: state <= 14;
                        LDSP: state <= 14;
                        STSP: state <= 14;
                        BR: state <= 38;
                        BMI: state <= 14;
                        BPL: state <= 14;
                        BZ: state <= 14;
                        PUSH: state <= 31;
                        POP: state <= 34;
                        CALL: state <= 34;
                        RET: state <= 34;
                        MOVE: state <= 14;
                        HALT: begin
                            if (INT) state <= 5;
                            else state <= 1;
                        end
                        NOP: state <= 5;
                    endcase
                end
                2: begin
                    combine <= 24'b000001000100001111000000;
                    case(opcode)
                        ALU: begin
                            case(func)
                                ADD: state <= 3;
                                SUB: state <= 6;
                                AND: state <= 7;
                                OR: state <= 8;
                                XOR: state <= 9;
                                NOT: state <= 10;
                                SLA: state <= 11;
                                SRA: state <= 12;
                                SRL: state <= 13;
                            endcase
                        end
                    endcase
                end
                3: begin
                    combine <= 24'b000000000000000000000000;
                    case(opcode)
                        ALU: state <= 4;
                        BMI: state <= 28;
                        BPL: state <= 29;
                        BZ: state <= 30;
                        POP: state <= 25;
                        RET: state <= 25;
                        MOVE: state <= 40;
                    endcase
                end
                4: begin
                    combine <= 24'b000000100010001111000000;
                    state <= 5;
                end
                5: begin
                    combine <= 24'b010000000000001111000000;
                    state <= 0;
                end
                6: begin
                    combine <= 24'b000000000000000001000000;
                    state <= 4;
                end
                7: begin
                    combine <= 24'b000000000000000010000000;
                    state <= 4;
                end
                8: begin
                    combine <= 24'b000000000000000011000000;
                    state <= 4;
                end
                9: begin
                    combine <= 24'b000000000000000100000000;
                    state <= 4;
                end
                10: begin
                    combine <= 24'b000000000000000101000000;
                    state <= 4;
                end
                11: begin
                    combine <= 24'b000000000000000110000000;
                    state <= 4;
                end
                12: begin
                    combine <= 24'b000000000000000111000000;
                    state <= 4;
                end
                13: begin
                    combine <= 24'b000000000000001000000000;
                    state <= 4;
                end
                14: begin
                    combine <= 24'b000000000100001111000000;
                    case(opcode)
                        ALU: begin
                            case(func)
                                ADDI: state <= 15;
                                SUBI: state <= 17;
                                ANDI: state <= 18;
                                ORI: state <= 19;
                                XORI: state <= 20;
                                NOTI: state <= 21;
                                SLAI: state <= 22;
                                SRAI: state <= 23;
                                SRLI: state <= 24;
                            endcase
                        end
                        LD: state <= 15;
                        ST: state <= 15;
                        LDSP: state <= 15;
                        STSP: state <= 15;
                        BMI: state <= 3;
                        BPL: state <= 3;
                        BZ: state <= 3;
                        MOVE: state <= 3;
                    endcase
                end
                15: begin
                    combine <= 24'b000000000001010000000000;
                    case(opcode)
                        ALU: state <= 16;
                        LD: state <= 25;
                        ST: state <= 41;
                        LDSP: state <= 25;
                        STSP: state <= 41;
                    endcase
                end
                16: begin
                    combine <= 24'b000000000010001111000000;
                    state <= 5;
                end
                17: begin
                    combine <= 24'b000000000001010001000000;
                    state <= 16;
                end
                18: begin
                    combine <= 24'b000000000001010010000000;
                    state <= 16;
                end
                19: begin
                    combine <= 24'b000000000001010011000000;
                    state <= 16;
                end
                20: begin
                    combine <= 24'b000000000001010100000000;
                    state <= 16;
                end
                21: begin
                    combine <= 24'b000000000001010101000000;
                    state <= 16;
                end
                22: begin
                    combine <= 24'b000000000001010110000000;
                    state <= 16;
                end
                23: begin
                    combine <= 24'b000000000001010111000000;
                    state <= 16;
                end
                24: begin
                    combine <= 24'b000000000001011000000000;
                    state <= 16;
                end
                25: begin
                    combine <= 24'b000000000000001111000010;
                    case(opcode)
                        LD: state <= 26;
                        LDSP: state <= 26;
                        POP: state <= 35;
                        RET: state <= 39;
                    endcase
                end
                26: begin
                    combine <= 24'b000000011010001111000000;
                    state <= 5;
                end
                27: begin
                    combine <= 24'b000000000000001111000001;
                    state <= 5;
                end
                28: begin
                    combine <= 24'b010000000001001111010000;
                    state <= 0;
                end
                29: begin
                    combine <= 24'b010000000001001111011000;
                    state <= 0;
                end
                30: begin
                    combine <= 24'b010000000001001111100000;
                    state <= 0;
                end
                31: begin
                    combine <= 24'b000101000100001111000000;
                    state <= 32;
                end
                32: begin
                    combine <= 24'b000000000000100001000000;
                    case(opcode)
                        PUSH: state <= 33;
                        CALL: state <= 37;
                    endcase
                end
                33: begin
                    combine <= 24'b000100000010001111000001;
                    state <= 5;
                end
                34: begin
                    combine <= 24'b000100000100001111000000;
                    case(opcode)
                        POP: state <= 3;
                        CALL: state <= 32;
                        RET: state <= 3;
                    endcase
                end
                35: begin
                    combine <= 24'b000000101010100000000000;
                    state <= 36;
                end
                36: begin
                    combine <= 24'b010100000010001111000000;
                    state <= 0;
                end
                37: begin
                    combine <= 24'b000100000010001111000101;
                    state <= 38;
                end
                38: begin
                    combine <= 24'b010000000000001111001000;
                    state <= 0;
                end
                39: begin
                    combine <= 24'b110000000000100000000000;
                    state <= 42;
                end
                40: begin
                    combine <= 24'b010000010010001111000000;
                    state <= 0;
                end
                41: begin
                    combine <= 24'b000010000100001111000000;
                    state <= 27;
                end
                42: begin
                    combine <= 24'b000100000010001111000000;
                    state <= 0;
                end
                default: begin
                    combine <= 24'b000000000000001111000000;
                    state <= 0;
                end
            endcase
        end
    end
endmodule