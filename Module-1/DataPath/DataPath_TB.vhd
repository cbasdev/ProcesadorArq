--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--------------------------------------------------------------------------------

 
ENTITY DataPath_TB IS
END DataPath_TB;
 
ARCHITECTURE behavior OF DataPath_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DataPath
    PORT(
         CLK_D : IN  std_logic;
         RST_D : IN  std_logic;
         DataPathOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_D : std_logic := '0';
   signal RST_D : std_logic := '0';

 	--Outputs
   signal DataPathOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_D_period : time := 10 ns;
--------------------------------------------------------------------------------

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DataPath PORT MAP (
          CLK_D => CLK_D,
          RST_D => RST_D,
          DataPathOut => DataPathOut
        );

   -- Clock process definitions
   CLK_D_process :process
   begin
		CLK_D <= '0';
		wait for CLK_D_period/2;
		CLK_D <= '1';
		wait for CLK_D_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
	
		RST_D <= '1';
		wait for 100 ns;	
		RST_D <= '0';
		wait for 100 ns;
		wait;
   end process;

END;
--------------------------------------------------------------------------------
