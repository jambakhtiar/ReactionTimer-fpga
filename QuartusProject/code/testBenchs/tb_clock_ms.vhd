library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_clock_ms is
end tb_clock_ms;

architecture Behavioral of tb_clock_ms is
    signal clk_50mhz : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal clk_1ms : STD_LOGIC;

    component clock_ms
        Port (
            clk_50mhz : in STD_LOGIC;
            reset : in STD_LOGIC;
            clk_1ms : out STD_LOGIC
        );
    end component;

    constant clk_period : time := 20 ns; -- 50MHz clock period

begin
    uut: clock_ms
        Port map (
            clk_50mhz => clk_50mhz,
            reset => reset,
            clk_1ms => clk_1ms
        );

    -- Clock generation process
    clk_process :process
    begin
        while True loop
            clk_50mhz <= '0';
            wait for clk_period / 2;
            clk_50mhz <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Apply reset
        reset <= '1';
        wait for 50 ns;
        reset <= '0';
        
        -- Wait for a few milliseconds to observe the output clock
        wait for 10 ms;
        
        -- Insert further test cases here if needed
        
        wait; -- wait forever
    end process;

end Behavioral;
