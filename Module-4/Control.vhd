----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:48:29 11/30/2017 
-- Design Name: 
-- Module Name:    Control - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Control is
    Port ( 
			  pcIN : in  STD_LOGIC_VECTOR (31 downto 0);
			  npcIN : in  STD_LOGIC_VECTOR (31 downto 0);
           iccIN : in  STD_LOGIC_VECTOR (3 downto 0);
           --opIN : in  STD_LOGIC_VECTOR (1 downto 0);
           --op3IN : in  STD_LOGIC_VECTOR (5 downto 0);
           --condIN : in  STD_LOGIC_VECTOR (3 downto 0);
			  instruction : in  STD_LOGIC_VECTOR (31 downto 0);
           aluResultIN : in  STD_LOGIC_VECTOR (31 downto 0);
           --pcOUT : out  STD_LOGIC_VECTOR (31 downto 0);
           rfDestOUT : out  STD_LOGIC;
           rfSourceOUT : out  STD_LOGIC_VECTOR (1 downto 0);
           wrEnMemOUT : out  STD_LOGIC;
			  wrEnRegisOUT : out  STD_LOGIC;
           aluOpOUT : out  STD_LOGIC_VECTOR (5 downto 0);
			  npcOUT : out  STD_LOGIC_VECTOR (31 downto 0));
			  
end Control;

architecture Behavioral of Control is

	signal auxExtDisp22 : std_logic_vector(31 downto 0);
	signal auxExtDisp30 : std_logic_vector(31 downto 0);
	signal auxPcmas1 : std_logic_vector(31 downto 0);
	signal auxPcmasSeu22 : std_logic_vector(31 downto 0);
	signal auxPcmasSeu30 : std_logic_vector(31 downto 0);
	signal auxPcSource : STD_LOGIC_VECTOR (1 downto 0);
	
	COMPONENT sumador32bits
	PORT(
		datainA : IN std_logic_vector(31 downto 0);
		datainB : IN std_logic_vector(31 downto 0);          
		Salida : OUT std_logic_vector(31 downto 0)
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






begin

	Inst_sumador32bitsMas1: sumador32bits PORT MAP(
		datainA => "00000000000000000000000000000001",
		datainB => npcin,
		Salida => auxPcmas1
	);
	
	Inst_SEUdisp22: SEUdisp22 PORT MAP(
		disp22 => instruction(21 downto 0),
		extdisp22 => auxExtDisp22
	);
	
	Inst_sumador32bitsSeu22: sumador32bits PORT MAP(
		datainA => pcIN,
		datainB => auxExtDisp22,
		Salida => auxPcmasSeu22
	);
	
	
	Inst_SEUdisp30: SEUdisp30 PORT MAP(
		disp30 => instruction(29 downto 0),
		extdisp30 => auxExtDisp30
	);
	
	Inst_sumador32bitsSeu30: sumador32bits PORT MAP(
		datainA => auxExtDisp30,
		datainB => pcIN,
		Salida => auxPcmasSeu30
	);
	
		Inst_muxPC: muxPC PORT MAP(
		disp30 => auxPcmasSeu30,
		disp22 => auxPcmasSeu22,
		pc => auxPcmas1,
		aluresult => aluResultIN,
		pcsource => auxPcSource,
		outNPC => npcOUT
	);
	
		Inst_ControUnit: ControUnit PORT MAP(
		ICC => iccIN,
		OP3 => instruction(24 downto 19),
		OP => instruction(31 downto 30),
		OP2 => instruction(24 downto 22),
		COND => instruction(28 downto 25),
		WE => wrEnRegisOUT,
		WEDM => wrEnMemOUT,
		RFSOURCE => rfSourceOUT,
		RFDEST => rfDestOUT,
		PCSOURCE => auxPcSource,
		ALUOP => aluOpOUT
	);
	
	
end Behavioral;

