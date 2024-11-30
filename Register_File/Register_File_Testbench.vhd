library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.ALL;

entity Register_File_Testbench is
end entity;

architecture bhv of Register_File_Testbench is
	component register_file is
		port (a1, a2, a3 : in std_logic_vector(2 downto 0); 
				d3 : in std_logic_vector(15 downto 0);
				rst, clk, en : in std_logic;
				d1, d2 : out std_logic_vector(15 downto 0));
	end component;
	
	signal a1, a2, a3 : std_logic_vector(2 downto 0) := (others => '0');
	signal d3 : std_logic_vector(15 downto 0) := (others => '0');
	signal rst, clk, en : std_logic := '0';
	signal d1, d2 : std_logic_vector(15 downto 0);
	constant clk_period : time := 10 ns;
	
	begin
		Rf: register_file port map(a1 => a1,a2 => a2,a3 => a3,d3 => d3,rst => rst,clk => clk, en => en, d1 => d1, d2 => d2);
		clk_process: process
			begin
				clk <= not clk after clk_period / 2;
				wait for clk_period / 2;
			end process clk_process;
			
		stim_proc: process
			begin
			  -- Reset the register file
			  rst <= '1';
			  wait for 2 * clk_period;
			  rst <= '0';

			  -- Write to register 3
			  en <= '1';
			  a3 <= "011"; -- Address of register 3
			  d3 <= x"A5A5"; -- Data to write
			  wait for clk_period;

			  -- Disable write enable
			  en <= '0';
			  wait for clk_period;

			  -- Read from registers 3 and 2
			  a1 <= "011"; -- Address of register 3
			  a2 <= "010"; -- Address of register 2
			  wait for clk_period;

			  -- Write to register 2
			  en <= '1';
			  a3 <= "010"; -- Address of register 2
			  d3 <= x"5A5A"; -- Data to write
			  wait for clk_period;

			  -- Disable write enable
			  en <= '0';
			  wait for clk_period;

			  -- Read back values from registers 3 and 2
			  a1 <= "011"; -- Address of register 3
			  a2 <= "010"; -- Address of register 2
			  wait for clk_period;

			  -- End simulation
			  wait;
		end process;
	 
end architecture bhv;
