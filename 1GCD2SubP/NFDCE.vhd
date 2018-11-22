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

architecture STR_REGN of RegN is

---- FD  LOCATIONS ATTRIBUTES
-- attribute LOC: string;
-- attribute LOC of FD_00 : label is "SLICE_X9Y8";
-- attribute LOC of FD_01 : label is "SLICE_X9Y8";
-- attribute LOC of FD_02 : label is "SLICE_X9Y8";
-- attribute LOC of FD_03 : label is "SLICE_X9Y8";
--


begin

-- PROPAGATION FDCES
FD_00: FDCE generic map (INIT => '0')
 port map (Q => Q(0), C => C, CE => E, CLR => R, D => D(0));
FD_01: FDCE generic map (INIT => '0')
 port map (Q => Q(1), C => C, CE => E, CLR => R, D => D(1));
FD_02: FDCE generic map (INIT => '0')
 port map (Q => Q(2), C => C, CE => E, CLR => R, D => D(2));
FD_03: FDCE generic map (INIT => '0')
 port map (Q => Q(3), C => C, CE => E, CLR => R, D => D(3));

end STR_REGN;