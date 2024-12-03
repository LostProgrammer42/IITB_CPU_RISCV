library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Controller is
	port(clk,reset,ALU_Z: in std_logic;
			 Mem_data_read,IR_data_read: in std_logic_vector(15 downto 0);
		  ostate: out std_logic_vector(4 downto 0) := "11111"; IR_data_controller : out std_logic_vector(15 downto 0));
end entity;

architecture str of Controller is
type state is (init,s0,s1,s2,s3,s5,s6,s7,s8,s9,s10,s11,s12,s15,s16,s17,s19,s20,s22,s23,s24);
	signal y_present,y_next: state := init;
	signal counter : integer := 0;
	begin	
		change_proc: process(y_next, reset) begin
			if reset = '1' then
				y_present <= init;
			else
				y_present <= y_next;
			end if;
		end process;

		IR_data_controller <= IR_data_read;
		state_proc: process(clk,reset)
		variable temp_IR_data : std_logic_vector(15 downto 0);
		begin
			if reset = '1' then
				y_next <= init;
				ostate <= "11111";
			elsif rising_edge(clk) then
				case y_present is
					when init=>
						ostate<= "11111";
						y_next <= s0;
					when s0 =>
						if counter = 1 then
							counter <= 0;
							ostate <= "00000";
							case Mem_data_read(15 downto 12) is
								when "0000"|"0001"|"0010"|"0011"|"0100"|"0101"|"0110"|"1011" => y_next <= s1;
								when "1000"|"1001"|"1110" => y_next <= s7;
								when "1010" => 
									report "going to s10" ;
									y_next <= s10;
								when "1100"|"1101"|"1111" => y_next <= s17;
								when others => report "kahi nahi jaara";
							end case;
						else
							counter <= 1;
							ostate <= "11110";
						end if;

					when s1 =>
						ostate <= "00001";
						case IR_data_read(15 downto 12) is
							when "0000"|"0010"|"0011"|"0100"|"0101"|"0110" => y_next <= s2;
							when "0001" => y_next <= s5;
							when "1011" => y_next <= s15;
							when others => null;
						end case;
					when s2 =>
						ostate <= "00010";
						y_next <= s3;
					when s3 =>
						ostate <= "00011";
						y_next <= s0;
					when s10 =>
						ostate <= "01010";
						y_next <= s11;
					when s11 =>
						ostate <= "01011";
						y_next <= s12;
					when s12 =>
						ostate <= "01100";
						y_next <= s6;
					when s6 =>
						ostate <= "00110";
						y_next <= s0;
					when s15 =>
						ostate <= "01111";
						y_next <= s16;
					when s16 =>
						ostate <= "10000";
						y_next <= s0;
					when s5 =>
						ostate <= "00101";
						y_next <= s6;
					when s7 =>
						ostate <= "00111";
						case IR_data_read(15 downto 12) is
							when "1110" => y_next <= s22;
							when "1000" => y_next <= s8;
							when "1001" => y_next <= s9;
							when others => null;
						end case;
					when s8 =>
						ostate <= "01000";
						y_next <= s0;
					when s9 =>
						ostate <= "01001";
						y_next <= s0;
					when s22 =>
						ostate <= "10110";
						y_next <= s0;
					when others => null;
				end case;
			end if;
		end process;
end architecture;
						
	
		
		
	
		