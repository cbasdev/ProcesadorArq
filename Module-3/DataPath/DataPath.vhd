library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;



entity Datapath is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC);
end Datapath;

architecture Behavioral of Datapath is

	COMPONENT regis
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		datain : IN std_logic_vector(31 downto 0);          
		dataout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT sumador32bits
	PORT(
		datainA : IN std_logic_vector(31 downto 0);
		datainB : IN std_logic_vector(31 downto 0);          
		Salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT SEUdisp22
	PORT(
		disp22 : IN std_logic_vector(21 downto 0);          
		extdisp22 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT SEUdisp30
	PORT(
		disp30 : IN std_logic_vector(29 downto 0);          
		extdisp30 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT windowsManager
	PORT(
		RS1 : IN std_logic_vector(4 downto 0);
		RS2 : IN std_logic_vector(4 downto 0);
		RD : IN std_logic_vector(4 downto 0);
		OP : IN std_logic_vector(1 downto 0);
		OP3 : IN std_logic_vector(5 downto 0);
		CWP : IN std_logic_vector(4 downto 0);          
		NCWP : OUT std_logic_vector(4 downto 0);
		NRS1 : OUT std_logic_vector(5 downto 0);
		NRS2 : OUT std_logic_vector(5 downto 0);
		NRD : OUT std_logic_vector(5 downto 0);
		Ro7 : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT psr
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		nzvc : IN std_logic_vector(3 downto 0);
		ncwp : IN std_logic_vector(4 downto 0);          
		cwp : OUT std_logic_vector(4 downto 0);
		c : OUT std_logic;
		icc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT muxCall
	PORT(
		Rd : IN std_logic_vector(5 downto 0);
		callrd : IN std_logic_vector(5 downto 0);
		rfdest : IN std_logic;          
		NRD : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

	COMPONENT SEU
	PORT(
		imm13 : IN std_logic_vector(12 downto 0);          
		seuout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT RegisterFile
	PORT(
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0);
		WE : IN std_logic;
		DtoWrite : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		crs1 : OUT std_logic_vector(31 downto 0);
		crs2 : OUT std_logic_vector(31 downto 0);
		cRD : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


	COMPONENT mux01
	PORT(
		crs2 : IN std_logic_vector(31 downto 0);
		i : IN std_logic;
		seuin : IN std_logic_vector(31 downto 0);          
		muxout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT ALU
	PORT(
		CRS1 : IN std_logic_vector(31 downto 0);
		CRS2mux : IN std_logic_vector(31 downto 0);
		ALUOP : IN std_logic_vector(5 downto 0);
		C : IN std_logic;          
		ALURESULT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT PSR_modifier
	PORT(
		ALUOP : IN std_logic_vector(5 downto 0);
		RESULT : IN std_logic_vector(31 downto 0);
		RS1 : IN std_logic_vector(31 downto 0);
		RS2 : IN std_logic_vector(31 downto 0);          
		NZVC : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	COMPONENT DataMemory
	PORT(
		cRD : IN std_logic_vector(31 downto 0);
		aluAddress : IN std_logic_vector(31 downto 0);
		wrenmem : IN std_logic;          
		datatomem : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT muxDM
	PORT(
		datatomem : IN std_logic_vector(31 downto 0);
		aluresult : IN std_logic_vector(31 downto 0);
		pc : IN std_logic_vector(31 downto 0);
		RFsource : IN std_logic_vector(1 downto 0);          
		DtoWrite : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT muxPC
	PORT(
		disp30 : IN std_logic_vector(31 downto 0);
		disp22 : IN std_logic_vector(31 downto 0);
		pc : IN std_logic_vector(31 downto 0);
		aluresult : IN std_logic_vector(31 downto 0);
		pcsource : IN std_logic_vector(1 downto 0);          
		outNPC : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	

	COMPONENT ControUnit
	PORT(
		ICC : IN std_logic_vector(3 downto 0);
		OP3 : IN std_logic_vector(5 downto 0);
		OP : IN std_logic_vector(1 downto 0);
		OP2 : IN std_logic_vector(2 downto 0);
		COND : IN std_logic_vector(3 downto 0);          
		WE : OUT std_logic;
		WEDM : OUT std_logic;
		RFSOURCE : OUT std_logic_vector(1 downto 0);
		RFDEST : OUT std_logic;
		PCSOURCE : OUT std_logic_vector(1 downto 0);
		ALUOP : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

	


signal aux_npcpc: std_logic_vector(31 downto 0);
signal aux_pc: std_logic_vector(31 downto 0);
signal aux_muxpc : std_logic_vector(31 downto 0);
signal aux_muxsumpc: std_logic_vector(31 downto 0);
signal aux_muxsumdisp22: std_logic_vector(31 downto 0);
signal aux_muxsumdisp30: std_logic_vector(31 downto 0);
signal aux_outseudips30: std_logic_vector(31 downto 0);
signal aux_outseudisp22: std_logic_vector(31 downto 0);
signal aux_instruction  : std_logic_vector(31 downto 0);
signal aux_cwp : std_logic_vector(4 downto 0);
signal aux_ncwp : std_logic_vector(4 downto 0);
signal aux_nRS1 : std_logic_vector(5 downto 0);
signal aux_nRS2 : std_logic_vector(5 downto 0);
signal aux_RD : std_logic_vector(5 downto 0);
signal aux_Ro7 : std_logic_vector(5 downto 0);
signal aux_carry: std_logic;
signal aux_nzvc:std_logic_vector(3 downto 0);
signal aux_icc:std_logic_vector(3 downto 0);
signal aux_NRD:std_logic_vector(5 downto 0);
signal aux_seuoutinstruction: std_logic_vector(31 downto 0);
signal aux_DtoWrite: std_logic_vector(31 downto 0);
signal aux_cRS1: std_logic_vector(31 downto 0);
signal aux_cRS2: std_logic_vector(31 downto 0);
signal aux_cRD: std_logic_vector(31 downto 0);
signal aux_OPerando2: std_logic_vector(31 downto 0);
signal aux_ALURESULT: std_logic_vector(31 downto 0);
signal aux_datatomem: std_logic_vector(31 downto 0);
--signal aux_
--signal aux_
--signal aux_


--salidas unite control
signal aux_RFDEST:std_logic;
signal aux_RFSOURCE:std_logic_vector(1 downto 0);
signal aux_WEDM:std_logic;
signal aux_WE:std_logic;
signal aux_PCSOURCE:std_logic_vector(1 downto 0);
signal aux_ALUOP:std_logic_vector(5 downto 0);

begin

	Inst_ControUnit: ControUnit PORT MAP(
		ICC => aux_icc,
		OP3 => aux_instruction(24 downto 19 ),
		OP => aux_instruction( 31 downto 30 ),
		OP2 => aux_instruction(24 downto 22),
		COND => aux_instruction (28 downto 25),
		WE => aux_WE,
		WEDM => aux_WEDM,
		RFSOURCE => aux_RFSOURCE,
		RFDEST => aux_RFDEST,
		PCSOURCE => aux_PCSOURCE,
		ALUOP => aux_ALUOP
	);
	
	
	Inst_muxPC: muxPC PORT MAP(
		disp30 => aux_muxsumdisp30,
		disp22 => aux_muxsumdisp22,
		pc => aux_muxsumpc,
		aluresult => aux_ALURESULT,
		pcsource => aux_PCSOURCE,
		outNPC => aux_muxpc
	);	
	
	Inst_muxDM: muxDM PORT MAP(
		datatomem => aux_datatomem,
		aluresult => aux_ALURESULT,
		pc => aux_pc,
		RFsource => aux_RFSOURCE,
		DtoWrite => aux_DtoWrite
	);


	Inst_DataMemory: DataMemory PORT MAP(
		cRD => aux_cRD ,
		aluAddress =>aux_ALURESULT ,
		wrenmem => aux_WEDM,
		datatomem => aux_datatomem
	);

	Inst_PSR_modifier: PSR_modifier PORT MAP(
		ALUOP => aux_ALUOP,
		RESULT => aux_ALURESULT,
		RS1 => aux_cRS1,
		RS2 => aux_OPerando2,
		NZVC => aux_nzvc
	);

	Inst_ALU: ALU PORT MAP(
		CRS1 => aux_cRS1 ,
		CRS2mux => aux_OPerando2,
		ALUOP => aux_ALUOP,
		C => aux_carry,
		ALURESULT => aux_ALURESULT
	);	

	Inst_mux01: mux01 PORT MAP(
		crs2 => aux_cRS2,
		i => aux_instruction(13),
		seuin => aux_seuoutinstruction,
		muxout => aux_OPerando2
	);	
	
	Inst_RegisterFile: RegisterFile PORT MAP(
		rs1 => aux_nRS1,
		rs2 => aux_nRS2,
		rd => aux_NRD,
		WE => aux_WE,
		DtoWrite => aux_DtoWrite ,
		rst => rst,
		crs1 => aux_cRS1,
		crs2 => aux_cRS2,
		cRD => aux_cRD
	);	

	Inst_SEU: SEU PORT MAP(
		imm13 => aux_instruction(12 downto 0) ,
		seuout => aux_seuoutinstruction
	);
	
	
	Inst_muxCall: muxCall PORT MAP(
		Rd => aux_RD,
		callrd => aux_Ro7,
		rfdest => aux_RFDEST,
		NRD => aux_NRD
	);

	Inst_psr: psr PORT MAP(
		clk => clk,
		rst => rst,
		nzvc => aux_nzvc,
		ncwp => aux_ncwp,
		cwp => aux_cwp,
		c => aux_carry,
		icc => aux_icc
	);

	Inst_WManager: windowsManager PORT MAP(
		RS1 => aux_instruction(18 downto 14),
		RS2 => aux_instruction(4 downto 0),
		RD => aux_instruction(29 downto 25),
		OP => aux_instruction(31 downto 30),
		OP3 => aux_instruction(24 downto 19),
		CWP =>aux_cwp ,
		NCWP => aux_ncwp,
		NRS1 => aux_nRS1,
		NRS2 => aux_nRS2,
		NRD => aux_RD,
		Ro7 => aux_Ro7
	);

	Inst_SEUdisp30: SEUdisp30 PORT MAP(
		disp30 =>aux_instruction(29 downto 0) ,
		extdisp30 => aux_outseudips30
	);


	Inst_SEUdisp22: SEUdisp22 PORT MAP(
		disp22 => aux_instruction(21 downto 0),
		extdisp22 => aux_outseudisp22
	);

	Inst_IM: instructionMemory PORT MAP(
		address => aux_pc,
		reset =>RST ,
		outInstruction => aux_instruction
	);

	Inst_sumpc: sumador32bits PORT MAP(
		datainA => "00000000000000000000000000000001" ,
		datainB => aux_npcpc,
		Salida => aux_muxsumpc
	);
	
	
	Inst_sumdisp22: sumador32bits PORT MAP(
		datainA => aux_pc,
		datainB => aux_outseudisp22,
		Salida => aux_muxsumdisp22
	);
	
	Inst_sumdisp30: sumador32bits PORT MAP(
		datainA => aux_outseudips30,
		datainB => aux_pc ,
		Salida => aux_muxsumdisp30
	);
	
	
	Inst_npc: regis PORT MAP(
		clk => CLK,
		rst => RST,
		datain =>aux_muxpc ,
		dataout => aux_npcpc
	);
	
	Inst_pc: regis PORT MAP(
		clk => CLK,
		rst => RST,
		datain => aux_npcpc,
		dataout => aux_pc
	);


end Behavioral;

