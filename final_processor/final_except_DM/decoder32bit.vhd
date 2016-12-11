library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity decoder32bit is
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
end decoder32bit;

architecture Behavioral of decoder32bit is

begin
PROCESS(inst)
BEGIN
CASE inst(31 downto 26) IS
WHEN"000000"=> 
halt<='0'; readwrite<='1'; jump<='0'; memtoreg<='0'; regdst<='0'; shiftlr<='0'; alusrc<='0'; memread<='0'; memwrite<='0'; func<=inst(2 DOWNTO 0);
WHEN"000001"=> 
halt<='0'; readwrite<='1'; jump<='0'; memtoreg<='0'; regdst<='1'; shiftlr<='0'; alusrc<='1'; memread<='0'; memwrite<='0'; func<="000";
WHEN"000010"=> 
halt<='0'; readwrite<='1'; jump<='0'; memtoreg<='0'; regdst<='1'; shiftlr<='0'; alusrc<='1'; memread<='0'; memwrite<='0'; func<="001";
WHEN"000011"=> 
halt<='0'; readwrite<='1'; jump<='0'; memtoreg<='0'; regdst<='1'; shiftlr<='0'; alusrc<='1'; memread<='0'; memwrite<='0'; func<="010";
WHEN"000100"=>
halt<='0'; readwrite<='1'; jump<='0'; memtoreg<='0'; regdst<='1'; shiftlr<='0'; alusrc<='1'; memread<='0'; memwrite<='0'; func<="011";
WHEN"000101"=> 
halt<='0'; readwrite<='1'; jump<='0'; memtoreg<='0'; regdst<='1'; shiftlr<='1'; alusrc<='0'; memread<='0'; memwrite<='0'; func<="111";
WHEN"000110"=> 
halt<='0'; readwrite<='1'; jump<='0'; memtoreg<='0'; regdst<='1'; shiftlr<='1'; alusrc<='0'; memread<='0'; memwrite<='0'; func<="111";
WHEN"000111"=> 
halt<='0'; readwrite<='1'; jump<='0'; memtoreg<='1'; regdst<='1'; shiftlr<='0'; alusrc<='1'; memread<='1'; memwrite<='0'; func<="000";
WHEN"001000"=> 
halt<='0'; readwrite<='0'; jump<='0'; memtoreg<='0'; regdst<='0'; shiftlr<='0'; alusrc<='1'; memread<='0'; memwrite<='1'; func<="000";
WHEN"001001"=> 
halt<='0'; readwrite<='0'; jump<='0'; memtoreg<='0'; regdst<='0'; shiftlr<='0'; alusrc<='0'; memread<='0'; memwrite<='0'; func<="111";
WHEN"001010"=> 
halt<='0'; readwrite<='0'; jump<='0'; memtoreg<='0'; regdst<='0'; shiftlr<='0'; alusrc<='0'; memread<='0'; memwrite<='0'; func<="111";
WHEN"001011"=> 
halt<='0'; readwrite<='0'; jump<='0'; memtoreg<='0'; regdst<='0'; shiftlr<='0'; alusrc<='0'; memread<='0'; memwrite<='0'; func<="111";
WHEN"001100"=> 
halt<='0'; readwrite<='0'; jump<='1'; memtoreg<='0'; regdst<='0'; shiftlr<='0'; alusrc<='0'; memread<='0'; memwrite<='0'; func<="111";
WHEN"111111"=> 
halt<='1'; readwrite<='0'; jump<='0'; memtoreg<='0'; regdst<='0'; shiftlr<='0'; alusrc<='0'; memread<='0'; memwrite<='0'; func<="111";
WHEN OTHERS=>
halt<='0'; readwrite<='0'; jump<='0'; memtoreg<='0'; regdst<='0'; shiftlr<='0'; alusrc<='0'; memread<='0'; memwrite<='0'; func<="111";

END CASE;
END PROCESS;
end Behavioral;

