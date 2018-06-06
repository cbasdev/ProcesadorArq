
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use std.textio.all;

entity ALU is
    Port ( CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           CRS2mux : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           C : in  STD_LOGIC;
           ALURESULT : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

	process (aluop,CRS2mux, crs1)
		begin
		
		case (aluop) is 
			when "000000" => -- equivale al op3 de la suma de enteros
				aluresult <= crs1 + CRS2mux  ;
			when "000001" => -- equivale al op3 del and para los enteros
				aluresult <= crs1 AND CRS2mux ;
			when "000101" =>-- equivale al and not para los enteros
				aluresult <= NOT(crs1 AND CRS2mux);
	      when "000010" =>-- equivale al or para los enteros
	         aluresult <= crs1 OR CRS2mux;
	      when "000110" => --equivale al or not para los enteros
	         aluresult <= NOT(crs1 OR CRS2mux);
	      when "000011" =>--equivale al xor  para los enteros
	         aluresult <= crs1 XOR CRS2mux ;
	      when "000111" =>--equivale al Xnor para los enteros
	         aluresult <= crs1 XNOR CRS2mux ;
			when "000100" => -- equivale al op3 de la resta de enteros
				aluresult <= crs1 - CRS2mux ;
				
				
				
			when "010000" => -- addcc
				aluresult <= crs1 + CRS2mux  ;
			when "011000" => --  addxcc
				aluresult <= crs1 + CRS2mux + c  ;
			when "001000" => -- addx
				aluresult <= crs1 + CRS2mux + c  ;
			when "010100" => -- subcc
				aluresult <= crs1 - CRS2mux ;
			when "011100" => -- suxcc
				aluresult <= crs1 - CRS2mux - c;
			when "001100" => -- subx
				aluresult <= crs1 - CRS2mux - c;
			when "010001" => -- andcc
				aluresult <= crs1 AND CRS2mux ;
			when "010101" => -- andncc
				aluresult <= NOT(crs1 AND CRS2mux);
			when "010010" => -- orcc
				aluresult <= crs1 OR CRS2mux;
			when "010110" => -- orncc
				aluresult <= NOT(crs1 OR CRS2mux);
			when "010011" => -- xorcc
				aluresult <= crs1 XOR CRS2mux ;
			when "010111" => -- xnorcc
				aluresult <= crs1 XNOR CRS2mux ;

			when "100101" => -- sll
				aluresult <= to_stdlogicvector((to_bitvector(CRS1)) sll conv_integer (CRS2mux));
				--aluresult <= crs1 + CRS2mux  ;
			when "100110" => -- srl
				aluresult <= to_stdlogicvector((to_bitvector(CRS1)) srl conv_integer (CRS2mux));
				--aluresult <= crs1 + CRS2mux  ;
			when "111100" => --  save
				aluresult <= crs1 + CRS2mux  ;
			when "111101" => -- restore
				aluresult <= crs1 + CRS2mux  ;
			
			when others =>
				aluresult <= "00000000000000000000000000000000";
   end case;
		
		
	end process;
end Behavioral;

