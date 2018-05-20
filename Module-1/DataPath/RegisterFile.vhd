
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
----------------------------------------------------------------------------------

entity RegisterFile is
    Port ( RS1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (4 downto 0);
           RD : in  STD_LOGIC_VECTOR (4 downto 0);
           DWR : in  STD_LOGIC_VECTOR (31 downto 0);
			  RST : in STD_LOGIC;
           CRS1 : out  STD_LOGIC_VECTOR (31 downto 0);
           CRS2 : out  STD_LOGIC_VECTOR (31 downto 0));
end RegisterFile;
----------------------------------------------------------------------------------

architecture Behavioral of RegisterFile is
    type ram_type is array (0 to 31) of std_logic_vector (31 downto 0);
	 
    signal RAM: ram_type:= ( others => x"00000000");
begin
		RAM(0)<=x"00000000" ;
		
    process (RS1, RS2, RD, DWR, RST, RAM)
		begin
		if  RST = '1'  then
			RAM <=( others => x"00000000");
			CRS1 <= x"00000000" ;
		   CRS2 <=x"00000000" ;
		else 
		  CRS1 <= RAM(conv_integer(RS1));
		  CRS2 <= RAM(conv_integer(RS2));
		  
		  
		  if RD /= "00000" then
				RAM(conv_integer(RD)) <= DWR;
			end if;
		end if;
		
    end process;

end Behavioral;


----------------------------------------------------------------------------------
