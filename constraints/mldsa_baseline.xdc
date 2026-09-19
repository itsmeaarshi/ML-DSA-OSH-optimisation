## ML-DSA-OSH baseline constraints
## Part: xc7a200tfbg676-2 (Artix-7)
##
## Deliberately conservative starting clock -- get a clean, correct
## implementation run first, note the actual timing slack Vivado reports,
## then tighten the period as a separate, logged step later (frequency
## changes affect both latency and power, so it becomes its own experiment
## rather than being folded into initial setup).

create_clock -period 17.500 -name clk [get_ports clk]

## Exact top-level ports of combined_top, confirmed from the RTL:
##   inputs:  clk, rst, start, mode[1:0], sec_lvl[2:0], valid_i, data_i[63:0], ready_o
##   outputs: ready_i, valid_o, data_o[63:0]
## This project targets synthesis/implementation for area/timing/power
## analysis, not a pin-mapped bitstream, so no package-pin/IOSTANDARD
## constraints are set here -- only I/O delay placeholders so Vivado
## doesn't flag every port as unconstrained during timing analysis.

set_input_delay -clock clk 2.000 [get_ports {rst start mode[*] sec_lvl[*] valid_i data_i[*] ready_o}]
set_output_delay -clock clk 2.000 [get_ports {ready_i valid_o data_o[*]}]
