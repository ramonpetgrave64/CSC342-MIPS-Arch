
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY Data_Memory_testbench IS
END Data_Memory_testbench;
 
ARCHITECTURE behavior OF Data_Memory_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Data_Memory_comp
    PORT(
         addr : IN  std_logic_vector(31 downto 0);
         data_write : IN  std_logic_vector(31 downto 0);
         data_read : OUT  std_logic_vector(31 downto 0);
         write_en : IN  std_logic;
         read_en : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal addr : std_logic_vector(31 downto 0) := (others => '0');
   signal data_write : std_logic_vector(31 downto 0) := (others => '0');
   signal write_en : std_logic := '0';
   signal read_en : std_logic := '0';

 	--Outputs
   signal data_read : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Data_Memory_comp PORT MAP (
          addr => addr,
          data_write => data_write,
          data_read => data_read,
          write_en => write_en,
          read_en => read_en
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
--      addr <= x"00000000‬";
		addr <= "00000001100110011000110000011100";
		data_write <= x"00000000";
		write_en <= '0';
		read_en <= '1';
		wait for 10 ns;	
		addr <= "00000001100110011000110000100000";
		wait for 10 ns;
		addr <= "00000001100110011000110000100100";
		wait for 10 ns;
      -- insert stimulus here 

      wait;
   end process;

END;
