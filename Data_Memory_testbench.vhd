
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY Data_Memory_testbench IS
END Data_Memory_testbench;
 
ARCHITECTURE behavior OF Data_Memory_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Data_Memory_comp
    PORT(
         read_addr : IN  std_logic_vector(31 downto 0);
         write_addr : IN  std_logic_vector(31 downto 0);
         data_write : IN  std_logic_vector(31 downto 0);
         data_read : OUT  std_logic_vector(31 downto 0);
         write_en : IN  std_logic;
         read_en : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal read_addr : std_logic_vector(31 downto 0) := (others => '0');
   signal write_addr : std_logic_vector(31 downto 0) := (others => '0');
   signal data_write : std_logic_vector(31 downto 0) := (others => '0');
   signal write_en : std_logic := '0';
   signal read_en : std_logic := '0';

 	--Outputs
   signal data_read : std_logic_vector(31 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Data_Memory_comp PORT MAP (
          read_addr => read_addr,
          write_addr => write_addr,
          data_write => data_write,
          data_read => data_read,
          write_en => write_en,
          read_en => read_en
        );
 

   -- Stimulus process
	read_en <= '1';
   stim_proc: process
   begin		
--       hold reset state for 100 ns.
--	reading all 16 words
		for I in 0 to 3 loop
			read_addr <= std_logic_vector(to_unsigned(I*4,32));
			wait for 10 ns;
		end loop;
		
	write_en <= '1';
			write_addr <= std_logic_vector(to_unsigned(0*4,32));
			data_write <= std_logic_vector(to_unsigned(17,32));
			wait for 10 ns;
			write_addr <= std_logic_vector(to_unsigned(1*4,32));
			data_write <= std_logic_vector(to_unsigned(23,32));
			wait for 10 ns;

      wait;
   end process;

END;
