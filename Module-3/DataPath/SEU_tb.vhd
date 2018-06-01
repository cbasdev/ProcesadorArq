
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY SEU_tb IS
END SEU_tb;
 
ARCHITECTURE behavior OF SEU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SEU
    PORT(
         imm13 : IN  std_logic_vector(12 downto 0);
         seuout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal imm13 : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal seuout : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SEU PORT MAP (
          imm13 => imm13,
          seuout => seuout
        );



   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		imm13 <= "0000100010111";
      wait for 10 ns;	
		imm13 <= "0000100000000";
		wait for 10 ns;	
		imm13 <= "0000000000111";
		wait for 10 ns;	
		
		imm13 <= "1110000000000";
		wait for 10 ns;	
		imm13 <= "1000000000001";
		
		wait for 10 ns;	
		imm13 <= "0011000000000";


      -- insert stimulus here 
   end process;

END;
