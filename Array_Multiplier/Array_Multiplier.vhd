library ieee;
use ieee.std_logic_1164.all;

entity Array_Multiplier is
	port(x,y: in std_logic_vector(15 downto 0);
		  p: out std_logic_vector(7 downto 0)
		  );
end Array_Multiplier;

architecture Struct2 of Array_Multiplier is
	component Array_Multiplier_Node is
		port(Ppk,yj,xi,ci: in std_logic;
			  Ppk_1, co: out std_logic
			 );
	end component;
	
	component Full_Adder is
		port(a,b,c :in std_logic;
			  s,cout:out std_logic);
	end component;
	
	signal p1_2,p1_3,p1_4,p2_2,p2_3,p2_4,p3_2,p3_3,p3_4: std_logic;
	signal c1_1,c1_2,c1_3,c1_4,c2_1,c2_2,c2_3,c2_4,c3_1,c3_2,c3_3,c3_4: std_logic;
	signal fc1,fc2,fc3: std_logic;
	signal ppk1_1,ppk1_2,ppk1_3: std_logic;
	begin
		p(0)<= y(0) and x(0);
		
		ppk1_1 <= (y(1) and x(0));
		ppk1_2 <= (y(2) and x(0));
		ppk1_3 <= (y(3) and x(0));
		Node1_1: Array_Multiplier_Node port map(Ppk=>ppk1_1,yj=>y(0),xi=>x(1),ci=>'0',Ppk_1=>p(1),co=>c1_1);
		Node1_2: Array_Multiplier_Node port map(Ppk=>ppk1_2,yj=>y(1),xi=>x(1),ci=>'0',Ppk_1=>p1_2,co=>c1_2);
		Node1_3: Array_Multiplier_Node port map(Ppk=>ppk1_3,yj=>y(2),xi=>x(1),ci=>'0',Ppk_1=>p1_3,co=>c1_3);
		Node1_4: Array_Multiplier_Node port map(Ppk=>'0',yj=>y(3),xi=>x(1),ci=>'0',Ppk_1=>p1_4,co=>c1_4);
		
		Node2_1: Array_Multiplier_Node port map(Ppk=>p1_2,yj=>y(0),xi=>x(2),ci=>c1_1,Ppk_1=>p(2),co=>c2_1);
		Node2_2: Array_Multiplier_Node port map(Ppk=>p1_3,yj=>y(1),xi=>x(2),ci=>c1_2,Ppk_1=>p2_2,co=>c2_2);
		Node2_3: Array_Multiplier_Node port map(Ppk=>p1_4,yj=>y(2),xi=>x(2),ci=>c1_3,Ppk_1=>p2_3,co=>c2_3);
		Node2_4: Array_Multiplier_Node port map(Ppk=>'0',yj=>y(3),xi=>x(2),ci=>c1_4,Ppk_1=>p2_4,co=>c2_4);
		
		Node3_1: Array_Multiplier_Node port map(Ppk=>p2_2,yj=>y(0),xi=>x(3),ci=>c2_1,Ppk_1=>p(3),co=>c3_1);
		Node3_2: Array_Multiplier_Node port map(Ppk=>p2_3,yj=>y(1),xi=>x(3),ci=>c2_2,Ppk_1=>p3_2,co=>c3_2);
		Node3_3: Array_Multiplier_Node port map(Ppk=>p2_4,yj=>y(2),xi=>x(3),ci=>c2_3,Ppk_1=>p3_3,co=>c3_3);
		Node3_4: Array_Multiplier_Node port map(Ppk=>'0',yj=>y(3),xi=>x(3),ci=>c2_4,Ppk_1=>p3_4,co=>c3_4);
		
		FA4_1: Full_Adder port map(a=>c3_1,b=>p3_2,c=>'0',s=>p(4),cout=>fc1);
		FA4_2: Full_Adder port map(a=>c3_2,b=>p3_3,c=>fc1,s=>p(5),cout=>fc2);
		FA4_3: Full_Adder port map(a=>c3_3,b=>p3_4,c=>fc2,s=>p(6),cout=>fc3);
		FA4_4: Full_Adder port map(a=>c3_4,b=>'0',c=>fc3,s=>p(7),cout=>open);
		
end architecture;

		
		