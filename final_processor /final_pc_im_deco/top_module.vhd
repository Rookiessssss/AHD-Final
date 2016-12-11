
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_module is
PORT( imm: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      clr: IN STD_LOGIC;
      clk: IN STD_LOGIC;
      counter: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);--should be removed later
      branch: IN STD_LOGIC;
		addr: IN STD_LOGIC_VECTOR(25 DOWNTO 0);
		inst: IN STD_LOGIC_VECTOR(31 DOWNTO 0);--should be removed later
		
      readwrite: OUT STD_LOGIC;--should be removed later
      memtoreg: OUT STD_LOGIC;--should be removed later
		regdst: OUT STD_LOGIC;--should be removed later
		shiftlr: OUT STD_LOGIC;--should be removed later
		alusrc: OUT STD_LOGIC;--should be removed later
		func: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);--should be removed later
		memread: OUT STD_LOGIC;--should be removed later
		memwrite: OUT STD_LOGIC;--should be removed later
		en_br: OUT STD_LOGIC
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

COMPONENT decoder32bit
PORT( inst: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      jump: OUT STD_LOGIC;
      readwrite: OUT STD_LOGIC;
      memtoreg: OUT STD_LOGIC;
		regdst: OUT STD_LOGIC;
		shiftlr: OUT STD_LOGIC;
		alusrc: OUT STD_LOGIC;
		func: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		memread: OUT STD_LOGIC;
		memwrite: OUT STD_LOGIC;
		halt: OUT STD_LOGIC;
		en_br: OUT STD_LOGIC
);
END COMPONENT;



SIGNAL pc_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL adder1_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL adderi_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL brmux_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL jump_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL jmux_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL haltmux_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL jump,halt: STD_LOGIC;



begin
pc: pc32bit PORT MAP(clr=>clr, clk=>clk, din=>haltmux_out, dout=>pc_out);

decoder: decoder32bit PORT MAP(inst=>inst, jump=>jump, readwrite=>readwrite, 
memtoreg=>memtoreg, regdst=>regdst, shiftlr=>shiftlr, alusrc=>alusrc, func=>func, 
memread=>memread, memwrite=>memwrite, halt=>halt, en_br=>en_br);

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

