library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc32bit is
PORT(clr: IN STD_LOGIC;
     clk: IN STD_LOGIC;
	  din: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	  jinst: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	  dout: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
end pc32bit;

architecture Behavioral of pc32bit is

begin
PROCESS(clk,clr)BEGIN
  IF(clr='0')THEN dout<=(OTHERS => '0');
  ELSIF (jinst = "001") THEN dout<=x"00000000";
  ELSIF (jinst = "010") THEN dout<=x"00000040";
  ELSIF (jinst = "100") THEN dout<=x"00000080";
  ELSIF(clk'EVENT AND clk='1')THEN dout<=din;
  END IF;
END PROCESS;


end Behavioral;

