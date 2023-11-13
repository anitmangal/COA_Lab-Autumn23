import sys
import regex as re
import argparse
import os

# Global variables
PC = 0  # program counter


def main(source_file, output_file):
    instructs = []
    with open(source_file, 'r') as f:
        for lno, line in enumerate(f.readlines()):
            if (line[0] == '/' and line[1] == '/'):
                continue
            line = line.strip()
            if line == '' or line[0] == '//':
                continue
            else:
                args = re.split(r'[\s,\(\)]+', line)
                opco = args[0]
                if opco == "ADD" or opco == "SUB" or opco == "AND" or opco == "OR" or opco == "XOR" or opco == "NOT" or opco == "SLA" or opco == "SRA" or opco == "SRL":
                    opcode = "0000"
                    if (opco == "ADD"):
                        funct = "00000"
                    elif (opco == "SUB"):
                        funct = "00001"
                    elif (opco == "AND"):
                        funct = "00010"
                    elif (opco == "OR"):
                        funct = "00011"
                    elif (opco == "XOR"):
                        funct = "00100"
                    elif (opco == "NOT"):
                        funct = "00101"
                    elif (opco == "SLA"):
                        funct = "00110"
                    elif (opco == "SRA"):
                        funct = "00111"
                    elif (opco == "SRL"):
                        funct = "01000"
                    rd, rs, rt = args[1], args[2], args[3]
                    rd = format(int(rd[1:]), '05b')
                    rs = format(int(rs[1:]), '05b')
                    rt = format(int(rt[1:]), '05b')
                    dc = '0'*8
                    instr = opcode + rs + rt + rd + dc + funct
                    instructs.append(instr)
                elif opco == "ADDI" or opco == "SUBI" or opco == "ANDI" or opco == "ORI" or opco == "XORI" or opco == "NOTI" or opco == "SLAI" or opco == "SRAI" or opco == "SRLI":
                    opcode = "0000"
                    if (opco == "ADDI"):
                        funct = "01001"
                    elif (opco == "SUBI"):
                        funct = "01010"
                    elif (opco == "ANDI"):
                        funct = "01011"
                    elif (opco == "ORI"):
                        funct = "01100"
                    elif (opco == "XORI"):
                        funct = "01101"
                    elif (opco == "NOTI"):
                        funct = "01110"
                    elif (opco == "SLAI"):
                        funct = "01111"
                    elif (opco == "SRAI"):
                        funct = "10000"
                    elif (opco == "SRLI"):
                        funct = "10001"
                    rs, imm = args[1], args[2]
                    imm = bin(int(imm[1:]) & 0b111111111111111111)[2:]
                    imm = imm.zfill(18)
                    rs = format(int(rs[1:]), '05b')
                    instr = opcode + rs + imm + funct
                    instructs.append(instr)
                elif opco == "LD" or opco == "ST" or opco == "LDSP" or opco == "STSP":
                    if (opco == "LD"):
                        opcode = "0001"
                    elif (opco == "ST"):
                        opcode = "0010"
                    elif (opco == "LDSP"):
                        opcode = "0011"
                    elif (opco == "STSP"):
                        opcode = "0100"
                    rd, imm, rs = args[1], args[2], args[3]
                    imm = bin(int(imm) & 0b111111111111111111)[2:]
                    imm = imm.zfill(18)
                    rs = format(int(rs[1:]), '05b')
                    rd = format(int(rd[1:]), '05b')
                    instr = opcode + rs + imm + rd
                    instructs.append(instr)
                elif opco == "BR" or opco == "CALL":
                    if (opco == "BR"):
                        opcode = "0101"
                    else:
                        opcode = "1011"
                    imm = args[1]
                    imm = bin(int(imm[1:]) & 0b1111111111111111111111111111)[2:]
                    imm = imm.zfill(28)
                    instr = opcode + imm
                    instructs.append(instr)
                elif opco == "BMI" or opco == "BPL" or opco == "BZ":
                    if (opco == "BMI"):
                        opcode = "0110"
                    elif (opco == "BPL"):
                        opcode = "0111"
                    elif (opco == "BZ"):
                        opcode = "1000"
                    rs, imm = args[1], args[2]
                    imm = bin(int(imm[1:]) & 0b111111111111111111)[2:]
                    imm = imm.zfill(18)
                    rs = format(int(rs[1:]), '05b')
                    dc = '0'*5
                    instr = opcode + rs + imm + dc
                    instructs.append(instr)
                elif opco == "PUSH":
                    opcode = "1001"
                    rt = args[1]
                    rt = format(int(rt[1:]), '05b')
                    dc1 = '0'*5
                    dc2 = '0'*18
                    instr = opcode + dc1 + rt + dc2
                    instructs.append(instr)
                elif opco == "POP":
                    opcode = "1010"
                    rd = args[1]
                    rd = format(int(rd[1:]), '05b')
                    dc1 = '0'*10
                    dc2 = '0'*13
                    instr = opcode + dc1 + rd + dc2
                    instructs.append(instr)
                elif opco == "RET" or opco == "HALT" or opco == "NOP":
                    if (opco == "RET"):
                        opcode = "1100"
                    elif (opco == "HALT"):
                        opcode = "1110"
                    elif (opco == "NOP"):
                        opcode = "1111"
                    dc = '0'*28
                    instr = opcode + dc
                    instructs.append(instr)
                elif opco == "MOVE":
                    opcode = "1101"
                    rd, rs = args[1], args[2]
                    rd = format(int(rd[1:]), '05b')
                    rs = format(int(rs[1:]), '05b')
                    dc = '0'*18
                    instr = opcode + rs + dc + rd
                    instructs.append(instr)
                else:
                    raise Exception("Error: Invalid instruction at line {}".format(lno))
    # Write instructions to file in binary format of 8-bit blocks
    with open(output_file, 'w') as f:
        for instr in instructs:
            f.write(instr[0:8]+" "+instr[8:16]+" "+instr[16:24]+" "+instr[24:33]+"\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Assembler')
    parser.add_argument('-s', '--source', help='source file',
                        required=True, type=str)
    parser.add_argument('-o', '--output', help='output file',
                        default='instr_mem.txt', type=str)
    args = parser.parse_args()

    # Check if source file exists
    if not os.path.isfile(args.source):
        print('Error: source file does not exist')
        sys.exit(1)
    main(args.source, args.output)
