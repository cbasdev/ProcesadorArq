
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity muxCall is
    Port ( Rd : in  STD_LOGIC_VECTOR (5 downto 0);
           callrd : in  STD_LOGIC_VECTOR (5 downto 0);
           rfdest : in  STD_LOGIC;
           NRD : out  STD_LOGIC_VECTOR (5 downto 0));
end muxCall;

architecture Behavioral of muxCall is

begin
process(Rd,callrd,rfdest)
begin
	if rfdest = '0' then
		NRD<= Rd;
	else
		NRD<= callrd;
		
	end if;
end process;	

end Behavioral;

