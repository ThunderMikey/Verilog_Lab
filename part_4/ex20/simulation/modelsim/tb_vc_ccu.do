force data_valid 0 0, 1 50ns -repeat 100ns
add wave data_valid
add wave -decimal GA GB KA KB state
run 100000ns