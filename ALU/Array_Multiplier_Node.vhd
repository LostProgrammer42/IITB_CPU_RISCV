library ieee;
use ieee.std_logic_1164.all;

entity Array_Multiplier_Node is
	port(Ppk,yj,xi,ci: in std_logic;
		  Ppk_1, co: out std_logic
		  );
end Array_Multiplier_Node;

architecture struct1 of Array_Multiplier_Node is
	component Full_Adder is
		port(a,b,c :in std_logic;
			  s,cout:out std_logic);
	end component;
	signal s1: std_logic;
	begin
		s1 <= yj and xi;
		instFA: Full_Adder port map(a=>Ppk, b=>s1, c=>ci, s=>Ppk_1, cout=>co);
end architecture;	

