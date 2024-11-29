library ieee;
use ieee.std_logic_1164.all;

entity Eight_Bit_Left_Shifter is
	port(a: in std_logic_vector(15 downto 0);
		  b: out std_logic_vector(15 downto 0)
		  );
end Eight_Bit_Left_Shifter;

architecture str of Eight_Bit_Left_Shifter is
	begin
		 b <= a(7 downto 0) & "00000000";
end architecture;