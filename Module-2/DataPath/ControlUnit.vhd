
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------

entity ControlUnit is
    Port ( OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           OP_Alu : out  STD_LOGIC_VECTOR (5 downto 0));
end ControlUnit;
----------------------------------------------------------------------------------

architecture Behavioral of ControlUnit is
----------------------------------------------------------------------------------

begin

	OP_ALU <= OP3;
end Behavioral;

----------------------------------------------------------------------------------
