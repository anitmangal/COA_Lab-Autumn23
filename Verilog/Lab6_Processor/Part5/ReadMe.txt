Use assembler.py to translate instructions from problem statement to 32-bit instructions.
	python3 assembler.py -s *filename*
It creates a file "instr_mem.txt". Copy its contents into "FPGA/instr_mem.txt" or "Simulation/instr_mem.txt"
Edit the contents of "data_mem.txt" in the format as in the samples given.

When running on Vivado, make sure to import instr_mem.txt and data_mem.txt as well.
