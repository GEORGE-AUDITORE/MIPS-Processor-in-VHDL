library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Leftshift is
    Port (
        input     : in  STD_LOGIC_VECTOR(31 downto 0);
        shifted   : out STD_LOGIC_VECTOR(31 downto 0)
    );
end Leftshift;

architecture Behavioral of Leftshift is
begin
    shifted <= std_logic_vector(shift_left(unsigned(input), 2));
end Behavioral;
