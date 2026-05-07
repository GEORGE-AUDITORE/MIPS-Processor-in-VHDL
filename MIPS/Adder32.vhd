library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Adder32 is
    Port (
        A      : in  STD_LOGIC_VECTOR(31 downto 0);
        B      : in  STD_LOGIC_VECTOR(31 downto 0);
        result : out STD_LOGIC_VECTOR(31 downto 0)
    );
end Adder32;

architecture Behavioral of Adder32 is
begin
    result <= std_logic_vector(unsigned(A) + unsigned(B));
end Behavioral;
