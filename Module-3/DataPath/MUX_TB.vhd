
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--------------------------------------------------------------------------------

 
ENTITY MUX_TB IS
END MUX_TB;
 --------------------------------------------------------------------------------

ARCHITECTURE behavior OF MUX_TB IS 
 
--------------------------------------------------------------------------------

 
    COMPONENT MUX
    PORT(
         CRS2 : IN  std_logic_vector(31 downto 0);
         SE_OUT : IN  std_logic_vector(31 downto 0);
         I : IN  std_logic;
         MUX_OUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
--------------------------------------------------------------------------------

   --Inputs
   signal CRS2 : std_logic_vector(31 downto 0) := (others => '0');
   signal SE_OUT : std_logic_vector(31 downto 0) := (others => '0');
   signal I : std_logic := '0';

 	--Outputs
   signal MUX_OUT : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 --------------------------------------------------------------------------------

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX PORT MAP (
          CRS2 => CRS2,
          SE_OUT => SE_OUT,
          I => I,
          MUX_OUT => MUX_OUT
        );

   -- Clock process definitions
   
--------------------------------------------------------------------------------

   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		I <= '0';
		CRS2 <=   "00000000000000000000000000000000";
		SE_OUT <= "11111111111111111111111111111111";

      wait for 100 ns;	
		I <= '1';
		CRS2 <=   "00000000000000000000000000000000";
		SE_OUT <= "11111111111111111111111111111111";
		

      -- insert stimulus here 

      wait;
   end process;
--------------------------------------------------------------------------------

END;
