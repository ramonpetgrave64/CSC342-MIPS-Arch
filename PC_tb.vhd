LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PC_tb IS
END PC_tb;
 
ARCHITECTURE behavior OF PC_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PC
    port(
	   clk: in std_logic; 
	   load: in std_logic; -- needed for implementation of branch instructions
	   reset: in std_logic; -- asynchronous reset of the PC
	   input_address: in std_logic_vector(31 downto 0); -- needed for implementation of branch instructions
	   output_address: out std_logic_vector(31 downto 0) -- 32 bit address
);
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal tbload : std_logic := '0';
   signal tbreset : std_logic;
   signal tbinput_address : std_logic_vector(31 downto 0);
   

 	--Outputs
   signal tboutput_address : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pc PORT MAP (
          clk => clk,
          load => tbload,
          reset => tbreset,
          input_address => tbinput_address,
          output_address => tboutput_address
          
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
-- 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      
      wait for 10 ns;	
      
      wait for 10 ns;
      
      wait for 10 ns;
      
      tbload <= '1';
      tbinput_address <= x"00000064";
      
      wait for 10 ns;
    
      
      tbload <= '0';
      
--		test_in <= x"00000000";
--      wait for clk_period*10;
      -- insert stimulus here 
		
--		test_in <= "00000000010000000000000000000000";
--		wait for 20 ns;
--		test_in <= "00000000010000000000000000000100";
--		wait for 20 ns;
--		test_in <= "00000000010000000000000000001000";
--		wait for 20 ns;

   end process;

END;


