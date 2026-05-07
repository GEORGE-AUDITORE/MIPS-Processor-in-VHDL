library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        PC_in : in  STD_LOGIC_VECTOR(31 downto 0);
        PC_out: out STD_LOGIC_VECTOR(31 downto 0)
    );
end PC;

architecture Behavioral of PC is
    signal PC_reg : STD_LOGIC_VECTOR(31 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                PC_reg <= (others => '0');
            else
                PC_reg <= PC_in;
            end if;
        end if;
    end process;

    PC_out <= PC_reg;
end Behavioral;
