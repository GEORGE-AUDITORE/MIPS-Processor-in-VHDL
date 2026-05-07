library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUcontrol is
    Port (
        ALUOp     : in  STD_LOGIC_VECTOR(1 downto 0);
        Funct     : in  STD_LOGIC_VECTOR(5 downto 0);
        ALUControl: out STD_LOGIC_VECTOR(3 downto 0)
    );
end ALUcontrol;

architecture Behavioral of ALUcontrol is
begin
    process(ALUOp, Funct)
    begin
        case ALUOp is
            when "00" =>  -- lw, sw, addi
                ALUControl <= "0010";  -- ADD

            when "01" =>  -- bne
                ALUControl <= "0110";  -- SUB

            when "10" =>  -- R-type
                case Funct is
                    when "100000" => ALUControl <= "0010"; -- add
                    when "100010" => ALUControl <= "0110"; -- sub
                    when others   => ALUControl <= "0000"; -- NOP/default
                end case;

            when others =>
                ALUControl <= "0000";
        end case;
    end process;
end Behavioral;
