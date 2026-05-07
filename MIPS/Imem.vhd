library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Imem is
    Port (
        address : in  STD_LOGIC_VECTOR(3 downto 0); -- 16 locations
        instr   : out STD_LOGIC_VECTOR(31 downto 0)
    );
end Imem;

architecture Behavioral of Imem is
    type rom_array is array (0 to 15) of STD_LOGIC_VECTOR(31 downto 0);
    signal ROM : rom_array := (
        0 => x"20030001", -- addi $3, $0, 1
        1 => x"20050003", -- addi $5, $0, 3
        2 => x"AC830000", -- sw $3, 0($4)
        3 => x"20630001", -- addi $3, $3, 1
        4 => x"20840001", -- addi $4, $4, 1
        5 => x"20A5FFFF", -- addi $5, $5, -1
        6 => x"14A0FFFC", -- bne $5, $0, L1 (offset -4)
        others => (others => '0')
    );
begin
    instr <= ROM(to_integer(unsigned(address)));
end Behavioral;
