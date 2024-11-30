transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Register_File/D_Flip_Flop.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Register_File/2_X_1_Mux.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Register_File/PIPO_Register.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Register_File/8_X_1_Mux_16_Bit.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Register_File/8_X_1_Demux_16_Bit.vhd}
vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Register_File/Register_File.vhd}

vcom -93 -work work {E:/Semester_3/Digital Systems/Project_Part_B/Register_File/Register_File_Testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  Register_File_Testbench

add wave *
view structure
view signals
run -all
