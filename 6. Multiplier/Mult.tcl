transcript off
vcom sim_mem_init.vhd
vcom Mult.vhd
vcom Mult_tb.vhd 

vsim Mult_tb
add wave sim:/Mult_tb/dev_to_test/*
 
run 850 ns