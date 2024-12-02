library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity demux_32x1_16bit is
	port (Y31, Y30, Y29, Y28, Y27, Y26, Y25, Y24, Y23, Y22, Y21, Y20, Y19, Y18, Y17, Y16, Y15, Y14, Y13, Y12, Y11, Y10, Y9, Y8, Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0 : out std_logic_vector(15 downto 0); 
		S : in std_logic_vector(4 downto 0);
		I : in std_logic_vector(15 downto 0));
end entity;

architecture beh of demux_32x1_16bit is
begin
	process(I, S) 
	begin
		case S is
			when "00000" => Y0 <= I;
			when "00001" => Y1 <= I;
			when "00010" => Y2 <= I;
			when "00011" => Y3 <= I;
			when "00100" => Y4 <= I;
			when "00101" => Y5 <= I;
			when "00110" => Y6 <= I;
			when "00111" => Y7 <= I;
			when "01000" => Y8 <= I;
			when "01001" => Y9 <= I;
			when "01010" => Y10 <= I;
			when "01011" => Y11 <= I;
			when "01100" => Y12 <= I;
			when "01101" => Y13 <= I;
			when "01110" => Y14 <= I;
			when "01111" => Y15 <= I;
			when "10000" => Y16 <= I;
			when "10001" => Y17 <= I;
			when "10010" => Y18 <= I;
			when "10011" => Y19 <= I;
			when "10100" => Y20 <= I;
			when "10101" => Y21 <= I;
			when "10110" => Y22 <= I;
			when "10111" => Y23 <= I;
			when "11000" => Y24 <= I;
			when "11001" => Y25 <= I;
			when "11010" => Y26 <= I;
			when "11011" => Y27 <= I;
			when "11100" => Y28 <= I;
			when "11101" => Y29 <= I;
			when "11110" => Y30 <= I;
			when "11111" => Y31 <= I;
			when others => NULL;
		end case;
	end process;
end architecture;
