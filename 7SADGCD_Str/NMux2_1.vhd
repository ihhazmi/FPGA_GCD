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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

---------------------------------------------------------------------
--2:1 mux, 16 bits wide
---------------------------------------------------------------------

ENTITY Mux2_1N IS
	generic (N : integer := 16);
	PORT(
				ina, inb	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input a
				sel 		: IN STD_LOGIC; --select input
				output	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0) --data output
			);
END Mux2_1N;

ARCHITECTURE beh OF Mux2_1N IS
BEGIN
	WITH sel SELECT
		output <= ina WHEN '0',
		inb WHEN '1',
		(OTHERS => 'X') WHEN OTHERS;
END beh;