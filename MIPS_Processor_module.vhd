library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MIPS_PROCESSOR is
	
	Port(clk : in STD_LOGIC;
			test_in : in STD_LOGIC_VECTOR (31 downto 0);
			test_out : out STD_LOGIC_VECTOR (2 downto 0));

end MIPS_PROCESSOR;

architecture Behavioral of MIPS_PROCESSOR is
	
	signal regfile_write_addr_src, regfile_data_in_src, alu_src, pc_src : STD_LOGIC;
	signal regfile_write, mem_read, mem_write : STD_LOGIC;
	signal alu_ctrl_in : STD_LOGIC_VECTOR (1 downto 0);
	component MIPS_Control_comp port(opcode : in  STD_LOGIC_VECTOR (5 downto 0); -- 6-bit opcode(31:26)
												  clk : in  STD_LOGIC; -- clocck signal
												  regfile_write_addr_src : out STD_LOGIC; -- 0: I-type(20:16), 1: R-type(15:11)
												  regfile_data_in_src : out STD_LOGIC; -- 0: memory_data, 1: ALU_data
												  pc_src : out STD_LOGIC; -- 0: pc, 1: adder
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
										 
	 signal write_addr : STD_LOGIC_VECTOR (4 downto 0);
	 component Mux_5 port( I0 : in  STD_LOGIC_VECTOR (4 downto 0);
								  I1 : in  STD_LOGIC_VECTOR (4 downto 0);
								  O : out  STD_LOGIC_VECTOR (4 downto 0);
								  S : in  STD_LOGIC);
								  end component;
	
	signal data_in : STD_LOGIC_VECTOR (31 downto 0);	
	signal read_one : STD_LOGIC_VECTOR (31 downto 0);
	signal read_two : STD_LOGIC_VECTOR (31 downto 0);
	component REG_FILE Port (reg_write: in STD_LOGIC;
									read_reg_one, read_reg_two, dest_reg: in STD_LOGIC_VECTOR(4 downto 0);
									write_data: in STD_LOGIC_VECTOR(31 downto 0);
									data_one, data_two: out STD_LOGIC_VECTOR(31 downto 0));
									end component;
									
	signal se_out : STD_LOGIC_VECTOR (31 downto 0);
	component SignExtender Port ( se_in : in STD_LOGIC_VECTOR (15 downto 0);
											se_out : out STD_LOGIC_VECTOR(31 downto 0));
											end component;
											
	signal alu_b : STD_LOGIC_VECTOR (31 downto 0);
	component Mux Port ( mux_in0 : in STD_LOGIC_VECTOR(31 downto 0);
								 mux_in1 : in STD_LOGIC_VECTOR(31 downto 0);
								 mux_ctl : in STD_LOGIC;
								 mux_out : out STD_LOGIC_VECTOR(31 downto 0));
								 end component;
	
	signal alu_out : STD_LOGIC_VECTOR (31 downto 0);
	signal alu_zero : std_logic;
	component ALU Port ( alu_en : in  STD_LOGIC;
							  alu_ctl : in  STD_LOGIC_VECTOR (2 downto 0);
							  alu_a, alu_b : in  STD_LOGIC_VECTOR (31 downto 0);           
							  alu_out : out  STD_LOGIC_VECTOR (31 downto 0);
							  alu_zero : out  STD_LOGIC);
							  end component;
							  
	signal dm_out : STD_LOGIC_VECTOR (31 downto 0);						  
	component Data_Memory_comp Port ( read_addr : in  STD_LOGIC_VECTOR (31 downto 0);
											  write_addr : in  STD_LOGIC_VECTOR (31 downto 0);
											  data_write : in  STD_LOGIC_VECTOR (31 downto 0);
											  data_read : out  STD_LOGIC_VECTOR (31 downto 0);
											  write_en : in  STD_LOGIC;
											  read_en : in  STD_LOGIC);
											  end component;
											  
	signal shift_out : STD_LOGIC_VECTOR (31 downto 0);								
	component Shift Port ( Input : in  STD_LOGIC_VECTOR (31 downto 0);
									Output: out STD_LOGIC_VECTOR (31 downto 0));
									end component;
									
	signal add_out : STD_LOGIC_VECTOR (31 downto 0);
	component add2 Port ( add_a : in  STD_LOGIC_VECTOR (31 downto 0);
								  add_b : in  STD_LOGIC_VECTOR (31 downto 0);
								  add_out : out  STD_LOGIC_VECTOR (31 downto 0));	
									end component;
begin

	PCnt: pc port map(clk, pc_load, pc_reset, pc_in, pc_out);
	CTRL: MIPS_Control_comp port map(instr_out(31 downto 26),
												clk, 
												regfile_write_addr_src,
												regfile_data_in_src,
												pc_src,
												regfile_write,
												alu_src,
												alu_ctrl_in,
												mem_read,
												mem_write);
	ALU_C: alu_control port map(alu_ctrl_in, instr_out(5 downto 0), alu_ctrl_out);
	IM: InstructionMemory port map(pc_out, instr_out);
	RF_MUX: Mux_5 port map(instr_out(20 downto 16),
								  instr_out(15 downto 11),
								  write_addr,
								  regfile_write_addr_src);
	RF: REG_FILE port map(regfile_write,
								 instr_out(25 downto 21),
								 instr_out(20 downto 16),
								 write_addr, 
								 data_in,
								 read_one,
								 read_two);
	SE: SignExtender port map(instr_out(15 downto 0), se_out);
	ALU_MUX: Mux port map(read_two, se_out, alu_src, alu_b);
	AL: ALU port map('1', alu_ctrl_out, read_one, alu_b, alu_out, alu_zero);
	DM: Data_Memory_comp port map(alu_out, alu_out, read_two, dm_out, mem_read, mem_write);
	WB_MUX: Mux port map(dm_out, alu_out, regfile_data_in_src, data_in);
	SL: Shift port map(se_out, shift_out);
	ADD: add2 port map(shift_out, pc_out, add_out);
	PC_MUX: Mux port map(pc_out, add_out, pc_src, pc_in); 
	
	test_out <= alu_ctrl_out;

end Behavioral;

