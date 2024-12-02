library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.ALL;

entity Memory_64b_testbench is
end entity;

architecture bhv of Memory_64b_testbench is
	component memory_64b is
		port (
			a1, a2 : in std_logic_vector(15 downto 0);
			d2 : in std_logic_vector(15 downto 0);
			rst, clk, mem_w, mem_r: in std_logic;
			d1 : out std_logic_vector(15 downto 0)
		);
	end component;
	signal a1, a2 : std_logic_vector(15 downto 0) := (others => '0');
	signal d2 : std_logic_vector(15 downto 0) := (others => '0');
	signal rst, clk, mem_w, mem_r : std_logic := '0';
	signal d1 : std_logic_vector(15 downto 0);
	constant clk_period : time := 10 ns;
begin
	mem: memory_64b port map(a1 => a1, a2 => a2, d2 => d2, rst => rst, clk => clk,  mem_w=> mem_w, mem_r=>mem_r, d1 => d1);
	clk_process: process
	begin
		clk <= not clk after clk_period / 2;
		wait for clk_period / 2;
	end process clk_process;
	stim_proc: process
	begin
		rst <= '1';
		wait for 2 * clk_period;
		rst <= '0';
		mem_w <= '1';
		mem_r <= '0';
		for i in 0 to 31 loop
			a2 <= std_logic_vector(to_unsigned(i, 16));
			d2 <= std_logic_vector(to_unsigned(i, 16));
			wait for clk_period;
		end loop;
		mem_w <= '0';
		mem_r <= '1';
		wait for clk_period;
		for i in 0 to 31 loop
			a1 <= std_logic_vector(to_unsigned(i, 16));
			wait for clk_period;
		end loop;
		wait;
	end process;
end architecture bhv;
