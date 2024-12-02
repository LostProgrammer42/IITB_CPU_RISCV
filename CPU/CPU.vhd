library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CPU is
	port(clk,reset: in std_logic;
		  Mem_add_read,Mem_add_write,Mem_data_write: out std_logic_vector(15 downto 0);
		  Mem_data_read: in std_logic_vector(15 downto 0);
		  Mem_r,Mem_w: out std_logic);
end entity;

architecture str of CPU is
	component ALU is
		port(a,b: in std_logic_vector(15 downto 0);
			  s0,s1,s2: in std_logic;
			  c: out std_logic_vector(15 downto 0);
			  Cout,Z: out std_logic);
	end component;
	
	component Eight_Bit_Left_Shifter is
		port(a: in std_logic_vector(15 downto 0);
			  b: out std_logic_vector(15 downto 0)
			  );
	end component;
	
	component pipo_register is
		port (din : in std_logic_vector(15 downto 0);
				en, rst, clk : in std_logic;
				dout : out std_logic_vector(15 downto 0));
	end component;
	
	component SE_9_To_16 is
		port(a: in std_logic_vector(8 downto 0);
			  b: out std_logic_vector(15 downto 0)
			  );
	end component;
	
	component SE_6_To_16 is
		port(a: in std_logic_vector(5 downto 0);
			  b: out std_logic_vector(15 downto 0)
			  );
	end component;
	
	component register_file is
		port (a1, a2, a3 : in std_logic_vector(2 downto 0); 
				d3 : in std_logic_vector(15 downto 0);
				rst, clk, en : in std_logic;
				d1, d2 : out std_logic_vector(15 downto 0));
	end component;
	
	signal T1_en, T2_en, PC_en, IR_en: std_logic;
	signal PC_data_read : std_logic_vector(15 downto 0) := "0000000000000000";
	signal T1_data_write, T1_data_read, T2_data_write, T2_data_read, PC_data_write, IR_data_write, IR_data_read: std_logic_vector(15 downto 0); 
	
	signal ALU_A, ALU_B,ALU_C: std_logic_vector(15 downto 0);
	signal ALU_Control: std_logic_vector(2 downto 0);
	
	signal RF_A1, RF_A2, RF_A3 : std_logic_vector(2 downto 0);
	signal RF_D1, RF_D2, RF_D3 : std_logic_vector(15 downto 0);
	signal RF_en, RF_rst : std_logic := '0' ;
	
	signal se6 : std_logic_vector(5 downto 0);
	signal se616: std_logic_vector(15 downto 0);
	signal se9 : std_logic_vector(8 downto 0);
	signal se916 : std_logic_vector(15 downto 0);
	
	signal Z,Cout: std_logic;
	type state is (init,s0,s1,s2,s3,s5,s6,s7,s8,s9,s10,s11,s12,s15,s16,s17,s19,s20,s22,s23,s24);
	signal y_present,y_next: state := init;
	begin
		T1: pipo_register port map(din=>T1_data_write,en=>T1_en,rst=>reset,clk=>clk,dout=>T1_data_read);
		T2: pipo_register port map(din=>T2_data_write,en=>T2_en,rst=>reset,clk=>clk,dout=>T2_data_read);
		PC: pipo_register port map(din=>PC_data_write,en=>PC_en,rst=>reset,clk=>clk,dout=>PC_data_read);
		IR: pipo_register port map(din=>IR_data_write,en=>IR_en,rst=>reset,clk=>clk,dout=>IR_data_read);
		
		SE6to16 : SE_6_To_16 port map(a=>se6, b=>se616);
		
		RF: Register_File port map(a1=> RF_A1, a2=> RF_A2, a3=> RF_A3, d1=> RF_D1, d2=> RF_D2, d3=> RF_D3, rst=>reset, en=>RF_en, clk=>clk);
		
		Arith_Unit: ALU port map(a=>ALU_A,b=>ALU_B,s0=>ALU_Control(0),s1=>ALU_Control(1),s2=>ALU_Control(2),c=>ALU_C,Cout=>Cout,Z=>Z);

		
		change_proc: process(y_next, reset) begin
			if reset = '1' then
				y_present <= init;
			else
				y_present <= y_next;
			end if;
		end process;

		
		state_proc: process(clk,reset)
		variable temp_IR_data : std_logic_vector(15 downto 0);
		begin
			if reset = '1' then
				y_next <= init;
			elsif rising_edge(clk) then
				case y_present is
					when init =>
						y_next <= s0;
						Mem_r <= '1';
						Mem_add_read <= PC_data_read;
						report "in init " & "IR=" & integer'image(to_integer(unsigned(PC_data_read)));
					when s0 =>
						RF_en <= '0';
						T1_en <= '0';
						T2_en <= '0';
						Mem_w <= '0';
						Mem_r <= '1';
						Mem_add_read <= PC_data_read;
						IR_en <= '1';
						IR_data_write <= Mem_data_read; 
--						temp_IR_data := Mem_data_read;
						ALU_A <= PC_data_read;
						ALU_B <= "0000000000000001";
						report "in s0 " & "IR=" & integer'image(to_integer(unsigned(PC_data_read)));
						ALU_Control <= "000";
						PC_en <= '1';
						PC_data_write <= ALU_C;
						
						case IR_data_write(15 downto 12) is
							when "0000"|"0001"|"0010"|"0011"|"0100"|"0101"|"0110"|"1011" => y_next <= s1;
							when "1000"|"1001"|"1110" => y_next <= s7;
							when "1010" => 
								report "going to s10" ;
								y_next <= s10;
							when "1100"|"1101"|"1111" => y_next <= s17;
							when others => report "kahi nahi jaara";
						end case;
					when s1 =>
						RF_A1 <= IR_Data_read(11 downto 9);
						T1_en <= '1';
						T1_data_write <= RF_D1;
						RF_A2 <= IR_Data_read(8 downto 6);
						T2_en <= '1';
						report "in s1 ";
						IR_en <= '0';
						Mem_r <= '0';
						T2_data_write <= RF_D2;
						case IR_data_read(15 downto 12) is
							when "0000"|"0010"|"0011"|"0100"|"0101"|"0110" => y_next <= s2;
							when "0001" => y_next <= s5;
							when "1011" => y_next <= s15;
							when others => null;
						end case;
					when s2 =>
						ALU_A <= T1_data_read;
						ALU_B <= T2_data_read;
						T1_en <= '1';
						report "in s2 ";
						T2_en <= '0';
						ALU_control <= IR_data_read(14 downto 12);
						T1_data_write <= ALU_C;
						y_next <= s3;
					when s3 =>
						RF_en <= '1';
						T1_en <= '0';
						report "in s3 ";
						RF_A3 <= IR_Data_read(5 downto 3);
						RF_D3 <= T1_data_read;
						y_next <= s0;
					when s10 =>
						RF_A1 <= IR_Data_read(8 downto 6);
						Mem_r <= '0';
						T1_en <= '1';
						report "in s10 ";
						T1_data_write <= RF_D1;
						y_next <= s11;
					when s11 =>
						ALU_A <= T1_data_read;
						report "in s11 ";
						se6 <= IR_data_read(5 downto 0);
						ALU_B <= se616;
						ALU_Control <= "000";
						T1_en <= '1';
						T1_data_write <= ALU_C;
						y_next <= s12;
					when s12 =>
						T1_en <= '1';
						Mem_r <= '1';
						report "in s12 ";
						Mem_add_read <= T1_data_read;
						T1_data_write <= Mem_data_read;
						y_next <= s6;
					when s6 =>
						T1_en <= '0';
						RF_en <= '1';
						Mem_r <= '0';
						report "in s6 ";
						RF_A3 <= IR_data_read(8 downto 6);
						RF_D3 <= T1_data_read;
						y_next <= s0;
					when s15 =>
						T1_en <= '0';
						report "in s15 ";
						ALU_A <= T2_data_read;
						se6 <= IR_data_read(5 downto 0);
						ALU_B <= se616;
						ALU_Control <= "000";
						T2_en <= '1';
						T2_data_write <= ALU_C;
						y_next <= s16;
					when s16 =>
						T2_en <= '0';
						Mem_w <= '1';
						report "in s16 ";
						Mem_add_write <= T2_data_read;
						Mem_data_write <= T1_data_read;
						y_next <= s0;
					when others => null;
				end case;
			end if;
		end process;
end architecture;
						
	
		
		
	
		