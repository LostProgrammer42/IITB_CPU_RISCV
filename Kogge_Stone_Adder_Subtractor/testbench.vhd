library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity;

architecture behav of testbench is
	component kogge_stone is
		port(
			A : in std_logic_vector(15 downto 0);
			B : in std_logic_vector(15 downto 0);
			C : out std_logic_vector(16 downto 0);
			M : in std_logic :='0';
			Cin: in std_logic := '0';
			k1, k2, k3, k4, temp1_Go, temp1_Po, temp2_Go, temp2_Po, temp3_Go, temp3_Po, temp4_Go, temp4_Po: out std_logic_vector(15 downto 0)
		);
	end component;
	signal n1, n2 : integer := 0;
	signal s1, s2 : std_logic_vector(15 downto 0) := (others => '0');  
	signal s : std_logic_vector(16 downto 0);       
	signal tprd : time := 20 ns;                       
	signal ka, kb, kc, kd : std_logic_vector(15 downto 0);
	signal temp1_G, temp1_P, temp2_G, temp2_P, temp3_G, temp3_P, temp4_G, temp4_P: std_logic_vector(15 downto 0);
begin
	inst1: kogge_stone port map(A => s1,B => s2,C => s,M => '0',Cin => '0',K1 => ka,K2 => kb,K3 => kc,K4 => kd, temp1_Go=>temp1_G, temp1_Po=>temp1_P, temp2_Go=>temp2_G, temp2_Po=>temp2_P, temp3_Go=>temp3_G, temp3_Po=>temp3_P, temp4_Go=>temp4_G, temp4_Po=>temp4_P);
	test_process : process
	variable n1_val,n2_val,n: integer;
	begin
		for n1_val in 0 to 65535 loop
			for n2_val in 0 to 65535 loop
				n1 <= n1_val;
				n2 <= n2_val;
				s1 <= std_logic_vector(to_unsigned(n1_val, 16));
				s2 <= std_logic_vector(to_unsigned(n2_val, 16));
				wait for tprd;
				n := to_integer(unsigned(s));
				if ((n1_val + n2_val) = n) then
					report "For a=" & integer'image(n1_val) & " b=" & integer'image(n2_val) & " got s=" & integer'image(to_integer(unsigned(s)));
				else
					null;
				end if;
			end loop;
		end loop;
		wait;
	end process;
end architecture;