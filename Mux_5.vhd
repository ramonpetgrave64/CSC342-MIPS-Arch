library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux_5 is
    Port ( I0 : in  STD_LOGIC_VECTOR (4 downto 0);
           I1 : in  STD_LOGIC_VECTOR (4 downto 0);
           O : out  STD_LOGIC_VECTOR (4 downto 0);
           S : in  STD_LOGIC);
end Mux_5;

architecture Behavioral of Mux_5 is

begin

	O <= I0 when S = '0' else
	I1;

end Behavioral;

