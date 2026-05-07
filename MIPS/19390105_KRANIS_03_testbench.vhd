library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity 19390105_KRANIS_03_testbench is
end 19390105_KRANIS_03_testbench;

architecture behavior of 19390105_KRANIS_03_testbench is


    -- Component under test
    component MIPS
        Port (
            clk   : in  STD_LOGIC;
            reset : in  STD_LOGIC
        );
    end component;

    -- Testbench signals
    signal clk   : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '1';

begin

    -- Instantiate MIPS processor
    uut: MIPS
        port map (
            clk   => clk,
            reset => reset
        );

    -- Clock process (10 ns period)
    clk_process : process
    begin
        while now < 500 ns loop  -- Simulate for 500 ns total
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Reset process
    reset_process : process
    begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait;
    end process;

end behavior;
