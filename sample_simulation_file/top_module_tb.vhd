--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:59:17 12/11/2016
-- Design Name:   
-- Module Name:   C:/NYU/Register_VHDL/final_processor/top_module_tb.vhd
-- Project Name:  final_processor
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
 
ENTITY top_module_tb IS
END top_module_tb;
 
ARCHITECTURE behavior OF top_module_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_module
    PORT(
         clr : IN  std_logic;
         clk100mhz : IN  std_logic;
--         clr_rf_in : IN  std_logic;
		st_btn : IN STD_LOGIC;
		stp_sw :IN STD_LOGIC;
         jinst : IN  std_logic_vector(2 downto 0);
         switch : IN  std_logic_vector(5 downto 0);
         an : OUT  std_logic_vector(7 downto 0);
         seg : OUT  std_logic_vector(7 downto 0);
         aluo : OUT  std_logic_vector(31 downto 0);
         rso : OUT  std_logic_vector(31 downto 0);
         rto : OUT  std_logic_vector(31 downto 0);
         dmo : OUT  std_logic_vector(31 downto 0);
         insto : OUT  std_logic_vector(31 downto 0);
			counter : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clr : std_logic := '0';
   signal clk100mhz : std_logic := '0';
	signal st_btn :  STD_LOGIC:='0';
	signal stp_sw : STD_LOGIC:='0';
--   signal clr_rf_in : std_logic := '1';
   signal jinst : std_logic_vector(2 downto 0) := (others => '0');
   signal switch : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal an : std_logic_vector(7 downto 0);
   signal seg : std_logic_vector(7 downto 0);
   signal aluo : std_logic_vector(31 downto 0);
   signal rso : std_logic_vector(31 downto 0);
   signal rto : std_logic_vector(31 downto 0);
   signal dmo : std_logic_vector(31 downto 0);
   signal insto : std_logic_vector(31 downto 0);
	signal counter : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk100mhz_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_module PORT MAP (
          clr => clr,
          clk100mhz => clk100mhz,
			 	st_btn =>st_btn,
		     stp_sw =>stp_sw,
--          clr_rf_in => clr_rf_in,
          jinst => jinst,
          switch => switch,
          an => an,
          seg => seg,
          aluo => aluo,
          rso => rso,
          rto => rto,
          dmo => dmo,
          insto => insto,
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
		wait for 100 ns;	
		st_btn <='0';
		stp_sw <='0';
		clr<='1';
--		clr_rf_in<='0';
		switch<="001000";
		
		wait for 500000 ns;
--		clr_rf_in<='1';
		jinst<="100";
		wait for 100 ns;
--		clr_rf_in<='0';
		jinst<="000";
 

      -- insert stimulus here 

      wait;
   end process;

END;
