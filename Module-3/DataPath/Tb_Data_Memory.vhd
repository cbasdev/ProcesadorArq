
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Tb_Data_Memory IS
END Tb_Data_Memory;
 
ARCHITECTURE behavior OF Tb_Data_Memory IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Data_Memory
    PORT(
         Address : IN  std_logic_vector(31 downto 0);
         WriteData : IN  std_logic_vector(31 downto 0);
         MemRead : IN  std_logic;
         MemWrite : IN  std_logic;
         ReadData : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Address : std_logic_vector(31 downto 0) := (others => '0');
   signal WriteData : std_logic_vector(31 downto 0) := (others => '0');
   signal MemRead : std_logic := '0';
   signal MemWrite : std_logic := '0';

 	--Outputs
   signal ReadData : std_logic_vector(31 downto 0);
  
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.Data_Memory (behavioral) PORT MAP (
          Address => Address,
          WriteData => WriteData,
          MemRead => MemRead,
          MemWrite => MemWrite,
          ReadData => ReadData
        );



   -- Stimulus process
   stim_proc: process
   begin		
      Address <= "00000000000000000000000000101101";
      WriteData <= "00000000000000000110110000000000";
		MemWrite <= '0';
		wait for 100 ns;		
		MemWrite <= '1';		
		wait for 100 ns;
		
		
      Address <= "00000000000000000000000110101101";
      WriteData <= "00000000000000000110110001000000";			
		MemRead <= '0';
		wait for 100 ns;		
		MemRead <= '1';		
		wait for 100 ns;		

  

   
		
		
		
   end process;

END;
