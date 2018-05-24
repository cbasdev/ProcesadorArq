----------------------------------------------------------------------------------
-- Create by Leonardo Castrillón Giraldo / UTP
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Data_Memory is
    Port ( Address : in  STD_LOGIC_VECTOR (31 downto 0);
           WriteData : in  STD_LOGIC_VECTOR (31 downto 0);
           MemRead : in  STD_LOGIC;
           MemWrite : in  STD_LOGIC;
           ReadData : out  STD_LOGIC_VECTOR (31 downto 0));
end Data_Memory;

architecture Behavioral of Data_Memory is

	type ram_type is array (0 to 39) of std_logic_vector (31 downto 0);
	signal DM : ram_type :=( others => x"00000000"); -- asumimos que empeiza en 0x100010000


begin

	process(MemWrite,MemRead)
	begin
		-- 268500992 es x100010000
		if( MemWrite = '1') then
			DM (to_integer(unsigned(Address)) /4) <= WriteData;
			end if;
			
		if (MemRead = '1') then
			ReadData <= DM ((to_integer(unsigned(Address))) /4);
			end if;

	end process;
end Behavioral;

