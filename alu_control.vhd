library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu_control is 

port(
	ALUop: in std_logic_vector(1 downto 0); -- 2 bits from the control unit dictates I vs R type
	funct: in std_logic_vector(5 downto 0); -- 6 bits used for R type instructions
	operation: out std_logic_vector(2 downto 0) -- 3 bits to be fed into the ALU
);

end alu_control;

architecture alu_control_arch of alu_control is

begin
  
-- The following logic is derived from a truth table 
--
--operation(2) <= ALUop(0) or (ALUop(1) and funct(1));
--operation(1) <= (not ALUop(1)) or (not funct(2));
--operation(0) <= ALUop(1) and (funct(3) or funct(0));

alu_proc: process(ALUop, funct) 
begin
	case ALUop is 
		when "00" =>
			operation <= "010";
		when "01" | "11" =>
			operation <= "110";
		when "10" =>
			case funct is
				when "000000" | "010000" | "100000" | "110000"=>
					operation <= "010";
				when "000010" | "010010" | "100010" | "110010" =>
					operation <= "110";
				when "000100" | "010100" | "100100" | "110100"=>
					operation <= "000";
				when "000101" | "010101" | "100101" | "110101" =>
					operation <= "001";
				when "001010" | "011010" | "101010" | "111010" =>
					operation <= "111";
				when others =>
					operation <= "XXX";
			end case;
		when others =>
			operation <= "XXX";
	end case;
end process;
	
end alu_control_arch;
			
