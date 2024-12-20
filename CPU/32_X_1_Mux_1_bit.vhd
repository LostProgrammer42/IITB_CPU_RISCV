library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_32x1_1bit is
    port (
        I31, I30, I29, I28, I27, I26, I25, I24, I23, I22, I21, I20, I19, I18, I17, I16, I15, I14, I13, I12, I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0 : in std_logic := '0'; 
        S : in std_logic_vector(4 downto 0); 
        Y : out std_logic
    );
end entity;

architecture beh of mux_32x1_1bit is
begin
    process (S, I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31)
    begin
        case S is
            when "00000" => Y <= I0;
            when "00001" => Y <= I1;
            when "00010" => Y <= I2;
            when "00011" => Y <= I3;
            when "00100" => Y <= I4;
            when "00101" => Y <= I5;
            when "00110" => Y <= I6;
            when "00111" => Y <= I7;
            when "01000" => Y <= I8;
            when "01001" => Y <= I9;
            when "01010" => Y <= I10;
            when "01011" => Y <= I11;
            when "01100" => Y <= I12;
            when "01101" => Y <= I13;
            when "01110" => Y <= I14;
            when "01111" => Y <= I15;
            when "10000" => Y <= I16;
            when "10001" => Y <= I17;
            when "10010" => Y <= I18;
            when "10011" => Y <= I19;
            when "10100" => Y <= I20;
            when "10101" => Y <= I21;
            when "10110" => Y <= I22;
            when "10111" => Y <= I23;
            when "11000" => Y <= I24;
            when "11001" => Y <= I25;
            when "11010" => Y <= I26;
            when "11011" => Y <= I27;
            when "11100" => Y <= I28;
            when "11101" => Y <= I29;
            when "11110" => Y <= I30;
            when "11111" => Y <= I31;
            when others => NULL;
        end case;
    end process;
end architecture;
