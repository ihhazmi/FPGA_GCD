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

entity GCD_BehFSM is
	Port(	
				clk, Reset, Start 	: 	in  STD_LOGIC;
				A, B						: 	in  std_logic_vector (15 downto 0);
				GCD 						: 	out std_logic_vector (15 downto 0);
				Finish					: 	out STD_LOGIC
			);
end GCD_BehFSM;

ARCHITECTURE behav OF GCD_BehFSM IS

TYPE StateType IS (S0, S1);

SIGNAL CurrentState	: StateType; -- C_S
SIGNAL NextState		: StateType; -- N_S
Signal AM, AR, AS, BM, BR, BS, Tmp_GCD : UnSigned(15 DOWNTO 0):= (others => '0');
Signal EnA, EnB : STD_LOGIC:= '0';

BEGIN

AS <= AR - BR;
BS <= BR - AR;
	
	C_S: PROCESS (clk, Reset)
	BEGIN
	
	IF (Reset = '1') THEN		
		AR 	<= (Others => '0');
		BR 	<= (Others => '0');
		CurrentState 	<= 	S0;			
		ELSIF (clk'event and clk='1') THEN
			CurrentState 	<= 	NextState;
				IF (EnA = '1') THEN
					AR 	<= AM;
				ELSE
					NULL;
				END IF;
				
				IF (EnB = '1') THEN
					BR 	<= BM;
				ELSE
					NULL;
				END IF;
			
	END IF;
		
	END PROCESS C_S;
	
	
	N_S: PROCESS (CurrentState, A, B, AR, BR, AS, BS, Start)
	
	BEGIN
		
		AM			<= UnSigned(A);
		BM			<= UnSigned(B);
		Tmp_GCD	<= (Others => '0');
		EnA		<= '1';
		EnB		<= '1';
		Finish 	<= '0';
		CASE CurrentState IS
			
			WHEN S0 =>
				IF (Start = '1') THEN					
					NextState 	<= S1;
				ELSE 	
					NextState 	<= S0;
				END IF;				

			WHEN S1 =>
				AM		<= AS;
				BM		<= BS;
				IF (AR = BR) THEN
					Tmp_GCD		<= BR;
					Finish 		<= '1';
					NextState 	<= S0;
				ELSIF (AR > BR) THEN
					EnA	<= '1';
					EnB	<= '0';
					NextState 	<= S1;
				ELSE
					EnA	<= '0';
					EnB	<= '1';
					NextState 	<= S1;
				END IF;


		-- Default Case	
			WHEN OTHERS =>
				NextState 		<= S0;	
		END CASE;
		
	END PROCESS N_S;
GCD <= std_logic_vector(Tmp_GCD);
END behav;