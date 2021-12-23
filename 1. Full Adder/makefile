all:
	ghdl -a Full_Adder.vhd
	ghdl -a --ieee=synopsys Full_Adder_tb.vhd
	ghdl -e --ieee=synopsys Full_Adder_tb
	ghdl -r --ieee=synopsys Full_Adder_tb --wave=Full_Adder.ghw --stop-time=80ns
	gtkwave Full_Adder.ghw