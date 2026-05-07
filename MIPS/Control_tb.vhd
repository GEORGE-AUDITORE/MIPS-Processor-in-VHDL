library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Control_tb is
end Control_tb;

architecture Behavioral of Control_tb is
    signal opcode     : STD_LOGIC_VECTOR(5 downto 0);
    signal RegDst     : STD_LOGIC;
    signal ALUSrc     : STD_LOGIC;
    signal MemtoReg   : STD_LOGIC;
    signal RegWrite   : STD_LOGIC;
    signal MemRead    : STD_LOGIC;
    signal MemWrite   : STD_LOGIC;
    signal Branch     : STD_LOGIC;
    signal ALUOp      : STD_LOGIC_VECTOR(1 downto 0);

    -- Helper function for bit-to-character conversion
    function bit_to_char(b: STD_LOGIC) return string is
    begin
        if b = '1' then
            return "1";
        elsif b = '0' then
            return "0";
        else
            return "X";
        end if;
    end function;

    function vec_to_str(v: STD_LOGIC_VECTOR) return string is
        variable s: string(1 to v'length);
    begin
        for i in v'range loop
            s(i - v'low + 1) := bit_to_char(v(i))(1);
        end loop;
        return s;
    end function;

begin
    uut: entity work.Control
        port map (
            opcode     => opcode,
            RegDst     => RegDst,
            ALUSrc     => ALUSrc,
            MemtoReg   => MemtoReg,
            RegWrite   => RegWrite,
            MemRead    => MemRead,
            MemWrite   => MemWrite,
            Branch     => Branch,
            ALUOp      => ALUOp
        );

    process
    begin
        -- addi $1, $0, 4 (opcode = 001000)
        opcode <= "001000";
        wait for 10 ns;
        report "addi: ALUSrc=" & bit_to_char(ALUSrc) & ", RegWrite=" & bit_to_char(RegWrite);

        -- sw $6, 0($4) (opcode = 101011)
        opcode <= "101011";
        wait for 10 ns;
        report "sw: MemWrite=" & bit_to_char(MemWrite) & ", RegWrite=" & bit_to_char(RegWrite);

        -- bne $5, $0, L1 (opcode = 000101)
        opcode <= "000101";
        wait for 10 ns;
        report "bne: Branch=" & bit_to_char(Branch) & ", ALUOp=" & vec_to_str(ALUOp);

        wait;
    end process;
end Behavioral;

