# PYNQ-Z2 Board Constraints
# The constraint provides the performance target for the clock signal provided by the
# Zynq Processing System (PS) to the PL side, we assume a clock frequency of 100 MHz
create_clock -period 10.000 -name clk_fpga_0 [get_clocks -of_objects [get_pins processing_system7_0/FCLK_CLK0]]