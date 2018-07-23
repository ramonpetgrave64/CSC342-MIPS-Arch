--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:58:31 07/17/2018
-- Design Name:   
-- Module Name:   /home/ise/MIPS_Arch/Test_InstructionMemory.vhd
-- Project Name:  MIPS_Arch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: InstructionMemory
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
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
