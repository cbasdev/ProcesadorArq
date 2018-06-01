
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity SEUdisp30 is
    Port ( disp30 : in  STD_LOGIC_VECTOR (29 downto 0);
           extdisp30 : out  STD_LOGIC_VECTOR (31 downto 0));
end SEUdisp30;

architecture Behavioral of SEUdisp30 is

begin
process(disp30)
begin
	if disp30(29)='1' then
		extdisp30<="11" & disp30;
	else
		extdisp30<="00" & disp30;
	
	end if;
end process;
end Behavioral;

