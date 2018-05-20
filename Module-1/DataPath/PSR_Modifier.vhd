
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity PSR_Modifier is
    Port ( CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           MUXOut : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUOut : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           PSROut : out  STD_LOGIC_VECTOR (3 downto 0));
end PSR_Modifier;

architecture Behavioral of PSR_Modifier is

begin
	process (CRS1, MUXOut, ALUOut,ALUOp		)
		begin
			PSROut <= "0000";
			if (ALUOP="000001" or ALUOP="000011" or ALUOP="000101"or ALUOP="000111" or ALUOP="001001" or ALUOP="001011" or ALUOP="001101" or ALUOP="001111" or ALUOP="010001" or ALUOP="010011" ) then
				PSROut(3) <= ALUOut(31);
				if (ALUOut = X"00000000") then
					PSROut(2) <= '1';
				else 
					PSROut(2) <= '0';
				end if;
				if (ALUOP="000001" or ALUOP="000011") then --ADDcc / ADDXcc
					PSROut(0) <= ((CRS1(31) and MUXOut(31)) or (not ALUOut(31) and (CRS1(31) or MUXOut(31))));
					PSROut(1) <= ((CRS1(31) and MUXOut(31) and not ALUOut(31)) or (not CRS1(31) and not MUXOut(31) and ALUOut(31)));
				end if;

				if (ALUOP="000101"or ALUOP="000111") then --SUBcc / SUBXcc
					PSROut(0) <= ((not CRS1(31) and MUXOut(31)) or (ALUOut(31) and (not CRS1(31) or MUXOut(31))));
					PSROut(1) <= ((CRS1(31) and not MUXOut(31) and not ALUOut(31)) or (not CRS1(31) and MUXOut(31) and ALUOut(31)));
				end if;
			end if;
	end process;

end Behavioral;

