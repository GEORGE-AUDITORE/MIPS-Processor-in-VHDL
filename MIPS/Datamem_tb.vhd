library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Datamem_tb is
end Datamem_tb;

architecture Behavioral of Datamem_tb is
    signal clk        : STD_LOGIC := '0';
    signal memRead    : STD_LOGIC;
    signal memWrite   : STD_LOGIC;
    signal address    : STD_LOGIC_VECTOR(3 downto 0);
    signal writeData  : STD_LOGIC_VECTOR(31 downto 0);
    signal readData   : STD_LOGIC_VECTOR(31 downto 0);

    constant CLK_PERIOD : time := 10 ns;
begin
    uut: entity work.Datamem
        port map (
            clk       => clk,
            memRead   => memRead,
            memWrite  => memWrite,
            address   => address,
            writeData => writeData,
            readData  => readData
        );

    -- Clock generation
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus
    stim_proc: process
        variable val: integer;
    begin
        -- Write 9 to address 2
        memWrite <= '1';
        memRead <= '0';
        address <= "0010";
        writeData <= std_logic_vector(to_signed(9, 32));
        wait for CLK_PERIOD;

        -- Write 4 to address 3
        address <= "0011";
        writeData <= std_logic_vector(to_signed(4, 32));
        wait for CLK_PERIOD;

        -- Disable write
        memWrite <= '0';

        -- Read from address 2
        address <= "0010";
        memRead <= '1';
        wait for CLK_PERIOD;

        val := to_integer(signed(readData));
        report "Memory[2] = " & integer'image(val);

        wait;
    end process;
end Behavioral;
