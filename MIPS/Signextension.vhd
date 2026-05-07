library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Signextension is
    Port (
        input16  : in  STD_LOGIC_VECTOR(15 downto 0);
        output32 : out STD_LOGIC_VECTOR(31 downto 0)
    );
end Signextension;

architecture Behavioral of Signextension is
begin
    output32 <= std_logic_vector(resize(signed(input16), 32));
end Behavioral;
