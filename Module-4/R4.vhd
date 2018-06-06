
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity R4 is
    Port ( Rin : in  STD_LOGIC_VECTOR (111 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Rout : out  STD_LOGIC_VECTOR (111 downto 0));
end R4;

architecture Behavioral of R4 is

signal registro: std_logic_vector(111 downto 0) := (others => '0');

begin

process(Rin,rst,clk)
begin
	if(rising_edge(clk)) then
		if(rst = '1') then
			registro <= (others => '0');
		else
			registro <= Rin;
		end if;
	end if;
end process;

Rout <= registro;

end Behavioral;

