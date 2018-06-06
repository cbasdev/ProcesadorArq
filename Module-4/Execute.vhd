
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Execute is
    Port ( Op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           AluOP : in  STD_LOGIC_VECTOR (5 downto 0);
           --wrenmem : in  STD_LOGIC;
			  --outwrenmem : out  STD_LOGIC;
           --rfsource : in  STD_LOGIC_VECTOR (1 downto 0);
			  --outrfsource : out  STD_LOGIC_VECTOR (1 downto 0);
           --pc : in  STD_LOGIC_VECTOR (31 downto 0);
			  --outpc : out  STD_LOGIC_VECTOR (31 downto 0);
           nCWP : in  STD_LOGIC_VECTOR (4 downto 0);
           AluR : out  STD_LOGIC_VECTOR (31 downto 0);
           --cRd : in  STD_LOGIC_VECTOR (31 downto 0);
			  --outcRd : out  STD_LOGIC_VECTOR (31 downto 0);
           CWP : out  STD_LOGIC_VECTOR (4 downto 0);
           icc : out  STD_LOGIC_VECTOR (3 downto 0);
			  clk : in std_logic;
			  rst : in std_logic);
end Execute;



architecture Behavioral of Execute is

component ALU is
    Port ( CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           CRS2mux : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           C : in  STD_LOGIC;
           ALURESULT : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component PSR_modifier is
    Port ( ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           RESULT : in  STD_LOGIC_VECTOR (31 downto 0);
           RS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (31 downto 0);
           NZVC : out  STD_LOGIC_VECTOR (3 downto 0) := "0000");
end component;

component psr is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           ncwp : in  STD_LOGIC_VECTOR (4 downto 0);
           cwp : out  STD_LOGIC_VECTOR (4 downto 0);
           c : out  STD_LOGIC;
			  icc : out std_logic_vector (3 downto 0));
end component;

signal sAluR: std_logic_vector(31 downto 0);
signal sNZVC: std_logic_vector(3 downto 0);
signal sCarry: std_logic;





begin

	Inst_ALU: ALU PORT MAP(
		CRS1 => Op1,
		CRS2mux => Op2,
		ALUOP => AluOp,
		C => sCarry,
		ALURESULT => sAluR 
	);
	
	Inst_PSR_modifier: PSR_modifier PORT MAP(
		ALUOP => AluOp,
		RESULT => sAluR,
		RS1 => Op1,
		RS2 => Op2,
		NZVC => sNZVC
	);
	
	Inst_psr: psr PORT MAP(
		clk => clk,
		rst => rst,
		nzvc => sNZVC,
		ncwp => nCWP,
		cwp => CWP,
		c => sCarry,
		icc => icc
	);
	

	alur <= sAluR;
--	outwrenmem <= wrenmem;
	--outpc <= pc;
	--outCrd <= Crd;
	--outrfsource <= rfsource;


end Behavioral;

