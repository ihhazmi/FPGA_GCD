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

entity CLASUB is
	generic (N : integer := 16);
    Port ( 	I1, I2 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				GNA, GNB : out  STD_LOGIC;
				SUBA, SUBB : out  STD_LOGIC_VECTOR (N-1 downto 0)
				);
end CLASUB;
architecture Behavioral of CLASUB is

-- COMPONENT DECLARATION

Component XORN is
	PORT(
				A, B	: IN STD_LOGIC_VECTOR(N/4-1 DOWNTO 0);
				O	: OUT STD_LOGIC_VECTOR(N/4-1 DOWNTO 0) 
			);
End Component;
--SIGNALS DECLARARION;
Signal NI2, GA, PA, CA : STD_LOGIC_VECTOR(N-1 downto 0);
Signal NI1, GB, PB, CB : STD_LOGIC_VECTOR(N-1 downto 0);

-- SUBA
-- CARRY4 LOCATIONS ATTRIBUTES
 attribute LOC: string;
 attribute LOC of CARRY4_A0 : label is "SLICE_X2Y8";
 attribute LOC of CARRY4_A1 : label is "SLICE_X2Y9";
 attribute LOC of CARRY4_A2 : label is "SLICE_X2Y10";
 attribute LOC of CARRY4_A3 : label is "SLICE_X2Y11";
-- XOR  LOCATIONS ATTRIBUTES
 attribute LOC of XOR_A40 : label is "SLICE_X2Y8";
 attribute LOC of XOR_A41 : label is "SLICE_X2Y9";
 attribute LOC of XOR_A42 : label is "SLICE_X2Y10";
 attribute LOC of XOR_A43 : label is "SLICE_X2Y11";

-- SUBB
-- CARRY4 LOCATIONS ATTRIBUTES
 attribute LOC of CARRY4_B0 : label is "SLICE_X2Y12";
 attribute LOC of CARRY4_B1 : label is "SLICE_X2Y13";
 attribute LOC of CARRY4_B2 : label is "SLICE_X2Y14";
 attribute LOC of CARRY4_B3 : label is "SLICE_X2Y15";
-- XOR  LOCATIONS ATTRIBUTES
 attribute LOC of XOR_B40 : label is "SLICE_X2Y12";
 attribute LOC of XOR_B41 : label is "SLICE_X2Y13";
 attribute LOC of XOR_B42 : label is "SLICE_X2Y14";
 attribute LOC of XOR_B43 : label is "SLICE_X2Y15";

begin

NI1 <= NOT I1;
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

--SUBB PORTMAPPING
-- PROPAGATION XORS
XOR_B40: XORN port map
 (O => PB(3 DOWNTO 0), A => NI1(3 DOWNTO 0), B => I2(3 DOWNTO 0));
XOR_B41: XORN port map
 (O => PB(7 DOWNTO 4), A => NI1(7 DOWNTO 4), B => I2(7 DOWNTO 4));
XOR_B42: XORN port map
 (O => PB(11 DOWNTO 8), A => NI1(11 DOWNTO 8), B => I2(11 DOWNTO 8));
XOR_B43: XORN port map
 (O => PB(15 DOWNTO 12), A => NI1(15 DOWNTO 12), B => I2(15 DOWNTO 12));


--  GNA, GNB
GNA <= CA(15);
GNB <= CB(15);

-- CARRY4 Prot Mapping
-- SUBA
CARRY4_A0 : CARRY4
port map (
CO => CA(3 DOWNTO 0), -- 4-bit carry out
O => SUBA(3 DOWNTO 0), -- 4-bit carry chain XOR data out
CI => '1', -- 1-bit carry cascade input
CYINIT => '0', -- 1-bit carry initialization
DI => I1(3 DOWNTO 0), -- 4-bit carry-MUX data in
S => PA(3 DOWNTO 0) -- 4-bit carry-MUX select input
);

CARRY4_A1 : CARRY4
port map (
CO => CA(7 DOWNTO 4), 
O 	=> SUBA(7 DOWNTO 4), 
CI => CA(3), 
CYINIT => '0', 
DI => I1(7 DOWNTO 4), 
S 	=> PA(7 DOWNTO 4) 
);

CARRY4_A2 : CARRY4
port map (
CO => CA(11 DOWNTO 8), 
O 	=> SUBA(11 DOWNTO 8), 
CI => CA(7), 
CYINIT => '0', 
DI => I1(11 DOWNTO 8), 
S 	=> PA(11 DOWNTO 8) 
);

CARRY4_A3 : CARRY4
port map (
CO => CA(15 DOWNTO 12), 
O => SUBA(15 DOWNTO 12), 
CI => CA(11), 
CYINIT => '0', 
DI => I1(15 DOWNTO 12), 
S => PA(15 DOWNTO 12) 
);

-- SUBB
CARRY4_B0 : CARRY4
port map (
CO => CB(3 DOWNTO 0), -- 4-bit carry out
O => SUBB(3 DOWNTO 0), -- 4-bit carry chain XOR data out
CI => '1', -- 1-bit carry cascade input
CYINIT => '0', -- 1-bit carry initialization
DI => I2(3 DOWNTO 0), -- 4-bit carry-MUX data in
S => PB(3 DOWNTO 0) -- 4-bit carry-MUX select input
);

CARRY4_B1 : CARRY4
port map (
CO => CB(7 DOWNTO 4), 
O 	=> SUBB(7 DOWNTO 4), 
CI => CB(3), 
CYINIT => '0', 
DI => I2(7 DOWNTO 4), 
S 	=> PB(7 DOWNTO 4) 
);

CARRY4_B2 : CARRY4
port map (
CO => CB(11 DOWNTO 8), 
O 	=> SUBB(11 DOWNTO 8), 
CI => CB(7), 
CYINIT => '0', 
DI => I2(11 DOWNTO 8), 
S 	=> PB(11 DOWNTO 8) 
);

CARRY4_B3 : CARRY4
port map (
CO => CB(15 DOWNTO 12), 
O => SUBB(15 DOWNTO 12), 
CI => CB(11), 
CYINIT => '0', 
DI => I2(15 DOWNTO 12), 
S => PB(15 DOWNTO 12) 
);

end Behavioral;


