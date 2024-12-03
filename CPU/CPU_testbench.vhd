library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CPU_testbench is
end entity;

architecture behav of CPU_testbench is
	component CPU is
		port(clk,reset: in std_logic;
			  Mem_add_read,Mem_add_write,Mem_data_write,PCout, IRout, IRoutcontroller: out std_logic_vector(15 downto 0);
			  Mem_data_read: in std_logic_vector(15 downto 0);
			  Mem_r,Mem_w: out std_logic;
			  ALU_Zo : out std_logic;
			  ostate: out std_logic_vector(4 downto 0);
			  RF_A1o,RF_A2o,RF_A3o: out std_logic_vector(2 downto 0);
			  RF_D1o,RF_D2o,RF_D3o,T1o,T1w, T2o, T2w: out std_logic_vector(15 downto 0);
			  T1e, T2e, RFe: out std_logic;
			reg0,reg1,reg2 : out std_logic_vector(15 downto 0));
	end component;
	signal clk: std_logic := '0';
	signal tprd: time := 10ns;
	signal Mem_add_write, Mem_data_write,PC, IR, IRoutcontroller: std_logic_vector(15 downto 0);
	signal Mem_r, Mem_w, T1_en, T2_en, RF_en: std_logic := '0';
	signal Mem_add_read, Mem_data_read, T1_data_read, T1_data_write, T2_data_read, T2_data_write: std_logic_vector(15 downto 0);
	signal cstate : std_logic_vector(4 downto 0);
	
	signal ALU_Z : std_logic;
	signal RF_A1,RF_A2,RF_A3: std_logic_vector(2 downto 0);
	signal RF_D1,RF_D2,RF_D3: std_logic_vector(15 downto 0);
	signal reg0,reg1,reg2 : std_logic_vector(15 downto 0);
	
	type regarray is array(31 downto 0) of std_logic_vector(15 downto 0);
	signal Memory: regarray:=(
--		0 =>  "1010000001000100",--Instr1: LW from Mem Address=4 to RF address = 0; Instr1 at Mem Address = 0
--		1 =>  "1010001000000010",--Instr2: LW from Mem Address=5 to RF address = 1; Instr2 at Mem Address = 1
----		0 => "1001000000001000", --Instr1: LLI value=16 from IR to RF address = 0; Instr1 at Mem Address = 0
----		0 => "1000000000000001", --Instr1: LHI value=1 (will be 8-shifted) from IR to RF address = 0; Instr2 at Mem Address = 0
----		1 => "1000001000000011", --Instr1: LHI value=1 (will be 8-shifted) from IR to RF address = 1; Instr2 at Mem Address = 1
--		2 =>  "0000000001010000",--Instr3: ADD Reg0 and Reg1 and store in Reg2; Instr3 at Mem Address = 2
----		2 =>  "0001000010111111",--Instr3: ADI -1 and REg0 and store in Reg2; Instr3 at Mem Address = 2
----		2 => "1100000001000111", -- Instr3: BEQ checks Reg0 and Reg1 and branches to PC+7
----		2 => "1111001000000000", -- Instr3: JLR PC goes to address given in Reg0 and writes current PC into reg1
----		2=> "1101001000010000",
----		3 =>  "1011010011000110",--Instr4: SW from RF address=2 to Mem address = 6; Instr4 at Mem Address = 3
----		2 =>  "1110000111111110", --Instr4: J from Current PC=3 to PC=0
--		4 =>  "0000000000010000", -- Number1
--		5 =>  "0000000000000001", -- Number2
--		6 =>  "0110000001010000", 
--		7 =>  "1000000000000111",
--		8 =>  "1001000000000100",
--		9 =>  "1010000110001110",
--		14=>  "0000000000000000",
--		15 => "1100100110000010",
--		18 => "1111000001000000",
--		27 => "1101000000000011",
--		30 => "1011000001000101",
		0=> "1010100101001101",
		1=> "1001000000000000",
		2=> "1001001000000001",
		3=> "0000000001010000",
		4=> "0001000001000000",
		5=> "0001001010000000",
		6=> "1011000011001111",
		7=> "1100000100111010",
		8=> "1110000111111011",
		13 => "1011010100100000",
		others => x"0000");
	begin
		cpuinst: CPU port map(ostate=>cstate, IRout=>IR,clk=>clk,reset=>'0',Mem_add_read=>Mem_add_read,Mem_add_write=>Mem_add_write,Mem_data_write=>Mem_data_write,PCout=>PC,Mem_data_read=>Mem_data_read,Mem_r=>Mem_r,Mem_w=>Mem_w, IRoutcontroller=>IRoutcontroller,RF_A1o=>RF_A1,RF_A2o=>RF_A2,RF_A3o=>RF_A3,RF_D1o=>RF_D1,RF_D2o=>RF_D2,RF_D3o=>RF_D3,T1o=>T1_Data_read, T1w=>T1_data_write, T1e=>T1_en, RFe=>RF_en, reg0=>reg0, reg1=>reg1, reg2=>reg2, T2e=>T2_en, T2w=>T2_data_write, T2o=>T2_data_read, ALU_Zo => ALU_Z);
		clk_process: process
		begin
			clk <= not clk after tprd / 2;
			wait for tprd / 2;
		end process clk_process;
		
		Mem_process: process(Mem_add_read,Mem_add_write,Mem_r,Mem_w,clk)
		begin
				if Mem_w = '1' and falling_edge(clk) then
					report "writing value: " & integer'image(to_integer(unsigned(Mem_data_write))) &" to memory address: " & integer'image(to_integer(unsigned(Mem_add_write)));
					Memory(to_integer(unsigned(Mem_add_write))) <= Mem_data_write;
				elsif Mem_r = '1' then
					Mem_data_read <= Memory(to_integer(unsigned(Mem_add_read)));
				end if;
		end process;
	
end architecture;