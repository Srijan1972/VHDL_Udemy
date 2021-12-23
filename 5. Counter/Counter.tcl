transcript off
vcom Counter.vhd
vcom Counter_tb.vhd 

vsim Counter_tb
add wave sim:/Counter_tb/dev_to_test/*
 
run 500 ns