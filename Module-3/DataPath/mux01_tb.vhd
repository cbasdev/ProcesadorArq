
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY mux01_tb IS
END mux01_tb;
 
ARCHITECTURE behavior OF mux01_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux01
    PORT(
         crs2 : IN  std_logic_vector(31 downto 0);
         i : IN  std_logic;
         seuin : IN  std_logic_vector(31 downto 0);
         muxout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal crs2 : std_logic_vector(31 downto 0) := (others => '0');
   signal i : std_logic := '0';
   signal seuin : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal muxout : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux01 PORT MAP (
          crs2 => crs2,
          i => i,
          seuin => seuin,
          muxout => muxout
        );

   -- Clock process definitions


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      i <= '0';
		crs2 <= "11111111111111111111111111111111";
		seuin <= "00000000000000000000000000001111";
		i <= '0';

		wait for 10 ns;
		i <= '1';
		crs2 <= "11110000000000000000000000000000";
		seuin <= "00000000000000000000000000001111";
		wait for 10 ns;
		i <= '0';
		crs2 <= "11110000000000000000000000000000";
		seuin <= "00000000000000000000000000001111";
      -- insert stimulus here 

      wait;
   end process;


END;
