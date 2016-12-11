--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:38:51 12/03/2016
-- Design Name:   
-- Module Name:   E:/ise/final_processor/top_module_tb.vhd
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
USE ieee.std_logic_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY top_module_tb IS
END top_module_tb;
 
ARCHITECTURE behavior OF top_module_tb IS 
 TYPE MARRAY IS ARRAY(0 to 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);

CONSTANT im: MARRAY:=(
"00000100000000010000000000000010", 
"00000100000000110000000000001010", 
"00000100000001000000000000001110", 
"00000100000001010000000000000010", 
"00100000011000110000000000000001", 
"00000000011001000010000000010001", 
"00001000000001000000000000000001", 
"00000000011000100010000000010010", 
"00001100010001000000000000001010", 
"00000000011000100010000000010011", 
"00011100011000100000000000000001", 
"00010000010001000000000000001010", 
"00000000011000100010000000010100", 
"00010100010001000000000000001010", 
"00011000010001000000000000001010", 
"00100000001001000000000000000010", 
"00101000000001011111111111111110", 
"00100100100001011111111111111110", 
"00101100100001010000000000000000", 
"00110000000000000000000000010110", 
"11111100000000000000000000000000",
x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000"
);

    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_module
    PORT(
         clr : IN  std_logic;
         clk : IN  std_logic;
         counter : OUT  std_logic_vector(31 downto 0);
         addr : IN  std_logic_vector(25 downto 0);
         inst : IN  std_logic_vector(31 downto 0);
         aluo : OUT  std_logic_vector(31 downto 0);
         rso : OUT  std_logic_vector(31 downto 0);
         rto : OUT  std_logic_vector(31 downto 0);
         memread : OUT  std_logic;
         memwrite : OUT  std_logic;
         rs : IN  std_logic_vector(4 downto 0);
         rt : IN  std_logic_vector(4 downto 0);
         rd : IN  std_logic_vector(4 downto 0);
         data_out : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clr : std_logic := '0';
   signal clk : std_logic := '0';
   signal addr : std_logic_vector(25 downto 0) := (others => '0');
   signal inst : std_logic_vector(31 downto 0) := (others => '0');
   signal rs : std_logic_vector(4 downto 0) := (others => '0');
   signal rt : std_logic_vector(4 downto 0) := (others => '0');
   signal rd : std_logic_vector(4 downto 0) := (others => '0');
   signal data_out : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal counter : std_logic_vector(31 downto 0);
   signal aluo : std_logic_vector(31 downto 0);
   signal rso : std_logic_vector(31 downto 0);
   signal rto : std_logic_vector(31 downto 0);
   signal memread : std_logic;
   signal memwrite : std_logic;

   -- Clock period definitions
   constant clk_period : time := 50 ns;
 
BEGIN
 inst<=im(CONV_INTEGER(counter(4 DOWNTO 0)));
 rs<=inst(25 DOWNTO 21);
 rt<=inst(20 DOWNTO 16);
 rd<=inst(15 DOWNTO 11);

	-- Instantiate the Unit Under Test (UUT)
   uut: top_module PORT MAP (
          clr => clr,
          clk => clk,
          counter => counter,
          addr => addr,
          inst => inst,
          aluo => aluo,
          rso => rso,
          rto => rto,
          memread => memread,
          memwrite => memwrite,
          rs => rs,
          rt => rt,
          rd => rd,
          data_out => data_out
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
			data_out<=x"00000005";

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
