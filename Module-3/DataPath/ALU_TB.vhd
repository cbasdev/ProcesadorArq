
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
--------------------------------------------------------------------------------

 
ENTITY ALU_TB IS
END ALU_TB;
 
ARCHITECTURE behavior OF ALU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         OP : IN  std_logic_vector(5 downto 0);
         RESULT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal OP : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal RESULT : std_logic_vector(31 downto 0);
--------------------------------------------------------------------------------

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          OP => OP,
          RESULT => RESULT
        );


 --------------------------------------------------------------------------------


   -- Stimulus process
   stim_proc: process
   begin		
	
      OP <= "000000"; -- ADD
		A <= "00000000000000000000000000001001";
		B <= "00000000000000000000000000000011";
		wait for 100 ns;
		
		OP <= "000100" ; -- SUB
		A <= "00000000000000000000000000000101";
		B <= "00000000000000000000000000000001";
		wait for 100 ns;
		
		OP <=  "000001"; -- AND
		A <= "11111111111111000000000000000111";
		B <= "11111111111111000000000000000111";
		wait for 100 ns;
		
		OP <= "000101" ; -- NAND
		A <= "11111111111111000000000000000111";
		B <= "11111111111111000000000000000111";
		wait for 100 ns;
		
		OP <= "000010"  ; -- OR
		A <= "00111110000100000000000001000000";
		B <= "01000000000111000100000001000000";
		wait for 100 ns;
		OP <= "000110" ; -- NOR
		A <= "00111110000100000000000001000000";
		B <= "01000000000111000100000001000000";
		wait for 100 ns;
		OP <= "000011" ; -- XOR
		A <= "00111110000100000000000001000000";
		B <= "01000000000111000100000001000000";
		wait for 100 ns;
		
		OP <= "000111" ; -- XNOR
		A <= "00111110000100000000000001000000";
		B <= "01000000000111000100000001000000";
		wait for 100 ns;
		
	

      wait;
   end process;
--------------------------------------------------------------------------------

END;
