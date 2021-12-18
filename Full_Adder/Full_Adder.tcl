transcript off
vcom Full_Adder.vhd
vcom Full_Adder_tb.vhd

vsim Full_Adder_tb
add wave sim:/Full_Adder_tb/dev_to_test/*

run 80 ns