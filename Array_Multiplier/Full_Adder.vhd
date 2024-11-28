library ieee;
use ieee.std_logic_1164.all;

entity Full_Adder is
	port( a,b,c :in std_logic;
			s,cout:out std_logic);
end Full_Adder;

architecture struct of Full_Adder is
	begin 
		s <= (a xor b) xor c;
		cout <= ((a xor b) nand c) nand (a nand b);
end struct; 