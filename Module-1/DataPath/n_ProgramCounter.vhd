
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

----------------------------------------------------------------------------------

entity n_ProgramCounter is
    Port ( n_address : in  STD_LOGIC_VECTOR (31 downto 0);
           n_rst : in  STD_LOGIC;
           n_clk : in  STD_LOGIC;
           n_pc_out : out  STD_LOGIC_VECTOR (31 downto 0));
end n_ProgramCounter;
----------------------------------------------------------------------------------

architecture Behavioral of n_ProgramCounter is

----------------------------------------------------------------------------------

begin
--- Iniciar el process con rst y clk para detectar flancos
	PROCESS (n_rst,n_clk) IS
		BEGIN 	
	if n_rst = '1' then
		n_pc_out <= x"00000000"; -- 32 bits en 0
	
	else
		if rising_edge(n_clk)then-- Detecta flancos de subida
			n_pc_out <= n_address;
		end if;
	end if;
end process;


end Behavioral;

