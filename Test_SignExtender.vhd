LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY Test_SignExtender IS
END Test_SignExtender;
 
ARCHITECTURE behavior OF Test_SignExtender IS 
   --Inputs
   signal t_se_in : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal t_se_out : std_logic_vector(31 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   U1_Test: entity work.SignExtender (Behavioral) 
	PORT MAP (
          se_in => t_se_in,
          se_out => t_se_out
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
		
		t_se_in <= x"7fff";
		wait for 100 ns;
		
		t_se_in <= x"8000";
		wait for 100 ns;
		
		t_se_in <= x"FFFF";
		wait for 100 ns;
	
		assert false
			report "End"
			severity failure;
			
   end process;

END;
