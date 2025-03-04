library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stopwatch_ms is
    port (
        clk_1ms     : in std_logic;
        reset       : in std_logic;
        en          : in std_logic;
        key_pressed : in std_logic;
        time_out    : out unsigned(23 downto 0);
        swatch_stopped : out std_logic
    );
end entity;

architecture Behavioral of stopwatch_ms is
    type state_type is (IDLE, RUN, STOP);
    signal state : state_type := IDLE;
    signal time : unsigned(23 downto 0); -- Default 10
begin
    process (clk_1ms, reset)
    begin
        if reset = '1' then
            state <= IDLE;
            time <= "000000000000000000000000";
            swatch_stopped <= '0';

        elsif rising_edge(clk_1ms) then
            case state is
                when IDLE =>
                    swatch_stopped <= '0';
                    time <= "000000000000000000000000";
                    if en = '1' then
                        state <= RUN;
                    end if;

                when RUN =>
                        time <= time + 1;
                        if key_pressed= '1' then
                            state <= STOP;
                          end if;

                when STOP =>
                    swatch_stopped <= '1';
                    state <= IDLE;

                when others => state <= IDLE;
            end case;
        end if;
    end process;

    time_out <= time;
end architecture;
