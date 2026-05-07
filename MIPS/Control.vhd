library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
    Port (
        opcode   : in  STD_LOGIC_VECTOR(5 downto 0);
        RegDst   : out STD_LOGIC;
        ALUSrc   : out STD_LOGIC;
        MemtoReg : out STD_LOGIC;
        RegWrite : out STD_LOGIC;
        MemRead  : out STD_LOGIC;
        MemWrite : out STD_LOGIC;
        Branch   : out STD_LOGIC;
        BranchNE : out STD_LOGIC;
        ALUop    : out STD_LOGIC_VECTOR(1 downto 0)
    );
end Control;

architecture Behavioral of Control is
begin
    process(opcode)
    begin
        -- Default values (safe state)
        RegDst   <= '0';
        ALUSrc   <= '0';
        MemtoReg <= '0';
        RegWrite <= '0';
        MemRead  <= '0';
        MemWrite <= '0';
        Branch   <= '0';
        BranchNE <= '0';
        ALUop    <= "00";

        case opcode is

            when "000000" =>  -- R-type
                RegDst   <= '1';
                ALUSrc   <= '0';
                MemtoReg <= '0';
                RegWrite <= '1';
                ALUop    <= "10";

            when "001000" =>  -- addi
                RegDst   <= '0';
                ALUSrc   <= '1';
                MemtoReg <= '0';
                RegWrite <= '1';
                ALUop    <= "00";

            when "101011" =>  -- sw
                RegDst   <= '0';
                ALUSrc   <= '1';
                MemtoReg <= '0';
                RegWrite <= '0';
                MemRead  <= '0';
                MemWrite <= '1';
                Branch   <= '0';
                ALUop    <= "00";

            when "100011" =>  -- lw (?? ???? ?????????)
                RegDst   <= '0';
                ALUSrc   <= '1';
                MemtoReg <= '1';
                RegWrite <= '1';
                MemRead  <= '1';
                MemWrite <= '0';
                ALUop    <= "00";

            when "000100" =>  -- beq
                RegDst   <= '0';
                ALUSrc   <= '0';
                MemtoReg <= '0';
                RegWrite <= '0';
                MemWrite <= '0';
                Branch   <= '1';
                ALUop    <= "01";

            when "000101" =>  -- bne
                RegDst   <= '0';
                ALUSrc   <= '0';
                MemtoReg <= '0';
                RegWrite <= '0';
                MemWrite <= '0';
                BranchNE <= '1';
                ALUop    <= "01";

            when others =>
                -- Do nothing (already assigned defaults)

        end case;
    end process;
end Behavioral;

