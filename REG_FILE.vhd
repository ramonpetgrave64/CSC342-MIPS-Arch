library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Reg_File is 
	Port (
				reg_write: in STD_LOGIC;
				read_reg_one, read_reg_two, dest_reg: in STD_LOGIC_VECTOR(4 downto 0);
				write_data: in STD_LOGIC_VECTOR(31 downto 0);
				data_one, data_two: out STD_LOGIC_VECTOR(31 downto 0)
			);
end Reg_File;

architecture Behavioral of Reg_File is
	--initializing register file 
    type reg_file_type is array(0 to 7) of STD_LOGIC_VECTOR (31 downto 0);
    signal array_reg: reg_file_type := (
											x"00000000", --$zero
											x"02020202", --$v0
											x"04040404", --$a0
											x"08080808", --$t0
											x"09090909", --$t1
											x"0A0A0A0A", --$t2
											x"0B0B0B0B", --$t3
											x"0C0C0C0C", --$t4
											x"0D0D0D0D", --$t5
											x"0E0E0E0E", --$t6
											x"0F0F0F0F", --$t7
											x"10101010", --$s0
											x"11111111", --$s1
											x"12121212", --$s2
											x"13131313", --$s3
											x"14141414", --$s4
											x"15151515", --$s5
											x"16161616", --$s6
											x"17171717", --$s7
											x"18181818", --$t8
											x"19191919", --$t9
											others => x"00000000" --others
													);

begin
	
	--outputting values from read registers
	data_one <= array_reg(to_integer(unsigned(read_reg_one)));
   	data_two <= array_reg(to_integer(unsigned(read_reg_two)));
	
	--instructions with reg_write enabled
	process(reg_write)
	begin
		if reg_write = '1' then
            --put write_data into destination register
            array_reg(to_integer(unsigned(dest_reg))) <= write_data;
		end if;
	end process;

end Behavioral;