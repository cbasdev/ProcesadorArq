
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY SEUdisp22_tb IS
END SEUdisp22_tb;
 
ARCHITECTURE behavior OF SEUdisp22_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SEUdisp22
    PORT(
         disp22 : IN  std_logic_vector(21 downto 0);
         extdisp22 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal disp22 : std_logic_vector(21 downto 0) := (others => '0');

 	--Outputs
   signal extdisp22 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SEUdisp22 PORT MAP (
          disp22 => disp22,
          extdisp22 => extdisp22
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		disp22<="1000000000000000000000";
		wait for 10 ns;
		disp22<="0000000000010000000000";
		wait for 10 ns;
		disp22<="1000000000000000001110";
		wait for 10 ns;
		disp22<="0000000000011100000000";
		wait for 10 ns;
		disp22<="1111111111111111111111";
		wait for 10 ns;
		disp22<="0000000000000000000001";
		
      wait for 100 ns;	



      -- insert stimulus here 

      wait;
   end process;

END;
