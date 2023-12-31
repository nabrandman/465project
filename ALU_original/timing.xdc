create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]
set_input_delay -clock [get_clocks clk] -min -add_delay 2.000 [get_ports {a[*]}]
set_input_delay -clock [get_clocks clk] -max -add_delay 3.000 [get_ports {a[*]}]
set_input_delay -clock [get_clocks clk] -min -add_delay 2.000 [get_ports {b[*]}]
set_input_delay -clock [get_clocks clk] -max -add_delay 3.000 [get_ports {b[*]}]
set_input_delay -clock [get_clocks clk] -min -add_delay 2.000 [get_ports {ctrl[*]}]
set_input_delay -clock [get_clocks clk] -max -add_delay 3.000 [get_ports {ctrl[*]}]
set_output_delay -clock [get_clocks clk] -min -add_delay 0.000 [get_ports {y[*]}]
set_output_delay -clock [get_clocks clk] -max -add_delay 1.100 [get_ports {y[*]}]
set_output_delay -clock [get_clocks clk] -min -add_delay 0.000 [get_ports cout]
set_output_delay -clock [get_clocks clk] -max -add_delay 1.100 [get_ports cout]
