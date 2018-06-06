
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity muxPC is
    Port ( disp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           disp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           pc : in  STD_LOGIC_VECTOR (31 downto 0);
           aluresult : in  STD_LOGIC_VECTOR (31 downto 0);
           pcsource : in  STD_LOGIC_VECTOR (1 downto 0);
           outNPC : out  STD_LOGIC_VECTOR (31 downto 0));
end muxPC;

architecture Behavioral of muxPC is

begin
process(disp30,disp22,pc,aluresult,pcsource)
begin
	   case (pcsource) is 
      when "00" =>
         outNPC<=disp30;
      when "01" =>
         outNPC<=disp22;
      when "10" =>
         outNPC<=pc;
      when "11" =>
         outNPC<=aluresult;
      when others =>
         outNPC<="00000000000000000000000000000000";
   end case;

end process;
end Behavioral;

