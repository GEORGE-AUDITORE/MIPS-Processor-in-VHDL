library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2to1_5bit is
    Port (
        in0   : in  STD_LOGIC_VECTOR(4 downto 0);
        in1   : in  STD_LOGIC_VECTOR(4 downto 0);
        sel   : in  STD_LOGIC;
        muxOut: out STD_LOGIC_VECTOR(4 downto 0)
    );
end Mux2to1_5bit;

architecture Behavioral of Mux2to1_5bit is
begin
    muxOut <= in1 when sel = '1' else in0;
end Behavioral;
