library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Shift is

	--Should this be signed or unsigned?
    Port ( Input : in  STD_LOGIC_VECTOR (31 downto 0);
			  Output: out STD_LOGIC_VECTOR (31 downto 0));
end Shift;

architecture Behavioral of Shift is

begin

	Output <= Input(29 downto 0) & "00";
	
	
end Behavioral;

