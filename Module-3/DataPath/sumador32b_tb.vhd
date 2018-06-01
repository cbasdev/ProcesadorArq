
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY sumador32b_tb IS
END sumador32b_tb;
 
ARCHITECTURE behavior OF sumador32b_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sumador32bits
    PORT(
         datainA : IN  std_logic_vector(31 downto 0);
         datainB : IN  std_logic_vector(31 downto 0);
         Salida : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal datainA : std_logic_vector(31 downto 0) := (others => '0');
   signal datainB : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Salida : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sumador32bits PORT MAP (
          datainA => datainA,
          datainB => datainB,
          Salida => Salida
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
		datainA <= "00000000000000000000000000000000";
		datainB <= "00000000000000000000000000000000";
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		datainA <= "00000000000000000000000000000001";
		datainB <= "00000000000000000000000000000001";
		wait for 100 ns;
		datainA <= "00000000000000000000000000000010";
		datainB <= "00000000000000000000000000000010";
		wait for 100 ns;
		datainA <= "00000000000000000000000000000111";
		datainB <= "00000000000000000000000000000111";
      -- hold reset state for 100 ns.
      wait for 100 ns;	



      -- insert stimulus here 

      wait;
   end process;

END;
