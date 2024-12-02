library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CPU_testbench is
end entity;

architecture behav of CPU_testbench is
	component CPU is
		port(clk,reset: in std_logic;
			  Mem_add_read,Mem_add_write,Mem_data_write,PCout, IRout, IRoutcontroller: out std_logic_vector(15 downto 0);
			  Mem_data_read: in std_logic_vector(15 downto 0);
			  Mem_r,Mem_w: out std_logic;
			  ostate: out std_logic_vector(4 downto 0));
	end component;
	signal clk: std_logic := '0';
	signal tprd: time := 10ns;
	signal Mem_add_write, Mem_data_write,PC, IR, IRoutcontroller: std_logic_vector(15 downto 0);
	signal Mem_r, Mem_w : std_logic := '0';
	signal Mem_add_read, Mem_data_read: std_logic_vector(15 downto 0);
	signal cstate : std_logic_vector(4 downto 0);
	
	type regarray is array(31 downto 0) of std_logic_vector(15 downto 0);
	signal Memory: regarray:=(
		0 =>  "1010000001000100",--Instr1: LW from Mem Address=4 to RF address = 0; Instr1 at Mem Address = 0
		1 =>  "1010001010000101",--Instr2: LW from Mem Address=5 to RF address = 1; Instr2 at Mem Address = 1
		2 =>  "0000000001010000",--Instr3: Add Reg0 and Reg1 and store in Reg2; Instr3 at Mem Address = 2
		3 =>  "1011010011000110",--Instr4: SW from RF address=2 to Mem address = 6; Instr4 at Mem Address = 3
		4 =>  "0000000000010000", -- Number1
		5 =>  "0000000000000001", -- Number2
		6 =>  "0110000001010000",
		7 =>  "1000000000000111",
		8 =>  "1001000000000100",
		9 =>  "1010000110001110",
		14=>  "0000000000000000",
		15 => "1100100110000010",
		18 => "1111000001000000",
		27 => "1101000000000011",
		30 => "1011000001000101",
		others => x"0000");
	begin
		cpuinst: CPU port map(ostate=>cstate, IRout=>IR,clk=>clk,reset=>'0',Mem_add_read=>Mem_add_read,Mem_add_write=>Mem_add_write,Mem_data_write=>Mem_data_write,PCout=>PC,Mem_data_read=>Mem_data_read,Mem_r=>Mem_r,Mem_w=>Mem_w, IRoutcontroller=>IRoutcontroller);
		clk_process: process
		begin
			clk <= not clk after tprd / 2;
			wait for tprd / 2;
		end process clk_process;
		
		Mem_process: process(Mem_add_read,Mem_add_write,Mem_r,Mem_w,clk)
		begin
				if Mem_w = '1' then
					Memory(to_integer(unsigned(Mem_add_write))) <= Mem_data_write;
				elsif Mem_r = '1' then
					Mem_data_read <= Memory(to_integer(unsigned(Mem_add_read)));
				end if;
		end process;
	
end architecture;