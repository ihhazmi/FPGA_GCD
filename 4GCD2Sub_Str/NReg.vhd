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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity RegN is
	generic (N : integer := 16);
	port (
				CLK, Reset, En: in STD_LOGIC;
				D: in STD_LOGIC_VECTOR(N-1 downto 0); -- Input bus
				Q: out STD_LOGIC_VECTOR (N-1 downto 0) 
			); 
end RegN;

architecture VregN of RegN is
begin
	process(CLK, Reset, En)
	begin
		if (Reset = '1') then
			Q <= (others => '0');
		else if (CLK'event and CLK='1') then
			IF (En ='1') THEN
				Q <= D;
			ELSE
				NULL;
			END IF;
		end if;
		end if;
	end process;
end VregN;