library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Kogge_stone_adder_subtractor_testbench is
end entity;

architecture s of Kogge_stone_adder_subtractor_testbench is
	component kogge_stone_adder_subtractor is
		port(
			A : in std_logic_vector(15 downto 0);
			B : in std_logic_vector(15 downto 0);
			M: in std_logic := '0';
			S: out std_logic_vector(15 downto 0);
			Cout: out std_logic);
	end component;
	component kogge_stone is
		port(
			A : in std_logic_vector(15 downto 0);
			B : in std_logic_vector(15 downto 0);
			S: out std_logic_vector(15 downto 0);
			Cout: out std_logic;
			Cin: in std_logic := '0'
			);
	end component;
	
	signal n1, n2 : integer := 0;
	signal s1, s2: std_logic_vector(15 downto 0) := (others => '1');  
	signal s : std_logic_vector(15 downto 0);       
	signal tprd : time := 20 ns;  
	signal Cout: std_logic;
	
	begin
		inst1: kogge_stone_adder_subtractor port map(A => s1,B => s2,S => s, M => '1',Cout=>Cout);
		test_process : process
			variable n1_val,n2_val,n: integer;
			begin
				for n1_val in 0 to 10 loop
					for n2_val in 0 to 10 loop
						n1 <= n1_val;
						n2 <= n2_val;
						s1 <= std_logic_vector(to_signed(n1_val, 16));
						s2 <= std_logic_vector(to_signed(n2_val, 16));
						wait for tprd;
						n := to_integer(signed(s));
						if ((n1_val - n2_val) = n) then
							report "For a=" & integer'image(n1_val) & " b=" & integer'image(n2_val) & " got s=" & integer'image(to_integer(unsigned(s)));
						else
							report "ERROR: For a=" & integer'image(n1_val) & " b=" & integer'image(n2_val) & " got s=" & integer'image(to_integer(unsigned(s)));
						end if;
					end loop;
				end loop;
				wait;
		end process;
end architecture;