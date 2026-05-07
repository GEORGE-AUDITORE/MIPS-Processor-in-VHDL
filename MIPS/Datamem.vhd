library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Datamem is
    Port (
        clk      : in  STD_LOGIC;
        address  : in  STD_LOGIC_VECTOR(3 downto 0);
        writeData: in  STD_LOGIC_VECTOR(31 downto 0);
        MemWrite : in  STD_LOGIC;
        readData : out STD_LOGIC_VECTOR(31 downto 0);
    	MemRead : in  STD_LOGIC

    );
end Datamem;

architecture Behavioral of Datamem is
    type mem_array is array (0 to 15) of STD_LOGIC_VECTOR(31 downto 0);
    signal memory : mem_array := (others => (others => '0'));
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if MemWrite = '1' then
                memory(to_integer(unsigned(address))) <= writeData;
            end if;
        end if;
    end process;

    readData <= memory(to_integer(unsigned(address)));

end Behavioral;

