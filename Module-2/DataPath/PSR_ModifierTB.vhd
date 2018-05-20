
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PSR_ModifierTB IS
END PSR_ModifierTB;
 
ARCHITECTURE behavior OF PSR_ModifierTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR_Modifier
    PORT(
         RST : IN  std_logic;
         CRS1 : IN  std_logic_vector(31 downto 0);
         MUXOut : IN  std_logic_vector(31 downto 0);
         ALUOut : IN  std_logic_vector(5 downto 0);
         Result : IN  std_logic_vector(31 downto 0);
         NZVC : OUT  std_logic_vector(3 downto 0):= "0000"
        );
    END COMPONENT;
    

   --Inputs
   signal RST : std_logic := '0';
   signal CRS1 : std_logic_vector(31 downto 0) := (others => '0');
   signal MUXOut : std_logic_vector(31 downto 0) := (others => '0');
   signal ALUOut : std_logic_vector(5 downto 0) := (others => '0');
   signal Result : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal NZVC : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under T est (UUT) 
   uut: PSR_Modifier PORT MAP (
          RST => RST,
          CRS1 => CRS1,
          MUXOut => MUXOut,
          ALUOut => ALUOut,
          Result => Result,
          NZVC => NZVC
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      ALUOut <= "010000";
		Result <=  "11111111111111111111111111111110" ;
		CRS1 <= "11111111111111111111111111111111"  ;
		MUXOut <=  "11111111111111111111111111111111" ;
		wait for 100 ns;	
		

   

      -- insert stimulus here 

      wait;
   end process;

END;
