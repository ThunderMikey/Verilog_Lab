add wave clock enable
add wave -hexadecimal count
force enable 0 0, 1 100ns -repeat 200ns
force clock 0  0, 1 10ns -repeat 15ns

#run 100ns
#force enable 0
#run 100ns
#force enable 1
#run 100000ns