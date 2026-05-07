library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC_tb is
end PC_tb;

architecture Behavioral of PC_tb is
    signal clk    : STD_LOGIC := '0';
    signal reset  : STD_LOGIC := '0';
    signal PC_in  : STD_LOGIC_VECTOR(31 downto 0);
    signal PC_out : STD_LOGIC_VECTOR(31 downto 0);

    constant CLK_PERIOD : time := 10 ns;

    function to_hex(v: STD_LOGIC_VECTOR) return string is
        variable hex_chars : string(1 to 8);
        variable i         : integer;
        variable val       : integer;
    begin
        for i in 0 to 7 loop
            val := to_integer(unsigned(v(i*4+3 downto i*4)));
            case val is
                when 0  => hex_chars(8-i) := '0';
                when 1  => hex_chars(8-i) := '1';
                when 2  => hex_chars(8-i) := '2';
                when 3  => hex_chars(8-i) := '3';
                when 4  => hex_chars(8-i) := '4';
                when 5  => hex_chars(8-i) := '5';
                when 6  => hex_chars(8-i) := '6';
                when 7  => hex_chars(8-i) := '7';
                when 8  => hex_chars(8-i) := '8';
                when 9  => hex_chars(8-i) := '9';
                when 10 => hex_chars(8-i) := 'A';
                when 11 => hex_chars(8-i) := 'B';
                when 12 => hex_chars(8-i) := 'C';
                when 13 => hex_chars(8-i) := 'D';
                when 14 => hex_chars(8-i) := 'E';
                when others => hex_chars(8-i) := 'F';
            end case;
        end loop;
        return hex_chars;
    end function;

begin
    uut: entity work.PC
        port map (
            clk    => clk,
            reset  => reset,
            PC_in  => PC_in,
            PC_out => PC_out
        );

    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    stim_proc: process
    begin
        -- Write 0xAAAACCCC
        reset <= '0';
        PC_in <= x"AAAACCCC";
        wait for CLK_PERIOD;
        report "PC = 0x" & to_hex(PC_out);

        -- Write 0xFFFFBBBB
        PC_in <= x"FFFFBBBB";
        wait for CLK_PERIOD;
        report "PC = 0x" & to_hex(PC_out);

        -- Reset
        reset <= '1';
        wait for CLK_PERIOD;
        report "After reset, PC = 0x" & to_hex(PC_out);

        wait;
    end process;
end Behavioral;
