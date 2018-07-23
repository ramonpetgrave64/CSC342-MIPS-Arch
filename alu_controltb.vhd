LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY alu_controltb IS
END alu_controltb;

ARCHITECTURE alu_controltb_arch OF alu_controltb IS
  
COMPONENT alu_control
PORT (ALUop : in STD_LOGIC_VECTOR(1 DOWNTO 0);
      funct : in STD_LOGIC_VECTOR(5 DOWNTO 0);
      operation : out STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END COMPONENT;
      
-- constants                                                 
-- signals                                                   
SIGNAL tbALUop : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL tbfunct : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL tboperation : STD_LOGIC_VECTOR(2 DOWNTO 0);

SIGNAL error : std_logic := '0';

BEGIN
	
	uut: alu_control
	
	PORT MAP (
-- list connections between master ports and signals
	ALUop => tbALUop,
	funct => tbfunct,
	operation => tboperation
	);

PROCESS
-- variable declarations                                     
BEGIN                                                        		  
	  
	  		-- I type (ADD / SUB)
		  tbALUop <= "00";
		  tbfunct <= "000000";
		  WAIT FOR 10 ns;
		  
		  tbALUop <= "01";
		  tbfunct <= "000000";
		  WAIT FOR 10 ns;
	  
		  -- R type ADD
		  tbALUop <= "10";
		  tbfunct <= "100000";
		  WAIT FOR 10 ns;
		  
		  -- R type SUB
		  tbALUop <= "10";
		  tbfunct <= "100010";
		  WAIT FOR 10 ns;
		  
		  --R type AND
		  tbALUop <= "10";
		  tbfunct <= "100100";
		  WAIT FOR 10 ns;
		  
		  --R type OR
		  tbALUop <= "10";
		  tbfunct <= "100101";
		  WAIT FOR 10 ns;
		  
		  --R type SLT
		  tbALUop <= "10";
		  tbfunct <= "101010";
		  WAIT FOR 10 ns;
		  
		  --I type BEQ
		  tbALUop <= "11";
		  tbfunct <= "000000";
		  WAIT FOR 10 ns;
		    
  ASSERT FALSE REPORT "Test over" SEVERITY FAILURE;
		
END PROCESS;
		                                        
END alu_controltb_arch;
