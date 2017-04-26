add wave -position end /counter/clock
add wave -position end /counter/reset
add wave -position end /counter/enable
add wave -position end -hexadecimal /counter/count
force /counter/clock   0 0ns, 1 10ns -repeat 20ns
force /counter/reset  0 0ns, 1 10ns, 0 20ns
force /counter/enable  0 0ns,  1 30ns
run 380ns