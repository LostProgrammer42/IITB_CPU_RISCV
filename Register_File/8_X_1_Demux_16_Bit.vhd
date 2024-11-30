library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity demux_8x1_16bit is
	port (Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0 : out std_logic_vector(15 downto 0); 
			S : in std_logic_vector(2 downto 0);
			I : in std_logic_vector(15 downto 0));
end entity;

architecture beh of demux_8x1_16bit is
begin
	process(I, S) begin
		case S is
			when "000" => Y0 <= I;
			when "001" => Y1 <= I;
			when "010" => Y2 <= I;
			when "011" => Y3 <= I;
			when "100" => Y4 <= I;
			when "101" => Y5 <= I;
			when "110" => Y6 <= I;
			when "111" => Y7 <= I;
			when others=> NULL;
		end case;
	end process;
end architecture;
