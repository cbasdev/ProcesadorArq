
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity muxDM is
    Port ( datatomem : in  STD_LOGIC_VECTOR (31 downto 0);
           aluresult : in  STD_LOGIC_VECTOR (31 downto 0);
           pc : in  STD_LOGIC_VECTOR (31 downto 0);
           RFsource : in  STD_LOGIC_VECTOR (1 downto 0);
           DtoWrite : out  STD_LOGIC_VECTOR (31 downto 0));
end muxDM;

architecture Behavioral of muxDM is

begin
process(datatomem,aluresult,pc,RFsource)
begin
	   case (RFsource) is 
      when "00" =>
         DtoWrite<=datatomem;
      when "01" =>
         DtoWrite<=aluresult;
      when "10" =>
         DtoWrite<=pc;
      when others =>
         DtoWrite<="00000000000000000000000000000000";
   end case;
end process;
end Behavioral;

