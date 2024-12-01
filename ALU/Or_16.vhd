library ieee;
use ieee.std_logic_1164.all;

entity OR_16 is
	port(a,b: in std_logic_vector(15 downto 0);
		  c: out std_logic_vector(15 downto 0)
		  );
end OR_16;

architecture str of OR_16 is
	begin
		for1: for i in 0 to 15 generate
			c(i) <= a(i) or b(i);
		end generate for1;
end architecture;