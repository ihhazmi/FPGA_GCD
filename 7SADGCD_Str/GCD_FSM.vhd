----------------------------------------------------------------------------------
-- Company:  UNIVERSITY OF VICTORIA - Dept. of Electrical & Computer Engineering.
-- Engineer: Ibrahim Hazmi - ihaz@ece.uvic.ca
--  
-- Create Date:    16:13:25 10/10/2014 
-- Design Name: 	GCD_Nbit
-- Module Name:    ModNb_Ibr - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GCD_FSM is
	PORT(		clk, Reset, Start, AEB, AGB, ALB	: IN  	STD_LOGIC;
				EnA, EnB	: OUT   	STD_LOGIC
			);
end GCD_FSM;

ARCHITECTURE behav OF GCD_FSM IS

TYPE StateType IS (S0, S1);

SIGNAL CurrentState	: StateType; -- C_S
SIGNAL NextState		: StateType; -- N_S
--Signal Sel11, Sel22: std_logic;

BEGIN
	
	C_S: PROCESS (clk, Reset)
	BEGIN
	
	IF (Reset = '1') THEN		
		CurrentState 	<= 	S0;			
		ELSIF (clk'event and clk='1') THEN
			CurrentState 	<= 	NextState;			
	END IF;
		
	END PROCESS C_S;
	
	
	N_S: PROCESS (CurrentState, AEB, AGB, ALB, Start)
	
	BEGIN
		
		EnA		<= '1';
		EnB		<= '1';
		CASE CurrentState IS
			
			WHEN S0 =>
				IF (Start = '1') THEN					
					NextState 	<= S1;
				ELSE 	
					NextState 	<= S0;
				END IF;				

			WHEN S1 =>
				EnA	<= AGB;
				EnB	<= ALB;
				IF (AEB = '1') THEN
					NextState 	<= S0;
				ELSE
					NextState 	<= S1;
				END IF;


		-- Default Case	
			WHEN OTHERS =>
				NextState 		<= S0;	
		END CASE;
		
	END PROCESS N_S;

END behav;