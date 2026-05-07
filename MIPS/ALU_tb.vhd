library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is
    signal A, B, Result : STD_LOGIC_VECTOR(31 downto 0);
    signal ALUop        : STD_LOGIC_VECTOR(1 downto 0);
begin
    uut: entity work.ALU
        port map (
            A      => A,
            B      => B,
            ALUop  => ALUop,
            Result => Result
        );

    process
        -- Helper function to show signed result in simulation
        impure function to_signed_integer(v: STD_LOGIC_VECTOR) return integer is
        begin
            return to_integer(signed(v));
        end function;

    begin
        -- 7 + (-3)
        A <= std_logic_vector(to_signed(7, 32));
        B <= std_logic_vector(to_signed(-3, 32));
        ALUop <= "00";  -- ADD
        wait for 10 ns;

        report "7 + (-3) = " & integer'image(to_signed_integer(Result));

        -- 6 + (-6)
        A <= std_logic_vector(to_signed(6, 32));
        B <= std_logic_vector(to_signed(-6, 32));
        ALUop <= "00";  -- ADD
        wait for 10 ns;

        report "6 + (-6) = " & integer'image(to_signed_integer(Result));

        -- 5 - 8
        A <= std_logic_vector(to_signed(5, 32));
        B <= std_logic_vector(to_signed(8, 32));
        ALUop <= "01";  -- SUB
        wait for 10 ns;

        report "5 - 8 = " & integer'image(to_signed_integer(Result));

        wait;
    end process;
end Behavioral;
