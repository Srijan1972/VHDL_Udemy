transcript off
vcom full_adder.vhd
vcom full_adder_tb.vhd

vsim full_adder_tb
add wave sim:/full_adder_tb/dev_to_test/*

run 80 ns