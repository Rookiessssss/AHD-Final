
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
 

 
ENTITY final_processor_tb IS
END final_processor_tb;
 
ARCHITECTURE behavior OF final_processor_tb IS 

TYPE MARRAY is ARRAY(0 to 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);

CONSTANT im: MARRAY:=(x"04010007", x"04020008", x"00411810", x"FC000000", 
x"00000000", x"00000000", x"00000000", x"00000000",
x"00000000", x"00000000", x"00000000", x"00000000",
x"00000000", x"00000000", x"00000000", x"00000000",
x"00000000", x"00000000", x"00000000", x"00000000",
x"00000000", x"00000000", x"00000000", x"00000000",
x"00000000", x"00000000", x"00000000", x"00000000",
x"00000000", x"00000000", x"00000000", x"00000000");
 
    COMPONENT top_module
    PORT(
         imm : IN  std_logic_vector(31 downto 0);
         clr : IN  std_logic;
         clk : IN  std_logic;
         counter : OUT  std_logic_vector(31 downto 0);
         branch : IN  std_logic;
         addr : IN  std_logic_vector(25 downto 0);
         inst : IN  std_logic_vector(31 downto 0);
         readwrite : OUT  std_logic;
         memtoreg : OUT  std_logic;
         regdst : OUT  std_logic;
         shiftlr : OUT  std_logic;
         alusrc : OUT  std_logic;
         func : OUT  std_logic_vector(2 downto 0);
         memread : OUT  std_logic;
         memwrite : OUT  std_logic;
         en_br : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal imm : std_logic_vector(31 downto 0) := (others => '0');
   signal clr : std_logic := '0';
   signal clk : std_logic := '0';
   signal branch : std_logic := '0';
   signal addr : std_logic_vector(25 downto 0) := (others => '0');
   signal inst : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal counter : std_logic_vector(31 downto 0);
   signal readwrite : std_logic;
   signal memtoreg : std_logic;
   signal regdst : std_logic;
   signal shiftlr : std_logic;
   signal alusrc : std_logic;
   signal func : std_logic_vector(2 downto 0);
   signal memread : std_logic;
   signal memwrite : std_logic;
   signal en_br : std_logic;

   -- Clock period definitions
   constant clk_period : time := 30 ns;
 
BEGIN
 inst<=im(CONV_INTEGER(counter(4 DOWNTO 0)));
 
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_module PORT MAP (
          imm => imm,
          clr => clr,
          clk => clk,
          counter => counter,
          branch => branch,
          addr => addr,
          inst => inst,
          readwrite => readwrite,
          memtoreg => memtoreg,
          regdst => regdst,
          shiftlr => shiftlr,
          alusrc => alusrc,
          func => func,
          memread => memread,
          memwrite => memwrite,
          en_br => en_br
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
