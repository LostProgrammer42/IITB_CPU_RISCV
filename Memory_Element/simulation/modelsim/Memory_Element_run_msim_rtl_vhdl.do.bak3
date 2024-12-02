transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Memory_Element/PIPO_Register.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Memory_Element/memory_64b.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Memory_Element/D_Flip_Flop.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Memory_Element/32_X_1_Mux_16_bit.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Memory_Element/32_X_1_Demux_16_bit.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Memory_Element/2_X_1_Mux.vhd}

vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Memory_Element/Memory_64b_testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  Memory_64b_testbench

add wave *
view structure
view signals
run -all
