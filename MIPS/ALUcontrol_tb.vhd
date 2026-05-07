library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUcontrol_tb is
end ALUcontrol_tb;

architecture Behavioral of ALUcontrol_tb is
    signal ALUOp      : STD_LOGIC_VECTOR(1 downto 0);
    signal Funct      : STD_LOGIC_VECTOR(5 downto 0);
    signal ALUControl : STD_LOGIC_VECTOR(3 downto 0);

    function to_string(v: STD_LOGIC_VECTOR) return string is
        variable result: string(1 to v'length);
    begin
        for i in v'range loop
            if v(i) = '1' then
                result(i - v'low + 1) := '1';
            elsif v(i) = '0' then
                result(i - v'low + 1) := '0';
            else
                result(i - v'low + 1) := 'X';
            end if;
        end loop;
        return result;
    end function;
begin
    uut: entity work.ALUcontrol
        port map (
            ALUOp      => ALUOp,
            Funct      => Funct,
            ALUControl => ALUControl
        );

    process
    begin
        -- R-type: add
        ALUOp <= "10";
        Funct <= "100000";
        wait for 10 ns;
        report "R-type add: ALUControl = " & to_string(ALUControl);

        -- R-type: sub
        Funct <= "100010";
        wait for 10 ns;
        report "R-type sub: ALUControl = " & to_string(ALUControl);

        -- lw/sw/addi
        ALUOp <= "00";
        Funct <= "111111"; -- ignored
        wait for 10 ns;
        report "addi/lw/sw: ALUControl = " & to_string(ALUControl);

        -- bne
        ALUOp <= "01";
        Funct <= "111111"; -- ignored
        wait for 10 ns;
        report "bne: ALUControl = " & to_string(ALUControl);

        wait;
    end process;
end Behavioral;

