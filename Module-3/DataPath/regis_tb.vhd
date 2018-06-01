
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY regis_tb IS
END regis_tb;
 
ARCHITECTURE behavior OF regis_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT regis
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         datain : IN  std_logic_vector(31 downto 0);
         dataout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal datain : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal dataout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: regis PORT MAP (
          clk => clk,
          rst => rst,
          datain => datain,
          dataout => dataout
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
			--rst <= '1';

      datain <= "00000001100000000000000011010000";
		wait for 100 ns;
		datain <= "00000000000010000000000011010000";
		wait for 100 ns;
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		datain <= "00010000000000000000000011010000";
		wait for 90 ns;
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		
		
		datain <= "00000000000000000000000001000000";
		wait for 90 ns;

      wait;
   end process;

END;
