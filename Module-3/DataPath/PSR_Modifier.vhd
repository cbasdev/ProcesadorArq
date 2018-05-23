--problems with carryout

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity PSR_Modifier is
    Port ( RST : in  STD_LOGIC;
           CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           MUXOut : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUOut : in  STD_LOGIC_VECTOR (5 downto 0);
           Result : in  STD_LOGIC_VECTOR (31 downto 0);
           NZVC : out  STD_LOGIC_VECTOR (3 downto 0):= "0000");
end PSR_Modifier;

architecture Behavioral of PSR_Modifier is

begin
process(RST,CRS1,MUXOut,ALUOut,Result)
	begin
	
		if(RST ='1')then
			NZVC <= "0000";
		else
		
			--addcc y addxcc
			if((ALUOut="010000") or (ALUOut="011000")) then
				NZVC(3) <= Result(31);
				if(Result="00000000000000000000000000000000")then
					NZVC(2) <= '1';
				else
					NZVC(2) <= '0';
				end if;
				if((CRS1(31)='1' and MUXOut(31)='1') or (Result(31)='0' and (CRS1(31)='1' or MUXOut(31)='1')))then
					NZVC(0)<='1';
				end if;
			end if;
			
			--subcc y subxcc 
			if((ALUOut="010100") or (ALUOut="011100")) then
				NZVC(3) <= '1';
				if(Result="00000000000000000000000000000000")then
					NZVC(2) <= '1';
				else
					NZVC(2) <= '0';
				end if;
				if((CRS1(31)='1' and MUXOut(31)='0' and Result(31)='0') or (CRS1(31)='0' and MUXOut(31)='1' and Result(31)='1')) then
					NZVC(1)<='1';
				end if;
				if((CRS1(31)='0' and MUXOut(31)='1') or (Result(31)='1' and (CRS1(31)='0' or MUXOut(31)='1')))then
					NZVC(0)<='1';
				end if;
			end if;
			
			--andcc, andncc, orcc, orncc, xorcc, xnorcc
			if((ALUOut="010001") or (ALUOut="010101") or (ALUOut="010010") or (ALUOut="010110") or (ALUOut="010011") or (ALUOut="010111"))then
				NZVC(3) <='1';
				if(Result="00000000000000000000000000000000")then
					NZVC(2) <= '1';
				else
					NZVC(2) <= '0';
				end if;
				NZVC(1)<='0';
				NZVC(0)<='0';
			end if;
		end if;
end process;
end Behavioral;
