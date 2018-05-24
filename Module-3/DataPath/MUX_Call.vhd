library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX_Call is
    Port ( RD : in  STD_LOGIC_VECTOR (5 downto 0);
           CallRD : in  STD_LOGIC_VECTOR (5 downto 0);
           RFdest : in  STD_LOGIC;
           NRD : out  STD_LOGIC_VECTOR (5 downto 0));
end MUX_Call;

architecture Behavioral of MUX_Call is

begin
process(RD,CallRD,RFdest)
begin
	if RFdest = '0' then
		NRD<= RD;
	else
		NRD<= CallRD;
		
	end if;
end process;	

end Behavioral;