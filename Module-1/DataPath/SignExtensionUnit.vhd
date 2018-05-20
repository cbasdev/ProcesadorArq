----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

----------------------------------------------------------------------------------

entity SingExtension is
    Port ( imm : in  STD_LOGIC_VECTOR (12 downto 0);
           se_out : out  STD_LOGIC_VECTOR (31 downto 0));
end SingExtension;
----------------------------------------------------------------------------------

architecture Behavioral of SingExtension is

begin

----------------------------------------------------------------------------------

process(imm)
begin
	
	if(imm(12) = '1') then
		se_out <= "1111111111111111111" & imm;
	
  else
		se_out <= "0000000000000000000" & imm;
	
	end if;
end process;

end Behavioral;
----------------------------------------------------------------------------------