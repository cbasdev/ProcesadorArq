
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--------------------------------------------------------------------------------
 
ENTITY PSR_Modifier_TB IS
END PSR_Modifier_TB;
 
ARCHITECTURE behavior OF PSR_Modifier_TB IS 
 
--------------------------------------------------------------------------------
 
    COMPONENT PSR_Modifier
    PORT(
         CRS1 : IN  std_logic_vector(31 downto 0);
         MUXOut : IN  std_logic_vector(31 downto 0);
         ALUOut : IN  std_logic_vector(31 downto 0);
         ALUOP : IN  std_logic_vector(5 downto 0);
         PSROut : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
--------------------------------------------------------------------------------

   --Inputs
   signal CRS1 : std_logic_vector(31 downto 0) := (others => '0');
   signal MUXOut : std_logic_vector(31 downto 0) := (others => '0');
   signal ALUOut : std_logic_vector(31 downto 0) := (others => '0');
   signal ALUOP : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal PSROut : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR_Modifier PORT MAP (
          CRS1 => CRS1,
          MUXOut => MUXOut,
          ALUOut => ALUOut,
          ALUOP => ALUOP,
          PSROut => PSROut
        );


 

--------------------------------------------------------------------------------

   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		wait for 100 ns;
		ALUOp <= "000001";
		CRS1 <="00000000000000000000000000000000";
		MUXOut <="00000000000000000000000000000000";
		wait for 100 ns;
		ALUOp <= "000001";
		CRS1 <="10000000000000000000000000000000";
		MUXOut <="10000000000000000000000000000000";
      wait for 100 ns;
		ALUOp <= "000010";
		CRS1 <="10000000000000000000000000000000";
		MUXOut <="00000000000000000000000000000000";
		ALUOut <="00000000000000000000000000000000";
      wait for 100 ns;
		ALUOp <= "000111";
		CRS1 <="00000000000000000000000000000000";
		MUXOut <="10000000000000000000000000000000";
      wait for 100 ns;
		ALUOp <= "000111";
		CRS1 <="00000000000000000000000000000000";
		MUXOut <="00000000000000000000000000000000";
      wait for 100 ns;
		ALUOp <= "000101";
		CRS1 <="00000000000000000000000000000000";
		MUXOut <="00000000000000000000000000000000";
		ALUOut <="10000000000000000000000000000000";

      wait;
   end process;

END;
--------------------------------------------------------------------------------
