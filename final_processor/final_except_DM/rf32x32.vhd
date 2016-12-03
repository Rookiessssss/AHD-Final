library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity rf32x32 is
PORT(clk: IN STD_LOGIC;
     readwrite: IN STD_LOGIC;
	  rs,rt,rd: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
     datain: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
     rs_data, rt_data: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)	  
);
end rf32x32;

architecture Behavioral of rf32x32 is

TYPE ram is ARRAY(0 TO 31)OF STD_LOGIC_VECTOR(31 DOWNTO 0);--move to top.pkg
SIGNAL skey:ram;--move to top.pkg

begin
PROCESS(clk)
BEGIN
IF(clk'EVENT AND clk='1') THEN
  IF(readwrite = '1')THEN skey(CONV_INTEGER(rd))<=datain;
  END IF;
END IF;
END PROCESS;

rs_data<=skey(CONV_INTEGER(rs));
rt_data<=skey(CONV_INTEGER(rt));

end Behavioral;

