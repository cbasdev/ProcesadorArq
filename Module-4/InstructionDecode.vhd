
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity InstructionDecode is
    Port ( 	rd6: in std_logic_vector(5 downto 0);
				ro7: in std_logic_vector(5 downto 0);
				rfdest: in std_logic;
				rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           cwp : in  STD_LOGIC_VECTOR (4 downto 0);
           --rfdest : in  STD_LOGIC;
           imm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           i : in  STD_LOGIC;
           we : in  STD_LOGIC;
           dtowrite : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           ncwp : out  STD_LOGIC_VECTOR (4 downto 0);
           op2_crs2 : out  STD_LOGIC_VECTOR (31 downto 0);
           crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           crd : out  STD_LOGIC_VECTOR (31 downto 0);
			  rdsave : out std_logic_vector(5 downto 0);
			  ro7save: out std_logic_vector(5 downto 0)
			  );
end InstructionDecode;

architecture Behavioral of InstructionDecode is

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

	COMPONENT muxCall
	PORT(
		Rd : IN std_logic_vector(5 downto 0);
		callrd : IN std_logic_vector(5 downto 0);
		rfdest : IN std_logic;          
		NRD : OUT std_logic_vector(5 downto 0)
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


	COMPONENT SEU
	PORT(
		imm13 : IN std_logic_vector(12 downto 0);          
		seuout : OUT std_logic_vector(31 downto 0)
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


--signal auxcwp:STD_LOGIC_VECTOR(4 downto 0) := "00000";
--salidas del windows manager
signal aux_ncwp:STD_LOGIC_VECTOR(4 downto 0); -- sale del modulo
signal aux_nrs1:STD_LOGIC_VECTOR(5 downto 0);
signal aux_nrs2:STD_LOGIC_VECTOR(5 downto 0);
signal aux_rd:STD_LOGIC_VECTOR(5 downto 0);
signal aux_ro7:STD_LOGIC_VECTOR(5 downto 0);

--salidas del multiplexor del call
signal aux_nrd:STD_LOGIC_VECTOR(5 downto 0);

--salidar del registe file
signal aux_crs1:STD_LOGIC_VECTOR(31 downto 0); --sale del modulo
signal aux_crs2:STD_LOGIC_VECTOR(31 downto 0);
signal aux_crd:STD_LOGIC_VECTOR(31 downto 0); --sale del modulo

--salidas de la seu
signal aux_seuout :STD_LOGIC_VECTOR(31 downto 0); --sale del modulo


--salidas del mux01
signal aux_operando2 :STD_LOGIC_VECTOR(31 downto 0); --sale del modulo

begin

	Inst_mux01: mux01 PORT MAP(
		crs2 => aux_crs2,
		i => i,
		seuin => aux_seuout,
		muxout => aux_operando2
	);
	
	


	Inst_SEU: SEU PORT MAP(
		imm13 => imm13 ,
		seuout => aux_seuout
	);


	RF: RegisterFile PORT MAP(
		rs1 => aux_nrs1,
		rs2 => aux_nrs2,
		rd => aux_nrd,
		WE => we,
		DtoWrite => dtowrite,
		rst => rst,
		crs1 => aux_crs1,
		crs2 => aux_crs2,
		cRD => aux_crd
	);
	



--multiplexor del call
	Inst_muxCall: muxCall PORT MAP(
		Rd => rd6,
		callrd => ro7,
		rfdest => rfdest,
		NRD => aux_nrd
	);
	
	
	
	Inst_windowsManager: windowsManager PORT MAP(
		RS1 => rs1,
		RS2 => rs2 ,
		RD => rd,
		OP => op,
		OP3 => op3,
		CWP => cwp,
		NCWP => aux_ncwp,
		NRS1 => aux_nrs1 ,
		NRS2 => aux_nrs2,
		NRD => aux_rd,
		Ro7 => aux_ro7
	);
	
ncwp <= aux_ncwp;
crs1 <= 	aux_crs1;
crd <= 	aux_crd;
op2_crs2 <= aux_operando2;
rdsave <= aux_rd;
ro7save <= aux_ro7;

end Behavioral;

