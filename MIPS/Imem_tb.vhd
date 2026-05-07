library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Imem_tb is
end Imem_tb;

architecture Behavioral of Imem_tb is
    signal address : STD_LOGIC_VECTOR(3 downto 0);
    signal instr   : STD_LOGIC_VECTOR(31 downto 0);

    -- Helper function to convert SLV to hex string
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
    uut: entity work.Imem
        port map (
            address => address,
            instr   => instr
        );

    stim_proc: process
    begin
        address <= "0100";  -- Address 4
        wait for 10 ns;

        report "Instruction at address 4 = 0x" & to_hex(instr);

        wait;
    end process;
end Behavioral;

