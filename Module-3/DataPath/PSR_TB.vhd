--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY PSR_TB IS
END PSR_TB;
 
ARCHITECTURE behavior OF PSR_TB IS 
 
    COMPONENT PSR
    PORT(
         NCWP : IN  std_logic_vector(3 downto 0);
         CWP : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         C : OUT  std_logic;
         CWPOUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal NCWP : std_logic_vector(3 downto 0) := (others => '0');
   signal CWP : std_logic := '0';
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal C : std_logic;
   signal CWPOUT : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR PORT MAP (
          NCWP => NCWP,
          CWP => CWP,
          RST => RST,
          CLK => CLK,
          C => C,
          CWPOUT => CWPOUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   stim_proc: process
   begin		
	
		RST <= '1';
      wait for 100 ns;	
		RST <= '0';
		wait for 100 ns;
		CWP <= '0';
		NCWP <= "1001";
      wait for clk_period*10;
		CWP <= '1';
		NCWP <= "1010";


      wait;
   end process;

END;
