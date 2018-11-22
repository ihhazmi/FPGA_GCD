--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:26:39 12/01/2014
-- Design Name:   
-- Module Name:   /home/ihaz/GCD1Sub_Str/TB_GCD1Sub.vhd
-- Project Name:  GCD1Sub_Str
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: GCD_Str_Top
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
--USE ieee.numeric_std.ALL;
 
ENTITY TB_GCD1Sub IS
END TB_GCD1Sub;
 
ARCHITECTURE behavior OF TB_GCD1Sub IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GCD_Str_Top
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Start : IN  std_logic;
         GCD : OUT  std_logic_vector(15 downto 0);
         Finish : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Start : std_logic := '0';

 	--Outputs
   signal GCD : std_logic_vector(15 downto 0);
   signal Finish : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GCD_Str_Top PORT MAP (
          A => A,
          B => B,
          Clk => Clk,
          Reset => Reset,
          Start => Start,
          GCD => GCD,
          Finish => Finish
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_period*10;

      Reset	<=	'1';      
      wait for Clk_period*2;
		Reset	<=	'0';
		Start	<=	'1';


      wait for clk_period*2;
		A <= "0000000000000110";
		B <= "0000000000000110";

      wait for clk_period;
		A <= "0000000000000100";
		B <= "0000000000000010";

      wait for clk_period*4;
      Reset	<=	'1';  
      wait for Clk_period;
		Reset	<=	'0';

		A <= "0000000000001111";
		B <= "0000000000000010";


      wait for clk_period*10;
      Reset	<=	'1';  
      wait for Clk_period;
		Reset	<=	'0';

		A <= "0000000000001111";
		B <= "0000000000000111";

      wait for clk_period*10;
      Reset	<=	'1';  
      wait for Clk_period;
		Reset	<=	'0';

		A <= "0000000000100011";
		B <= "0000000000000110";

      wait for clk_period*12;
      Reset	<=	'1';  
      wait for Clk_period;
		Reset	<=	'0';

		A <= "0000000111111111";
		B <= "0000000000000010";



      wait;
   end process;

END;
