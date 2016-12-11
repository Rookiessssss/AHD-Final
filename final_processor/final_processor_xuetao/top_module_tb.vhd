--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:10:37 12/04/2016
-- Design Name:   
-- Module Name:   E:/ise/top_module_final/top_module_tb.vhd
-- Project Name:  top_module_final
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY top_module_tb IS
END top_module_tb;
 
ARCHITECTURE behavior OF top_module_tb IS 
TYPE MARRAY IS ARRAY(0 to 63) OF STD_LOGIC_VECTOR(31 DOWNTO 0);









CONSTANT im: MARRAY:=(
"00000100001000011011011111100001",
"00010100001000010000000000010000",
"00000100001000010101000101100011",
"00000100010000101001111000110111",
"00010100010000100000000000010000",
"00000100010000100111100110111001",
"00000000011000010001100000010000",
"00100000110000110000000000001000",
"00000100100001000000000000011001",
"00000000010000110001100000010000",
"00000100101001010000000000000001",
"00100000110000110000000000001001",
"00000100110001100000000000000001",
"00101100100001011111111111111100",
"00000101010010100000000000001000",
"00000101101011010000000000100010",
"00000101110011100000000000000100",
"00000101111011110000000001001110",
"00000110000100000000000000011111",
"00000000001000010000100000010001",
"00000000010000100001000000010001",
"00011101010001000000000000000000",
"00011101011001100000000000000000",
"00000000001000100001100000010000",
"00000000011001000010100000010000",
"00010100101001010000000000000011",
"00000100101000010000000000000000",
"00000100101001000000000000000000",
"00000000001000100001100000010000",
"00000001001000110100100000010000",
"00000000011001100011100000010000",
"00000001001100000100100000010010",
"00000001000010000100000000010001",
"00101000000010010000000000000011",
"00010100111001110000000000000001",
"00000101000010000000000000000001",
"00101101000010011111111111111101",
"00000100111000100000000000000000",
"00000100111001100000000000000000",
"00100001010001000000000000000000",
"00100001010001100000000000000000",
"00000101010010100000000000000001",
"00000101011010110000000000000001",
"00000101100011000000000000000001",
"00101101010011010000000000000001",
"00001001010010100000000000011010",
"00101101011011100000000000000001",
"00001001011010110000000000000100",
"00101101100011111111111111100101",
"11111100000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000"
);

    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_module
    PORT(
         clr : IN  std_logic;
         clk : IN  std_logic;
         aluo : OUT  std_logic_vector(31 downto 0);
         rso : OUT  std_logic_vector(31 downto 0);
         rto : OUT  std_logic_vector(31 downto 0);
         dmo : OUT  std_logic_vector(31 downto 0);
         rs : IN  std_logic_vector(4 downto 0);
         rt : IN  std_logic_vector(4 downto 0);
         rd : IN  std_logic_vector(4 downto 0);
         counter : OUT  std_logic_vector(31 downto 0);
         inst : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clr : std_logic := '0';
   signal clk : std_logic := '0';
   signal rs : std_logic_vector(4 downto 0) := (others => '0');
   signal rt : std_logic_vector(4 downto 0) := (others => '0');
   signal rd : std_logic_vector(4 downto 0) := (others => '0');
   signal inst : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal aluo : std_logic_vector(31 downto 0);
   signal rso : std_logic_vector(31 downto 0);
   signal rto : std_logic_vector(31 downto 0);
   signal dmo : std_logic_vector(31 downto 0);
   signal counter : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 50 ns;
 
BEGIN
 inst<=im(CONV_INTEGER(counter(5 DOWNTO 0)));
 rs<=inst(25 DOWNTO 21);
 rt<=inst(20 DOWNTO 16);
 rd<=inst(15 DOWNTO 11);

	-- Instantiate the Unit Under Test (UUT)
   uut: top_module PORT MAP (
          clr => clr,
          clk => clk,
          aluo => aluo,
          rso => rso,
          rto => rto,
          dmo => dmo,
          rs => rs,
          rt => rt,
          rd => rd,
          counter => counter,
          inst => inst
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
		clr<='1';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
