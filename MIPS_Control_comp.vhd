library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MIPS_Control_comp is
    Port ( opcode : in  STD_LOGIC_VECTOR (5 downto 0); -- 6-bit opcode(31:26)
           clk : in  STD_LOGIC; -- clocck signal
			  regfile_write_addr_src : out STD_LOGIC; -- 0: I-type(20:16), 1: R-type(15:11)
			  regfile_data_in_src : out STD_LOGIC; -- 0: memory_data, 1: ALU_data
			  regfile_write: out STD_LOGIC; -- -- enable register-file-write
			  alu_src : out STD_LOGIC; -- 0: register file, 1: sign extender
			  alu_op :out STD_LOGIC_VECTOR (1 downto 0);
           mem_read : out  STD_LOGIC; -- enable memory-read
           mem_write : out  STD_LOGIC); -- enable memory-write
end MIPS_Control_comp;

architecture Behavioral of MIPS_Control_comp is

begin

--	control_proc: process (clk)
	control_proc: process (opcode)
	begin
--		if rising_edge(clk) then
			case opcode is 
				when "000000" => -- R-Type instruction
					regfile_write_addr_src <= '1';
					regfile_data_in_src <= '1';
					regfile_write <= '1';
					alu_src <= '0';
					alu_op <= "10";
					mem_read <= '0';
					mem_write <= '0';
				when "100011" => -- I-Type instruction, Load Word
					regfile_write_addr_src <= '0';
					regfile_data_in_src <= '0';
					regfile_write <= '1';
					alu_src <= '1';
					alu_op <= "00";
					mem_read <= '1';
					mem_write <= '0';
				when "101011" => -- I-Type instruction, Store Word
					regfile_write_addr_src <= 'X';
					regfile_data_in_src <= 'X';
					regfile_write <= '0';
					alu_src <= '1';
					alu_op <= "00";
					mem_read <= '0';
					mem_write <= '1';
				when "000100" => -- I-type instruction, beq
					regfile_write_addr_src <= 'X';
					regfile_data_in_src <= 'X';
					regfile_write <= '0';
					alu_src <= '1';
					alu_op <= "01";
					mem_read <= '0';
					mem_write <= '0';
				when "100000" => -- J-type instruction, Jump
					regfile_write_addr_src <= 'X';
					regfile_data_in_src <= 'X';
					regfile_write <= '0';
					alu_src <= '1';
					alu_op <= "XX";
					mem_read <= '0';
					mem_write <= '0';
				when others => 
					regfile_write_addr_src <= '0';
					regfile_data_in_src <= '0';
					regfile_write <= '0';
					alu_src <= '0';
					alu_op <= "XX";
					mem_read <= '0';
					mem_write <= '0';
			end case;
--		end if;
	end process;


end Behavioral;

