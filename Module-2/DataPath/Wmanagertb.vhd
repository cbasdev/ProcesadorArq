--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:04:13 05/04/2018
-- Design Name:   
-- Module Name:   C:/Users/utp/Desktop/procesador2/WindowManager/Wmanagertb.vhd
-- Project Name:  WindowManager
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Wmanager
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Wmanagertb IS
END Wmanagertb;
 
ARCHITECTURE behavior OF Wmanagertb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Wmanager
    PORT(
         Rs1 : IN  std_logic_vector(5 downto 0);
         Rs2 : IN  std_logic_vector(5 downto 0);
         Rd : IN  std_logic_vector(5 downto 0);
         Op : IN  std_logic_vector(1 downto 0);
         Op3 : IN  std_logic_vector(5 downto 0);
         Cwp : IN  std_logic;
         nRs1 : OUT  std_logic_vector(5 downto 0);
         nRs2 : OUT  std_logic_vector(5 downto 0);
         nRd : OUT  std_logic_vector(5 downto 0);
         nCwp : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Rs1 : std_logic_vector(5 downto 0) := (others => '0');
   signal Rs2 : std_logic_vector(5 downto 0) := (others => '0');
   signal Rd : std_logic_vector(5 downto 0) := (others => '0');
   signal Op : std_logic_vector(1 downto 0) := (others => '0');
   signal Op3 : std_logic_vector(5 downto 0) := (others => '0');
   signal Cwp : std_logic := '0';

 	--Outputs
   signal nRs1 : std_logic_vector(5 downto 0);
   signal nRs2 : std_logic_vector(5 downto 0);
   signal nRd : std_logic_vector(5 downto 0);
   signal nCwp : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Wmanager PORT MAP (
          Rs1 => Rs1,
          Rs2 => Rs2,
          Rd => Rd,
          Op => Op,
          Op3 => Op3,
          Cwp => Cwp,
          nRs1 => nRs1,
          nRs2 => nRs2,
          nRd => nRd,
          nCwp => nCwp
        );
 

   -- Stimulus process
   stim_proc: process
   begin

		Rs1 <= "000000";
		Rs2 <= "000100";
		Rd <= "011000";
		Op <= "10";
		Op3 <="111100";
		Cwp <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		Rs1 <= "001100";
		Rs2 <= "010100";
		Rd <= "011000";
		Op <= "10";
		Op3 <="111101";
		Cwp <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;

		Rs1 <= "000000";
		Rs2 <= "000100";
		Rd <= "011000";
		Op <= "10";
		Op3 <= "111100";
		Cwp <= '0';
      -- hold reset state for 100 ns.
      wait for 100 ns;


		Rs1 <= "000000";
		Rs2 <= "000100";
		Rd <= "011000";
		Op <= "10";
		Op3 <="111101";
		Cwp <= '0';
      -- hold reset state for 100 ns.
      wait for 100 ns;


		Rs1 <= "000000";
		Rs2 <= "000100";
		Rd <= "011000";
		Op <= "10";
		Op3 <="111100";
		Cwp <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;		
      -- insert stimulus here 

      wait;
   end process;

END;
