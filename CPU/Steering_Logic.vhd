library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--T1,T2,RF,IR,PC,ALU,SE,Mem
entity Steering_logic is
	port(State_in: in std_logic_vector(4 downto 0);
		  T1_en,T2_en,IR_en,PC_en,RF_en,Mem_r,Mem_w: out std_logic;
		  RF_A1,RF_A2,RF_A3: out std_logic_vector(2 downto 0);
		  RF_D3: out std_logic_vector(15 downto 0);
		  RF_D1, RF_D2 : in std_logic_vector(15 downto 0);
		  T1_Data_Read,T2_Data_Read: in std_logic_vector(15 downto 0);
		  T1_Data_Write,T2_Data_Write: out std_logic_vector(15 downto 0);
		  ALU_A,ALU_B: out std_logic_vector(15 downto 0);
		  ALU_Control: out std_logic_vector(2 downto 0);
		  ALU_C: in std_logic_vector(15 downto 0);
		  ALU_Cout,ALU_Z: in std_logic;
		  IR_Data_Read: in std_logic_vector(15 downto 0);
		  IR_Data_Write: out std_logic_vector(15 downto 0);
		  PC_Data_Read: in std_logic_vector(15 downto 0);
		  PC_Data_Write: out std_logic_vector(15 downto 0);
		  Mem_Data_Read: in std_logic_vector(15 downto 0);
		  Mem_Data_Write, Mem_Add_Read, Mem_Add_Write: out std_logic_vector(15 downto 0);
		  to_SE6: out std_logic_vector(5 downto 0);
		  from_SE6: in std_logic_vector(15 downto 0);
		  to_SE9: out std_logic_vector(8 downto 0);
		  from_SE9: in std_logic_vector(15 downto 0);
		  to_8s: out std_logic_vector(15 downto 0);
		  from_8s: in std_logic_vector(15 downto 0));
end entity;

architecture str of Steering_Logic is
	component mux_2x1_3bit is
		port (I1, I0 : in std_logic_vector(2 downto 0); 
				S : in std_logic; 
				Y : out std_logic_vector(2 downto 0));
	end component;
	component mux_4x1_3bit is
		port (I3, I2, I1, I0 : in std_logic_vector(2 downto 0); 
				S : in std_logic_vector(1 downto 0); 
				Y : out std_logic_vector(2 downto 0));
	end component;
	component mux_4x1_16bit is
		port (I3,I2,I1,I0 : in std_logic_vector(15 downto 0); 
				S : in std_logic_vector(1 downto 0); 
				Y : out std_logic_vector(15 downto 0));
	end component;
	component mux_32x1_16bit is
		port (I31, I30, I29, I28, I27, I26, I25, I24, I23, I22, I21, I20, I19, I18, I17, I16, I15, I14, I13, I12, I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0 : in std_logic_vector(15 downto 0) := "0000000000000000"; 
			S : in std_logic_vector(4 downto 0); 
			Y : out std_logic_vector(15 downto 0));
	end component;
	component mux_32x1_9bit is
		 port (
			  I31, I30, I29, I28, I27, I26, I25, I24, I23, I22, I21, I20, I19, I18, I17, I16, I15, I14, I13, I12, I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0 : in std_logic_vector(8 downto 0) := "000000000"; 
			  S : in std_logic_vector(4 downto 0); 
			  Y : out std_logic_vector(8 downto 0)
		 );
	end component;
	component mux_32x1_6bit is
		 port (
			  I31, I30, I29, I28, I27, I26, I25, I24, I23, I22, I21, I20, I19, I18, I17, I16, I15, I14, I13, I12, I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0 : in std_logic_vector(5 downto 0) := "000000"; 
			  S : in std_logic_vector(4 downto 0); 
			  Y : out std_logic_vector(5 downto 0)
		 );
	end component;
	component mux_32x1_3bit is
		port (I31, I30, I29, I28, I27, I26, I25, I24, I23, I22, I21, I20, I19, I18, I17, I16, I15, I14, I13, I12, I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0 : in std_logic_vector(2 downto 0) := "000"; 
			S : in std_logic_vector(4 downto 0); 
			Y : out std_logic_vector(2 downto 0));
	end component;
	component mux_32x1_1bit is
		 port (
			  I31, I30, I29, I28, I27, I26, I25, I24, I23, I22, I21, I20, I19, I18, I17, I16, I15, I14, I13, I12, I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0 : in std_logic := '0'; 
			  S : in std_logic_vector(4 downto 0); 
			  Y : out std_logic
		 );
	end component;
	signal RF_A1_sel : std_logic;
	signal RF_A3_sel, RF_D3_sel: std_logic_vector(1 downto 0);
	begin
		RF_A1_sel <= state_in(0) xor state_in(1) xor state_in(2) xor state_in(3) xor state_in(4);
		RF_A1_path : mux_2x1_3bit port map(I1 => IR_data_read(11 downto 9), I0 => IR_data_read(8 downto 6), S=> RF_A1_sel, Y=> RF_A1);
		RF_A2_path : RF_A2 <= IR_data_read(8 downto 6);
		RF_A3_sel(0) <= (not state_in(4)) and (not state_in(3));
		RF_A3_sel(1) <= state_in(1) xor state_in(2);
		RF_A3_path : mux_4x1_3bit port map(I3 => IR_data_read(5 downto 3), I2 => "000", I1 => IR_data_read(8 downto 6), I0 => IR_data_read(11 downto 9), S=> RF_A3_sel, Y=> RF_A3);
		RF_D3_sel(0) <= (not state_in(0)) or ((not state_in(4)) and (not state_in(3)));
		RF_D3_sel(1) <= ((not state_in(4)) and state_in(0)) or ((not state_in(4)) and (not state_in(3)));
		RF_D3_path : mux_4x1_16bit port map(I3 => T1_data_read, I2 => from_SE9, I1 => from_8s, I0 => PC_data_read, S=> RF_D3_sel, Y=> RF_D3);
		T1_data_write_path : mux_32x1_16bit port map(I1=>RF_D1, I4=> RF_D1, I10=>RF_D1, I2=>ALU_C, I5=>ALU_C, I11=>ALU_C, I19=>ALU_C, S=> state_in, Y=> T1_data_write);
		T2_data_write_path : mux_32x1_16bit port map(I1=>RF_D2, I15=> ALU_C, S=> state_in, Y=> T2_data_write);
		PC_data_write_path : mux_32x1_16bit port map(I0=>ALU_C, I17=>ALU_C, I20=>ALU_C, I22=>ALU_C, I24=>RF_D1, S=> state_in, Y=>PC_data_write);
		IR_en_path : mux_32x1_1bit port map(I0=>'1', S=>state_in, Y=>IR_en);
		IR_data_write_path : mux_32x1_16bit port map(I0=> Mem_data_read ,S=>state_in, Y=>IR_data_write);
		ALU_A_path : mux_32x1_16bit port map(I0=>PC_data_read, I17=> PC_data_read, I20=> PC_data_read, I22=> PC_data_read, I2=> T1_data_read, I5=> T1_data_read, I11=>T1_data_read, I19=>T1_data_read, S=>state_in, Y=>ALU_A);
		ALU_B_path : mux_32x1_16bit port map(I0=>"0000000000000001", I17=> "0000000000000001", I2=>T2_data_read, I19=> T2_data_read, I5=>from_SE6, I11=>from_SE6, I20=>from_SE6, I22=>from_SE9, S=>state_in, Y=>ALU_B);
		to_SE6_path: mux_32x1_6bit port map(I5=>IR_data_read(5 downto 0), I11=>IR_data_read(5 downto 0), I15=>IR_data_read(5 downto 0), I20=>IR_data_read(5 downto 0), S=>state_in, Y=>to_SE6);
		to_SE9_path: mux_32x1_9bit port map(I8=>IR_data_read(8 downto 0), I9=>IR_data_read(8 downto 0), I22=>IR_data_read(8 downto 0), S=>state_in, Y=>to_SE9);
		to_8s_path: mux_32x1_16bit port map(I8=>from_SE9, S=>state_in, Y=>to_8s);
		ALU_control_path: mux_32x1_3bit port map(I0=>"000",I11=>"000",I15=>"000",I20=>"000",I22=>"000",I2=>IR_data_read(14 downto 12), I5=>"001", I17=>"010", I19=>"010", S=>state_in, Y=>ALU_control);
		Mem_add_read_path: mux_32x1_16bit port map(I0=>PC_data_read, I12=>T1_data_read, S=>state_in, Y=>Mem_add_read);
		Mem_add_write_path: mux_32x1_16bit port map(I16=>T2_data_read, S=>state_in, Y=>Mem_add_write);
		Mem_data_write_path: mux_32x1_16bit port map(I16=>T1_data_read, S=>state_in, Y=>Mem_data_write);
		Mem_w_path: mux_32x1_1bit port map(I16=>'1', S=>state_in, Y=>Mem_w);
		Mem_r_path: mux_32x1_1bit port map(I0=>'1', I12=>'1', S=>state_in, Y=>Mem_r);
		RF_en_path: mux_32x1_1bit port map(I3=>'1', I6=>'1', I8=>'1', I9=>'1', I13=>'1', I21=>'1', I23=>'1', S=>state_in, Y=>RF_en);
		T1_en_path: mux_32x1_1bit port map(I1=>'1', I2=>'1', I4=>'1', I5=>'1', I10=>'1', I11=>'1', I12=>'1', I19=>'1', S=>state_in, Y=>T1_en);
		T2_en_path: mux_32x1_1bit port map(I1=>'1', I15=>'1', S=>state_in, Y=>T2_en);
		PC_en_path: mux_32x1_1bit port map(I0=>'1', I17=>'1', I20=>'1', I22=>'1', I24=>'1', S=>state_in, Y=>PC_en);
end architecture;
		
		