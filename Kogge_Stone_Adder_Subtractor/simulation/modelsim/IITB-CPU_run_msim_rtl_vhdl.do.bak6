transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/pravm/OneDrive/Documents/ACADS/SEM3/EE224/EE224-Project/IITB_CPU_RISCV/Kogge_Stone_Adder_Subtractor/kogge_stone.vhd}
vcom -93 -work work {C:/Users/pravm/OneDrive/Documents/ACADS/SEM3/EE224/EE224-Project/IITB_CPU_RISCV/Kogge_Stone_Adder_Subtractor/kogge_stone_node.vhd}
vcom -93 -work work {C:/Users/pravm/OneDrive/Documents/ACADS/SEM3/EE224/EE224-Project/IITB_CPU_RISCV/Kogge_Stone_Adder_Subtractor/preprocessing.vhd}
vcom -93 -work work {C:/Users/pravm/OneDrive/Documents/ACADS/SEM3/EE224/EE224-Project/IITB_CPU_RISCV/Kogge_Stone_Adder_Subtractor/postprocessing.vhd}

vcom -93 -work work {C:/Users/pravm/OneDrive/Documents/ACADS/SEM3/EE224/EE224-Project/IITB_CPU_RISCV/Kogge_Stone_Adder_Subtractor/testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
