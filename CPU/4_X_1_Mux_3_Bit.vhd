library ieee;
use ieee.std_logic_1164.all;

entity mux_4x1_3bit is
	port (
		I0, I1, I2, I3 : in std_logic_vector(2 downto 0); -- 4 inputs, each 3 bits
		S              : in std_logic_vector(1 downto 0); -- 2-bit selection line
		Y              : out std_logic_vector(2 downto 0) -- Output, 3 bits
	);
end entity;

architecture beh of mux_4x1_3bit is
begin
	process(S, I0, I1, I2, I3) begin
		case S is
			when "00" => Y <= I0; -- Select input I0
			when "01" => Y <= I1; -- Select input I1
			when "10" => Y <= I2; -- Select input I2
			when "11" => Y <= I3; -- Select input I3
			when others => Y <= (others => '0'); -- Default case, set to 0
		end case;
	end process;
end architecture;
