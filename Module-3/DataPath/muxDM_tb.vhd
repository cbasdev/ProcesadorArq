
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY muxDM_tb IS
END muxDM_tb;
 
ARCHITECTURE behavior OF muxDM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT muxDM
    PORT(
         datatomem : IN  std_logic_vector(31 downto 0);
         aluresult : IN  std_logic_vector(31 downto 0);
         pc : IN  std_logic_vector(31 downto 0);
         RFsource : IN  std_logic_vector(1 downto 0);
         DtoWrite : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal datatomem : std_logic_vector(31 downto 0) := (others => '0');
   signal aluresult : std_logic_vector(31 downto 0) := (others => '0');
   signal pc : std_logic_vector(31 downto 0) := (others => '0');
   signal RFsource : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal DtoWrite : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: muxDM PORT MAP (
          datatomem => datatomem,
          aluresult => aluresult,
          pc => pc,
          RFsource => RFsource,
          DtoWrite => DtoWrite
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		    datatomem <="00000000000000000000000000000001";
          aluresult <="00000000000000000000000000000010";
          pc <="00000000000000000000000000000011";
			 RFsource <="00";
      wait for 10 ns;
			 RFsource <="01";
		wait for 10 ns;
			 RFsource <="10";
		wait for 10 ns;
			 RFsource <="11";
		wait for 10 ns;
			 RFsource <="00";


      -- insert stimulus here 

      wait;
   end process;

END;
