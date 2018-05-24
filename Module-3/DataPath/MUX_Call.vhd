----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:41:45 05/24/2018 
-- Design Name: 
-- Module Name:    MUX_Call - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;




entity MUX_Call is
    Port ( Rd : in  STD_LOGIC_VECTOR (5 downto 0);
           CallRD : in  STD_LOGIC_VECTOR (5 downto 0);
           RFdest : in  STD_LOGIC;
           NRD : out  STD_LOGIC_VECTOR (5 downto 0));
end MUX_Call;

architecture Behavioral of MUX_Call is

begin


end Behavioral;

