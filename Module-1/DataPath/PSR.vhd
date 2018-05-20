
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


----------------------------------------------------------------------------------


entity PSR is
    Port ( NCWP : in  STD_LOGIC_VECTOR (3 downto 0);
           CWP : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           C : out  STD_LOGIC;
           CWPOUT : out  STD_LOGIC);
end PSR;

architecture Behavioral of PSR is

begin
	process(NCWP, CWP, CLK)
		begin
			if(RST = '1') then
				C <= '0';
				CWPOUT <= '0';
			end if;
			
			if(rising_edge(CLK)) then
				C <= NCWP(0); 
				CWPOUT <= CWP;
			end if;

	end process;
end Behavioral;

