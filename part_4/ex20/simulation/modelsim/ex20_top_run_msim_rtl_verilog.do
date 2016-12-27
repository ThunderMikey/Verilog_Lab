transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Projects/Verilog_Lab/part_4/ex20 {D:/Projects/Verilog_Lab/part_4/ex20/counter_13.v}
vlog -vlog01compat -work work +incdir+D:/Projects/Verilog_Lab/part_4/ex20 {D:/Projects/Verilog_Lab/part_4/ex20/pulse_gen.v}
vlog -vlog01compat -work work +incdir+D:/Projects/Verilog_Lab/part_4/ex20 {D:/Projects/Verilog_Lab/part_4/ex20/vc_main.v}
vlog -vlog01compat -work work +incdir+D:/Projects/Verilog_Lab/part_4/ex20 {D:/Projects/Verilog_Lab/part_4/ex20/vc_ccu.v}
vlog -vlog01compat -work work +incdir+D:/Projects/Verilog_Lab/part_4/ex20 {D:/Projects/Verilog_Lab/part_4/ex20/ram_2ports_wr.v}

