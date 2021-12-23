all:
	ghdl -a --ieee=synopsys Sim_Mem_Init.vhd
	ghdl -a Mult.vhd
	ghdl -a --ieee=synopsys Mult_tb.vhd
	ghdl -e --ieee=synopsys Mult_tb
	ghdl -r --ieee=synopsys Mult_tb --wave=Mult.ghw --stop-time=850ns
	gtkwave Mult.ghw