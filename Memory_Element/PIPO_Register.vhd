library ieee;
use ieee.std_logic_1164.all;

entity pipo_register is
	port (din : in std_logic_vector(15 downto 0);
			w ,r , rst, clk : in std_logic;
			dout : out std_logic_vector(15 downto 0));
end entity;

architecture ha of pipo_register is
	
	component d_ff is
		port (clk, rst, d : in std_logic; q : out std_logic);
	end component;
	
	component mux_2x1 is
		port (I1, I0 : in std_logic; S : in std_logic; Y : out std_logic);
	end component;
	
	signal d, q : std_logic_vector(15 downto 0);
	
begin

	gen_dff : for i in 15 downto 0 generate
		dffi : d_ff port map(d=>d(i), q=>q(i), rst=>rst, clk=>clk);
	end generate;
	
	gen_mux : for i in 15 downto 0 generate
		muxi : mux_2x1 port map(I1=>din(i), I0=>q(i), S=>w, Y=>d(i));
	end generate;
	
	gen_mux1 : for i in 15 downto 0 generate
		mux1i : mux_2x1 port map(I1=>q(i), I0=>'X', S=>r, Y=>dout(i));
	end generate;
end architecture;
