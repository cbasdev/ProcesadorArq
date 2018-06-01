
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity regis is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC := '0' ;
           datain : in  STD_LOGIC_VECTOR (31 downto 0) := x"00000000" ;
           dataout : out  STD_LOGIC_VECTOR (31 downto 0) := x"00000000" );
end regis;

architecture Behavioral of regis is

signal res: std_logic_vector(31 downto 0):= x"00000000";

begin
res <= datain;


	process (clk, rst)
		begin  
			if (clk'event and clk = '1' and rst = '0') then
				if datain = "00000000000000000000000001000000" then
					dataout<= "00000000000000000000000000000000";
				else
					dataout <= res;
				end if;
			end if;
			if (rst = '1') then
		      dataout <= "00000000000000000000000000000000";
		   end if;
		
	end process;
	


--process (rst)
--begin  
--	if (rst'event and rst = '1') then
--		res <= x"00000000";
--		dataout <= res;
--	end if;
--end process;

end Behavioral;

