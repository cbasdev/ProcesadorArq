--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--------------------------------------------------------------------------------


ENTITY Sumador_Completo_TB IS
END Sumador_Completo_TB;
 
ARCHITECTURE behavior OF Sumador_Completo_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sumador_Completo
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         C : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
--------------------------------------------------------------------------------

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal C : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--------------------------------------------------------------------------------

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sumador_Completo PORT MAP (
          A => A,
          B => B,
          C => C
        );

--------------------------------------------------------------------------------
 
-- Stimulus process
   stim_proc: process
	
   begin		
      -- hold reset state for 100 ns.
		
		A <= "00000000000000000000000000001000";
		B <= "00000000000000000000000000001001";
      wait for 100 ns;
		A <= "00000000000000000000000000001000";
		B <= "00000000000000000000000000001001";
      wait for 100 ns;
		A <= "00000000000000000000000000001111";
		B <= "00000000000000000000000000001111";
      wait for 100 ns;		
		A <= "00000000000100000000000000001111";
		B <= "00000000000000000100000000001111";
      wait for 100 ns;	
		A <= "00000000010000000001000000001111";
		B <= "00000000000000011000000000001111";
      wait for 100 ns;	
		A <= "00000110000001100000000000001111";
		B <= "00000001111000000111000000001111";
      wait for 100 ns;	
		
		
		
		

      -- insert stimulus here 

      wait;
   end process;

END;