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
				EnA, EnB	: OUT   	STD_LOGIC
			);
End Component;
Component RegN is
	PORT(		clk, Reset, En	: in STD_LOGIC;
				D					: in STD_LOGIC_VECTOR(N-1 downto 0); -- Input bus
				Q					: out STD_LOGIC_VECTOR (N-1 downto 0) 
				); 
End Component;
Component Mux2_1N IS
	PORT(		ina, inb: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input a
				sel 		: IN STD_LOGIC; --select input
				output 	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0) --data output
	);
End Component;
Component SubN IS
	PORT(		ina, inb : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input a
				outc : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) --data output
			);
End Component;
Component CmpN is
	port(		A,B   : in std_logic_vector(N-1 downto 0);
				AGB  : out std_logic;
				AEB  : out std_logic
			);
End Component;

-- SIGNALS DECLARATION
Signal AM, AR, AS, BM, BR, BS	: STD_LOGIC_VECTOR(N-1 DOWNTO 0):= (others => '0');
Signal AGB, AEB, ALB, EnA, EnB 	: STD_LOGIC;

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

--Process(AS)
--	variable temp_OR :STD_LOGIC;
--	begin
--	temp_OR:= AS(0);
--	for i in 1 to 15 loop
--		temp_OR := temp_OR OR AS(i);
--	end loop;
--	AEB <= NOT temp_OR;	
--end process;

ALB <= AGB NOR AEB;
-- SelA <= AGB & EnA <= '1' at S0, then EnA <= AGB;
-- SelA <= ALB & EnB <= '1' at S0, then EnB <= ALB;;


-- Port mapping
FSM_GCD:	GCD_FSM 	port map(clk,	Reset, Start, AEB, AGB, ALB, EnA, EnB); -- Finish when AEB = '1';
Cmp_AB:	CmpN 		port map(AR, 	BR, 		AGB,		AEB);
Mux_A:	Mux2_1N 	port map(A, 	AS, 		AGB,		AM); -- Controlled by AGB Signal
Mux_B:	Mux2_1N 	port map(B, 	BS, 		ALB, 		BM); -- Controlled by AGB Signal
Reg_A:	RegN 		port map(clk, 	Reset,	EnA,		AM, 		AR);
Reg_B:	RegN 		port map(clk, 	Reset,	EnB,		BM, 		BR);
Sub_A:	SubN 		port map(AR,	BR,		AS);
Sub_B:	SubN 		port map(BR,	AR,		BS);

GCD 		<= BR; 
Finish 	<= AEB;
end Behavioral;

