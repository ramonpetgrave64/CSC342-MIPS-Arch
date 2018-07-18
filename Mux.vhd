library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux is -- 2:1 Mux
	Generic(
		N : Integer := 32
	);
	Port ( mux_in0 : in STD_LOGIC_VECTOR(N-1 downto 0);
			 mux_in1 : in STD_LOGIC_VECTOR(N-1 downto 0);
			 mux_ctl : in STD_LOGIC;
			 mux_out : out STD_LOGIC_VECTOR(N-1 downto 0)	
	);
end Mux;

architecture Behavioral of Mux is

begin

	mux_out <= mux_in0 when mux_ctl = '0' else
	mux_in1;

end Behavioral;

