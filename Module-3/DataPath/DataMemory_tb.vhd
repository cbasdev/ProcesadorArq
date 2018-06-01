
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY DataMemory_tb IS
END DataMemory_tb;
 
ARCHITECTURE behavior OF DataMemory_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DataMemory
    PORT(
         cRD : IN  std_logic_vector(31 downto 0);
         aluAddress : IN  std_logic_vector(31 downto 0);
         wrenmem : IN  std_logic;
         datatomem : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal cRD : std_logic_vector(31 downto 0) := (others => '0');
   signal aluAddress : std_logic_vector(31 downto 0) := (others => '0');
   signal wrenmem : std_logic := '0';

 	--Outputs
   signal datatomem : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DataMemory PORT MAP (
          cRD => cRD,
          aluAddress => aluAddress,
          wrenmem => wrenmem,
          datatomem => datatomem
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
      cRD<="11111111111111111111111111111111";
		aluAddress<="00000000000000000000000000000000";
		wrenmem<='0';
      wait for 10 ns;
		wrenmem<='1';
		cRD<="00000000000000000000000000000010";
		aluAddress<="00000000000000000000000000000000";
		wait for 10 ns;
		wrenmem<='1';
		cRD<="00000000000000000000000000000011";
		aluAddress<="00000000000000000000000000000001";
      wait for 10 ns;
		cRD<="00000000000000000000000000001111";
		aluAddress<="00000000000000000000000000000010";
		wrenmem<='1';	
		wait for 10 ns;
		cRD<="00000000000000000000000000001111";
		aluAddress<="00000000000000000000000000000000";
		wrenmem<='0';
		wait for 10 ns;
		cRD<="00000000000000000000000000001111";
		aluAddress<="00000000000000000000000000000001";
		wrenmem<='0';
		wait for 10 ns;
		cRD<="00000000000000000000000000001111";
		aluAddress<="00000000000000000000000000000011";
		wrenmem<='0';


      -- insert stimulus here 

      wait;
   end process;

END;
