
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY muxPC_tb IS
END muxPC_tb;
 
ARCHITECTURE behavior OF muxPC_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT muxPC
    PORT(
         disp30 : IN  std_logic_vector(31 downto 0);
         disp22 : IN  std_logic_vector(31 downto 0);
         pc : IN  std_logic_vector(31 downto 0);
         aluresult : IN  std_logic_vector(31 downto 0);
         pcsource : IN  std_logic_vector(1 downto 0);
         outNPC : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal disp30 : std_logic_vector(31 downto 0) := (others => '0');
   signal disp22 : std_logic_vector(31 downto 0) := (others => '0');
   signal pc : std_logic_vector(31 downto 0) := (others => '0');
   signal aluresult : std_logic_vector(31 downto 0) := (others => '0');
   signal pcsource : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal outNPC : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: muxPC PORT MAP (
          disp30 => disp30,
          disp22 => disp22,
          pc => pc,
          aluresult => aluresult,
          pcsource => pcsource,
          outNPC => outNPC
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		disp30 <="00000000000000000000000000000001";
      disp22 <="00000000000000000000000000000010";
      pc <="00000000000000000000000000000011";
      aluresult <="00000000000000000000000000000100";
      pcsource <="00";
      wait for 10 ns;	
		pcsource <="01";
      wait for 10 ns;
		pcsource <="10";
      wait for 10 ns;
		pcsource <="11";
      wait for 10 ns;
		pcsource <="00";
      wait for 10 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
