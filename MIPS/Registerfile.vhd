
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Registerfile is
    Port (
        clk        : in  STD_LOGIC;
        regWrite   : in  STD_LOGIC;
        readReg1   : in  STD_LOGIC_VECTOR(3 downto 0);
        readReg2   : in  STD_LOGIC_VECTOR(3 downto 0);
        writeReg   : in  STD_LOGIC_VECTOR(3 downto 0);
        writeData  : in  STD_LOGIC_VECTOR(31 downto 0);
        readData1  : out STD_LOGIC_VECTOR(31 downto 0);
        readData2  : out STD_LOGIC_VECTOR(31 downto 0);
        debug_regs0 : out STD_LOGIC_VECTOR(31 downto 0);
        debug_regs3 : out STD_LOGIC_VECTOR(31 downto 0);
        debug_regs4 : out STD_LOGIC_VECTOR(31 downto 0);
        debug_regs5 : out STD_LOGIC_VECTOR(31 downto 0)
    );
end Registerfile;

architecture Behavioral of Registerfile is
    type reg_array is array (0 to 15) of STD_LOGIC_VECTOR(31 downto 0);
    signal regs: reg_array := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if regWrite = '1' then
                regs(to_integer(unsigned(writeReg))) <= writeData;
            end if;
        end if;
    end process;

    readData1 <= regs(to_integer(unsigned(readReg1)));
    readData2 <= regs(to_integer(unsigned(readReg2)));

    -- Debug outputs
    debug_regs0 <= regs(0);
    debug_regs3 <= regs(3);
    debug_regs4 <= regs(4);
    debug_regs5 <= regs(5);

end Behavioral;
