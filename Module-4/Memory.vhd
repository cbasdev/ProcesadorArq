
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Memory is
    Port ( we : in  STD_LOGIC;
           --pc : inout  STD_LOGIC_VECTOR (31 downto 0);
--			  pc : in  STD_LOGIC_VECTOR (31 downto 0);
--			  pcO : out  STD_LOGIC_VECTOR (31 downto 0);
           --address : inout  STD_LOGIC_VECTOR (31 downto 0);
			  address : in  STD_LOGIC_VECTOR (31 downto 0);
--			  addressO : out  STD_LOGIC_VECTOR (31 downto 0);
           crd : in  STD_LOGIC_VECTOR (31 downto 0);
           --rfsource : inout  STD_LOGIC_VECTOR (1 downto 0);
--			  rfsource : in  STD_LOGIC_VECTOR (1 downto 0);
--			  rfsourceO : out  STD_LOGIC_VECTOR (1 downto 0);
           Datatomem : out  STD_LOGIC_VECTOR (31 downto 0));
end Memory;

architecture Behavioral of Memory is

	COMPONENT DataMemory
	PORT(
		cRD : IN std_logic_vector(31 downto 0);
		aluAddress : IN std_logic_vector(31 downto 0);
		wrenmem : IN std_logic;          
		datatomem : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

begin


	Inst_DataMemory: DataMemory PORT MAP(
		cRD => crd,
		aluAddress => address,
		wrenmem => we,
		datatomem => Datatomem
	);
	
--	pcO<=pc;
--	addressO<=address;
--	rfsourceO<=rfsource;

end Behavioral;

