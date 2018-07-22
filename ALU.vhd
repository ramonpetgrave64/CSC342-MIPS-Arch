library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( alu_en : in  STD_LOGIC;
           alu_ctl : in  STD_LOGIC_VECTOR (3 downto 0);
           alu_a, alu_b : in  STD_LOGIC_VECTOR (31 downto 0);           
           alu_out : out  STD_LOGIC_VECTOR (31 downto 0);
           alu_zero : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

--creating a 32-bit variable to hold the computation result
signal result : STD_LOGIC_VECTOR(31 downto 0);

begin
--this part executes only if the ALU signal is enabled
process(alu_en)
	begin
		if alu_en = '1' then
			--addition
			if alu_ctl = "0010" then
				result <= STD_LOGIC_VECTOR(unsigned(alu_a) + unsigned(alu_b));
			end if;
			--subtraction
			if alu_ctl = "0110" then
				result <= STD_LOGIC_VECTOR(unsigned(alu_a) - unsigned(alu_b));
			end if;
			-- alu_zero output
			if result = "0" then
				alu_zero <= '1';
			else 
				alu_zero <= '0';
			end if;
		end if;
	end process;
	
end Behavioral;