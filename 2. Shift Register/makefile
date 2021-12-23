all:
	ghdl -a Shift_Reg.vhd
	ghdl -a Shift_Reg_tb.vhd
	ghdl -e Shift_Reg_tb
	ghdl -r Shift_Reg_tb --wave=Shift_Reg.ghw --stop-time=350ns
	gtkwave Shift_Reg.ghw