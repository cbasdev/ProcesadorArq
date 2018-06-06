library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;



entity ControUnit is
    Port ( ICC : in  STD_LOGIC_VECTOR (3 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP2 : in  STD_LOGIC_VECTOR (2 downto 0);
           COND : in  STD_LOGIC_VECTOR (3 downto 0);
           WE : out  STD_LOGIC;
           WEDM : out  STD_LOGIC;
           RFSOURCE : out  STD_LOGIC_VECTOR (1 downto 0);
           RFDEST : out  STD_LOGIC;
           PCSOURCE : out  STD_LOGIC_VECTOR (1 downto 0);
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end ControUnit;

architecture Behavioral of ControUnit is

begin
process(icc, op3, op, op2,cond)
begin
	--------------------------------------
	if op = "10" then
		
		if op3 ="111000" then --jmp and link
			ALUOP <= "000000";
			
			PCSOURCE <= "11"; -- pasa el resultado de la alu
			WE <= '1'; -- SE PUEDE ESCRIBIR EN RF
			WEDM <= '0'; --NO SE PUEDE ESCRIBIR EN DATA MEMORY
			RFSOURCE <= "10"; -- SE PASA A GUARDAR EN RD EL VALOR ACTUAL DEL PROGRAM COUNTER
			RFDEST <= '0';-- DESDE EL WINDOWS MANAGER PASA EL RD
		else 					-- operaciones matematicologicas de la ALU
			aluop <= op3;
			WE <= '1';
			WEDM <= '0';
			PCSOURCE <= "10"; --PASA EL VALOR DEL PC 
			RFSOURCE <= "01"; -- SE GUARDA EN RD EL VALOR DEL ALURESUTL
			RFDEST <= '0';-- DESDE EL WINDOWS MANAGER PASA EL RD
		end if;
	
	end if;
	---------------------------------------------------------
	
	if op = "11" then  -- operaciones de ld y st
		
		if op3 = "000000" then  --ld
		
			aluop <= "000000";
			WE <= '1';
			WEDM <= '0';
			PCSOURCE <= "10"; -- deja pasar el program counter
			RFSOURCE <= "00"; -- deja pasar la salida de el data memory
			RFDEST <= '0';-- debe pasar el rd a donde se hara el load
		
		end if;
		
		if op3 = "000100" then  --st
		
			aluop <= "000000";
			WE <= '0';
			WEDM <= '1';
			PCSOURCE <= "10"; -- deja pasar el program counter
			RFSOURCE <= "00"; -- deja pasar la salida de el data memory pero es indiferente pq no va escribir en el RF
			RFDEST <= '0';-- indiferetnte pq no va esccibir en ningun registro
		
		end if;

	end if;
---------------------------------------------------------------------------------------------	
	if op = "01" then --call
			aluop <= "000000";
			WE <= '1';-- debo escribir en el register file ya que voy a guardar la posicion del pc actual
			WEDM <= '0'; -- no escribo en el data memory
			PCSOURCE <= "00"; -- pasa pc+disp30 
			RFSOURCE <= "10"; -- dejo pasar el valor del pc para guardarlo en el RF
			RFDEST <= '1';-- guardo el registro en 07

	end if;
--------------------------------------------------------------------------------------------
--nzvx
--n	icc(3)
--z	icc(2)
--v	icc(1)
--c   icc(0)
	if op = "00" then
		if op2 = "010" then-- ES UN BRANCH
			case (COND) is 
				when "0001" =>
					if  icc(2) = '1'   then  -- si el salto es verdadero
						PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
					else
						PCSOURCE <= "10";  -- en caso contrario de pasar el pc que viene 
					end if;
				when "0010" =>
					if  (icc(2)  or (icc(3) xor icc(1))) = '1'  then  -- si el salto es verdadero Z or (N xor V)
						PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
					else
						PCSOURCE <= "10";  -- en caso contrario de pasar el pc que viene 
					end if;
				when "0011" =>
					if (icc(3) xor icc(1)) = '1'   then  -- si el salto es verdadero N xor V
						PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
					else
						PCSOURCE <= "10";  -- en caso contrario de pasar el pc que viene 
					end if;
				when "0100" =>
					if  (icc(0) or icc(2)) = '1' then  -- si el salto es verdadero (C or Z)
						PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
					else
						PCSOURCE <= "10";  -- en caso contrario de pasar el pc que viene 
					end if;
				when "0101" =>
					if  icc(0) = '1' then  -- si el salto es verdadero  C
						PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
					else
						PCSOURCE <= "10";  -- en caso contrario de pasar el pc que viene 
					end if;
				when "0110" =>
					if  icc(3) = '1' then  -- si el salto es verdadero N
						PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
					else
						PCSOURCE <= "10";  -- en caso contrario de pasar el pc que viene 
					end if;
				when "0111" =>
					if  icc(1) = '1'  then  -- si el salto es verdadero V
						PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
					else
						PCSOURCE <= "10";  -- en caso contrario de pasar el pc que viene 
					end if;
				when "1000" =>
					-- salto siempre
					PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
							
				when "1001" =>
					if ( not icc(2)) = '1'  then  -- si el salto es verdadero not Z
						PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
					else
						PCSOURCE <= "10";  -- en caso contrario de pasar el pc que viene 
					end if;
				when "1010" =>
					if ( not (icc(2) or (icc(3) xor icc(1)))) = '1'  then  -- si el salto es verdadero not (Z or (N xor V))
						PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
					else
						PCSOURCE <= "10";  -- en caso contrario de pasar el pc que viene 
					end if;
				when "1011" =>
					if  (not (icc(3) xor icc(1))) = '1'  then  -- si el salto es verdadero not (N xor V)
						PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
					else
						PCSOURCE <= "10";  -- en caso contrario de pasar el pc que viene 
					end if;
				when "1100" =>
					if  (not (icc(0) or icc(2))) = '1'  then  -- si el salto es verdadero not (C or Z)
						PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
					else
						PCSOURCE <= "10";  -- en caso contrario de pasar el pc que viene 
					end if;
				when "1101" =>
					if ( not icc(0)) = '1'  then  -- si el salto es verdadero not C
						PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
					else
						PCSOURCE <= "10";  -- en caso contrario de pasar el pc que viene 
					end if;
				when "1110" =>
					if  (not icc(3)) = '1'  then  -- si el salto es verdadero not N
						PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
					else
						PCSOURCE <= "10";  -- en caso contrario de pasar el pc que viene 
					end if;
				when "1111" =>
					if ( not(icc(1))) = '1'  then  -- si el salto es verdadero
						PCSOURCE <= "01"; --  para el NPC el valor sera pc+ disp22
					else
						PCSOURCE <= "10";  -- en caso contrario de pasar el pc que viene 
					end if;
				when others =>
					PCSOURCE <= "10";
			end case;
			
			aluop <= "000000";
			WE <= '0';
			WEDM <= '0';						
			RFSOURCE <= "01"; -- 
			RFDEST <= '0';-- 
		
		end if;
	end if;
	

end process;

end Behavioral;
