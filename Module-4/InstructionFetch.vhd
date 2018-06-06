----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:18:12 11/09/2017 
-- Design Name: 
-- Module Name:    InstructionFetch - Behavioral 
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

entity InstructionFetch is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           npc : in  STD_LOGIC_VECTOR (31 downto 0);
           instructionM : out  STD_LOGIC_VECTOR (31 downto 0);
			  outSumador: out std_logic_vector(31 downto 0);
			  pcO: out std_logic_vector(31 downto 0));
end InstructionFetch;

architecture Behavioral of InstructionFetch is

	COMPONENT InstruccionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		instruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT regis
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		datain : IN std_logic_vector(31 downto 0);          
		dataout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	
	signal aux_instruccion: std_logic_vector(31 downto 0);
	signal aux_npcpc: std_logic_vector(31 downto 0);
	signal aux_addressIM : std_logic_vector(31 downto 0);
--signal : std_logic_vector(31 downto 0);
--signal : std_logic_vector(31 downto 0);
--signal : std_logic_vector(31 downto 0);
--signal : std_logic_vector(31 downto 0);
--signal : std_logic_vector(31 downto 0);
--signal : std_logic_vector(31 downto 0);
--signal : std_logic_vector(31 downto 0);

begin
	Inst_InstruccionMemory: InstruccionMemory PORT MAP(
		address => aux_addressIM,
		rst => rst,
		instruction => aux_instruccion
	);
	
	Inpc: regis PORT MAP(
		clk => clk,
		rst =>rst,
		datain => npc,
		dataout => aux_npcpc
	);
	
	pc: regis PORT MAP(
		clk => clk,
		rst => rst,
		datain => aux_npcpc,
		dataout => aux_addressIM
	);
	pcO <= aux_addressIM;
	instructionM <= aux_instruccion;
	outSumador <= aux_npcpc;

end Behavioral;

