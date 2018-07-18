
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY Test_Mux IS
END Test_Mux;
 
ARCHITECTURE behavior OF Test_Mux IS 
    
	 Constant N : Integer := 32;

   --Inputs
   signal t_mux_in0 : std_logic_vector(N-1 downto 0) := (others => '0');
   signal t_mux_in1 : std_logic_vector(N-1 downto 0) := (others => '0');
   signal t_mux_ctl : std_logic := '0';

 	--Outputs
   signal t_mux_out : std_logic_vector(N-1 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   U1_Test: entity work.Mux(Behavioral)
		Generic Map (N => 32)
		PORT MAP (
          mux_in0 => t_mux_in0,
          mux_in1 => t_mux_in1,
          mux_ctl => t_mux_ctl,
          mux_out => t_mux_out
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
	
		t_mux_in0 <= x"AAAA5555";
		t_mux_in1 <= x"5555AAAA";
	
		t_mux_ctl <= '0';
		wait for 100 ns;
		
		t_mux_ctl <= '1';
		wait for 100 ns;
		
		t_mux_ctl <= '0';
		wait for 100 ns;
		
		--For 5-bit input output
--		t_mux_in0 <= "11100";
--		t_mux_in1 <= "00111";
--	
--		t_mux_ctl <= '0';
--		wait for 100 ns;
--		
--		t_mux_ctl <= '1';
--		wait for 100 ns;
--		
--		t_mux_ctl <= '0';
--		wait for 100 ns;
--		
		
		
		
		assert false
			report "End"
			severity failure;

   end process;

END;
