all:
	ghdl -a Counter.vhd
	ghdl -a --ieee=synopsys Counter_tb.vhd
	ghdl -e --ieee=synopsys Counter_tb
	ghdl -r --ieee=synopsys  Counter_tb --wave=Counter.ghw --stop-time=500ns
	gtkwave Counter.ghw