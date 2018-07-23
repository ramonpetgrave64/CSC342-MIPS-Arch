LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY ALU_TB IS
END ALU_TB;
 
ARCHITECTURE behavior OF ALU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         alu_en : IN  std_logic;
         alu_ctl : IN  std_logic_vector(2 downto 0);
         alu_a : IN  std_logic_vector(31 downto 0);
         alu_b : IN  std_logic_vector(31 downto 0);
         alu_out : OUT  std_logic_vector(31 downto 0);
         alu_zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal alu_en : std_logic := '0';
   signal alu_ctl : std_logic_vector(2 downto 0) := (others => '0');
   signal alu_a : std_logic_vector(31 downto 0) := (others => '0');
   signal alu_b : std_logic_vector(31 downto 0) := (others => '0');

  --Outputs
   signal alu_out : std_logic_vector(31 downto 0);
   signal alu_zero : std_logic;
  
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          alu_en => alu_en,
          alu_ctl => alu_ctl,
          alu_a => alu_a,
          alu_b => alu_b,
          alu_out => alu_out,
          alu_zero => alu_zero
        );

   -- Stimulus process
   stim_proc: process
   begin        
        
    alu_en <= '1';            
    alu_ctl <= "010";   
    alu_a <= x"02020202";
    alu_b <= x"08080808";   
    wait for 10 ns;
          
    alu_en <= '0';    
    alu_ctl <= "000";
    alu_a <= x"00000000";
    alu_b <= x"00000000";       
    wait for 10 ns;
        
    alu_en <= '1';    
    alu_ctl <= "110";
    alu_a <= x"FFFFFFFF";
    alu_b <= x"FFFFFFFF";       
    wait for 10 ns;
    
    alu_en <= '0';
    alu_ctl <= "000";
    alu_a <= x"00000000";
    alu_b <= x"00000000";
    wait;   
   end process;
END;