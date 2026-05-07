library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Adder32_tb is
end Adder32_tb;

architecture Behavioral of Adder32_tb is
    signal A, B, result : STD_LOGIC_VECTOR(31 downto 0);

    function to_hex(v: STD_LOGIC_VECTOR) return string is
        variable result : string(1 to 8);
        variable nibble : STD_LOGIC_VECTOR(3 downto 0);
    begin
        for i in 0 to 7 loop
            nibble := v(31 - i*4 downto 28 - i*4);
            case nibble is
                when "0000" => result(i+1) := '0';
                when "0001" => result(i+1) := '1';
                when "0010" => result(i+1) := '2';
                when "0011" => result(i+1) := '3';
                when "0100" => result(i+1) := '4';
                when "0101" => result(i+1) := '5';
                when "0110" => result(i+1) := '6';
                when "0111" => result(i+1) := '7';
                when "1000" => result(i+1) := '8';
                when "1001" => result(i+1) := '9';
                when "1010" => result(i+1) := 'A';
                when "1011" => result(i+1) := 'B';
                when "1100" => result(i+1) := 'C';
                when "1101" => result(i+1) := 'D';
                when "1110" => result(i+1) := 'E';
                when others => result(i+1) := 'F';
            end case;
        end loop;
        return result;
    end function;

begin
    uut: entity work.Adder32
        port map (
            A      => A,
            B      => B,
            result => result
        );

    process
    begin
        -- Test 1: CCCCCCCC + BBBBBBBB
        A <= x"CCCCCCCC";
        B <= x"BBBBBBBB";
        wait for 10 ns;
        report "CCCCCCCC + BBBBBBBB = 0x" & to_hex(result);

        -- Test 2: BBBBBBBB + 55555556
        A <= x"BBBBBBBB";
        B <= x"55555556";
        wait for 10 ns;
        report "BBBBBBBB + 55555556 = 0x" & to_hex(result);

        wait;
    end process;
end Behavioral;
