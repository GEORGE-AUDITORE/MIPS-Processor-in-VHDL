library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mux2to1_5bit_tb is
end Mux2to1_5bit_tb;

architecture Behavioral of Mux2to1_5bit_tb is
    signal in0, in1, muxOut : STD_LOGIC_VECTOR(4 downto 0);
    signal sel              : STD_LOGIC;

    function to_int(v: STD_LOGIC_VECTOR) return integer is
    begin
        return to_integer(unsigned(v));
    end function;
begin
    uut: entity work.Mux2to1_5bit
        port map (
            in0    => in0,
            in1    => in1,
            sel    => sel,
            muxOut => muxOut
        );

    process
    begin
        -- Test 1: sel = 1 -> output = in1 = 0x0A = 10
        in0 <= "11100";  -- 0x1C = 28
        in1 <= "01010";  -- 0x0A = 10
        sel <= '1';
        wait for 10 ns;
        report "sel=1 -> muxOut = " & integer'image(to_int(muxOut));

        -- Test 2: sel = 0 -> output = in0 = 0x1C = 28
        in1 <= "01011";  -- 0x0B = 11 (not used)
        sel <= '0';
        wait for 10 ns;
        report "sel=0 -> muxOut = " & integer'image(to_int(muxOut));

        wait;
    end process;
end Behavioral;
