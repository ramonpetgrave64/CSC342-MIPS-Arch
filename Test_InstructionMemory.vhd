
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY Test_InstructionMemory IS
END Test_InstructionMemory;
 
ARCHITECTURE behavior OF Test_InstructionMemory IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InstructionMemory
    PORT(
         ReadAddress : IN  std_logic_vector(31 downto 0) := (others => '0');
         Instruction : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal tb_ReadAddress : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal tb_Instruction : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InstructionMemory PORT MAP (
          ReadAddress => tb_ReadAddress,
          Instruction => tb_Instruction
        );


   -- Stimulus process
   process
   begin		
      -- hold reset state for 100 ns.
      
		tb_ReadAddress <= "00000000000000000000000000000000";
--		tb_ReadAddress <= x"‭00400000‬";
      wait for 10ns;
		tb_ReadAddress <= "00000000000000000000000000000100";
--		tb_ReadAddress <= x"00400004";
      wait for 10ns;
		tb_ReadAddress <= "00000000000000000000000000001100";
--		tb_ReadAddress <= x"00400008";
      wait for 10ns;
		tb_ReadAddress <= "00000000000000000000000000010000";
--		tb_ReadAddress <= x"0040000C";
      wait for 10ns;

      -- insert stimulus here 

--      wait;
	Assert false report "over" severity failure;
   end process;

END;
