LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MIPS_Processor_module_testbench IS
END MIPS_Processor_module_testbench;
 
ARCHITECTURE behavior OF MIPS_Processor_module_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MIPS_PROCESSOR
    PORT(
         clk : IN  std_logic;
         test_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal test_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MIPS_PROCESSOR PORT MAP (
          clk => clk,
          test_out => test_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
--		clk <= '1';
      wait for clk_period*3;
--		clk <= '0';
      wait for clk_period*3;
--		clk <= '1';
      wait for clk_period*3;
--		clk <= '0';
      wait for clk_period*3;

      -- insert stimulus here 

      wait;
   end process;

END;
