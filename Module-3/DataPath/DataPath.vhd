----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
----------------------------------------------------------------------------------

entity DataPath is
    Port ( CLK_D : in  STD_LOGIC;
           RST_D : in  STD_LOGIC;
			  NZVC_D : out STD_LOGIC_VECTOR(3 downto 0);
           DataPathOut : out  STD_LOGIC_VECTOR (31 downto 0));
end DataPath;

----------------------------------------------------------------------------------

architecture Behavioral of DataPath is


--- Integrando los otros modulos
	COMPONENT ProgramCounter
	PORT(
		address : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;
		clk : IN std_logic;          
		pc_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	 
	
	COMPONENT Sumador_Completo
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);          
		C : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
 
	COMPONENT SingExtension
	PORT(
		imm : IN std_logic_vector(12 downto 0);          
		se_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT ControlUnit
	PORT(
		OP : IN std_logic_vector(1 downto 0);
		OP3 : IN std_logic_vector(5 downto 0);          
		OP_Alu : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;


	COMPONENT RegisterFile
	PORT(
		RS1 : IN std_logic_vector(5 downto 0);
		RS2 : IN std_logic_vector(5 downto 0);
		RD : IN std_logic_vector(5 downto 0);
		DWR : IN std_logic_vector(31 downto 0);
		RST : IN std_logic;          
		CRS1 : OUT std_logic_vector(31 downto 0);
		CRS2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MUX
	PORT(
		CRS2 : IN std_logic_vector(31 downto 0);
		SE_OUT : IN std_logic_vector(31 downto 0);
		I : IN std_logic;          
		MUX_OUT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ALU
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		OP : IN std_logic_vector(5 downto 0);  
		CARRY: IN std_logic;
		RESULT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT PSR
   Port ( 
		clk : in std_logic;
		rst : in std_logic;
		nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
      ncwp : in  STD_LOGIC;
      cwp : out  STD_LOGIC;
      c : out  STD_LOGIC
		);
	END COMPONENT;
	
	component PSR_Modifier 
    Port ( 
		RST : in  STD_LOGIC;
      CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
      MUXOut : in  STD_LOGIC_VECTOR (31 downto 0);
      ALUOut : in  STD_LOGIC_VECTOR (5 downto 0);
      Result : in  STD_LOGIC_VECTOR (31 downto 0);
      NZVC : out  STD_LOGIC_VECTOR (3 downto 0)
		);
		
	END COMPONENT;
	
	COMPONENT Wmanager
    Port ( 
		Rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
      Rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
      Rd : in  STD_LOGIC_VECTOR (4 downto 0);
      Op : in  STD_LOGIC_VECTOR (1 downto 0);
      Op3 : in  STD_LOGIC_VECTOR (5 downto 0);
      Cwp : in  STD_LOGIC;
      nRs1 : out  STD_LOGIC_VECTOR (5 downto 0);
      nRs2 : out  STD_LOGIC_VECTOR (5 downto 0);
      nRd : out  STD_LOGIC_VECTOR (5 downto 0);
      nCwp : out  STD_LOGIC
		);
	END COMPONENT;
	
----------------------------------------------------------------------------------
signal aux: std_logic_vector(31 downto 0):="00000000000000000000000000000001";
signal npc_out: STD_LOGIC_VECTOR (31 downto 0);
signal C_s: STD_LOGIC_VECTOR (31 downto 0);
signal pc_out_s: STD_LOGIC_VECTOR (31 downto 0);
signal outIM_s: STD_LOGIC_VECTOR (31 downto 0); --- base de todo
signal SEU_s: STD_LOGIC_VECTOR(31 downto 0);
signal UC_s: STD_LOGIC_VECTOR(5 downto 0);

signal CRS1_s: STD_LOGIC_VECTOR(31 downto 0);
signal CRS2_s: STD_LOGIC_VECTOR(31 downto 0);
signal RESULT_s: STD_LOGIC_VECTOR(31 downto 0);
signal WMOut: STD_LOGIC;
signal NZVCs: STD_LOGIC_VECTOR(3 downto 0);
signal C_ALU: STD_LOGIC := '1';
signal CWP_WM: STD_LOGIC;

--por ahora no modificar el rf

signal CRS1s: STD_LOGIC_VECTOR(31 downto 0);
signal MUXOuts: STD_LOGIC_VECTOR(31 downto 0);
signal ALUOPs: STD_LOGIC_VECTOR(5 downto 0);

signal nRs1s: STD_LOGIC_VECTOR(5 downto 0);
signal nRs2s: STD_LOGIC_VECTOR(5 downto 0);
signal nRds: STD_LOGIC_VECTOR(5 downto 0);

signal MUX_s: STD_LOGIC_VECTOR(31 downto 0);

----------------------------------------------------------------------------------

begin
-- instanciando el ProgramCounter

Sum: Sumador_Completo PORT MAP(
								A => aux,
								B => npc_out,
								C => C_s
								);
			
nPC: ProgramCounter port map(
								address => C_s,
								rst => RST_D,
								clk => CLK_D,
								pc_out => npc_out
								);
								
PC: ProgramCounter port map(
								address => npc_out,
								rst => RST_D,
								clk => CLK_D,
								pc_out => pc_out_s
								);
								
IM: instructionMemory PORT MAP(
								address => pc_out_s,
								reset => RST_D,
								outInstruction => outIM_s
								);

UC: ControlUnit PORT MAP(
								OP => outIM_s(31 downto 30),
								OP3 => outIM_s(24 downto 19),
								OP_Alu => UC_s
								);
WM: Wmanager port map(
								Rs1 => outIM_s(18 downto 14),
								Rs2 => outIM_s(4 downto 0),
								Rd => outIM_s(29 downto 25),
								Op => outIM_s(31 downto 30),
								Op3 => outIM_s(24 downto 19),
								Cwp => CWP_WM,
								nRs1 => nRs1s,
								nRs2 => nRs2s,
								nRd => nRds,
								nCwp => WMOut
								);



PSR_M: PSR_Modifier port map (
								RST => RST_D,
								CRS1 => CRS1s,
								MUXOut => MUXOuts,
								Result => RESULT_s,
								ALUOut => UC_s,
								NZVC => NZVCs
								);
	 
PSR0: PSR port map(
								ncwp => WMOut,
								nzvc => NZVCs,
								rst => RST_D,
								clk => CLK_D,
								c => C_ALU,
								cwp => CWP_WM	
								);

RF: RegisterFile PORT MAP(
								RS1 => nRS1s,
								RS2 => nRS2s,
								RD => nRDs,
								DWR => RESULT_s,
								RST => RST_D,
								CRS1 => CRS1_s,
								CRS2 => CRS2_s
								);							
SEU: SingExtension port map(
								imm => outIM_s(12 downto 0),
								se_out => SEU_s
								);






MUX0: MUX PORT MAP(
								CRS2 => CRS2_s,
								SE_OUT => SEU_s,
								I => outIM_s(13),
								MUX_OUT => MUX_s
								);

ALU0: ALU PORT MAP(
								A => CRS1_s,
								B => MUX_s,
								OP => UC_s,
								CARRY =>C_ALU,
								RESULT => RESULT_s
								);
NZVC_D <= NZVCs;
DataPathOut <= RESULT_s;

end Behavioral;
----------------------------------------------------------------------------------

