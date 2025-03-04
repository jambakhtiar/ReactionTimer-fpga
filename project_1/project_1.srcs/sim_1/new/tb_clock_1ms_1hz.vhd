library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_clock_1ms_1hz is
end tb_clock_1ms_1hz;

architecture Behavioral of tb_clock_1ms_1hz is
    signal clk_1ms : STD_LOGIC := '0';   -- 1ms input clock
    signal reset : STD_LOGIC := '0';     -- Active high reset
    signal clk_1hz : STD_LOGIC;         -- 1Hz output clock

    component clock_1ms_1hz
        Port (
            clk_1ms : in STD_LOGIC;
            reset : in STD_LOGIC;
            clk_1hz : out STD_LOGIC
        );
    end component;

    constant clk_period_1ms : time := 1 ms; -- 1ms clock period

begin
    uut: clock_1ms_1hz
        Port map (
            clk_1ms => clk_1ms,
            reset => reset,
            clk_1hz => clk_1hz
        );

    -- Clock generation process for 1ms clock
    clk_process :process
    begin
        while True loop
            clk_1ms <= '0';
            wait for clk_period_1ms / 2;
            clk_1ms <= '1';
            wait for clk_period_1ms / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Apply reset
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        
        -- Wait for a few milliseconds to observe the output clock
        wait for 10 ms;
        
        -- Insert further test cases here if needed
        
        wait; -- wait forever
    end process;

end Behavioral;
