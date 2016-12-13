library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mem128x32 is
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
end mem128x32;

architecture Behavioral of mem128x32 is
TYPE dataram IS ARRAY(0 TO 127)OF STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL skey: dataram;

begin

PROCESS(clk,clr)BEGIN
IF (clr = '0') THEN
  FOR i IN 0 TO 35 LOOP
	 skey(i)<=(OTHERS=>'0');
  END LOOP;
ELSIF(clk'EVENT AND clk='1')THEN
  IF(memwrite='1' AND memread='0')THEN skey(CONV_INTEGER(addr(6 DOWNTO 0)))<=datain;
  END IF;
END IF;
END PROCESS;

PROCESS(memread,memwrite,skey,addr) BEGIN
IF(memread='1' AND memwrite='0')THEN
  dataout<=skey(CONV_INTEGER(addr(6 DOWNTO 0)));
ELSE
  dataout<=x"ffffffff";
END IF;
END PROCESS;

led_out <= skey(CONV_INTEGER(switch));

end Behavioral;

