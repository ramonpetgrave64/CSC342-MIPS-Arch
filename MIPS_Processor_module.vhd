library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MIPS_PROCESSOR is
	
	Port(clk : in STD_LOGIC;
			test_in : in STD_LOGIC_VECTOR (31 downto 0);
			test_out : out STD_LOGIC_VECTOR (2 downto 0));

end MIPS_PROCESSOR;

architecture Behavioral of MIPS_PROCESSOR is
	
	signal regfile_write_addr_src, regfile_data_in_src, alu_src : STD_LOGIC;
	signal regfile_write, mem_read, mem_write : STD_LOGIC;
	signal alu_ctrl_in : STD_LOGIC_VECTOR (1 downto 0);
	component MIPS_Control_comp port(opcode : in  STD_LOGIC_VECTOR (5 downto 0); -- 6-bit opcode(31:26)
												  clk : in  STD_LOGIC; -- clocck signal
												  regfile_write_addr_src : out STD_LOGIC; -- 0: I-type(20:16), 1: R-type(15:11)
												  regfile_data_in_src : out STD_LOGIC; -- 0: memory_data, 1: ALU_data
												  regfile_write: out STD_LOGIC; -- -- enable register-file-write
												  alu_src : out STD_LOGIC; -- 0: register file, 1: sign extender
												  alu_op :out STD_LOGIC_VECTOR (1 downto 0);
												  mem_read : out  STD_LOGIC; -- enable memory-read
												  mem_write : out  STD_LOGIC); -- enable memory-write
												  end component;
												  
	signal alu_ctrl_out : STD_LOGIC_VECTOR (2 downto 0);
	component alu_control port(ALUop: in std_logic_vector(1 downto 0); -- 2 bits from the control unit dictates I vs R type
										funct: in std_logic_vector(5 downto 0); -- 6 bits used for R type instructions
										operation: out std_logic_vector(2 downto 0) -- 3 bits to be fed into the ALU
										); end component;
	
	signal pc_load : std_logic := '0';
	signal pc_reset : std_logic := '0';
	signal pc_in : STD_LOGIC_VECTOR (31 downto 0);
	signal pc_out : STD_LOGIC_VECTOR (31 downto 0);
	component pc port(clk, load, reset : in STD_LOGIC; 
					 input_address : in std_logic_vector(31 downto 0); 
					 output_address : out std_logic_vector(31 downto 0)); 
					 end component;
	
	signal instr_out : STD_LOGIC_VECTOR (31 downto 0);
	component InstructionMemory port(ReadAddress : in std_logic_vector(31 downto 0); 
										 Instruction : out std_logic_vector(31 downto 0));
										 end component;

begin

	PCnt: pc port map(clk, pc_load, pc_reset, pc_in, pc_out);
	CTRL: MIPS_Control_comp port map(instr_out(31 downto 26),
												clk, 
												regfile_write_addr_src,
												regfile_data_in_src,
												regfile_write,
												alu_src,
												alu_ctrl_in,
												mem_read,
												mem_write);
	ALU_C: alu_control port map(alu_ctrl_in, instr_out(5 downto 0), alu_ctrl_out);
	IM: InstructionMemory port map(pc_out, instr_out);
	test_out <= alu_ctrl_out;

end Behavioral;

