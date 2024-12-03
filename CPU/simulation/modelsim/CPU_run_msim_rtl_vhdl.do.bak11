transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/SE_9_To_16.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/SE_6_To_16.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/Register_File.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/preprocessing.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/postprocessing.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/PIPO_Register.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/Or_16.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/kogge_stone_node.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/Kogge_stone_adder_subtractor.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/kogge_stone.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/Imp_16.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/Full_Adder.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/Eight_Bit_Left_Shifter.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/D_Flip_Flop.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/Array_Multiplier_Node.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/Array_Multiplier.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/And_16.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/ALU.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/32_X_1_Mux_16_bit.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/8_X_1_Mux_16_Bit.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/8_X_1_Demux_16_Bit.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/2_X_1_Mux.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/CPU.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/Steering_Logic.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/32_X_1_Mux_3_bit.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/32_X_1_Mux_1_bit.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/32_X_1_Mux_6_bit.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/32_X_1_Mux_9_bit.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/Controller.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/8_X_1_Demux_1_Bit.vhd}

vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/CPU/CPU_testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  CPU_testbench

add wave *
view structure
view signals
run 1500 ns
