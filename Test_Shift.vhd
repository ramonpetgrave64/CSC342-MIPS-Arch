LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Test_Shift IS
END Test_Shift;
 
ARCHITECTURE behavior OF Test_Shift IS 

   --Inputs
   signal t_Input : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

 	--Outputs
   signal t_Output : STD_LOGIC_VECTOR(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   Shift_Test: entity work.Shift(Behavioral) 
	PORT MAP (
          Input => t_Input,
          Output => t_Output
        );


   -- Stimulus process
   stim_proc: process
   begin		
	t_Input <= x"00000004";
		wait for 100 ns;
	t_Input <= x"00000008";
			wait for 100 ns;
			
		assert false
		report "End"
		severity failure; 
   end process;

END;
