all:
	ghdl -a --ieee=synopsys Sim_Mem_Init.vhd
	ghdl -a USR.vhd
	ghdl -a --ieee=synopsys USR_tb.vhd
	ghdl -e --ieee=synopsys USR_tb
	ghdl -r --ieee=synopsys USR_tb --wave=USR.ghw --stop-time=420ns
	gtkwave USR.ghw