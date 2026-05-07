library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mux2to1_32bit_tb is
end Mux2to1_32bit_tb;

architecture Behavioral of Mux2to1_32bit_tb is
    signal in0, in1, muxOut : STD_LOGIC_VECTOR(31 downto 0);
    signal sel              : STD_LOGIC;

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
    uut: entity work.Mux2to1_32bit
        port map (
            in0    => in0,
            in1    => in1,
            sel    => sel,
            muxOut => muxOut
        );

    process
    begin
        -- Test 1: sel = 1 -> muxOut = in1
        in0 <= x"CCCCCCCC";
        in1 <= x"BBBBBBBB";
        sel <= '1';
        wait for 10 ns;
        report "sel=1 -> muxOut = 0x" & to_hex(muxOut);

        -- Test 2: sel = 0 -> muxOut = in0
        sel <= '0';
        wait for 10 ns;
        report "sel=0 -> muxOut = 0x" & to_hex(muxOut);

        wait;
    end process;
end Behavioral;

