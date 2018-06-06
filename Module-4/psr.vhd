
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity psr is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           ncwp : in  STD_LOGIC_VECTOR (4 downto 0);
           cwp : out  STD_LOGIC_VECTOR (4 downto 0);
           c : out  STD_LOGIC;
			  icc : out std_logic_vector (3 downto 0));
end psr;

architecture Behavioral of psr is

	signal regispsr : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
	
begin
	
	
	process(clk, rst,nzvc)
		begin
			if ( rst='1') then
				regispsr <=  "00000000000000000000000000000000";
			
			elsif (clk'event and clk='1') then
				
				regispsr(26 downto 23) <= nzvc;
				regispsr(4 downto 0) <= ncwp;
				
			end if;

	end process;
	c <= regispsr(23);
	cwp <= regispsr(4 downto 0);
	icc <= regispsr(26 downto 23);
end Behavioral;

