----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

----------------------------------------------------------------------------------

entity Sumador_Completo is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           C : out  STD_LOGIC_VECTOR (31 downto 0));
end Sumador_Completo;

----------------------------------------------------------------------------------

architecture Behavioral of Sumador_Completo is

----------------------------------------------------------------------------------

begin

	PROCESS (A, B) IS --- 
       BEGIN
         C <= std_logic_vector(UNSIGNED(A) + UNSIGNED(B));
       END PROCESS;

end Behavioral;

