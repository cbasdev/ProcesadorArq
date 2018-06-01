library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;



entity RegisterFile is
    Port ( rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
			  WE: in std_logic;
           DtoWrite : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           crs2 : out  STD_LOGIC_VECTOR (31 downto 0);
			  cRD : out STD_LOGIC_VECTOR (31 downto 0));
			  
end RegisterFile;



architecture syn of RegisterFile is
    type ram_type is array (0 to 39) of std_logic_vector (31 downto 0);
    signal RAM: ram_type:= ( others => "00000000000000000000000000000000");
begin
		RAM(0)<="00000000000000000000000000000000" ;
    process (rs1, rs2, rd, dtowrite, rst,RAM, we)
		begin
		if  rst = '1'  then
		RAM <=( others => "00000000000000000000000000000000");
			crs1 <= "00000000000000000000000000000000" ;
		   crs2 <="00000000000000000000000000000000" ;
		else 
		  crs1 <= RAM(conv_integer(rs1)) ;
		  crs2 <= RAM(conv_integer(rs2))  ;
		  
			if we = '1' then
				if rd /= "00000" then
					RAM(conv_integer(rd)) <= DtoWrite;
				end if;
			end if;
			cRD <= RAM(conv_integer(rd));
		end if;
		
    end process;
	 

end syn;

