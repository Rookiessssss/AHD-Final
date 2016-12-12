
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity im128x32 is
PORT(
	  addr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	  inst : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	  );

end im128x32;

architecture Behavioral of im128x32 is

TYPE MARRAY IS ARRAY(0 to 127) OF STD_LOGIC_VECTOR(31 DOWNTO 0);



CONSTANT im: MARRAY:=(
"00000100001000011011011111100001",
"00010100001000010000000000010000",
"00000100001000010101000101100011",
"00000100010000101001111000110111",
"00010100010000100000000000010000",
"00000100010000100111100110111001",
"00000000011000010001100000010000",
"00100000110000110000000000001000",
"00000100100001000000000000011001",
"00000000010000110001100000010000",
"00000100101001010000000000000001",
"00100000110000110000000000001001",
"00000100110001100000000000000001",
"00101100100001011111111111111011",
"00000101010010100000000000001000",
"00000101101011010000000000100010",
"00000101110011100000000000000100",
"00000101111011110000000001001110",
"00000110000100000000000000011111",
"00000000001000010000100000010001",
"00000000010000100001000000010001",
"00011101010001000000000000000000",
"00011101011001100000000000000000",
"00000000001000100001100000010000",
"00000000011001000010100000010000",
"00010100101001010000000000000011",
"00000100101000010000000000000000",
"00000100101001000000000000000000",
"00000000001000100001100000010000",
"00000001001010010100100000010001",
"00000001001000110100100000010000",
"00000000011001100011100000010000",
"00000001001100000100100000010010",
"00000001000010000100000000010001",
"00101000000010010000000000000011",
"00010100111001110000000000000001",
"00000101000010000000000000000001",
"00101101000010011111111111111101",
"00000100111000100000000000000000",
"00000100111001100000000000000000",
"00100001010001000000000000000000",
"00100001011001100000000000000000",
"00000101010010100000000000000001",
"00000101011010110000000000000001",
"00000101100011000000000000000001",
"00101101010011010000000000000001",
"00001001010010100000000000011010",
"00101101011011100000000000000001",
"00001001011010110000000000000100",
"00101101100011111111111111100011",
"11111100000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000100000010100000000000001000",
"00000100000000010000000000000100",
"00000100000000100000000000000101",
"00011101010000110000000000000000",
"00000101010010110000000000000001",
"00011101011001000000000000000000",
"00000000001000110000100000010000",
"00000000010001000001000000010000",
"00000101101011010000000000001100",
"00000101100011000000000000000001",
"00000000001000010010100000010100",
"00000000010000100011000000010100",
"00000000101001100010100000010100",
"00000000001000100011000000010100",
"00000000101001100011000000010100",
"00000000111001110011100000010001",
"00101000010000000000000000000011",
"00010100110001100000000000000001",
"00000100111001110000000000000001",
"00101100010001111111111111111101",
"00011101010000110000000000000010",
"00000000110000110000100000010000",
"00000000001000010010100000010100",
"00000000010000100011000000010100",
"00000000101001100010100000010100",
"00000000001000100011000000010100",
"00000000101001100011000000010100",
"00000001000010000100000000010001",
"00101000010000000000000000000011",
"00010100110001100000000000000001",
"00000101000010000000000000000001",
"00101100001010001111111111111101",
"00011101011001000000000000000010",
"00000000110001000001000000010000",
"00101101100011011111111111100110",
"11111100000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000"
);

begin
inst<= im(CONV_INTEGER(addr(6 DOWNTO 0)));

end Behavioral;
