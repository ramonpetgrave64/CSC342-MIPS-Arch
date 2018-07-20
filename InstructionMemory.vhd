library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory is
    Port ( ReadAddress : in  STD_LOGIC_VECTOR (31 downto 0);
           Instruction : out  STD_LOGIC_VECTOR (31 downto 0));
end InstructionMemory;

architecture Behavioral of InstructionMemory is

	type RAM_16_x_32 is array(0 to 15) of std_logic_vector(31 downto 0);
	
	signal IM : RAM_16_x_32 := ( x"01285024", -- 0x0040 0000: and $t2, $t1, $t0
										  x"018b6825", -- 0x0040 0004: or  $t5, $t4, $t3
										  x"01285020", -- 0x0040 0008: add $t2, $t1, $t0
										  x"01285022", -- 0x0040 000C: sub $t2, $t1, $t0
										  x"0149402a", -- 0x0040 0010: slt $t0, $t2, $t1
										  x"1211fffb", -- 0x0040 0014: beq $s0, $s1, L1
										  x"01285024", -- 0x0040 0018: and $t2, $t1, $t0
										  x"018b6825", -- 0x0040 001C: or  $t5, $t4, $t3
										  x"01285020", -- 0x0040 0020: add $t2, $t1, $t0
										  x"01285022", -- 0x0040 0024: sub $t2, $t1, $t0
										  x"0149402a", -- 0x0040 0028: slt $t0, $t2, $t1
										  x"08100000", -- 0x0040 002C: j   0x00400000 => 0000 1000
										  x"00000000", 
										  x"00000000", 
										  x"00000000", 
										  x"00000000"
										  );
										  						

begin
		--Note: 4194303 = 0x0040 0000
		Instruction <= x"00000000" when ReadAddress = x"003FFFFC" else
		IM((to_integer(unsigned(ReadAddress))-4194304)/4);
				  
				  
end Behavioral;

