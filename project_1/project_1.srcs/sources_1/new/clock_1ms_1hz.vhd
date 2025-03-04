library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_1ms_1hz is
    Port (
        clk_1ms : in STD_LOGIC;   -- 1ms input clock
        reset : in STD_LOGIC;     -- Active high reset
        clk_1hz : out STD_LOGIC  -- 1Hz output clock
    );
end clock_1ms_1hz;

architecture Behavioral of clock_1ms_1hz is
    signal counter : integer range 0 to 999 := 0;  -- Counter for dividing the clock
    signal clk_1hz_reg : STD_LOGIC := '0';       -- Register for the 1Hz clock output
begin
    process(clk_1ms, reset)
    begin
        if reset = '1' then
            counter <= 0;
            clk_1hz_reg <= '0';
        elsif rising_edge(clk_1ms) then
            if counter = 999 then
                counter <= 0;
                clk_1hz_reg <= not clk_1hz_reg; -- Toggle the 1Hz clock
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_1hz <= clk_1hz_reg;
end Behavioral;
