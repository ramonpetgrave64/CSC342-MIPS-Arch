-- This particular implementation uses a D flip-flop approach. In general, the program counter should start at 0 and update by 4 every single time. 
-- If we are trying to load an address because of a branch instruction, then the PC should load in the input and that will be the output. Regardless,
-- the PC should automatically update by 4.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pc is

port(
	clk: in std_logic; 
	load: in std_logic; -- needed for implementation of branch instructions
	reset: in std_logic; -- asynchronous reset of the PC
	input_address: in std_logic_vector(31 downto 0); -- needed for implementation of branch instructions
	output_address: buffer std_logic_vector(31 downto 0) -- 32 bit address
);

end pc;

architecture pc_arch of pc is

signal temp_output: std_logic_vector(31 downto 0);

begin

output_address <= temp_output; -- avoid making the output a buffer by assigning the output to a temp signal

	process(clk, reset)
	
	begin
	
		if reset = '1' then -- in the event that we want to reset the PC
			temp_output <= "00000000000000000000000000000000";
		elsif (rising_edge(clk)) then -- will only update on the rising edge of the clock cycle
			if load = '1' then -- in the event that we want to branch
				temp_output <= input_address; -- if branching, set the output to the input address
			elsif load = '0' then -- if we're not branching, the PC will update on the rising edge by 4 each time
				temp_output <= temp_output + 4;
			end if;
		end if;
	
	end process;

end pc_arch;
			
