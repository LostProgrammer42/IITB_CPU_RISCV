library ieee;
use ieee.std_logic_1164.all;

entity SE_9_To_16 is
	port(a: in std_logic_vector(8 downto 0);
		  b: out std_logic_vector(15 downto 0)
		  );
end SE_9_To_16;

architecture str of SE_9_To_16 is
	begin
		for1: for i in 0 to 15 generate
			b(i) <= a(i) when i < 9 else a(8);
		end generate for1;
end architecture;