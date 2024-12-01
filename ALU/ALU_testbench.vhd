library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_testbench	is
end entity;

architecture str of ALU_testbench is
	component ALU is
		port(a,b: in std_logic_vector(15 downto 0);
			  s0,s1,s2: in std_logic;
			  c: out std_logic_vector(15 downto 0);
			  Cout,Z: out std_logic);
	end component;
	signal n1, n2 : integer := 0;
	signal s1, s2: std_logic_vector(15 downto 0) := (others => '1');  
	signal s : std_logic_vector(15 downto 0);   
	signal tprd : time := 20 ns;  
	signal Cout, Z: std_logic;
	
	begin
		inst1: ALU port map(A => s1,B => s2,S
		
		
		
		
		
		
		2 => '1', s1 => '0', s0 => '0', c=> s, Cout=>Cout, Z => Z);
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
						report "For a=" & integer'image(n1_val) & " b=" & integer'image(n2_val) & " got s=" & integer'image(to_integer(unsigned(s)));
					end loop;
				end loop;
				wait;
		end process;
end architecture;