library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_stopwatch_ms is
end entity;

architecture Behavioral of tb_stopwatch_ms is

    -- Component declaration of the unit under test (UUT)
    component stopwatch_ms
        port (
            clk_1ms         : in std_logic;
            reset           : in std_logic;
            en              : in std_logic;
            key_pressed     : in std_logic;
            time_out        : out unsigned(23 downto 0);
            swatch_stopped  : out std_logic
        );
    end component;

    -- Testbench signals
    signal clk_1ms        : std_logic := '0';
    signal reset          : std_logic := '0';
    signal en             : std_logic := '0';
    signal key_pressed    : std_logic := '0';
    signal time_out       : unsigned(23 downto 0);
    signal swatch_stopped : std_logic;

    constant CLK_PERIOD : time := 1 ms; -- 1 ms clock period

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: stopwatch_ms
        port map (
            clk_1ms        => clk_1ms,
            reset          => reset,
            en             => en,
            key_pressed    => key_pressed,
            time_out       => time_out,
            swatch_stopped => swatch_stopped
        );

    -- Clock process definitions
    clk_process : process
    begin
        clk_1ms <= '0';
        wait for CLK_PERIOD / 2;
        clk_1ms <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the system
        reset <= '1';
        wait for 20 ms; -- Ensure reset is active for a few clock cycles
        reset <= '0';

        -- Enable the stopwatch
        en <= '1';
        wait for 5 ms;

        -- Simulate running the stopwatch
        key_pressed <= '0';
        wait for 100 ms; -- Wait to let the stopwatch run for some time

        -- Stop the stopwatch
        key_pressed <= '1';
        wait for 1 ms;
        key_pressed <= '0';

        -- Wait for some time to observe stopped state
        wait for 20 ms;

        -- Disable the stopwatch
        en <= '0';

        -- End simulation
        assert false report "End of Simulation" severity failure;
    end process;

end Behavioral;
