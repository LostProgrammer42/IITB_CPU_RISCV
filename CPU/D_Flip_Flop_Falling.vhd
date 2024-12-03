library ieee;
use ieee.std_logic_1164.all;

entity d_ff_falling is
	port (clk, rst, d : in std_logic; 
			q : out std_logic := '0');
end entity;

architecture beh of d_ff_falling is
begin
	process(clk, rst)	begin
		if rst='1' then q<='0';
		elsif falling_edge(clk) then q<=d;
		end if;
	end process;
end architecture;