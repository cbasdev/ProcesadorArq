
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------

entity ControlUnit is
    Port ( OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  icc: in STD_LOGIC_VECTOR(3 downto 0);
			  Cond : 	in STD_LOGIC_VECTOR(3 downto 0);
			  OP2 : in STD_LOGIC_VECTOR(2 downto 0);
			  We : out STD_LOGIC;
			  WeDM : out STD_LOGIC;
			  RfSource : out STD_LOGIC_VECTOR(1 downto 0);
			  RfDest : out STD_LOGIC;
			  PCSource : out STD_LOGIC_VECTOR(1 downto 0);
			  OP_Alu : out  STD_LOGIC_VECTOR (5 downto 0));
			  
			  
end ControlUnit;
----------------------------------------------------------------------------------

architecture Behavioral of ControlUnit is
----------------------------------------------------------------------------------

begin

	OP_ALU <= OP3;
end Behavioral;

----------------------------------------------------------------------------------
