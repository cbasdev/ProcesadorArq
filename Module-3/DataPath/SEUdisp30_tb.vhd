
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY SEUdisp30_tb IS
END SEUdisp30_tb;
 
ARCHITECTURE behavior OF SEUdisp30_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SEUdisp30
    PORT(
         disp30 : IN  std_logic_vector(29 downto 0);
         extdisp30 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal disp30 : std_logic_vector(29 downto 0) := (others => '0');

 	--Outputs
   signal extdisp30 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SEUdisp30 PORT MAP (
          disp30 => disp30,
          extdisp30 => extdisp30
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		disp30<="111111111111111111111111111111";
		wait for 10 ns;
		disp30<="000000000000000000000000000001";
      wait for 100 ns;	



      -- insert stimulus here 

      wait;
   end process;

END;
