library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_8x1_16bit is
	port (I7,I6,I5,I4,I3,I2,I1,I0 : in std_logic_vector(15 downto 0); 
			S : in std_logic_vector(2 downto 0); 
			Y : out std_logic_vector(15 downto 0));
end entity;

architecture beh of mux_8x1_16bit is
begin
	process (S, I0, I1, I2, I3, I4, I5, I6, I7) begin
		case S is
			when "000" => Y <= I0;
			when "001" => Y <= I1;
			when "010" => Y <= I2;
			when "011" => Y <= I3;
			when "100" => Y <= I4;
			when "101" => Y <= I5;
			when "110" => Y <= I6;
			when "111" => Y <= I7;
			when others=> NULL;
		end case;
	end process;
end architecture;
