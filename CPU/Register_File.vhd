library ieee;
use ieee.std_logic_1164.all;

entity register_file is
	port (a1, a2, a3 : in std_logic_vector(2 downto 0); 
			d3 : in std_logic_vector(15 downto 0);
			rst, clk, en : in std_logic;
			d1, d2 : out std_logic_vector(15 downto 0);
			reg0,reg1,reg2 : out std_logic_vector(15 downto 0));
end entity;

architecture str of register_file is
	
	component pipo_register is
		port (din : in std_logic_vector(15 downto 0); 
				dout : out std_logic_vector(15 downto 0);
				en, rst, clk : in std_logic);
	end component;
	
	component mux_8x1_16bit is
		port (I7,I6,I5,I4,I3,I2,I1,I0 : in std_logic_vector(15 downto 0); 
				S : in std_logic_vector(2 downto 0); 
				Y : out std_logic_vector(15 downto 0));
	end component;
	
	component demux_8x1_1bit is
		port (
			Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0 : out std_logic; 
			S : in std_logic_vector(2 downto 0);
			I : in std_logic
		);
	end component;
	
	component demux_8x1_16bit is
		port (Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0 : out std_logic_vector(15 downto 0); 
				S : in std_logic_vector(2 downto 0); 
				I : in std_logic_vector(15 downto 0));
	end component;
	
	type sig_array is array(7 downto 0) of std_logic_vector(15 downto 0);
	signal din, dout : sig_array;
	signal ena: std_logic_vector(7 downto 0) := "00000000";
begin
	gen_reg : for i in 7 downto 0 generate
		regi : pipo_register port map (din=>din(i), dout=>dout(i), en=>ena(i), rst=>rst, clk=>clk);
	end generate;
	reg0<=dout(0);
	reg1<=dout(1);
	reg2<=dout(2);
	mux1 : mux_8x1_16bit port map(I7=>dout(7), I6=>dout(6), I5=>dout(5), I4=>dout(4), I3=>dout(3), I2=>dout(2), I1=>dout(1), I0=>dout(0), S=>a1, Y=>d1);
	mux2 : mux_8x1_16bit port map(I7=>dout(7), I6=>dout(6), I5=>dout(5), I4=>dout(4), I3=>dout(3), I2=>dout(2), I1=>dout(1), I0=>dout(0), S=>a2, Y=>d2);
	demux3 : demux_8x1_16bit port map(Y7=>din(7), Y6=>din(6), Y5=>din(5), Y4=>din(4), Y3=>din(3), Y2=>din(2), Y1=>din(1), Y0=>din(0), S=>a3, I=>d3);
	demux4 : demux_8x1_1bit port map(Y7=>ena(7), Y6=>ena(6), Y5=>ena(5), Y4=>ena(4), Y3=>ena(3), Y2=>ena(2), Y1=>ena(1), Y0=>ena(0), S=>a3, I=>en);
end architecture;
