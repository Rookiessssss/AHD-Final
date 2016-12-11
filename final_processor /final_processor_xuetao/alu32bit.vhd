library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu32bit is
PORT(din0: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
     din1: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	  func: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	  dout: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
end alu32bit;

architecture Behavioral of alu32bit is

begin
WITH func SELECT
dout<=din0+din1 WHEN "000",
      din0-din1 WHEN "001",
      din0 AND din1 WHEN "010",
      din0 OR din1 WHEN "011",
      din0 NOR din1 WHEN "100",
		din0 WHEN OTHERS;  --unexpected cases


end Behavioral;

