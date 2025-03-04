library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_config_fsm is
end entity;

architecture Behavioral of tb_config_fsm is

    -- Component declaration of the unit under test (UUT)
    component config_fsm
        port (
            clk            : in std_logic;
            reset          : in std_logic;
            inc_button     : in std_logic;
            config_enable  : in std_logic;
            confirm_button : in std_logic;
            target_score   : out unsigned(5 downto 0);
            config_done    : out std_logic
        );
    end component;

    -- Testbench signals
    signal clk            : std_logic := '0';
    signal reset          : std_logic := '0';
    signal inc_button     : std_logic := '0';
    signal config_enable  : std_logic := '0';
    signal confirm_button : std_logic := '0';
    signal target_score   : unsigned(5 downto 0);
    signal config_done    : std_logic;

    constant CLK_PERIOD : time := 10 ns; -- 100 MHz clock period

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: config_fsm
        port map (
            clk            => clk,
            reset          => reset,
            inc_button     => inc_button,
            config_enable  => config_enable,
            confirm_button => confirm_button,
            target_score   => target_score,
            config_done    => config_done
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

        -- Enable configuration
        config_enable <= '1';
        wait for CLK_PERIOD;
        config_enable <= '0';
        wait for CLK_PERIOD;

        -- Increment score
        for i in 0 to 45 loop
            inc_button <= '1';
            wait for CLK_PERIOD;
            inc_button <= '0';
            wait for CLK_PERIOD;
        end loop;

        -- Confirm the score
        confirm_button <= '1';
        wait for CLK_PERIOD;
        confirm_button <= '0';
        wait for CLK_PERIOD;

        -- Wait for some time and finish simulation
        wait for 100 ns;
        assert false report "End of Simulation" severity failure;
    end process;

end Behavioral;
