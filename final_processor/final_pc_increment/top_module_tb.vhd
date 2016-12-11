
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY top_module_tb IS
END top_module_tb;
 
ARCHITECTURE behavior OF top_module_tb IS 

--ROM
TYPE MARRAY is ARRAY (0 to 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);

CONSTANT im: MARRAY:= (x"00000000", x"00000001", x"00000002", x"00000003", 
								 x"00000004", x"00000005", x"00000006", x"00000007", 
								 x"00000008", x"00000009", x"0000000a", x"0000000b", 
								 x"0000000c", x"0000000d", x"0000000e", x"0000000f", 
								 x"00000010", x"00000011", x"00000012", x"00000013", 
								 x"00000014", x"00000015", x"00000016", x"00000017", 
								 x"00000018", x"00000019", x"0000001a", x"0000001b", 
								 x"0000001c", x"0000001d", x"0000001e", x"0000001f");
 
    COMPONENT top_module
    PORT(
         imm : IN  std_logic_vector(31 downto 0);
         clr : IN  std_logic;
         clk : IN  std_logic;
         counter : OUT  std_logic_vector(31 downto 0);
         branch : IN  std_logic;
         jump : IN  std_logic;
         halt : IN  std_logic;
         addr : IN  std_logic_vector(25 downto 0)
        );
    END COMPONENT;
    
 
   signal imm : std_logic_vector(31 downto 0) := (others => '0');
   signal clr : std_logic := '0';
   signal clk : std_logic := '0';
   signal branch : std_logic := '0';
   signal jump : std_logic := '0';
   signal halt : std_logic := '0';
   signal addr : std_logic_vector(25 downto 0) := (others => '0');
	
	signal im_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
   signal counter : std_logic_vector(31 downto 0);

   constant clk_period : time := 20 ns;
 
BEGIN
im_out <= im(CONV_INTEGER(counter(4 DOWNTO 0)));
  
   uut: top_module PORT MAP (
          imm => imm,
          clr => clr,
          clk => clk,
          counter => counter,
          branch => branch,
          jump => jump,
          halt => halt,
          addr => addr
        );

   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      imm <= x"00000002";
      clr <= '1';
      branch <= '0';
      jump <= '0';
      halt <= '0';
      addr <= "00000000000000000000000011";
		
		wait for 100 ns;
		imm <= x"00000002";
      clr <= '1';
      branch <= '1';
      jump <= '0';
      halt <= '0';
      addr <= "00000000000000000000000011";
		
		wait for 100 ns;
		imm <= x"00000002";
      clr <= '1';
      branch <= '0';
      jump <= '1';
      halt <= '0';
      addr <= "00000000000000000000000011";
		
		wait for 100 ns;
		imm <= x"00000002";
      clr <= '1';
      branch <= '0';
      jump <= '0';
      halt <= '1';
      addr <= "00000000000000000000000011";
		
      wait;
   end process;

END;
