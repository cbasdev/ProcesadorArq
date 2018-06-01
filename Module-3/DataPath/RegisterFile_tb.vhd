--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:42:16 10/24/2017
-- Design Name:   
-- Module Name:   D:/UTP/semestres/Sexto Semestre/Arquitectura/ThirdProcessor/RegisterFile_tb.vhd
-- Project Name:  ProcesadorMonociclo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegisterFile
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
 
ENTITY RegisterFile_tb IS
END RegisterFile_tb;
 
ARCHITECTURE behavior OF RegisterFile_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         rs1 : IN  std_logic_vector(5 downto 0);
         rs2 : IN  std_logic_vector(5 downto 0);
         rd : IN  std_logic_vector(5 downto 0);
         WE : IN  std_logic;
         DtoWrite : IN  std_logic_vector(31 downto 0);
         rst : IN  std_logic;
         crs1 : OUT  std_logic_vector(31 downto 0);
         crs2 : OUT  std_logic_vector(31 downto 0);
         cRD : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rs1 : std_logic_vector(5 downto 0) := (others => '0');
   signal rs2 : std_logic_vector(5 downto 0) := (others => '0');
   signal rd : std_logic_vector(5 downto 0) := (others => '0');
   signal WE : std_logic := '0';
   signal DtoWrite : std_logic_vector(31 downto 0) := (others => '0');
   signal rst : std_logic := '0';

 	--Outputs
   signal crs1 : std_logic_vector(31 downto 0);
   signal crs2 : std_logic_vector(31 downto 0);
   signal cRD : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          rs1 => rs1,
          rs2 => rs2,
          rd => rd,
          WE => WE,
          DtoWrite => DtoWrite,
          rst => rst,
          crs1 => crs1,
          crs2 => crs2,
          cRD => cRD
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		we <= '1';
		rs1 <= "000000";
		rs2 <="000000"; 
		rd <="000001";
		dToWrite <= "00000000000000000000000000000001";
		
		
		wait for 15 ns;
		rd <="000010";
		dToWrite <= "00000000000000000000000000000010";
		
		wait for 15 ns;
		rd <="000011";
		dToWrite <= "00000000000000000000000000000011";
		we <= '0';
		wait for 15 ns;
--		rst <= '1';
		rd <="000100";
		dToWrite <= "00000000000000000000000000000100";
		
		wait for 15 ns;
		rd <="000101";
		dToWrite <= "00000000000000000000000000000101";	
		wait for 15 ns;
		
		rs1 <= "000000";
		rs2 <= "000001";
		wait for 15 ns;
		rs1 <= "000001";
		rs2 <= "000010";
		wait for 15 ns;
		rs1 <= "000010";
		rs2 <= "000011";
		wait for 15 ns;
		rs1 <= "000011";
		rs2 <= "000100";
		wait for 15 ns;
		rs1 <= "000100";
		rs2 <= "000101";
		wait for 15 ns;


      -- insert stimulus here 

   
   end process;

END;
