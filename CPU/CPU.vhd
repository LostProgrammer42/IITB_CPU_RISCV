library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CPU is
	port(clk,reset: in std_logic;
		  Mem_add_read,Mem_add_write,Mem_data_write,PCout, IRout, IRoutcontroller: out std_logic_vector(15 downto 0);
		  Mem_data_read: in std_logic_vector(15 downto 0);
		  Mem_r,Mem_w: out std_logic;
		  ALU_Zo: out std_logic;
		  ostate: out std_logic_vector(4 downto 0);
		  RF_A1o,RF_A2o,RF_A3o: out std_logic_vector(2 downto 0);
		  RF_D1o,RF_D2o,RF_D3o,T1o,T1w, T2o, T2w: out std_logic_vector(15 downto 0);
		  T1e, T2e, RFe: out std_logic;
			reg0,reg1,reg2 : out std_logic_vector(15 downto 0));
end entity;

architecture str of CPU is
	component Controller is
		port(clk,reset,ALU_Z: in std_logic;
			 Mem_data_read, IR_data_read: in std_logic_vector(15 downto 0);
			  ostate: out std_logic_vector(4 downto 0); IR_data_controller: out std_logic_vector(15 downto 0));
	end component;
	
	component Steering_logic is
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
	end component;

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
	
	component pipo_register_falling is
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
				d1, d2 : out std_logic_vector(15 downto 0);
			reg0,reg1,reg2 : out std_logic_vector(15 downto 0));
	end component;
	
	signal T1_en, T2_en, PC_en, IR_en: std_logic := '0';
	signal PC_data_read : std_logic_vector(15 downto 0) := "0000000000000000";
	signal T1_data_write, T1_data_read, T2_data_write, T2_data_read, PC_data_write, IR_data_write, IR_data_read: std_logic_vector(15 downto 0); 
	
	signal ALU_A, ALU_B,ALU_C: std_logic_vector(15 downto 0);
	signal ALU_Control: std_logic_vector(2 downto 0);
	
	signal RF_A1, RF_A2, RF_A3 : std_logic_vector(2 downto 0);
	signal RF_D1, RF_D2, RF_D3 : std_logic_vector(15 downto 0);
	signal RF_en, RF_rst : std_logic := '0' ;
	
	signal to_SE6 : std_logic_vector(5 downto 0);
	signal from_SE6 : std_logic_vector(15 downto 0);
	signal to_SE9 : std_logic_vector(8 downto 0);
	signal from_SE9 : std_logic_vector(15 downto 0);
	signal to_8s, from_8s: std_logic_vector(15 downto 0);
	signal state_in : std_logic_vector(4 downto 0);
	
	signal CC_data_write, CC_data_read : std_logic_vector(15 downto 0);
	
	signal ALU_Z,ALU_Cout: std_logic;
	begin
		RF_A1o <= RF_A1;
		RF_A2o <= RF_A2;
		RF_A3o <= RF_A3;
		RF_D1o <= RF_D1;
		RF_D2o <= RF_D2;
		RF_D3o <= RF_D3;
		T1o <= T1_Data_read;
		T1w <= T1_Data_write;
		T1e <= T1_En;
		T2o <= T2_data_read;
		T2w <= T2_data_write;
		T2e <= T2_en;
		RFe <= RF_En;
		ALU_Zo <= ALU_Z;
		CC_data_write(15 downto 2) <= "00000000000000";
		CC_data_write(1) <= ALU_Cout;
		CC_data_write(0) <= ALU_Z;
		T1: pipo_register port map(din=>T1_data_write,en=>T1_en,rst=>reset,clk=>clk,dout=>T1_data_read);
		T2: pipo_register port map(din=>T2_data_write,en=>T2_en,rst=>reset,clk=>clk,dout=>T2_data_read);
		PC: pipo_register port map(din=>PC_data_write,en=>PC_en,rst=>reset,clk=>clk,dout=>PC_data_read);
		IR: pipo_register port map(din=>IR_data_write,en=>IR_en,rst=>reset,clk=>clk,dout=>IR_data_read);
		
		CC_reg: pipo_register_falling port map(din=>CC_data_write, en=>'1', rst=>reset, clk=>clk, dout=>CC_data_read);
		
		PCout <= PC_data_read;
		
		SE6to16 : SE_6_To_16 port map(a=>to_SE6, b=>from_SE6);
		SE9to16 : SE_9_To_16 port map(a=>to_SE9, b=>from_SE9);
		
		s8: Eight_Bit_Left_Shifter port map(a=>to_8s, b=>from_8s);
		
		RF: Register_File port map(a1=> RF_A1, a2=> RF_A2, a3=> RF_A3, d1=> RF_D1, d2=> RF_D2, d3=> RF_D3, rst=>reset, en=>RF_en, clk=>clk, reg0=>reg0, reg1=>reg1, reg2=>reg2);
		
		Arith_Unit: ALU port map(a=>ALU_A,b=>ALU_B,s0=>ALU_Control(0),s1=>ALU_Control(1),s2=>ALU_Control(2),c=>ALU_C,Cout=>ALU_Cout,Z=>ALU_Z);
		
		Controller_Unit: Controller port map(clk=>clk, reset=>reset, Mem_data_read=>Mem_data_read, IR_data_read=>IR_data_read, ALU_Z=>ALU_Z, ostate=>State_in, IR_data_controller=>IRoutcontroller);
		
		SL: Steering_Logic port map(State_in,
			  T1_en,T2_en,IR_en,PC_en,RF_en,Mem_r,Mem_w,
			  RF_A1,RF_A2,RF_A3,
			  RF_D3,
			  RF_D1, RF_D2,
			  T1_Data_Read,T2_Data_Read,
			  T1_Data_Write,T2_Data_Write,
			  ALU_A,ALU_B,
			  ALU_Control,
			  ALU_C,
			  ALU_Cout,ALU_Z,
			  IR_Data_Read,
			  IR_Data_Write,
			  PC_Data_Read,
			  PC_Data_Write,
			  Mem_Data_Read,
			  Mem_Data_Write, Mem_Add_Read, Mem_Add_Write,
			  to_SE6,
			  from_SE6,
			  to_SE9,
			  from_SE9,
			  to_8s,
			  from_8s);
			  
		ostate <= state_in;
		IRout <= IR_data_read;
end architecture;
						
	
		
		
	
		