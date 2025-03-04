library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_controller is
end entity;

architecture Behavioral of tb_controller is

    -- Signals to connect to the UUT
    signal clock           : std_logic := '0';
    signal reset           : std_logic := '0';
    signal clk_1ms         : std_logic := '0';
    signal clk_1hz         : std_logic := '0';
    signal player_A        : std_logic := '0';
    signal player_B        : std_logic := '0';
    signal start           : std_logic := '0';
    signal target_confirm  : std_logic := '0';
    
    signal target_score    : unsigned(5 downto 0);
    signal config_enable_o : std_logic;
    signal test_cycles     : unsigned(5 downto 0);
    signal score_playerA   : unsigned(5 downto 0);
    signal score_playerB   : unsigned(5 downto 0);
    signal stimulus_playerA: std_logic_vector(3 downto 0);
    signal stimulus_playerB: std_logic_vector(3 downto 0);

    -- Clock generation
    constant CLK_PERIOD : time := 20 ns; -- 50 MHz clock

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.controller
        port map (
            clock           => clock,
            reset           => reset,
            clk_1ms         => clk_1ms,
            clk_1hz         => clk_1hz,
            player_A        => player_A,
            player_B        => player_B,
            start           => start,
            target_confirm  => target_confirm,
            target_score    => target_score,
            config_enable_o => config_enable_o,
            test_cycles     => test_cycles,
            score_playerA   => score_playerA,
            score_playerB   => score_playerB,
            stimulus_playerA=> stimulus_playerA,
            stimulus_playerB=> stimulus_playerB
        );

    -- Clock process definitions
    clock_process : process
    begin
        while true loop
            clock <= '0';
            wait for CLK_PERIOD/2;
            clock <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;

    clk_1ms_process : process
    begin
        while true loop
            clk_1ms <= '0';
            wait for 15 ns;--1 ms;
            clk_1ms <= '1';
            wait for 15 ns;--1 ms;
        end loop;
    end process;

    clk_1hz_process : process
    begin
        while true loop
            clk_1hz <= '0';
            wait for 20 ns;--0.5 sec;
            clk_1hz <= '1';
            wait for 20 ns;--0.5 sec;
        end loop;
    end process;

    -- Test process
    test_process : process
    begin
        -- Initialize Inputs
        reset <= '1';
        player_A <= '0';
        player_B <= '0';
        start <= '0';
        target_confirm <= '0';
        wait for 100 ns;

        -- Apply reset
        reset <= '0';
        wait for 100 ns;
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- Start configuration
        start <= '1';
        wait for 10 ns; --1 ms;
        start <= '0';
        wait for 10 ns; --2 ms;

        -- Increment score configuration
        player_B <= '1';
        wait for 10 ns; --1 ms;
        player_B <= '0';
        wait for 10 ns; --2 ms;
        target_confirm <= '1';
        wait for 10 ns; --1 ms;
        target_confirm <= '0';
        wait for 10 ns; --2 ms;

        -- Start the game
        start <= '1';
        wait for 10 ns; --1 ms;
        start <= '0';
        wait for 10 ns; --2 ms;

        -- Simulate player A pressing the button
        player_A <= '1';
        wait for 500 ns; --500 ms;
        player_A <= '0';
        wait for 10000 ns; --1 sec;

        -- Simulate player B pressing the button
        player_B <= '1';
        wait for 500 ns; --500 ms;
        player_B <= '0';
        wait for 1000 ns; --1 sec;

        -- Simulate end of the game and check the result
        wait for 5000 ns; --5 sec;

        -- Finish the simulation
        wait;
    end process;

end architecture;
