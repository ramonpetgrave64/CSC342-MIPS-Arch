
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Control_comp_testbench IS
END Control_comp_testbench;
 
ARCHITECTURE behavior OF Control_comp_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MIPS_Control_comp
    PORT(
         opcode : IN  std_logic_vector(5 downto 0);
         clk : IN  std_logic;
         regfile_write_addr_src : OUT  std_logic;
         regfile_data_in_src : OUT  std_logic;
         regfile_write : OUT  std_logic;
         alu_src : OUT  std_logic;
         alu_op : OUT  std_logic_vector(1 downto 0);
         mem_read : OUT  std_logic;
         mem_write : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal opcode : std_logic_vector(5 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal regfile_write_addr_src : std_logic;
   signal regfile_data_in_src : std_logic;
   signal regfile_write : std_logic;
   signal alu_src : std_logic;
   signal alu_op : std_logic_vector(1 downto 0);
   signal mem_read : std_logic;
   signal mem_write : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MIPS_Control_comp PORT MAP (
          opcode => opcode,
          clk => clk,
          regfile_write_addr_src => regfile_write_addr_src,
          regfile_data_in_src => regfile_data_in_src,
          regfile_write => regfile_write,
          alu_src => alu_src,
          alu_op => alu_op,
          mem_read => mem_read,
          mem_write => mem_write
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
      wait for 100 ns;	
		opcode <= "000000";
      wait for clk_period*2;
		opcode <= "100011";
      wait for clk_period*2;
		opcode <= "101011";
      wait for clk_period*2;
		opcode <= "111111";
      wait for clk_period*2;
		--again
		opcode <= "000000";
      wait for clk_period*2;
		opcode <= "100011";
      wait for clk_period*2;
		opcode <= "101011";
      wait for clk_period*2;
		opcode <= "111111";
      wait for clk_period*2;
      wait;
   end process;

END;
