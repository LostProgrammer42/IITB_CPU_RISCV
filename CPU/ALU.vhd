library ieee;
use ieee.std_logic_1164.all;

entity ALU is
	port(a,b: in std_logic_vector(15 downto 0);
		  s0,s1,s2: in std_logic;
		  c: out std_logic_vector(15 downto 0);
		  Cout,Z: out std_logic);
end ALU;

architecture str of ALU is
	component OR_16 is
		port(a,b: in std_logic_vector(15 downto 0);
			  c: out std_logic_vector(15 downto 0)
			  );
	end component;
	
	component IMP_16 is
		port(a,b: in std_logic_vector(15 downto 0);
			  c: out std_logic_vector(15 downto 0)
			  );
	end component;
	
	component AND_16 is
		port(a,b: in std_logic_vector(15 downto 0);
			  c: out std_logic_vector(15 downto 0)
			  );
	end component;
	
	component kogge_stone_adder_subtractor is
		port(
			A : in std_logic_vector(15 downto 0);
			B : in std_logic_vector(15 downto 0);
			M: in std_logic := '0';
			S: out std_logic_vector(15 downto 0);
			Cout: out std_logic);
	end component;
	
	component Array_Multiplier is
		port(x,y: in std_logic_vector(15 downto 0);
			  p: out std_logic_vector(7 downto 0)
			  );
	end component;
	
	component mux_8x1_16bit is
		port (I7,I6,I5,I4,I3,I2,I1,I0 : in std_logic_vector(15 downto 0); 
				S : in std_logic_vector(2 downto 0); 
				Y : out std_logic_vector(15 downto 0));
	end component;
	
	signal Or_out,And_out,Imp_out,kogge_out,array_out_16_bit,c_buf: std_logic_vector(15 downto 0);
	signal array_out_8_bit: std_logic_vector(7 downto 0);
	signal m: std_logic;
	begin
		m <= (not s0) and s1 and (not s2);
		adder: kogge_stone_adder_subtractor port map(A=>a,B=>b,S=>kogge_out,Cout=>Cout,M=>m);
		multiplier: Array_multiplier port map(x=>a,y=>b,p=>array_out_8_bit);
		
		array_out_16_bit(7 downto 0) <= array_out_8_bit;
		array_out_16_bit(15 downto 8) <= "00000000";
		or16: Or_16 port map(a=>a,b=>b,c=>Or_out);
		and16: And_16 port map(a=>a,b=>b,c=>And_out);
		imp16: Imp_16 port map(a=>a,b=>b,c=>Imp_out);
		mux: mux_8x1_16bit port map(I0=>kogge_out,I1=>kogge_out,I2=>kogge_out,I3=>array_out_16_bit,I4=>And_out,I5=>Or_out,I6=>Imp_out,I7=>"0000000000000000",S(0)=>s0,S(1)=>s1,S(2)=>s2,Y=>c_buf);
		c <= c_buf;
		Z <= not (c_buf(0) or c_buf(1) or c_buf(2) or c_buf(3) or c_buf(4) or c_buf(5) or c_buf(6) or c_buf(7) or c_buf(8) or c_buf(9) or c_buf(10) or c_buf(11) or c_buf(12) or c_buf(13) or c_buf(14) or c_buf(15));
end architecture;	
		
	