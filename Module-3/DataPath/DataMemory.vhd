library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;



entity DataMemory is
    Port ( cRD : in  STD_LOGIC_VECTOR (31 downto 0);
          aluAddress : in  STD_LOGIC_VECTOR (31 downto 0);
           wrenmem : in  STD_LOGIC;
           datatomem : out  STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture syn of DataMemory is
    type ram_type is array (0 to 63) of std_logic_vector (31 downto 0);
    signal RAM: ram_type := (others => "00000000000000000000000000000000");
begin

    process (cRD,wrenmem,aluAddress,RAM)
    begin
        --if CLK'event and CLK = '1' then
            --if EN = '1' then
                if wrenmem = '1' then
						
                    RAM(conv_integer(aluAddress)) <= cRD;
						
                end if;
					 if (aluAddress >= "00000000000000000000000000000000" and aluAddress < "00000000000000000000000001000000") then
						datatomem <= RAM(conv_integer(aluAddress)) ;
					 else
						datatomem <= RAM(0) ;
					 end if;
            --end if;
        --end if;
    end process;
	 
--	 datatomem<=RAM(conv_integer(aluAddress));
	
end syn;


