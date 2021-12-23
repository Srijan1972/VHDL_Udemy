all:
	ghdl -a Hex_to_7_Seg.vhd
	ghdl -a --ieee=synopsys  Hex_to_7_Seg_tb.vhd
	ghdl -e --ieee=synopsys  Hex_to_7_Seg_tb
	ghdl -r --ieee=synopsys  Hex_to_7_Seg_tb --wave=Hex_to_7_Seg.ghw --stop-time=160ns
	gtkwave Hex_to_7_Seg.ghw