
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------


entity MUX is
    Port ( CRS2 : in  STD_LOGIC_VECTOR (31 downto 0);
           SE_OUT : in  STD_LOGIC_VECTOR (31 downto 0);
           I : in  STD_LOGIC;
           MUX_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX;

architecture Behavioral of MUX is
----------------------------------------------------------------------------------

begin
	process(CRS2, SE_OUT, I)
		begin 
			if (i = '1') THEN
				MUX_OUT <= SE_OUT;
			else 
				MUX_OUT <= CRS2;
			end if;
	end process;

end Behavioral;

----------------------------------------------------------------------------------
