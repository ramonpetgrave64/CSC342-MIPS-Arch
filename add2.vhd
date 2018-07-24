library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADD2 is
    Port ( add_a : in  STD_LOGIC_VECTOR (31 downto 0);
           add_B : in  STD_LOGIC_VECTOR (31 downto 0);
           add_out : out  STD_LOGIC_VECTOR (31 downto 0));
end ADD2;

architecture Behavioral of ADD2 is

begin
	process(add_a, add_b)
	begin
		add_out <= STD_LOGIC_VECTOR(to_unsigned((to_integer(unsigned(add_a))) + (to_integer(unsigned(add_b))), 32));
	end process;
end Behavioral;