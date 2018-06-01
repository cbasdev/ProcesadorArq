--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:22:31 10/24/2017
-- Design Name:   
-- Module Name:   D:/UTP/semestres/Sexto Semestre/Arquitectura/ThirdProcessor/windowsManager_tb.vhd
-- Project Name:  ProcesadorMonociclo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: windowsManager
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
 
ENTITY windowsManager_tb IS
END windowsManager_tb;
 
ARCHITECTURE behavior OF windowsManager_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT windowsManager
    PORT(
         RS1 : IN  std_logic_vector(4 downto 0);
         RS2 : IN  std_logic_vector(4 downto 0);
         RD : IN  std_logic_vector(4 downto 0);
         OP : IN  std_logic_vector(1 downto 0);
         OP3 : IN  std_logic_vector(5 downto 0);
         CWP : IN  std_logic_vector(4 downto 0);
         NCWP : OUT  std_logic_vector(4 downto 0);
         NRS1 : OUT  std_logic_vector(5 downto 0);
         NRS2 : OUT  std_logic_vector(5 downto 0);
         NRD : OUT  std_logic_vector(5 downto 0);
         Ro7 : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RS1 : std_logic_vector(4 downto 0) := (others => '0');
   signal RS2 : std_logic_vector(4 downto 0) := (others => '0');
   signal RD : std_logic_vector(4 downto 0) := (others => '0');
   signal OP : std_logic_vector(1 downto 0) := (others => '0');
   signal OP3 : std_logic_vector(5 downto 0) := (others => '0');
   signal CWP : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal NCWP : std_logic_vector(4 downto 0);
   signal NRS1 : std_logic_vector(5 downto 0);
   signal NRS2 : std_logic_vector(5 downto 0);
   signal NRD : std_logic_vector(5 downto 0);
   signal Ro7 : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: windowsManager PORT MAP (
          RS1 => RS1,
          RS2 => RS2,
          RD => RD,
          OP => OP,
          OP3 => OP3,
          CWP => CWP,
          NCWP => NCWP,
          NRS1 => NRS1,
          NRS2 => NRS2,
          NRD => NRD,
          Ro7 => Ro7
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      -- hold reset state for 100 ns.
    --"111100" OR  OP3 = "111101"  
			 CWP <= "00000";
			 --CWP <= "00001";
			 OP <= "00";
          OP3 <= "000000";
			 RS1 <= "00000"; --0
          RS2 <= "00001"; --1
          RD <= "00111"; --7
 wait for 10 ns;	
			CWP <= "00001";
			 OP <= "10";
          OP3 <= "111101"; --restore

			 RS1 <= "11111"; --31
          RS2 <= "10000"; --16
          RD <= "10100"; -- 8
 wait for 10 ns;	 

			CWP <= "00000";
			
			 OP <= "10"; -- save
          OP3 <= "111100";

 			 RS1 <= "11111"; --31
          RS2 <= "10110"; --22
          RD <= "01110"; --aqui iba el 14
 wait for 10 ns;	

 
			CWP <= "00000";
			
				 OP <= "10"; --restore
          OP3 <= "111101";

 			 RS1 <= "10011";--19
          RS2 <= "00010"; --2
          RD <= "11010"; --26
 wait for 10 ns;	
 

			CWP <= "00001";
			
			 OP <= "10"; -- save
          OP3 <= "111100";

 			 RS1 <= "01111"; 
          RS2 <= "11100"; 
          RD <= "10110";  
 wait for 10 ns;	
 
 
 			 CWP <= "00000";
			 
			 OP <= "00";
          OP3 <= "000000";
			 RS1 <= "00000"; --0
          RS2 <= "00001"; --1
          RD <= "00111"; --7
 wait for 10 ns;	
			


			 RS1 <= "11111"; --31
          RS2 <= "10000"; --16
          RD <= "10100"; -- 8
 wait for 10 ns;	 

			CWP <= "00001";
			


 			 RS1 <= "11111"; --31
          RS2 <= "10110"; --22
          RD <= "01110"; --aqui iba el 14
 wait for 10 ns;	

 
			
			


 			 RS1 <= "10011";--19
          RS2 <= "00010"; --2
          RD <= "11010"; --26
 wait for 10 ns;	
 

			CWP <= "00001";
			


 			 RS1 <= "01111"; 
          RS2 <= "11100"; 
          RD <= "10110";  



      -- insert stimulus here 

      wait;
   end process;

END;
