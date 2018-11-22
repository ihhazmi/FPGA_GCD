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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GCD_SAD_Top is
	generic (N : integer := 16);
    Port ( A, B 					: in  STD_LOGIC_VECTOR (N-1 downto 0);
           Clk, Reset, Start	: in  STD_LOGIC;
           GCD 					: out  STD_LOGIC_VECTOR (N-1 downto 0);
           Finish 				: out  STD_LOGIC);
end GCD_SAD_Top;

architecture Behavioral of GCD_SAD_Top is

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
Component SAD is
    Port ( A : in  STD_LOGIC_VECTOR (N-1 downto 0);
           B : in  STD_LOGIC_VECTOR (N-1 downto 0);
           GN : inout  STD_LOGIC;
           ABSD : OUT  STD_LOGIC_VECTOR (N-1 downto 0)); -- ABSD = ABS since ABS is preserved word in VHDL	!
End Component;

-- SIGNALS DECLARATION
Signal AM, AR, ABSD, BM, BR	: STD_LOGIC_VECTOR(N-1 DOWNTO 0):= (others => '0');
Signal AGB, AEB, ALB, EnA, EnB, GN 	: STD_LOGIC:= '0';

begin

Process(ABSD)
	variable temp_OR :STD_LOGIC;
	begin
	temp_OR:= ABSD(0);
	for i in 1 to 15 loop
		temp_OR := temp_OR OR ABSD(i);
	end loop;
	AEB <= NOT temp_OR;	
end process;

AGB <= GN;
ALB <= AGB NOR AEB;
-- SelA <= AGB & EnA <= '1' at S0, then EnA <= AGB;
-- SelA <= ALB & EnB <= '1' at S0, then EnB <= ALB;;

-- Port mapping
FSM_GCD:	GCD_FSM 	port map(clk,	Reset, Start, AEB, AGB, ALB, EnA, EnB); -- Finish when AEB = '1';
Mux_A:	Mux2_1N 	port map(A, 	ABSD, 	AGB,		AM); -- Controlled by AGB Signal
Mux_B:	Mux2_1N 	port map(B, 	ABSD, 	ALB, 	BM); -- Controlled by ALB Signal
Reg_A:	RegN 		port map(clk, 	Reset,	EnA,		AM, 		AR);
Reg_B:	RegN 		port map(clk, 	Reset,	EnB,		BM, 		BR);
SADAB:	SAD 		port map(AR,	BR,		GN,		ABSD);

GCD 		<= BR; 
Finish 	<= AEB;
end Behavioral;

