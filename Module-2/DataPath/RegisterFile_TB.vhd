--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 --------------------------------------------------------------------------------

ENTITY RegisterFile_TB IS
END RegisterFile_TB;
 
ARCHITECTURE behavior OF RegisterFile_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         RS1 : IN  std_logic_vector(4 downto 0);
         RS2 : IN  std_logic_vector(4 downto 0);
         RD : IN  std_logic_vector(4 downto 0);
         DWR : IN  std_logic_vector(31 downto 0);
         RST : IN  std_logic;
         CRS1 : OUT  std_logic_vector(31 downto 0);
         CRS2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RS1 : std_logic_vector(4 downto 0) := (others => '0');
   signal RS2 : std_logic_vector(4 downto 0) := (others => '0');
   signal RD : std_logic_vector(4 downto 0) := (others => '0');
   signal DWR : std_logic_vector(31 downto 0) := (others => '0');
   signal RST : std_logic := '0';

 	--Outputs
   signal CRS1 : std_logic_vector(31 downto 0);
   signal CRS2 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

--------------------------------------------------------------------------------

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          RS1 => RS1,
          RS2 => RS2,
          RD => RD,
          DWR => DWR,
          RST => RST,
          CRS1 => CRS1,
          CRS2 => CRS2
        );

 
--------------------------------------------------------------------------------

   -- Stimulus process
   stim_proc: process
   begin		
		RS1 <= "00000";
		RS2 <="00001"; 
		RD <="00001";
		DWR <= "00000000000000000000000000000000";
		wait for 20 ns;
		
		RS1 <= "00000";
		RS2 <="00001";
		RD <="00001";
		DWR <= "00000000000000000000000000001111";
		wait for 20 ns;
		
		RS1 <= "00000";
		RS2 <="00000";
		RD <="00011";
		DWR <= "00000000000000000000000000011111";
		wait for 20 ns;
		
		RST <= '1';
		
		wait for 20 ns;
		
		RD <= "00000";
		
		wait;
--------------------------------------------------------------------------------

   end process;

END;
--------------------------------------------------------------------------------