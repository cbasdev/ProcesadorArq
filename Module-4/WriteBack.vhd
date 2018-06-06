
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity WriteBack is
    Port ( pc : in  STD_LOGIC_VECTOR (31 downto 0);
           datatomem : in  STD_LOGIC_VECTOR (31 downto 0);
           aluads : in  STD_LOGIC_VECTOR (31 downto 0);
           rfsource : in  STD_LOGIC_VECTOR (1 downto 0);
           datatores : out  STD_LOGIC_VECTOR (31 downto 0));
end WriteBack;

 architecture Behavioral of WriteBack is

	COMPONENT muxDM
	PORT(
		datatomem : IN std_logic_vector(31 downto 0);
		aluresult : IN std_logic_vector(31 downto 0);
		pc : IN std_logic_vector(31 downto 0);
		RFsource : IN std_logic_vector(1 downto 0);          
		DtoWrite : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

begin

Inst_muxDM: muxDM PORT MAP(
		datatomem => datatomem,
		aluresult => aluads,
		pc => pc,
		RFsource => rfsource,
		DtoWrite => datatores
	);

end Behavioral;

