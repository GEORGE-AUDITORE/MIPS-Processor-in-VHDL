library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Registerfile_tb is
end Registerfile_tb;

architecture testbench of Registerfile_tb is
    signal clk        : STD_LOGIC := '0';
    signal regWrite   : STD_LOGIC;
    signal readReg1   : STD_LOGIC_VECTOR(3 downto 0);
    signal readReg2   : STD_LOGIC_VECTOR(3 downto 0);
    signal writeReg   : STD_LOGIC_VECTOR(3 downto 0);
    signal writeData  : STD_LOGIC_VECTOR(31 downto 0);
    signal readData1  : STD_LOGIC_VECTOR(31 downto 0);
    signal readData2  : STD_LOGIC_VECTOR(31 downto 0);

    constant CLK_PERIOD : time := 10 ns;
begin
    -- Instantiate the unit under test
    uut: entity work.Registerfile
        port map (
            clk        => clk,
            regWrite   => regWrite,
            readReg1   => readReg1,
            readReg2   => readReg2,
            writeReg   => writeReg,
            writeData  => writeData,
            readData1  => readData1,
            readData2  => readData2
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

    -- Stimulus process
    stim_proc: process
        variable i1, i2: integer;
    begin
        -- Write 6 to $4
        regWrite <= '1';
        writeReg <= "0100"; -- $4
        writeData <= std_logic_vector(to_signed(6, 32));
        wait for CLK_PERIOD;

        -- Write 9 to $5
        writeReg <= "0101"; -- $5
        writeData <= std_logic_vector(to_signed(9, 32));
        wait for CLK_PERIOD;

        -- Write 3 to $6
        writeReg <= "0110"; -- $6
        writeData <= std_logic_vector(to_signed(3, 32));
        wait for CLK_PERIOD;

        -- Disable write
        regWrite <= '0';
        wait for CLK_PERIOD;

        -- Read $4 and $5
        readReg1 <= "0100"; -- $4
        readReg2 <= "0101"; -- $5
        wait for CLK_PERIOD;

        i1 := to_integer(signed(readData1));
        i2 := to_integer(signed(readData2));

        report "$4 = " & integer'image(i1);
        report "$5 = " & integer'image(i2);

        wait;
    end process;
end testbench;
