
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

----------------------------------------------------------------------------------

entity ProgramCounter is
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           pc_out : out  STD_LOGIC_VECTOR (31 downto 0));
end ProgramCounter;
----------------------------------------------------------------------------------

architecture Behavioral of ProgramCounter is

----------------------------------------------------------------------------------

begin
--- Iniciar el process con rst y clk para detectar flancos
	PROCESS (rst,clk) IS
		BEGIN 	
	if rst = '1' then
		pc_out <= x"00000000"; -- 32 bits en 0
	
	else
		if rising_edge(clk)then-- Detecta flancos de subida
			pc_out <= address;
		end if;
	end if;
end process;


end Behavioral;

