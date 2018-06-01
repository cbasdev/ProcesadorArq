
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY muxCall_tb IS
END muxCall_tb;
 
ARCHITECTURE behavior OF muxCall_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT muxCall
    PORT(
         Rd : IN  std_logic_vector(5 downto 0);
         callrd : IN  std_logic_vector(5 downto 0);
         rfdest : IN  std_logic;
         NRD : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Rd : std_logic_vector(5 downto 0) := (others => '0');
   signal callrd : std_logic_vector(5 downto 0) := (others => '0');
   signal rfdest : std_logic := '0';

 	--Outputs
   signal NRD : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: muxCall PORT MAP (
          Rd => Rd,
          callrd => callrd,
          rfdest => rfdest,
          NRD => NRD
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      RD<="000001";
		callrd<="001111";
		rfdest<='0';
		wait for 10 ns;
		rfdest<='1';

		

      -- insert stimulus here 

      wait;
   end process;

END;
