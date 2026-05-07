library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Signextension_tb is
end Signextension_tb;

architecture Behavioral of Signextension_tb is
    signal input16  : STD_LOGIC_VECTOR(15 downto 0);
    signal output32 : STD_LOGIC_VECTOR(31 downto 0);

    function to_int(v: STD_LOGIC_VECTOR) return integer is
    begin
        return to_integer(signed(v));
    end function;
begin
    uut: entity work.Signextension
        port map (
            input16  => input16,
            output32 => output32
        );

    process
        variable ext_val : integer;
    begin
        -- Test 1: 0xFAAA
        input16 <= x"FAAA";
        wait for 10 ns;
        ext_val := to_int(output32);
        report "0xFAAA extended = " & integer'image(ext_val);

        -- Test 2: 0xAFFF
        input16 <= x"AFFF";
        wait for 10 ns;
        ext_val := to_int(output32);
        report "0xAFFF extended = " & integer'image(ext_val);

        -- Test 3: 0x5444
        input16 <= x"5444";
        wait for 10 ns;
        ext_val := to_int(output32);
        report "0x5444 extended = " & integer'image(ext_val);

        wait;
    end process;
end Behavioral;
