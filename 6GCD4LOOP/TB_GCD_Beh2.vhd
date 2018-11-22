--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:06:52 11/15/2014
-- Design Name:   
-- Module Name:   /home/ihaz/GCD_Beh2/TB_GCD_Beh2.vhd
-- Project Name:  GCD_Beh2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: GCD_Beh2
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY TB_GCD_Beh2 IS
END TB_GCD_Beh2;
 
ARCHITECTURE behavior OF TB_GCD_Beh2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GCD_Beh2
		Port(	--clk		: in  std_logic;
         A : IN  Signed(15 downto 0);
         B : IN  Signed(15 downto 0);
         GCD : OUT  Signed(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : Signed(15 downto 0) := (others => '0');
   signal B : Signed(15 downto 0) := (others => '0');

 	--Outputs
   signal GCD : Signed(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
   Signal clk: std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GCD_Beh2 PORT MAP (
   --       clk => clk,
			 A => A,
          B => B,
          GCD => GCD
        );

   -- Clock process definitions
   clock_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

		A <= "0000000000000110";
		B <= "0000000000000110";

      wait for clk_period*10;
		A <= "0000000000000100";
		B <= "0000000000000010";

      wait for clk_period*10;
		A <= "0000000000010010";
		B <= "0000000000000011";


      wait for clk_period*10;
		A <= "0000000000001111";
		B <= "0000000000000111";


      wait for clk_period*10;
		A <= "0000000111111111";
		B <= "0000000000000010";

      wait for clk_period*20;
		A <= "0000000000001111";
		B <= "0000000000000111";

      wait for clk_period*10;
		A <= "0000000000000000";
		B <= "0000000000000000";

      wait;
   end process;

END;
