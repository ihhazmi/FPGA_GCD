----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:41:58 10/10/2014 
-- Design Name: 	 GCD_Nbit
-- Module Name:    Reg16_Beh - Behavioral 
-- Project Name:   GCD_Nbit  Implementation.
-- Target Devices: SPARTAN6 - XC6SLX45T
-- Tool versions:  ISE 13.4
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

--use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;


entity RegN is
	generic (N : integer := 4);
	port (
				C, R, E: in STD_LOGIC;
				D: in STD_LOGIC_VECTOR(N-1 downto 0); -- Input bus
				Q: out STD_LOGIC_VECTOR (N-1 downto 0) 
			); 
end RegN;

architecture beh of RegN is


begin

	process(C, R, E)
	begin
		if (R = '1') then
			Q <= (others => '0');
		else if (C'event and C='1') then
			IF (E ='1') THEN
				Q <= D;
			ELSE
				NULL;
			END IF;
		end if;
		end if;
	end process;

end beh;