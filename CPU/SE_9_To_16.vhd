library ieee;
use ieee.std_logic_1164.all;

entity SE_9_To_16 is
    port(
        a: in std_logic_vector(8 downto 0);
        b: out std_logic_vector(15 downto 0)
    );
end SE_9_To_16;

architecture str of SE_9_To_16 is
begin
    gen_lower: for i in 0 to 8 generate
        b(i) <= a(i);
    end generate gen_lower;
	 gen_upper: for i in 9 to 15 generate
        b(i) <= a(8);
    end generate gen_upper;
end architecture;
