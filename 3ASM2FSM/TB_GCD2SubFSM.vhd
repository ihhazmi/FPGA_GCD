--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:15:07 11/18/2014
-- Design Name:   
-- Module Name:   /home/ihaz/GCD_BehFSM2Sub/TB_GCD2SubFSM.vhd
-- Project Name:  GCD_BehFSM2Sub
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: GCD_BehFSM
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
 
ENTITY TB_GCD2SubFSM IS
END TB_GCD2SubFSM;
 
ARCHITECTURE behavior OF TB_GCD2SubFSM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GCD_BehFSM
    PORT(
        clk : IN  std_logic;
         Reset : IN  std_logic;
         Start : IN  std_logic;
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         GCD : OUT  std_logic_vector(15 downto 0);
         Finish : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Start : std_logic := '0';
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal GCD : std_logic_vector(15 downto 0);
   signal Finish : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GCD_BehFSM PORT MAP (
          clk => clk,
          Reset => Reset,
          Start => Start,
          A => A,
          B => B,
          GCD => GCD,
          Finish => Finish
        );

   -- Clock process definitions
   clk_process :process
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

      Reset	<=	'1';
      
      wait for Clk_period*2;
		Reset	<=	'0';
		Start <= '1';
		
      wait for clk_period;
		A <= "0000000000000110";
		B <= "0000000000000110";

      wait for Clk_period*2;
      Reset	<=	'1';
      wait for Clk_period*2;
		Reset	<=	'0';

		A <= "0000000000000100";
		B <= "0000000000000010";

      wait for clk_period*2;
      Reset	<=	'1';
      wait for Clk_period*2;
		Reset	<=	'0';
		A <= "0000000000010010";
		B <= "0000000000000011";


      wait for clk_period*6;
      Reset	<=	'1';
      wait for Clk_period*2;
		Reset	<=	'0';
		A <= "0000000000001111";
		B <= "0000000000000111";


      wait for clk_period*12;
      Reset	<=	'1';
      wait for Clk_period*2;
		Reset	<=	'0';
		A <= "0000000111111111";
		B <= "0000000000000010";


      wait for clk_period*270;
      Reset	<=	'1';
      wait for Clk_period*2;
		Reset	<=	'0';
		A <= "0000000000000000";
		B <= "0000000000000000";
      wait;
   end process;

END;
