library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CPU_testbench is
end entity;

architecture behav of CPU_testbench is
	component top_level is
		port(
				clk, reset: in std_logic;
				mem_add_write_init, mem_data_write_init : in std_logic_vector(15 downto 0);
				mem_w_init : in std_logic;
				add_write, add_read, data_write, data_read : out std_logic_vector(15 downto 0);
		dout0 : out std_logic_vector(15 downto 0);
			mem_r_out, mem_read : out std_logic
			);
	end component;
	signal clk: std_logic := '0';
	signal tprd: time := 10ns;
	signal Mem_add_write, Mem_data_write: std_logic_vector(15 downto 0);
	signal Mem_r, Mem_w, reset : std_logic := '0';
	signal Mem_r_cpu, mem_r_memory : std_logic := '0';
	signal Mem_add_read_cpu, Mem_add_write_cpu, Mem_data_write_cpu, Mem_data_read_cpu, dout0: std_logic_vector(15 downto 0);
begin
	clk_process: process
	begin
		clk <= not clk after tprd / 2;
		wait for tprd / 2;
	end process clk_process;
	write_process: process
	begin
			reset <= '1';
--			Mem_add_write<="0000000000000100";--4
--			Mem_w <= '1';
--			Mem_r <= '0';
--			Mem_data_write <= "0000000000010000"; --Number1 = 16 in Memory at address=4
--			wait for 2*tprd;
--			Mem_add_write<="0000000000000101";--5
--			Mem_w <= '1';
--			Mem_r <= '0';
--			Mem_data_write <= "0000000000000001"; --Number2 = 1 in Memory at address=5
--			wait for 2*tprd;
--			Mem_add_write<="0000000000000000";--0
--			Mem_w <= '1';
--			Mem_r <= '0';
--			Mem_data_write <= "1010000001000100"; --Instr1: LW from Mem Address=4 to RF address = 0; Instr1 at Mem Address = 0
--			wait for 2*tprd;
--			Mem_add_write<="0000000000000001";--1
--			Mem_w <= '1';
--			Mem_r <= '0';
--			Mem_data_write <= "1010001010000101"; --Instr2: LW from Mem Address=5 to RF address = 1; Instr2 at Mem Address = 1
--			wait for 2*tprd;
			Mem_add_write<="0000000000000000"; --2
			Mem_w <= '1';
			Mem_r <= '0';
			Mem_data_write <= "0000000001010000"; --Instr3: Add Reg0 and Reg1 and store in Reg2; Instr3 at Mem Address = 2
			wait for 2*tprd;
--			Mem_add_write<="0000000000000011";--3
--			Mem_w <= '1';
--			Mem_r <= '0';
--			Mem_data_write <= "1011010011000110"; --Instr4: SW from RF address=2 to Mem address = 6; Instr4 at Mem Address = 3
--			wait for 2*tprd;
			Mem_w <= '0';
			Mem_r <= '1';
			reset <= '0';
			wait;
	end process;
	inst : top_level port map(clk=>clk, reset => reset, mem_add_write_init=>mem_add_write, mem_data_write_init => mem_data_write, mem_w_init=>mem_w, add_write=>mem_add_write_cpu, add_read=>mem_add_read_cpu, data_write=>mem_data_write_cpu, data_read => mem_data_read_cpu, mem_r_out => mem_r_cpu, mem_read => mem_r_memory, dout0 => dout0);
end architecture;