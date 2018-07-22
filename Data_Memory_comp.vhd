library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Data_Memory_comp is
    Port ( addr : in  STD_LOGIC_VECTOR (31 downto 0);
           data_write : in  STD_LOGIC_VECTOR (31 downto 0);
           data_read : out  STD_LOGIC_VECTOR (31 downto 0);
           write_en : in  STD_LOGIC;
           read_en : in  STD_LOGIC);
end Data_Memory_comp;

architecture Behavioral of Data_Memory_comp is

	type RAM_16_x_32 is array(0 to 15) of std_logic_vector (31 downto 0);
	
	signal mem : RAM_16_x_32 := (x"00000000",
										  x"00000000",
									 	  x"00000000",
								  	     x"00000000",
										  x"00000000",
										  x"00000000",
										  x"00000000",
										  x"00000000",
										  x"00000000",
										  x"00000000",
										  x"00000000",
										  x"00000000",
										  x"00000000",
										  x"00000000",
										  x"00000000",
										  x"00000000"
										 );
										 
begin

	process(write_en, read_en)
		begin
			if(write_en = '1') then
				mem( (to_integer(unsigned(addr))-26840092) / 4 ) <= data_write;
			end if;
			if(read_en = '1') then
				data_read <= mem( (to_integer(unsigned(addr))-26840092) / 4 );
			end if;
	end process;
			
end Behavioral;

