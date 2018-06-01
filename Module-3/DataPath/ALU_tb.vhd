
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         CRS1 : IN  std_logic_vector(31 downto 0);
         CRS2mux : IN  std_logic_vector(31 downto 0);
         ALUOP : IN  std_logic_vector(5 downto 0);
         C : IN  std_logic;
         ALURESULT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CRS1 : std_logic_vector(31 downto 0) := (others => '0');
   signal CRS2mux : std_logic_vector(31 downto 0) := (others => '0');
   signal ALUOP : std_logic_vector(5 downto 0) := (others => '0');
   signal C : std_logic := '0';

 	--Outputs
   signal ALURESULT : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          CRS1 => CRS1,
          CRS2mux => CRS2mux,
          ALUOP => ALUOP,
          C => C,
          ALURESULT => ALURESULT
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		CRS1 <="11111111111111111111111110111110";--addcc
		CRS2mux <="11111111111111111111110111011111";
		ALUOP <="010000"; 
		C <='1';
		
      wait for 10 ns;
		CRS1 <="11111111111111111111111111111111";--orcc
		CRS2mux <="11111111111111111111111111111111";
		ALUOP <="010010";
		--C <=;
		
      wait for 10 ns;
		CRS1 <="00000000000000000000000000000001";--addx
		CRS2mux <="00000000000000000000000000000001";
		ALUOP <="001000";
		--C <=;
		
		
      		


      -- insert stimulus here 

      wait;
   end process;

END;
