library ieee;
use ieee.std_logic_1164.all;

entity Memory_64b is
	port (
		a1, a2: in std_logic_vector(15 downto 0);
		d2: in std_logic_vector(15 downto 0);
		rst, clk, mem_r, mem_w : in std_logic;
		d1: out std_logic_vector(15 downto 0)
	);
end entity;

architecture str of Memory_64b is
	component pipo_register is
		port (
			din  : in std_logic_vector(15 downto 0); 
			dout : out std_logic_vector(15 downto 0);
			w, r, rst , clk : in std_logic
		);
	end component;
	component mux_32x1_16bit is
		port (
			I31, I30, I29, I28, I27, I26, I25, I24, I23, I22, I21, I20, I19, I18, I17, I16, I15, I14, I13, I12, I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0 : in std_logic_vector(15 downto 0);
			S : in std_logic_vector(4 downto 0);
			Y : out std_logic_vector(15 downto 0)
		);
	end component;

	component demux_32x1_16bit is
		port (
			Y31, Y30, Y29, Y28, Y27, Y26, Y25, Y24, Y23, Y22, Y21, Y20, Y19, Y18, Y17, Y16, Y15, Y14, Y13, Y12, Y11, Y10, Y9, Y8, Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0 : out std_logic_vector(15 downto 0);
			S : in std_logic_vector(4 downto 0);
			I : in std_logic_vector(15 downto 0)
		);
	end component;

type sig_array is array(31 downto 0) of std_logic_vector(15 downto 0);
signal din, dout : sig_array;

begin
gen_reg : for i in 31 downto 0 generate
	regi : pipo_register port map (din => din(i), dout => dout(i), w => mem_w, r=> mem_r, rst => rst, clk => clk);
end generate;
mux1 : mux_32x1_16bit port map (I31 => dout(31), I30 => dout(30), I29 => dout(29), I28 => dout(28), I27 => dout(27), I26 => dout(26), I25 => dout(25), I24 => dout(24), I23 => dout(23), I22 => dout(22), I21 => dout(21), I20 => dout(20), I19 => dout(19), I18 => dout(18), I17 => dout(17), I16 => dout(16),I15 => dout(15), I14 => dout(14), I13 => dout(13), I12 => dout(12), I11 => dout(11),I10 => dout(10),I9 => dout(9), I8 => dout(8), I7 => dout(7), I6 => dout(6), I5  => dout(5), I4 => dout(4), I3  => dout(3),I2 => dout(2), I1 => dout(1), I0 => dout(0),S => a1(4 downto 0),Y => d1);
demux3 : demux_32x1_16bit port map (Y31 => din(31), Y30 => din(30), Y29 => din(29), Y28 => din(28),Y27 => din(27), Y26 => din(26), Y25 => din(25), Y24 => din(24),Y23 => din(23), Y22 => din(22), Y21 => din(21), Y20 => din(20),Y19 => din(19), Y18 => din(18), Y17 => din(17), Y16 => din(16),Y15 => din(15),Y14 => din(14),Y13 => din(13),Y12 => din(12),Y11 => din(11),Y10 => din(10),Y9 => din(9),Y8 => din(8),Y7 => din(7),Y6 => din(6),Y5 => din(5),Y4 => din(4),Y3 => din(3),Y2 => din(2),Y1 => din(1),Y0 => din(0),S => a2(4 downto 0), I => d2);
end architecture;
