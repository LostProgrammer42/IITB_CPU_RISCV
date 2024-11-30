library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.ALL;

entity Array_Multiplier_Testbench is
end entity;

architecture bhv of Array_Multiplier_Testbench is
	component Array_Multiplier is
		port(x,y: in std_logic_vector(15 downto 0);
			  p: out std_logic_vector(7 downto 0)
			 );
	end component;
	
	signal x_tb, y_tb: std_logic_vector(15 downto 0);
	signal p_tb: std_logic_vector(7 downto 0);
	begin
		multiplier: Array_Multiplier port map(x=>x_tb, y=>y_tb,p=>p_tb);
		
		test_proc: process
			variable i,j: integer;
			variable true_product: integer;
			begin
				for i in 0 to 15 loop
					for j in 0 to 15 loop
						x_tb <= std_logic_vector(to_unsigned(i, 16));
						y_tb <= std_logic_vector(to_unsigned(j, 16));
						wait for 10 ns;
						report "For x = " & integer'image(i) & " and y = " & integer'image(j) & " got p=" & integer'image(to_integer(unsigned(p_tb)));
					end loop;
				end loop;
        wait;
    end process;
end architecture bhv;
