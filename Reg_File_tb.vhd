LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY Reg_File_TB IS
END Reg_File_TB;
 
ARCHITECTURE behavior OF Reg_File_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Reg_File
    PORT(
         reg_write : IN  std_logic;
         read_reg_one : IN  std_logic_vector(4 downto 0);
         read_reg_two : IN  std_logic_vector(4 downto 0);
         dest_reg : IN  std_logic_vector(4 downto 0);
         write_data : IN  std_logic_vector(31 downto 0);
         data_one : OUT  std_logic_vector(31 downto 0);
         data_two : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal reg_write : std_logic := '0';
   signal read_reg_one : std_logic_vector(4 downto 0) := (others => '0');
   signal read_reg_two : std_logic_vector(4 downto 0) := (others => '0');
   signal dest_reg : std_logic_vector(4 downto 0) := (others => '0');
   signal write_data : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal data_one : std_logic_vector(31 downto 0);
   signal data_two : std_logic_vector(31 downto 0);   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Reg_File PORT MAP (
          reg_write => reg_write,
          read_reg_one => read_reg_one,
          read_reg_two => read_reg_two,
          dest_reg => dest_reg,
          write_data => write_data,
          data_one => data_one,
          data_two => data_two
        );

   -- Stimulus process
   stim_proc: process
   begin		      
	--reading all 32 registers
		for I in 0 to 30 loop
			read_reg_one <= std_logic_vector(to_unsigned(I,5));
			read_reg_two <= std_logic_vector(to_unsigned(I+1,5));
			wait for 20 ns;
		end loop;
		
		
		--writing to a register

--		reg_write <= '0';
--		wait for 5 ns;
--		reg_write <= '1';
--		--overwriting register $t2
--		dest_reg <= "01010";
--		write_data <= x"AAAAAAAA";
--		wait for 5 ns;		
--		reg_write <= '0';
--		dest_reg <= "00000";
--		write_data <= x"00000000";
--		
--		reg_write <= '1';
--		--overwriting register $v0		
--		dest_reg <= "00010";
--		write_data <= x"08080808";
--		wait for 5 ns;
--		reg_write <= '0';
--		dest_reg <= "00000";
--		write_data <= x"00000000";
		
		wait;		
   end process;

END;
