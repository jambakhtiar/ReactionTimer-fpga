library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_random_delay is
end entity;

architecture Behavioral of tb_random_delay is

    -- Component declaration of the unit under test (UUT)
    component random_delay
        port (
            clk       : in std_logic;
            reset     : in std_logic;
            delay_out : out std_logic
        );
    end component;

    -- Testbench signals
    signal clk       : std_logic := '0';
    signal reset     : std_logic := '0';
    signal delay_out : std_logic;

    constant CLK_PERIOD : time := 20 ns; -- 100 MHz clock period

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: random_delay
        port map (
            clk       => clk,
            reset     => reset,
            delay_out => delay_out
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the system
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Let the simulation run for a sufficient time
        wait for 1000 us; -- Run for a long time to observe the random delay

        -- End simulation
        assert false report "End of Simulation" severity failure;
    end process;

end Behavioral;
