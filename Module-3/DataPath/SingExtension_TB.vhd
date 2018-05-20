--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
--------------------------------------------------------------------------------

ENTITY SingExtension_TB IS
END SingExtension_TB;
 
ARCHITECTURE behavior OF SingExtension_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SingExtension
    PORT(
         imm : IN  std_logic_vector(12 downto 0);
         se_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
--------------------------------------------------------------------------------

   --Inputs
   signal imm : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal se_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--------------------------------------------------------------------------------

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SingExtension PORT MAP (
          imm => imm,
          se_out => se_out
        );

--------------------------------------------------------------------------------

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	


		imm <= "0101010101010";
      wait for 100 ns;	

		imm <= "1001010101010";
      wait for 100 ns;	

      -- insert stimulus here 

      wait;
   end process;
--------------------------------------------------------------------------------

END;
