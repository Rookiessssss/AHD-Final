
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_module is
PORT( 
      clr: IN STD_LOGIC;
      clk: IN STD_LOGIC;
		--only clear registers file
		clr_rf_in: IN STD_LOGIC;
		--jump to key,enc,dec
		jinst: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		
		--test signal
		aluo, rso, rto,dmo: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		--this is for IM 
	   rs,rt,rd: IN STD_LOGIC_VECTOR(4 DOWNTO 0);--should be removed later
	   counter: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);--should be removed later
		inst: IN STD_LOGIC_VECTOR(31 DOWNTO 0)--should be removed later
		
);
end top_module;

architecture Behavioral of top_module is

COMPONENT rf32x32
PORT(clk,clr: IN STD_LOGIC;
     readwrite: IN STD_LOGIC;
	  rs,rt,rd: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
     datain: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
     rs_data, rt_data: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)	  
);
END COMPONENT;

 
COMPONENT pc32bit
PORT(clr: IN STD_LOGIC;
     clk: IN STD_LOGIC;
	  din: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	  jinst: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
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
		halt: OUT STD_LOGIC
);
END COMPONENT;

COMPONENT alu32bit
PORT(din0: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
     din1: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	  func: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	  dout: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END COMPONENT;

COMPONENT shift32bit
PORT(shiftlr: IN STD_LOGIC;
     din: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	  imm: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	  dout: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END COMPONENT;

COMPONENT mem128x32
PORT(memread: IN STD_LOGIC;
     memwrite: IN STD_LOGIC;
	  addr: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	  datain: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	  dataout: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	  clk: IN STD_LOGIC;
	  clr: IN STD_LOGIC
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
SIGNAL readwrite: STD_LOGIC;
SIGNAL regdst: STD_LOGIC;
SIGNAL branch: STD_LOGIC;
SIGNAL memtoreg: STD_LOGIC;
SIGNAL shiftlr: STD_LOGIC;
SIGNAL alusrc: STD_LOGIC;
SIGNAL func: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL memread: STD_LOGIC;
SIGNAL memwrite: STD_LOGIC;

--only clear registers file
SIGNAL clr_rf: STD_LOGIC;

SIGNAL rdin: STD_LOGIC_VECTOR(4 DOWNTO 0);


SIGNAL data_out: STD_LOGIC_VECTOR(31 DOWNTO 0);


SIGNAL uimm_out,imm_out, alu_out, shift_out, smux_out, alusrc_out, mmux_out, rs_out, rt_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
 

begin


pc: pc32bit PORT MAP(clr=>clr, clk=>clk, din=>haltmux_out,jinst=>jinst, dout=>pc_out);

decoder: decoder32bit PORT MAP(inst=>inst, jump=>jump, readwrite=>readwrite, 
memtoreg=>memtoreg, regdst=>regdst, shiftlr=>shiftlr, alusrc=>alusrc, func=>func, 
memread=>memread, memwrite=>memwrite, halt=>halt);

rf: rf32x32 PORT MAP(clk=>clk,clr=>clr_rf, readwrite=>readwrite, rs=>rs, rd=>rdin, rt=>rt, 
datain=>smux_out, rs_data=>rs_out, rt_data=>rt_out);

alu: alu32bit PORT MAP(din0=>rs_out, din1=>alusrc_out, func=>func, dout=>alu_out);

shift: shift32bit PORT MAP(shiftlr=>inst(3),din=>rs_out, imm=>inst(15 DOWNTO 0), dout=>shift_out);

mem: mem128x32 PORT MAP(addr=>alu_out, datain=>rt_out, memread=>memread, memwrite=>memwrite, dataout=>data_out,clk=>clk,clr=>clr);


counter<=pc_out;

adder1_out<=pc_out+'1';
adderi_out<=imm_out+adder1_out;
jump_out<=adder1_out(31 DOWNTO 26)&inst(25 DOWNTO 0);


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


WITH regdst SELECT
rdin<=rd WHEN '0',
		rt WHEN '1',
		"11111" WHEN OTHERS;
		

uimm_out <= x"0000"&inst(15 DOWNTO 0);

WITH inst(15) SELECT
imm_out<=x"0000"&inst(15 DOWNTO 0) WHEN '0',
			x"ffff"&inst(15 DOWNTO 0) WHEN '1',
			x"ffffffff" WHEN OTHERS;

WITH alusrc SELECT
alusrc_out<=rt_out WHEN '0',
				uimm_out WHEN '1',
				x"ffffffff" WHEN OTHERS;

WITH memtoreg SELECT
mmux_out<=alu_out WHEN '0',
		    data_out WHEN '1',
			 x"ffffffff" WHEN OTHERS;

WITH shiftlr SELECT
smux_out<=mmux_out WHEN '0',
			 shift_out WHEN '1',
			 x"ffffffff" WHEN OTHERS;

PROCESS(inst,rs_out,rt_out)
BEGIN 
IF(inst(31 DOWNTO 26)="001001") THEN
	IF(rs_out<rt_out) THEN 
		branch<='1';
	ELSE
		branch<='0';
	END IF;
ELSIF(inst(31 DOWNTO 26)="001010") THEN
	IF(rs_out=rt_out) THEN 
		branch<='1';
	ELSE
		branch<='0';
	END IF;
ELSIF(inst(31 DOWNTO 26)="001011") THEN
	IF(rs_out=rt_out) THEN 
		branch<='0';
	ELSE
		branch<='1';
	END IF;
ELSE
	branch<='0';
END IF;


END PROCESS; 

--only clear registers file
clr_rf <= clr AND clr_rf_in;

--test signal
aluo<=alu_out;
rso<=rs_out;
rto<=rt_out;
dmo<=data_out;

end Behavioral;

