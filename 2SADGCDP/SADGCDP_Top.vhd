----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:39:04 11/17/2014 
-- Design Name: 
-- Module Name:    GCD_Str_Top - Behavioral 
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

--use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity GCD_Str_Top is
	generic (N : integer := 16);
    Port ( A, B 					: in  STD_LOGIC_VECTOR (N-1 downto 0);
           Clk, Reset, Start	: in  STD_LOGIC;
           GCD 					: out  STD_LOGIC_VECTOR (N-1 downto 0);
           Finish 				: out  STD_LOGIC);
end GCD_Str_Top;

architecture Behavioral of GCD_Str_Top is

Component GCD_FSM IS
	PORT(		clk, Reset, Start, AEB, AGB, ALB	: IN  	STD_LOGIC;
				EnA, EnB, SelA, SelB		: OUT   	STD_LOGIC
			);
End Component;
Component SAD is
    Port ( 	I1, I2 : in  STD_LOGIC_VECTOR (N-1 downto 0);
				GNA : INout  STD_LOGIC;
				SUBA : out  STD_LOGIC_VECTOR (N-1 downto 0)
			);
End Component;
Component RegN is
	PORT(		C, R, E	: in STD_LOGIC;
				D	: in STD_LOGIC_VECTOR(N/4-1 downto 0); -- Input bus
				Q	: out STD_LOGIC_VECTOR (N/4-1 downto 0) 
				); 
End Component;
Component Mux2_1N IS
	PORT(		A, B: IN STD_LOGIC_VECTOR(N/4-1 DOWNTO 0); --input a
				S 	 : IN STD_LOGIC; --select input
				O 	 : OUT STD_LOGIC_VECTOR(N/4-1 DOWNTO 0) --data output
	);
End Component;

-- SIGNALS DECLARATION
Signal AM, AR, BM, BR, ABSD	: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
Signal AGB, AEB, ALB, EnA, EnB, SelA, SelB, OR0, OR1, NAEB: STD_LOGIC;

-- 2-1 MUXA  LOCATIONS ATTRIBUTES
 attribute LOC: string;
 attribute LOC of MUX_A40 : label is "SLICE_X5Y8";
 attribute LOC of MUX_A41 : label is "SLICE_X5Y8";
 attribute LOC of MUX_A42 : label is "SLICE_X5Y9";
 attribute LOC of MUX_A43 : label is "SLICE_X5Y9";
-- 2-1 MUXB  LOCATIONS ATTRIBUTES
 attribute LOC of MUX_B40 : label is "SLICE_X5Y10";
 attribute LOC of MUX_B41 : label is "SLICE_X5Y10";
 attribute LOC of MUX_B42 : label is "SLICE_X5Y11";
 attribute LOC of MUX_B43 : label is "SLICE_X5Y11";
 
-- FD REGA LOCATIONS ATTRIBUTES
 attribute LOC of Reg_A40 : label is "SLICE_X5Y8";
 attribute LOC of Reg_A41 : label is "SLICE_X5Y8";
 attribute LOC of Reg_A42 : label is "SLICE_X5Y9";
 attribute LOC of Reg_A43 : label is "SLICE_X5Y9";
-- FD REGB LOCATIONS ATTRIBUTES
 attribute LOC of Reg_B40 : label is "SLICE_X5Y10";
 attribute LOC of Reg_B41 : label is "SLICE_X5Y10";
 attribute LOC of Reg_B42 : label is "SLICE_X5Y11";
 attribute LOC of Reg_B43 : label is "SLICE_X5Y11";
--
-- OR (AEB) LOCATIONS ATTRIBUTES
 attribute LOC of OR_0 : label is "SLICE_X7Y8";
 attribute LOC of OR_1 : label is "SLICE_X7Y8";
 attribute LOC of OR_2 : label is "SLICE_X7Y8";


begin

-- Input / Output	Buffers Generator
--IBUF_00: IBUF port map (O => AB(0), I => A(0));
--IBUF_01: IBUF port map (O => AB(1), I => A(1));
--IBUF_02: IBUF port map (O => AB(2), I => A(2));
--IBUF_03: IBUF port map (O => AB(3), I => A(3));
--IBUF_04: IBUF port map (O => AB(4), I => A(4));
--IBUF_05: IBUF port map (O => AB(5), I => A(5));
--IBUF_06: IBUF port map (O => AB(6), I => A(6));
--IBUF_07: IBUF port map (O => AB(7), I => A(7));
--IBUF_08: IBUF port map (O => AB(8), I => A(8));
--IBUF_09: IBUF port map (O => AB(9), I => A(9));
--IBUF_0A: IBUF port map (O => AB(10), I => A(10));
--IBUF_0B: IBUF port map (O => AB(11), I => A(11));
--IBUF_0C: IBUF port map (O => AB(12), I => A(12));
--IBUF_0D: IBUF port map (O => AB(13), I => A(13));
--IBUF_0E: IBUF port map (O => AB(14), I => A(14));
--IBUF_0F: IBUF port map (O => AB(15), I => A(15));
---- Input2
--IBUF_10: IBUF port map (O => BB(0), I => B(0));
--IBUF_11: IBUF port map (O => BB(1), I => B(1));
--IBUF_12: IBUF port map (O => BB(2), I => B(2));
--IBUF_13: IBUF port map (O => BB(3), I => B(3));
--IBUF_14: IBUF port map (O => BB(4), I => B(4));
--IBUF_15: IBUF port map (O => BB(5), I => B(5));
--IBUF_16: IBUF port map (O => BB(6), I => B(6));
--IBUF_17: IBUF port map (O => BB(7), I => B(7));
--IBUF_18: IBUF port map (O => BB(8), I => B(8));
--IBUF_19: IBUF port map (O => BB(9), I => B(9));
--IBUF_1A: IBUF port map (O => BB(10), I => B(10));
--IBUF_1B: IBUF port map (O => BB(11), I => B(11));
--IBUF_1C: IBUF port map (O => BB(12), I => B(12));
--IBUF_1D: IBUF port map (O => BB(13), I => B(13));
--IBUF_1E: IBUF port map (O => BB(14), I => B(14));
--IBUF_1F: IBUF port map (O => BB(15), I => B(15));
---- Output
--OBUF_0: OBUF port map (O => GCDB(0), I => GCD(0));
--OBUF_1: OBUF port map (O => GCDB(1), I => GCD(1));
--OBUF_2: OBUF port map (O => GCDB(2), I => GCD(2));
--OBUF_3: OBUF port map (O => GCDB(3), I => GCD(3));
--OBUF_4: OBUF port map (O => GCDB(4), I => GCD(4));
--OBUF_5: OBUF port map (O => GCDB(5), I => GCD(5));
--OBUF_6: OBUF port map (O => GCDB(6), I => GCD(6));
--OBUF_7: OBUF port map (O => GCDB(7), I => GCD(7));
--OBUF_8: OBUF port map (O => GCDB(8), I => GCD(8));
--OBUF_9: OBUF port map (O => GCDB(9), I => GCD(9));
--OBUF_A: OBUF port map (O => GCDB(10), I => GCD(10));
--OBUF_B: OBUF port map (O => GCDB(11), I => GCD(11));
--OBUF_C: OBUF port map (O => GCDB(12), I => GCD(12));
--OBUF_D: OBUF port map (O => GCDB(13), I => GCD(13));
--OBUF_E: OBUF port map (O => GCDB(14), I => GCD(14));
--OBUF_F: OBUF port map (O => GCDB(15), I => GCD(15));


-- SelA <= AGB & EnA <= '1' at S0, then EnA <= AGB;
-- SelA <= ALB & EnB <= '1' at S0, then EnB <= ALB;;

-- TRICKY PORTMAPPING (MUXA, MUXB, REGA, REGB)
-- MUXA
MUX_A40:	Mux2_1N 	port map
	(A(3 DOWNTO 0), ABSD(3 DOWNTO 0), SelA, AM(3 DOWNTO 0)); -- Controlled by AGB Signal
MUX_A41:	Mux2_1N 	port map
	(A(7 DOWNTO 4), ABSD(7 DOWNTO 4), SelA, AM(7 DOWNTO 4)); -- Controlled by AGB Signal
MUX_A42:	Mux2_1N 	port map
	(A(11 DOWNTO 8), ABSD(11 DOWNTO 8), SelA, AM(11 DOWNTO 8)); -- Controlled by AGB Signal
MUX_A43:	Mux2_1N 	port map
	(A(15 DOWNTO 12), ABSD(15 DOWNTO 12), SelA, AM(15 DOWNTO 12)); -- Controlled by AGB Signal
-- MUXB
Mux_B40:	Mux2_1N 	port map
	(B(3 DOWNTO 0), ABSD(3 DOWNTO 0), SelB, BM(3 DOWNTO 0)); -- Controlled by ALB Signal
Mux_B41:	Mux2_1N 	port map
	(B(7 DOWNTO 4), ABSD(7 DOWNTO 4), SelB, BM(7 DOWNTO 4)); -- Controlled by ALB Signal
Mux_B42:	Mux2_1N 	port map
	(B(11 DOWNTO 8), ABSD(11 DOWNTO 8), SelB, BM(11 DOWNTO 8)); -- Controlled by ALB Signal
Mux_B43:	Mux2_1N 	port map
	(B(15 DOWNTO 12), ABSD(15 DOWNTO 12), SelB, BM(15 DOWNTO 12)); -- Controlled by ALB Signal
-- REGA
Reg_A40:	RegN 		port map
	(clk, Reset, EnA,	AM(3 DOWNTO 0), AR(3 DOWNTO 0));
Reg_A41:	RegN 		port map
	(clk, Reset, EnA,	AM(7 DOWNTO 4), AR(7 DOWNTO 4));
Reg_A42:	RegN 		port map
	(clk, Reset, EnA,	AM(11 DOWNTO 8), AR(11 DOWNTO 8));
Reg_A43:	RegN 		port map
	(clk, Reset, EnA,	AM(15 DOWNTO 12), AR(15 DOWNTO 12));
-- REGB
Reg_B40:	RegN 		port map
	(clk, Reset, EnB, BM(3 DOWNTO 0), BR(3 DOWNTO 0));
Reg_B41:	RegN 		port map
	(clk, Reset, EnB, BM(7 DOWNTO 4), BR(7 DOWNTO 4));
Reg_B42:	RegN 		port map
	(clk, Reset, EnB, BM(11 DOWNTO 8), BR(11 DOWNTO 8));
Reg_B43:	RegN 		port map
	(clk, Reset, EnB, BM(15 DOWNTO 12), BR(15 DOWNTO 12));

-- AEB CALCULATION <= NOT(OR (ABSD))
OR_0: LUT6 generic map (INIT => X"FFFFFFFFFFFFFFFE")
  port map (O => OR0, I5 => ABSD(0), I4 => ABSD(1), 
  I3 => ABSD(2), I2 => ABSD(3), I1 => ABSD(4), I0 => ABSD(5));
OR_1: LUT6 generic map (INIT => X"FFFFFFFFFFFFFFFE")
  port map (O => OR1, I5 => ABSD(6), I4 => ABSD(7), 
  I3 => ABSD(8), I2 => ABSD(9), I1 => ABSD(10), I0 => ABSD(11));
OR_2: LUT4 generic map (INIT => X"FFFE")
  port map (O => NAEB, I3 => ABSD(12), I2 => ABSD(13), 
  I1 => ABSD(14), I0 => ABSD(15));

AEB <= NOT NAEB;
ALB <= AGB NOR AEB;

-- DIECT Port mapping
FSM_GCD:	GCD_FSM 	port map(clk, Reset, Start, AEB, AGB, ALB, EnA, EnB, SelA, SelB); 
SADAB:	SAD 	port map(AR, BR, AGB, ABSD);

GCD 		<= BR; 
Finish   <= AEB;
end Behavioral;

