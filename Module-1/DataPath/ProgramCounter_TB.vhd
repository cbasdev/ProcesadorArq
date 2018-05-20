
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--------------------------------------------------------------------------------
 
ENTITY ProgramCounter_TB IS
END ProgramCounter_TB;
 
ARCHITECTURE behavior OF ProgramCounter_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ProgramCounter
    PORT(
         address : IN  std_logic_vector(31 downto 0);
         rst : IN  std_logic;
         clk : IN  std_logic;
         pc_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
--------------------------------------------------------------------------------

   --Inputs
   signal address : std_logic_vector(31 downto 0) := (others => '0');
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal pc_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
--------------------------------------------------------------------------------

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ProgramCounter PORT MAP (
          address => address,
          rst => rst,
          clk => clk,
          pc_out => pc_out
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
      -- hold reset state for 100 ns.
		address <= "00000000000000000000000000000011";
		rst <= '0';
      wait for 200 ns;
		
		address <= "00000000000000000000000000000010";
		rst <= '0';
      wait for 200 ns;
		
		address <= "00000000000000000000000000000001";
		rst <= '0';
      wait for 200 ns;
		
		address <= "00000000000000000000000000000111";
		rst <= '0';
      wait for 200 ns;

		address <= "00000000000000000000000000000111";
		rst <= '1';
      wait for 200 ns;
		
		address <= "00000000000000000000000000000111";
		rst <= '1';
      wait for 200 ns;
		
		address <= "00000000000000000000000000000111";
		rst <= '1';
      wait for 200 ns;
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
