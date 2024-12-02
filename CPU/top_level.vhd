library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
	port(
			clk, reset: in std_logic;
			mem_add_write_init, mem_data_write_init : in std_logic_vector(15 downto 0);
			mem_w_init : in std_logic;
			add_write, add_read, data_write, data_read : out std_logic_vector(15 downto 0);
			mem_r_out : out std_logic;
		dout0 : out std_logic_vector(15 downto 0);
		mem_read : out std_logic
		);
end entity;

architecture behav of top_level is
	component mux_2x1 is
		port (I1, I0 : in std_logic; 
				S : in std_logic; 
				Y : out std_logic);
	end component;
	component mux_2x1_16bit is
		port (I1, I0 : in std_logic_vector(15 downto 0); 
				S : in std_logic; 
				Y : out std_logic_vector(15 downto 0));
	end component;
	component CPU is
		port(clk,reset: in std_logic;
			  Mem_add_read,Mem_add_write,Mem_data_write: out std_logic_vector(15 downto 0);
			  Mem_data_read: in std_logic_vector(15 downto 0);
			  Mem_r,Mem_w: out std_logic);
	end component;
	component Memory_64b is
		port (
			a1, a2: in std_logic_vector(15 downto 0);
			d2: in std_logic_vector(15 downto 0);
			rst, clk, mem_r, mem_w : in std_logic;
			d1: out std_logic_vector(15 downto 0);
		dout0 : out std_logic_vector(15 downto 0);
			mem_read: out std_logic
		);
	end component;
	signal Mem_add_read_cpu, Mem_add_read, Mem_add_write, Mem_add_write_cpu, Mem_data_write, Mem_data_write_cpu, Mem_data_read, Mem_data_read_cpu: std_logic_vector(15 downto 0);
	signal Mem_r, mem_r_memory, Mem_w_cpu,mem_w : std_logic := '0';
begin
	mux_inst1: mux_2x1_16bit port map(I1=> Mem_add_write_init, I0=>Mem_add_write_cpu, S=>'1', Y=>Mem_add_write);
	mux_inst2: mux_2x1_16bit port map(I1=> Mem_data_write_init, I0=>Mem_data_write_cpu, S=>'1', Y=>Mem_data_write);
	mux_inst3: mux_2x1 port map(I1=> mem_w_init, I0=>mem_w_cpu, S=>mem_w_init, Y=>mem_w);
	CPU_inst : CPU port map(clk=>clk, reset=>mem_w_init, Mem_add_read=>mem_add_read, Mem_add_write=>Mem_add_write_cpu, Mem_data_write=>Mem_data_write_cpu, Mem_data_read=>Mem_data_read, Mem_r=>mem_r, Mem_w=>mem_w_cpu);
	memory_inst : Memory_64b port map(a1 => mem_add_read, a2=> Mem_add_write, d1=>Mem_data_read, d2=>Mem_data_write, rst => '0', clk => clk, mem_r=>mem_r, mem_w=>'1', mem_read => mem_r_memory, dout0=> dout0);
	add_read <= mem_add_read;
	add_write <= mem_add_write_cpu;
	data_read <= mem_data_read;
	data_write <= mem_data_write_cpu;
	mem_r_out <= mem_r;
	mem_read <= mem_r_memory;
end architecture;