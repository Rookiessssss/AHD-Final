
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_module is
PORT( imm: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      clr: IN STD_LOGIC;
      clk: IN STD_LOGIC;
      counter: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      branch,jump,halt: IN STD_LOGIC;
		addr: IN STD_LOGIC_VECTOR(25 DOWNTO 0)
);
end top_module;

architecture Behavioral of top_module is

COMPONENT pc32bit
PORT(clr: IN STD_LOGIC;
     clk: IN STD_LOGIC;
	  din: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	  dout: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END COMPONENT;




SIGNAL pc_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL adder1_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL adderi_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL brmux_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL jump_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL jmux_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL haltmux_out: STD_LOGIC_VECTOR(31 DOWNTO 0);




begin
pc: pc32bit PORT MAP(clr=>clr, clk=>clk, din=>haltmux_out, dout=>pc_out);

counter<=pc_out;

adder1_out<=pc_out+'1';
adderi_out<=imm+adder1_out;
jump_out<=adder1_out(31 DOWNTO 26)&addr;

WITH branch SELECT


brmux_out<=adder1_out WHEN '0',
           adderi_out WHEN '1',
			  x"ffffffff" WHEN OTHERS;

WITH jump SELECT
jmux_out<=brmux_out WHEN '0',
          jump_out WHEN '1',
			 x"ffffffff" WHEN OTHERS;

WITH halt SELECT
haltmux_out<=jmux_out WHEN '0',
             pc_out WHEN '1',
				 x"ffffffff" WHEN OTHERS;

				 

end Behavioral;

