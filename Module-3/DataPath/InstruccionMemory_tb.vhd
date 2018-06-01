
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY InstruccionMemory_tb IS
END InstruccionMemory_tb;
 
ARCHITECTURE behavior OF InstruccionMemory_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InstruccionMemory
    PORT(
         address : IN  std_logic_vector(31 downto 0);
         rst : IN  std_logic;
         instruction : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal address : std_logic_vector(31 downto 0) := (others => '0');
   signal rst : std_logic := '0';

 	--Outputs
   signal instruction : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InstruccionMemory PORT MAP (
          address => address,
          rst => rst,
          instruction => instruction
        );


   -- Stimulus process
   stim_proc: process
   begin		
      rst <= '0';
		address <= "00000000000000000000000000000000"; 
		
      wait for 25 ns;	
		address <= "00000000000000000000000000000001";
		
		wait for 25 ns;	
		address <= "00000000000000000000000000000010";
		
		wait for 25 ns;	
		address <= "00000000000000000000000000000011";
		
		wait for 25 ns;
			rst <= '1';
		wait for 25 ns;
		rst <= '0';

 

      -- insert stimulus here 

      wait;
   end process;

END;
