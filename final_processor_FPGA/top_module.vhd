library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_module is
PORT( 
      clr: IN STD_LOGIC;
      clk100mhz: IN STD_LOGIC;
		--single stepping
		st_btn : IN STD_LOGIC;
		stp_sw :IN STD_LOGIC;
		--jump to key,enc,dec
		jinst: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		--switches for LED output
		switch: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		an : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		seg : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		--test signal
		counter: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      --aluo, rso, rto, dmo,insto: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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

COMPONENT im256x32
PORT(
	  addr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	  inst : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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
	  switch: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	  addr: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	  datain: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	  dataout: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	  clk: IN STD_LOGIC;
	  clr: IN STD_LOGIC;
	  led_out:OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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

SIGNAL inst : STD_LOGIC_VECTOR(31 DOWNTO 0);

SIGNAL clr_rf_in: STD_LOGIC;




--SSD 
signal clk_div: STD_LOGIC_VECTOR(19 DOWNTO 0);
signal ac: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal s:STD_LOGIC_VECTOR(2 DOWNTO 0);
signal sdout: STD_LOGIC_VECTOR(31 DOWNTO 0);

--slow clk
signal clk25mhz: STD_LOGIC;

signal clk: STD_LOGIC;

begin
clk25mhz<= clk_div(1);
--SSD
s <= clk_div(19 DOWNTO 17);

--clock divider
PROCESS (clr, clk100mhz)  BEGIN
  IF (clr='0') THEN clk_div <= "00000000000000000000";
  ELSIF (clk100mhz'EVENT AND clk100mhz='1') THEN 
   IF (clk_div < "11111000000000000000") Then clk_div <= clk_div + 1 ;
	Else clk_div <= "00000000000000000000";
	END IF;
  END IF;
END PROCESS;

----single step
--PROCESS(st_btn, clk25mhz) BEGIN
--   IF(clr='0')then
--	   clk_os<='0';
--	ELSIF(clk25mhz'EVENT AND clk25mhz='1')THEN
--	   st_btn_bf<=st_btn;
--		IF(st_btn_bf='1' AND st_btn='0')THEN
--		clk_os<='1';
--		END IF;
--	ELSIF(clk25mhz'EVENT AND clk25mhz='0')THEN
--   clk_os<='0';
--	END IF;
--END PROCESS;




WITH stp_sw SELECT
clk<=clk25mhz WHEN '0',
     st_btn   WHEN OTHERS;

--output control
process(s, sdout)
begin
  case s is
  when "000" => ac <= sdout(3 DOWNTO 0);an<="11111110";
  when "001" => ac <= sdout(7 DOWNTO 4);an<="11111101";
  when "010" => ac <= sdout(11 DOWNTO 8);an<="11111011";
  when "011" => ac <= sdout(15 DOWNTO 12);an<="11110111";
  when "100" => ac <= sdout(19 DOWNTO 16);an<="11101111";
  when "101" => ac <= sdout(23 DOWNTO 20);an<="11011111";
  when "110" => ac <= sdout(27 DOWNTO 24);an<="10111111";
  when others => ac <= sdout(31 DOWNTO 28);an<="01111111";
  end case;
end process;

process(ac)
begin
case ac is
    when "0000" => seg <= "00000011";
    when "0001" => seg <= "10011111";
    when "0010" => seg <= "00100101";
    when "0011" => seg <= "00001101";
    when "0100" => seg <= "10011001";
    when "0101" => seg <= "01001001";
    when "0110" => seg <= "01000001";
    when "0111" => seg <= "00011111";
    when "1000" => seg <= "00000001";
    when "1001" => seg <= "00001001";
    when "1010" => seg <= "00010001";
    when "1011" => seg <= "11000001";
    when "1100" => seg <= "01100011";
    when "1101" => seg <= "10000101";
    when "1110" => seg <= "01100001";
    when "1111" => seg <= "01110001";
    when others => null;
end case;
end process;


pc: pc32bit PORT MAP(clr=>clr, clk=>clk, din=>haltmux_out,jinst=>jinst, dout=>pc_out);

decoder: decoder32bit PORT MAP(inst=>inst, jump=>jump, readwrite=>readwrite, 
memtoreg=>memtoreg, regdst=>regdst, shiftlr=>shiftlr, alusrc=>alusrc, func=>func, 
memread=>memread, memwrite=>memwrite, halt=>halt);

rf: rf32x32 PORT MAP(clk=>clk,clr=>clr_rf, readwrite=>readwrite, rs=>inst(25 DOWNTO 21), rd=>rdin, rt=>inst(20 DOWNTO 16), 
datain=>smux_out, rs_data=>rs_out, rt_data=>rt_out);

alu: alu32bit PORT MAP(din0=>rs_out, din1=>alusrc_out, func=>func, dout=>alu_out);

shift: shift32bit PORT MAP(shiftlr=>inst(27),din=>rs_out, imm=>inst(15 DOWNTO 0), dout=>shift_out);

mem: mem128x32 PORT MAP(addr=>alu_out, datain=>rt_out, switch=>switch, led_out=>sdout, memread=>memread, memwrite=>memwrite, dataout=>data_out,clk=>clk,clr=>clr);

im : im256x32 PORT MAP(addr=>pc_out, inst=>inst);

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
rdin<=inst(15 DOWNTO 11) WHEN '0',
		inst(20 DOWNTO 16) WHEN '1',
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



WITH jinst SELECT
clr_rf_in<='1' WHEN "010",
		     '1' WHEN "100",
			  '0' WHEN OTHERS;



--only clear registers file
clr_rf <= clr AND (NOT clr_rf_in);

--test signal
--aluo<=alu_out;
--rso<=rs_out; 
--rto<=rt_out;
--dmo<=data_out;
--insto<=inst;
counter<=pc_out(7 DOWNTO 0);

end Behavioral;

