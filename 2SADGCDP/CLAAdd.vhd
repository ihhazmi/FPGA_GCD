----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Ibrahim Hazmi
-- 
-- Create Date:    14:18:54 11/25/2014 
-- Design Name: 
-- Module Name:    CLAAdd - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity SAD is
	generic (N : integer := 16);
    Port ( 	I1, I2 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				GNA : INout  STD_LOGIC;
				SUBA : out  STD_LOGIC_VECTOR (N-1 downto 0)
				);
end SAD;
architecture Behavioral of SAD is

-- COMPONENT DECLARATION

Component XORN is
	PORT(
				A, B	: IN STD_LOGIC_VECTOR(N/4-1 DOWNTO 0);
				O	: OUT STD_LOGIC_VECTOR(N/4-1 DOWNTO 0) 
			);
End Component;
Component ANDN is
	PORT(
				A, B	: IN STD_LOGIC_VECTOR(N/4-1 DOWNTO 0);
				O	: OUT STD_LOGIC_VECTOR(N/4-1 DOWNTO 0) 
			);
End Component;

--SIGNALS DECLARARION;
Signal NI2, GA, PA, C1A, I1X : STD_LOGIC_VECTOR(N-1 downto 0);
Signal GB4A, PB4A : STD_LOGIC_VECTOR(N/4 downto 1);
Signal C4A, C8A, C12A, GB8A, PB8A, NGNA : STD_LOGIC;

-- SUBA
-- CARRY4 LOCATIONS ATTRIBUTES
 attribute LOC: string;
 attribute LOC of CARRY4_A0 : label is "SLICE_X6Y8";
 attribute LOC of CARRY4_A1 : label is "SLICE_X6Y9";
 attribute LOC of CARRY4_A2 : label is "SLICE_X6Y10";
 attribute LOC of CARRY4_A3 : label is "SLICE_X6Y11";
-- XOR  LOCATIONS ATTRIBUTES
 attribute LOC of XOR_A40 : label is "SLICE_X6Y8";
 attribute LOC of XOR_A41 : label is "SLICE_X6Y9";
 attribute LOC of XOR_A42 : label is "SLICE_X6Y10";
 attribute LOC of XOR_A43 : label is "SLICE_X6Y11";
-- AND  LOCATIONS ATTRIBUTES
 attribute LOC of AND_A40 : label is "SLICE_X6Y12";
 attribute LOC of AND_A41 : label is "SLICE_X6Y12";
 attribute LOC of AND_A42 : label is "SLICE_X6Y13";
 attribute LOC of AND_A43 : label is "SLICE_X6Y13";
-- THE ABSOLUTE  XORS LOCATIONS ATTRIBUTES
 attribute LOC of XOR_A400 : label is "SLICE_X5Y12";
 attribute LOC of XOR_A410 : label is "SLICE_X5Y12";
 attribute LOC of XOR_A420 : label is "SLICE_X5Y13";
 attribute LOC of XOR_A430 : label is "SLICE_X5Y13";


begin

NI2 <= NOT I2;

--SUBA PORTMAPPING
-- PROPAGATION XORS
XOR_A40: XORN port map
 (O => PA(3 DOWNTO 0), A => I1(3 DOWNTO 0), B => NI2(3 DOWNTO 0));
XOR_A41: XORN port map
 (O => PA(7 DOWNTO 4), A => I1(7 DOWNTO 4), B => NI2(7 DOWNTO 4));
XOR_A42: XORN port map
 (O => PA(11 DOWNTO 8), A => I1(11 DOWNTO 8), B => NI2(11 DOWNTO 8));
XOR_A43: XORN port map
 (O => PA(15 DOWNTO 12), A => I1(15 DOWNTO 12), B => NI2(15 DOWNTO 12));
--GENERATION ANDS
AND_A40: ANDN port map
 (O => GA(3 DOWNTO 0), A => I1(3 DOWNTO 0), B => NI2(3 DOWNTO 0));
AND_A41: ANDN port map
 (O => GA(7 DOWNTO 4), A => I1(7 DOWNTO 4), B => NI2(7 DOWNTO 4));
AND_A42: ANDN port map
 (O => GA(11 DOWNTO 8), A => I1(11 DOWNTO 8), B => NI2(11 DOWNTO 8));
AND_A43: ANDN port map
 (O => GA(15 DOWNTO 12), A => I1(15 DOWNTO 12), B => NI2(15 DOWNTO 12));

-- A BLOCKS FOR GNA, CnA
-- GP_LOCKS
AGPBLOCK: FOR i IN 1 TO (N/4) generate
PB4A(i) <= PA(4*i-1) AND PA(4*i-2) AND PA(4*i-3)AND PA(4*i-4);
GB4A(i) <= GA(4*i-1) OR (GA(4*i-2) AND PA(4*i-1)) OR 
								(GA(4*i-3) AND PA(4*i-1) AND PA(4*i-2)) OR
								(GA(4*i-4) AND PA(4*i-1) AND PA(4*i-2) AND PA(4*i-3)); 
END Generate AGPBLOCK;

-- GN_SUPBLOCK to descide IF A>B!
GNA <= GB4A(4) OR (GB4A(3) AND PB4A(4)) OR 
						(GB4A(2) AND PB4A(4) AND PB4A(3)) OR
						(GB4A(1) AND PB4A(4) AND PB4A(3) AND PB4A(2)); 

--
NGNA <= NOT GNA;
-- THE ABSOLUTE SUBTRACTION PROPAGATION XORS
XOR_A400: XORN port map
 (O => I1X(3 DOWNTO 0), A => I1(3 DOWNTO 0), 
  B(3) => NGNA, B(2) => NGNA, B(1) => NGNA, B(0) => NGNA);
XOR_A410: XORN port map
 (O => I1X(7 DOWNTO 4), A => I1(7 DOWNTO 4), 
  B(3) => NGNA, B(2) => NGNA, B(1) => NGNA, B(0) => NGNA);
XOR_A420: XORN port map
 (O => I1X(11 DOWNTO 8), A => I1(11 DOWNTO 8), 
  B(3) => NGNA, B(2) => NGNA, B(1) => NGNA, B(0) => NGNA);
XOR_A430: XORN port map
 (O => I1X(15 DOWNTO 12), A => I1(15 DOWNTO 12), 
  B(3) => NGNA, B(2) => NGNA, B(1) => NGNA, B(0) => NGNA);


-- CARRY4 Prot Mapping
-- SUBA
CARRY4_A0 : CARRY4
port map (
CO => C1A(3 DOWNTO 0), -- 4-bit carry out
O => SUBA(3 DOWNTO 0), -- 4-bit carry chain XOR data out
CI => GNA, -- 1-bit carry cascade input
CYINIT => '0', -- 1-bit carry initialization
DI => I1X(3 DOWNTO 0), -- 4-bit carry-MUX data in
S => PA(3 DOWNTO 0) -- 4-bit carry-MUX select input
);

CARRY4_A1 : CARRY4
port map (
CO => C1A(7 DOWNTO 4), 
O 	=> SUBA(7 DOWNTO 4), 
CI => C1A(3), 
CYINIT => '0', 
DI => I1X(7 DOWNTO 4), 
S 	=> PA(7 DOWNTO 4) 
);

CARRY4_A2 : CARRY4
port map (
CO => C1A(11 DOWNTO 8), 
O 	=> SUBA(11 DOWNTO 8), 
CI => C1A(7), 
CYINIT => '0', 
DI => I1X(11 DOWNTO 8), 
S 	=> PA(11 DOWNTO 8) 
);

CARRY4_A3 : CARRY4
port map (
CO => C1A(15 DOWNTO 12), 
O => SUBA(15 DOWNTO 12), 
CI => C1A(11), 
CYINIT => '0', 
DI => I1X(15 DOWNTO 12), 
S => PA(15 DOWNTO 12) 
);


end Behavioral;


