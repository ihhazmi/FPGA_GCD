----------------------------------------------------------------------------------
-- Company:  UNIVERSITY OF VICTORIA - Dept. of Electrical & Computer Engineering.
-- Engineer: Ibrahim Hazmi - ihaz@ece.uvic.ca
-- 
-- Create Date:    20:23:51 10/10/2014 
-- Design Name: 
-- Module Name:    Sub16_Beh - Behavioral 
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

use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
---------------------------------------------------------------------
-- 16 bit Multiplier Version 1
---------------------------------------------------------------------


ENTITY SubN IS
	generic (N : integer := 16);
	PORT(
				ina : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input a
				inb : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input b
				outc : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) --data output
			);
END SubN;

ARCHITECTURE SubN_beh OF SubN IS
BEGIN
	outc <= ina - inb;
END;



---------------------------------------------------------------------
-- 16 bit Multiplier Version 2
---------------------------------------------------------------------

--ibrary ieee;
--entity ripplesub is
--port(a,b: in bit_vector(15 downto 0);
--c0:inout bit;
--d:out bit_vector(15 downto 0);
--cout: out bit);
--end ripplesub;
--
--architecture struct of ripplesub is
--component fulladder is
--port(a,b,cin:in bit;
--s,cout:out bit);
--end component;
--signal c:bit_vector(3 downto 1);
--begin
--c0<='1';
--a0:fulladder port map(a(0),not b(0),c0,d(0),c(1));
--a1:fulladder port map(a(1),not b(1),c(1),d(1),c(2));
--a2:fulladder port map(a(2),not b(2),c(2),d(2),c(3));
--a3:fulladder port map(a(3),not b(3),c(3),d(3),cout);
-- *** Need modification!
--a4:fulladder port map(a(3),not b(3),c(3),d(3),cout);
--a5:fulladder port map(a(0),not b(0),c0,d(0),c(1));
--a6fulladder port map(a(1),not b(1),c(1),d(1),c(2));
--a7:fulladder port map(a(2),not b(2),c(2),d(2),c(3));
--a8:fulladder port map(a(3),not b(3),c(3),d(3),cout);
--a9:fulladder port map(a(0),not b(0),c0,d(0),c(1));
--a10:fulladder port map(a(1),not b(1),c(1),d(1),c(2));
--a11:fulladder port map(a(2),not b(2),c(2),d(2),c(3));
--a12:fulladder port map(a(3),not b(3),c(3),d(3),cout);
--a13:fulladder port map(a(0),not b(0),c0,d(0),c(1));
--a14:fulladder port map(a(1),not b(1),c(1),d(1),c(2));
--a15:fulladder port map(a(2),not b(2),c(2),d(2),c(3));

--end struct; 
--
----component:
--library ieee;
--entity fulladder is
--port(a,b,cin:in bit;
--s,cout:out bit);
--end fulladder;
--
--architecture dataflow of fulladder is
--begin
--s<= (a xor b) xor cin;
--cout<= (a and b)or (b and cin) or(a and cin);
--end dataflow;


---------------------------------------------------------------------
-- 16 bit Subtractor Version 3
---------------------------------------------------------------------

--entity CLA_ADD_SUB is
--generic (N : integer := 8);
--    Port ( A : in  STD_LOGIC_VECTOR (N-1 downto 0);
--           B : in  STD_LOGIC_VECTOR (N-1 downto 0);
--         Binv : in  STD_LOGIC;
--         C_in: in  STD_LOGIC;
--           S : out  STD_LOGIC_VECTOR (N-1 downto 0);
--         TEST : out  STD_LOGIC_VECTOR (N-1 downto 0);
--           C_out : out  STD_LOGIC
--           );
--end CLA_ADD_SUB;
--
--architecture CLA_ADD_SUB_ARCH of CLA_ADD_SUB is
--
--SIGNAL    h_sum              :    STD_LOGIC_VECTOR(N-1 DOWNTO 0);
--SIGNAL    carry_generate     :    STD_LOGIC_VECTOR(N-1 DOWNTO 0);
--SIGNAL    carry_propagate    :    STD_LOGIC_VECTOR(N-1 DOWNTO 0);
--SIGNAL    carry_in_internal  :    STD_LOGIC_VECTOR(N-1 DOWNTO 1);
--
--SIGNAL  B_mod : STD_LOGIC_VECTOR(N-1 DOWNTO 0) := B;
--SIGNAL  C_in_mod: STD_LOGIC := C_in;
--
--signal S_wider : std_logic_vector(N downto 0);
--
--
--begin
--
--    WITH Binv  SELECT
--    B_mod <= B WHEN '0',
--            not B WHEN '1',
--            B WHEN OTHERS;
--
--    WITH Binv  SELECT
--    C_in_mod <= C_in WHEN '0',
--            not C_in WHEN '1',
--            C_in WHEN OTHERS;
--
--    -- Sum, P and G
--    h_sum <= A XOR B_mod;
--    carry_generate <= A AND B_mod;
--    carry_propagate <= A OR B_mod;
--
--    PROCESS (carry_generate,carry_propagate,carry_in_internal,C_in_mod)
--    BEGIN
--        carry_in_internal(1) <= carry_generate(0) OR (carry_propagate(0) AND C_in_mod);
--        inst: FOR i IN 1 TO (N-2) LOOP
--            carry_in_internal(i+1) <= carry_generate(i) OR (carry_propagate(i) AND carry_in_internal(i));
--        END LOOP;
--        C_out <= carry_generate(N-1) OR (carry_propagate(N-1) AND carry_in_internal(N-1));
--    END PROCESS;
--
--    S(0) <= h_sum(0) XOR C_in_mod;
--    S(N-1 DOWNTO 1) <= h_sum(N-1 DOWNTO 1) XOR carry_in_internal(N-1 DOWNTO 1);
--
--end CLA_ADD_SUB_ARCH;