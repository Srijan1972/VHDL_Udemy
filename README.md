
# VHDL_Udemy

This repository contains the code for labs in Jordan Christman's VHDL and FPGA development course on Udemy.
These designs are meant for a **BASYS 3** development board, however as I currently do not have access to any circuit boards, I have only done simulations.


## Designs

- Full Adder
- Shift Register
- Universal Shift Register
- 7 Segment Display (The display seen in traffic lights)
- Counter
- Multiplier (Using addition and bit shifting)


## ModelSim Simulation

To simulate any of the designs in ModelSim:
- Go to File > Change Directory, and go to the directory where the files you wish to simulate are located
- Go to File > New > Library. Leave the name as 'work' and make sure the option 'create a library and a logical mapping to it' is selected
- Go to Tools > TCL > Execute Macro. Select the tcl file in the design directory



## Simulation with GHDL and GTKWave
To simulate any of the designs in GTKWave:

- Open a terminal session in the directory of the design you wish to simulate.
- Type:
```bash
    make
```

If you don't have make installed, either install it or simply copy each line in the makefile into the terminal one by one.

