transcript off
vcom shift_reg.vhd
vcom shift_reg_tb.vhd 

vsim shift_reg_tb
add wave sim:/shift_reg_tb/dev_to_test/*
 
run 350 ns