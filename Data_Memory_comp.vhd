library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Data_Memory_comp is
    Port ( read_addr : in  STD_LOGIC_VECTOR (31 downto 0);
			  write_addr : in  STD_LOGIC_VECTOR (31 downto 0);
           data_write : in  STD_LOGIC_VECTOR (31 downto 0);
           data_read : out  STD_LOGIC_VECTOR (31 downto 0);
           write_en : in  STD_LOGIC;
           read_en : in  STD_LOGIC);
end Data_Memory_comp;

architecture Behavioral of Data_Memory_comp is

	type RAM_16_x_32 is array(0 to 15) of std_logic_vector (31 downto 0);
	
	signal mem : RAM_16_x_32 := (x"00000A00",
										  x"00000B00",
									 	  x"00000C00",
								  	     x"00000D00",
										  x"00000E00",
										  x"00000F00",
										  x"00000A10",
										  x"00000A20",
										  x"00000A30",
										  x"00000A40",
										  x"00000A50",
										  x"00000A60",
										  x"00000A70",
										  x"00000A80",
										  x"00000A90",
										  x"00000AA0"
										 );
										 
begin

	process(write_en, read_en, read_addr, write_addr)
		begin
			if(write_en = '1') then --offset was 26840092
				mem( (to_integer(unsigned(write_addr))-0) / 4 ) <= data_write;
			end if;
			if(read_en = '1') then
				data_read <= mem( (to_integer(unsigned(read_addr))-0) / 4 );
			end if;
	end process;
			
end Behavioral;

