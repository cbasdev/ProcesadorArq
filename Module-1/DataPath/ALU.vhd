
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

----------------------------------------------------------------------------------


entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           OP : in  STD_LOGIC_VECTOR (5 downto 0);
			  CARRY: in STD_LOGIC;
           RESULT : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

----------------------------------------------------------------------------------

architecture Behavioral of ALU is
----------------------------------------------------------------------------------

begin
	process (A, B, OP)
		begin 
		
			case (OP) is
				when "000000" => ---ADD
					RESULT <= A + B;
				when "011000"=> ---ADDXcc
					RESULT <= A + B + CARRY;
				when "000100" => ---SUB
					RESULT <= A - B;
				when "000001" =>---AND
					RESULT <= A and B;
				when "000101" =>---ANDN
					RESULT <= A not(and) B;
				when "000010" =>--- OR
					RESULT <= A or B;
				when "000110" => ---ORN
					RESULT <= A not(or) B; 
				when "000011" => ---XOR
					RESULT <= A xor B;
				when "000111" => ---XORN
					RESULT <= A not(xor) B;
				when others =>
					RESULT <= "00000000000000000000000000000000";
			end case;
	end process;
end Behavioral;

----------------------------------------------------------------------------------
