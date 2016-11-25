transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Verilog_Lab/Part_2/ex5 {C:/Verilog_Lab/Part_2/ex5/counter_8.v}

