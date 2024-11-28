transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Array_Multiplier/Full_Adder.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Array_Multiplier/Array_Multiplier_Node.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Array_Multiplier/Array_Multiplier.vhd}

vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Array_Multiplier/Array_Multiplier_Testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  Array_Multiplier_Testbench

add wave *
view structure
view signals
run -all
