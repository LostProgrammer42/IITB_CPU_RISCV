transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Kogge_Stone_Adder_Subtractor/kogge_stone.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Kogge_Stone_Adder_Subtractor/kogge_stone_node.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Kogge_Stone_Adder_Subtractor/preprocessing.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Kogge_Stone_Adder_Subtractor/postprocessing.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Kogge_Stone_Adder_Subtractor/Kogge_stone_adder_subtractor.vhd}

vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Kogge_Stone_Adder_Subtractor/Kogge_stone_adder_subtractor_testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  Kogge_stone_adder_subtractor_testbench

add wave *
view structure
view signals
run -all
