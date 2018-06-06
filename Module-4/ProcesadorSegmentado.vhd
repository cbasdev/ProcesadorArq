
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


 
entity ProcesadorSegmentado is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           datatoWrite : out  STD_LOGIC_VECTOR (31 downto 0));
end ProcesadorSegmentado;

architecture Behavioral of ProcesadorSegmentado is

	COMPONENT InstructionFetch
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		npc : IN std_logic_vector(31 downto 0);          
		instructionM : OUT std_logic_vector(31 downto 0);
		outSumador : OUT std_logic_vector(31 downto 0);
		pcO : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
		COMPONENT Control
	PORT(
		pcIN : IN std_logic_vector(31 downto 0);
		npcIN : IN std_logic_vector(31 downto 0);
		iccIN : IN std_logic_vector(3 downto 0);
		instruction : IN std_logic_vector(31 downto 0);
		aluResultIN : IN std_logic_vector(31 downto 0);          
		rfDestOUT : OUT std_logic;
		rfSourceOUT : OUT std_logic_vector(1 downto 0);
		wrEnMemOUT : OUT std_logic;
		wrEnRegisOUT : OUT std_logic;
		aluOpOUT : OUT std_logic_vector(5 downto 0);
		npcOUT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT R1
	PORT(
		clk : IN std_logic;
		Rin : IN std_logic_vector(74 downto 0);
		rst : IN std_logic;          
		Rout : OUT std_logic_vector(74 downto 0)
		);
	END COMPONENT;
	


	COMPONENT InstructionDecode
	PORT(
		rd6 : IN std_logic_vector(5 downto 0);
		ro7 : IN std_logic_vector(5 downto 0);
		rfdest : IN std_logic;
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		cwp : IN std_logic_vector(4 downto 0);
		imm13 : IN std_logic_vector(12 downto 0);
		i : IN std_logic;
		we : IN std_logic;
		dtowrite : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		ncwp : OUT std_logic_vector(4 downto 0);
		op2_crs2 : OUT std_logic_vector(31 downto 0);
		crs1 : OUT std_logic_vector(31 downto 0);
		crd : OUT std_logic_vector(31 downto 0);
		rdsave : OUT std_logic_vector(5 downto 0);
		ro7save : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;







	COMPONENT Execute
	PORT(
		Op1 : IN std_logic_vector(31 downto 0);
		Op2 : IN std_logic_vector(31 downto 0);
		AluOP : IN std_logic_vector(5 downto 0);
		nCWP : IN std_logic_vector(4 downto 0);
		clk : IN std_logic;
		rst : IN std_logic;          
		AluR : OUT std_logic_vector(31 downto 0);
		CWP : OUT std_logic_vector(4 downto 0);
		icc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;






	COMPONENT R2
	PORT(
		clk : IN std_logic;
		Rin : IN std_logic_vector(155 downto 0);
		rst : IN std_logic;          
		Rout : OUT std_logic_vector(155 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT R3
	PORT(
		clk : IN std_logic;
		Rin : IN std_logic_vector(112 downto 0);
		rst : IN std_logic;          
		Rout : OUT std_logic_vector(112 downto 0)
		);
	END COMPONENT;


	COMPONENT Memory
	PORT(
		we : IN std_logic;
		address : IN std_logic_vector(31 downto 0);
		crd : IN std_logic_vector(31 downto 0);          
		Datatomem : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT R4
	PORT(
		clk : IN std_logic;
		Rin : IN std_logic_vector(111 downto 0);
		rst : IN std_logic;          
		Rout : OUT std_logic_vector(111 downto 0)
		);
	END COMPONENT;



	COMPONENT WriteBack
	PORT(
		pc : IN std_logic_vector(31 downto 0);
		datatomem : IN std_logic_vector(31 downto 0);
		aluads : IN std_logic_vector(31 downto 0);
		rfsource : IN std_logic_vector(1 downto 0);          
		datatores : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;








--señales:

signal snpcout: std_logic_vector(31 downto 0);
signal sInstruction: std_logic_vector(31 downto 0);
signal snpc1: std_logic_vector(31 downto 0);
signal sPC: std_logic_vector(31 downto 0);
signal sICC: std_logic_vector(3 downto 0);
signal sALUR: std_logic_vector(31 downto 0);
signal sRFDEST: std_logic;
signal sRFSOURCE: std_logic_vector(1 downto 0);
signal sWRENMEM: std_logic;
signal sWRENREGIS: std_logic;
signal sALUOP: std_logic_vector(5 downto 0);
signal sR1: std_logic_vector(74 downto 0);
signal sCWP: std_logic_vector(4 downto 0);
signal sDataToWrite: std_logic_vector(31 downto 0);
signal sNCWP: std_logic_vector(4 downto 0);
signal sOP1: std_logic_vector(31 downto 0);
signal sOP2: std_logic_vector(31 downto 0);
signal sCRD: std_logic_vector(31 downto 0);
signal sR2: std_logic_vector(155 downto 0);
signal sR3: std_logic_vector(112 downto 0);
signal sDataToMem: std_logic_vector(31 downto 0);
signal sR4: std_logic_vector(111 downto 0);
signal sRDSAVE: std_logic_vector(5 downto 0);
signal sRO7SAVE: std_logic_vector(5 downto 0);



--señales de prueba
signal sRin: std_logic_vector(74 downto 0);
signal sRin2: std_logic_vector(155 downto 0);
signal sRin3: std_logic_vector(112 downto 0);
signal sRin4: std_logic_vector(111 downto 0);

begin

	Inst_InstructionFetch: InstructionFetch PORT MAP(
		clk => clk,
		rst => rst,
		npc => snpcout,
		instructionM => sInstruction,
		outSumador => snpc1,
		pcO => sPC
	);
	
	Inst_Control: Control PORT MAP(
		pcIN => sPC,
		npcIN => snpc1,
		iccIN => sICC,
		instruction => sInstruction,
		aluResultIN => sALUR,
		rfDestOUT => sRFDEST,
		rfSourceOUT => sRFSOURCE,
		wrEnMemOUT => sWRENMEM,
		wrEnRegisOUT => sWRENREGIS,
		aluOpOUT => sALUOP,
		npcOUT => snpcout
	);
	
sRin <= sInstruction & sRFDEST & sRFSOURCE & sWRENMEM & sALUOP & sWRENREGIS & sPC;
	Inst_R1: R1 PORT MAP(
		clk => clk,
		Rin => sRin,
		rst => rst,
		Rout => sR1
	);
	


	
	
	Inst_InstructionDecode: InstructionDecode PORT MAP(
		rd6 => sR4(104 downto 99),
		ro7 => sR4(110 downto 105),
		rfdest => sR4(111),
		rs1 => SR1(61 downto 57),
		rs2 => sR1(47 downto 43),
		rd => sR1(72 downto 68),
		op => sR1(74 downto 73),
		op3 => sR1(67 downto 62),
		cwp => sCWP,
		imm13 => sR1(55 downto 43),
		i => sR1(56),
		we => sR1(32),
		dtowrite => sDataToWrite,
		rst => rst,
		ncwp => sNCWP,
		op2_crs2 => sOP2,
		crs1 => sOP1,
		crd => sCRD,
		rdsave => sRDSAVE,
		ro7save => sRO7SAVE
	);
	
sRin2 <= sR1(42) & sRO7SAVE & sRDSAVE & sOP1 & sOP2 & sR1(38 downto 33) & sR1(39) & sR1(41 downto 40) & sR1(31 downto 0) & sNCWP & sCRD & SR1(32);
	Inst_R2: R2 PORT MAP(
		clk => clk,
		Rin => sRin2,
		Rout => sR2,
		rst => rst
	);
	
	
	Inst_Execute: Execute PORT MAP(
		Op1 => sR2(142 downto 111),
		Op2 => sR2(110 downto 79),
		AluOP => sR2(78 downto 73),
		nCWP => sNCWP,--sR2(37 downto 33),-- NOTA: Pensar si el ALUR se debe registrar hasta el final
		AluR => sALUR,
		CWP => sCWP,
		icc => sICC,
		clk => clk,
		rst => rst
	);


sRin3 <= sR2(155) & sR2(154 downto 149) & sR2(148 downto 143) & sR2(72) & sR2(69 downto 38) & sALUR & sR2(32 downto 1) & sR2(71 downto 70) & sR2(0);

	Inst_R3: R3 PORT MAP(
		clk => clk,
		Rin => sRin3,
		rst => rst,
		Rout => sR3
	);
	
	Inst_Memory: Memory PORT MAP(
		we => sR3(99),
		address => sR3(66 downto 35),
		crd => sR3(34 downto 3),
		Datatomem => sDataToMem
	);
	
sRin4 <= sR3(112) & sR3(111 downto 106) & sR3(105 downto 100) & sR3(98 downto 67) & sDataToMem & sR3(66 downto 35) & sR3(2 downto 1) & sR3(0);

	Inst_R4: R4 PORT MAP(
		clk => clk,
		Rin => sRin4,
		rst => rst,
		Rout => sR4
	);

	Inst_WriteBack: WriteBack PORT MAP(
		pc => sR4(98 downto 67),
		datatomem => sR4(66 downto 35),
		aluads => sR4(34 downto 3),
		rfsource => sR4(2 downto 1),
		datatores => sDataToWrite
	);

datatoWrite <= sDataToWrite;

end Behavioral;

