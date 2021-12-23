transcript off
vcom sim_mem_init.vhd
vcom USR.vhd
vcom USR_tb.vhd 

vsim USR_tb
add wave sim:/USR_tb/dev_to_test/*
 
run 420 ns