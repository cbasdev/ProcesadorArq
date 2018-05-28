-----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-----------------------------------------------------------------------------------


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
	process (A, B, OP, CARRY)
		begin 
		
			case (OP) is
				when "000000" => ---ADD
					RESULT <= A + B;
				when "010000" => ---ADDcc
					RESULT <= A + B;
				when "011000"=> ---ADDXcc
					RESULT <= A + B + CARRY;
				when "001000"=> ---ADDX
					RESULT <= A + B + CARRY;
				when "000100" => ---SUB
					RESULT <= A - B;
				when "010100" => ---SUBcc
					RESULT <= A - B;
				when "001100" => ---SUBX
					RESULT <= A - B - CARRY;
				when "011100" => ---SUBXcc
					RESULT <= A - B - CARRY;					
				when "000001" =>---AND
					RESULT <= A and B;
				when "010001" =>---ANDcc
					RESULT <= A and B;					
				when "000101" =>---ANDN
					RESULT <= A and not B;
				when "010101" =>---ANDNcc
					RESULT <= A and not B;					
				when "000010" =>--- OR
					RESULT <= A or B;
				when "010010" =>--- ORcc
					RESULT <= A or B;					
				when "000110" => ---ORN
					RESULT <= A or not B;
				when "010110" => ---ORNcc
					RESULT <= A or not B;					
				when "000011" => ---XOR
					RESULT <= A xor B;
				when "010011" => ---XORcc
					RESULT <= A xor B;					
				when "000111" => ---XORN 
					RESULT <= A xor not B;
				when "010111" => ---XORNcc 
					RESULT <= A xor not B;	
----------------------------------------------------
				when "111100" => -- save 
					RESULT <= A - B;
				when "111101" => -- restore0 
					RESULT <= A + B;
----------------------------------------------------					
				when others =>
					RESULT <= "00000000000000000000000000000000";
			end case;
	end process;
end Behavioral;

----------------------------------------------------------------------------------
