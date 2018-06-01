
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

 
ENTITY PSR_modifier_tb IS
END PSR_modifier_tb;
 
ARCHITECTURE behavior OF PSR_modifier_tb IS 
 

 
    COMPONENT PSR_modifier
    PORT(
         ALUOP : IN  std_logic_vector(5 downto 0);
         RESULT : IN  std_logic_vector(31 downto 0);
         RS1 : IN  std_logic_vector(31 downto 0);
         RS2 : IN  std_logic_vector(31 downto 0);
         NZVC : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
	 

   --Inputs
   signal ALUOP : std_logic_vector(5 downto 0) := (others => '0');
   signal RESULT : std_logic_vector(31 downto 0) := (others => '0');
   signal RS1 : std_logic_vector(31 downto 0) := (others => '0');
   signal RS2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal NZVC : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR_modifier PORT MAP (
          ALUOP => ALUOP,
          RESULT => RESULT,
          RS1 => RS1,
          RS2 => RS2,
          NZVC => NZVC
        );



   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		ALUOP <= "010000" ; -- addcc
		RESULT <=  "11111111111111111111111111111110" ;
		RS1 <= "11111111111111111111111111111111"  ;
		RS2 <=  "11111111111111111111111111111111" ;

		
		wait for 10 ns;
		ALUOP <= "010100" ; --SUBCC
		RESULT <=  "00000000000000000000000000000000" ;
		RS1 <=  "01111111111111111111111111111111" ;
		RS2 <=   "01111111111111111111111111111111";
		
		
		wait for 10 ns;
		ALUOP <= "010001" ; -- andcc
		RESULT <=  "00000000000000000000000000000000" ;
		RS1 <=  "11111111111111111111111111111111" ;
		RS2 <=  "00000000000000000000000000000000"  ;
		
		
		wait for 10 ns;
		ALUOP <= "010010" ;--orcc
		RESULT <=  "10000000000000000000000000000000"  ;
		RS1 <= "00000000000000000000000000000000"  ;
		RS2 <=  "10000000000000000000000000000000" ;
		wait for 10 ns;
		
		

		--hola

      wait;
   end process;

END;
