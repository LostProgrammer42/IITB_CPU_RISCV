transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/ALU/8_X_1_Mux_16_Bit.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/ALU/preprocessing.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/ALU/postprocessing.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/ALU/Or_16.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/ALU/kogge_stone_node.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/ALU/Kogge_stone_adder_subtractor.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/ALU/kogge_stone.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/ALU/Imp_16.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/ALU/Full_Adder.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/ALU/Array_Multiplier_Node.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/ALU/Array_Multiplier.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/ALU/And_16.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/ALU/ALU.vhd}

vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/ALU/ALU_testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  ALU_testbench

add wave *
view structure
view signals
run -all
