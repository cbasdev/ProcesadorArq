library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Wmanager is
    Port ( 
	 
			  Rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Rd  : in  STD_LOGIC_VECTOR (4 downto 0);
           Op  : in  STD_LOGIC_VECTOR (1 downto 0);
           Op3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  
           Cwp : in  STD_LOGIC;
			  
		     nCwp: out std_logic;
           nRs1: out  STD_LOGIC_VECTOR (5 downto 0);
           nRs2: out  STD_LOGIC_VECTOR (5 downto 0);
           nRd : out  STD_LOGIC_VECTOR (5 downto 0)
			  
			  );
			  
end Wmanager;

architecture Behavioral of Wmanager is
begin
     process(Rs1,Rs2,Rd,Op,Op3,Cwp)
     begin 
         
			if(Op ="10" and Op3 ="111100") then   --SAVE 
			     nCwp <='0';
         elsif(Op = "10" and Op3 ="111101") then  --RESTORE
              nCwp <='1';
         end if;
			
			--Rs1
			if(Rs1 >= "10000" and Rs1 <="10111") then 
                nRs1 <= conv_std_logic_vector(( conv_integer(Rs1) + conv_integer(Cwp) * 16),6);  --local 			
			
			elsif(Rs1 >= "11000" and Rs1 <= "11111") then
                nRs1 <= conv_std_logic_vector(( conv_integer(Rs1) - conv_integer(Cwp) * 16),6);  --input			
            
			elsif (Rs1 >= "01000" and Rs1 <= "01111") then
				nRs1 <=conv_std_logic_vector(( conv_integer(Rs1) + conv_integer(Cwp) * 16),6);   --output

			elsif (Rs1 >= "00000" and Rs1 <= "00111") then 
				nRs1 <= conv_std_logic_vector(( conv_integer(Rs1)),6);  
            
            end if;
 
			-- Rs2
			if (Rs2 >= "10000" and Rs2 <= "10111") then
				nRs2 <=conv_std_logic_vector(( conv_integer(Rs2) + conv_integer(Cwp) * 16),6); --local 
			
			elsif (Rs2 >= "11000" and Rs2 <= "11111") then
				nRs2 <=conv_std_logic_vector(( conv_integer(Rs2) - conv_integer(Cwp) * 16),6);  --input
			
			elsif (Rs2 >= "01000" and Rs2 <= "01111") then
				nRs2 <=conv_std_logic_vector(( conv_integer(Rs2) + conv_integer(Cwp) * 16),6);  --output
				
			elsif (Rs2 >= "00000" and Rs2 <= "00111") then 
				nRs2 <= conv_std_logic_vector(( conv_integer(Rs2)),6);	
			
			end if;
	
	
			--Rd
			if (Rd >= "10000" and Rd <= "10111") then
				nRd <= conv_std_logic_vector(( conv_integer(Rd) + conv_integer(Cwp) * 16),6);   --local 
			
			elsif (Rd >= "11000" and Rd<= "11111") then
				nRd <= conv_std_logic_vector(( conv_integer(Rd) - conv_integer(Cwp) * 16),6);   --input
			
			elsif (Rd >= "01000" and Rd <= "01111") then
				nRd <=conv_std_logic_vector(( conv_integer(Rd) + conv_integer(Cwp) * 16),6);    --output
			
			elsif (Rd >= "00000" and Rd <= "00111") then 
				nRd <= conv_std_logic_vector((conv_integer(Rd)),6);	
			end if;
			

end process;
end Behavioral;	