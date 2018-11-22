----------------------------------------------------------------------------------
-- Company:  UNIVERSITY OF VICTORIA - Dept. of Electrical & Computer Engineering.
-- Engineer: Ibrahim Hazmi - ihaz@ece.uvic.ca
-- 
-- Create Date:    20:17:12 10/10/2014 
-- Design Name: 
-- Module Name:    MUX2_1_16b - Behavioral 
-- Project Name: 
-- Project Name:   GCD_Nbit  Implementation.
-- Target Devices: SPARTAN6 - XC6SLX45T
-- Tool versions:  ISE 13.4
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

---------------------------------------------------------------------
--2:1 mux, N bits wide
---------------------------------------------------------------------

ENTITY Mux2_1N IS
	generic (N : integer := 4);
	PORT(
				A, B	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input a
				S 		: IN STD_LOGIC; --select input
				O	: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) --data output
			);
END Mux2_1N;

ARCHITECTURE STR_MUXN OF Mux2_1N IS

---- 2-1 MUX  LOCATIONS ATTRIBUTES
-- attribute LOC: string;
-- attribute LOC of MUX_0 : label is "SLICE_X8Y8";
-- attribute LOC of MUX_1 : label is "SLICE_X8Y8";
-- attribute LOC of MUX_2 : label is "SLICE_X8Y8";
-- attribute LOC of MUX_3 : label is "SLICE_X8Y8";


BEGIN
-- PROPAGATION XORS
MUX_0: LUT3 generic map (INIT => X"AC")
  port map (O => O(0), I2 => S, I1 => A(0), I0 => B(0));
MUX_1: LUT3 generic map (INIT => X"AC")
  port map (O => O(1), I2 => S, I1 => A(1), I0 => B(1));
MUX_2: LUT3 generic map (INIT => X"AC")
  port map (O => O(2), I2 => S, I1 => A(2), I0 => B(2));
MUX_3: LUT3 generic map (INIT => X"AC")
  port map (O => O(3), I2 => S, I1 => A(3), I0 => B(3));

END STR_MUXN;