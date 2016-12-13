--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:00:00 12/13/2016
-- Design Name:   
-- Module Name:   C:/lab/finfpga/finfpga_tb.vhd
-- Project Name:  finfpga
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_module
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
 
ENTITY finfpga_tb IS
END finfpga_tb;
 
ARCHITECTURE behavior OF finfpga_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_module
    PORT(
         clr : IN  std_logic;
         clk100mhz : IN  std_logic;
         st_btn : IN  std_logic;
         stp_sw : IN  std_logic;
         jinst : IN  std_logic_vector(2 downto 0);
         switch : IN  std_logic_vector(5 downto 0);
         an : OUT  std_logic_vector(7 downto 0);
         seg : OUT  std_logic_vector(7 downto 0);
         sw_in : IN  std_logic_vector(7 downto 0);
         din_ctl : IN  std_logic;
         counter : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clr : std_logic := '0';
   signal clk100mhz : std_logic := '0';
   signal st_btn : std_logic := '0';
   signal stp_sw : std_logic := '0';
   signal jinst : std_logic_vector(2 downto 0) := (others => '0');
   signal switch : std_logic_vector(5 downto 0) := (others => '0');
   signal sw_in : std_logic_vector(7 downto 0) := (others => '0');
   signal din_ctl : std_logic := '0';

 	--Outputs
   signal an : std_logic_vector(7 downto 0);
   signal seg : std_logic_vector(7 downto 0);
   signal counter : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk100mhz_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_module PORT MAP (
          clr => clr,
          clk100mhz => clk100mhz,
          st_btn => st_btn,
          stp_sw => stp_sw,
          jinst => jinst,
          switch => switch,
          an => an,
          seg => seg,
          sw_in => sw_in,
          din_ctl => din_ctl,
          counter => counter
        );

   -- Clock process definitions
   clk100mhz_process :process
   begin
		clk100mhz <= '0';
		wait for clk100mhz_period/2;
		clk100mhz <= '1';
		wait for clk100mhz_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
         clr <= '0';
         st_btn <='0';
         stp_sw <='0';
         jinst <="000";
         switch <="100001";
         sw_in <="00000000";
         din_ctl<='0';

      wait for 100 ns;	
		clr<='1';

      wait for clk100mhz_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
