library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        A     : in  STD_LOGIC_VECTOR(31 downto 0);
        B     : in  STD_LOGIC_VECTOR(31 downto 0);
        ALUop : in  STD_LOGIC_VECTOR(3 downto 0);
        Result: out STD_LOGIC_VECTOR(31 downto 0)
    );
end ALU;

architecture Behavioral of ALU is
begin
    process(A, B, ALUop)
        variable A_int, B_int, Res_int : signed(31 downto 0);
    begin
        A_int := signed(A);
        B_int := signed(B);

        case ALUop is
            when "0000" =>  -- ADD
                Res_int := A_int + B_int;
            when "0001" =>  -- SUB
                Res_int := A_int - B_int;
            when others =>
                Res_int := (others => '0');  -- Default to 0
        end case;

        Result <= std_logic_vector(Res_int);
    end process;
end Behavioral;
