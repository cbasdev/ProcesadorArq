
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEUdisp22 is
    Port ( disp22 : in  STD_LOGIC_VECTOR (21 downto 0);
           extdisp22 : out  STD_LOGIC_VECTOR (31 downto 0));
end SEUdisp22;

architecture Behavioral of SEUdisp22 is

begin
process(disp22)
begin
	if disp22(21)='1' then
		extdisp22<="1111111111" & disp22;
	else
		extdisp22<="0000000000" & disp22;
	end if;
end process;
end Behavioral;

