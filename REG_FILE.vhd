library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Reg_File is 
	Port (
				reg_write: in STD_LOGIC;
				read_reg_one, read_reg_two, dest_reg: in STD_LOGIC_VECTOR(4 downto 0);
				write_data: in STD_LOGIC_VECTOR(31 downto 0);
				data_one, data_two: out STD_LOGIC_VECTOR(31 downto 0) := x"00000000"
			);
end Reg_File;

architecture Behavioral of Reg_File is
	--initializing register file 
    type reg_file_type is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
    signal array_reg: reg_file_type := (
											x"00000000", --$zero
											x"02020202", --$at
											x"04040404", --$v0
											x"08080808", --$v1
											x"09090909", --$a0
											x"0A0A0A0A", --$a1
											x"0B0B0B0B", --$a2
											x"0C0C0C0C", --$a3
											x"12345670", --$t0
											x"0E0E0E0E", --$t1
											x"0F0F0F0F", --$t2
											x"10101010", --$t3
											x"11111111", --$t4
											x"12121212", --$t5
											x"13131313", --$t6
											x"14141414", --$t7
											x"15151515", --$s0
											x"16161616", --$s1
											x"17171717", --$s2
											x"18181818", --$s3
											x"19191919", --$s4
											x"AAAAAAAA", --$s5
											x"BBBBBBBB", --$s6
											x"CCCCCCCC", --$s7
											x"DDDDDDDD", --$t8
											x"EEEEEEEE", --$t9
											x"FFFFFFFF", --$k0
											x"11221122", --$k1
											x"22332233", --$gp
											x"33443344", --$sp
											x"44554455", --$fp
											x"55665566" --$ra											
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