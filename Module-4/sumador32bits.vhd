
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity sumador32bits is
    Port ( datainA : in  STD_LOGIC_VECTOR (31 downto 0);
           datainB : in  STD_LOGIC_VECTOR (31 downto 0);
           Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end sumador32bits;

architecture Behavioral of sumador32bits is

begin

Salida <= (datainA + datainB);
end Behavioral;

