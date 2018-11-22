----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:17:54 11/14/2014 
-- Design Name: 
-- Module Name:    GCD_Beh2 - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GCD_Beh2 is
		generic (N : integer := 16);
		Port(	--clk		: in  std_logic;
				A, B		: in   Signed (N-1 downto 0);
				GCD 		: out  Signed (N-1 downto 0)
			);
end GCD_Beh2;

architecture Behavioral of GCD_Beh2 is
Constant max_itr: integer := 100;
signal AA, BB, Tmp_GCD:	Signed (N-1 downto 0);

begin

--	PROCESS (clk)
--	BEGIN
--		IF (clk'event and clk='1') THEN
--			AA 	<= B;
--			BB 	<= A;
--			GCD 	<= Tmp_GCD;
--		END IF;
--	END PROCESS;


	Process (A, B)
	Variable AX, BX: Signed (N-1 downto 0);
	Begin
		AX := A;
		BX := B;
		for i in 1 to max_itr Loop
			If  (AX /= BX) Then
				If (AX > BX) Then
					AX := AX - BX;
				Else
					BX := BX - AX;
				End If;
				Tmp_GCD <= (Others => '0');
			Else
				Tmp_GCD <= BX;
				Exit;
			End If;
		End Loop;
	End Process;
GCD 	<= Tmp_GCD;
end Behavioral;

