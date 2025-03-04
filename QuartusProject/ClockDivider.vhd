library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockDivider is
    Port (
        clk_in : in STD_LOGIC;   -- 1ms input clock
        reset : in STD_LOGIC;     -- Active high reset
        clk_out : out STD_LOGIC  -- 1Hz output clock
    );
end ClockDivider;

architecture Behavioral of ClockDivider is
    signal counter : integer range 0 to 499 := 0;  -- Counter for dividing the clock
    signal clk_1hz_reg : STD_LOGIC := '0';       -- Register for the 1Hz clock output
begin
    process(clk_in, reset)
    begin
        if reset = '1' then
            counter <= 0;
            clk_1hz_reg <= '0';
        elsif rising_edge(clk_in) then
            if counter = 999 then
                counter <= 0;
                clk_1hz_reg <= not clk_1hz_reg; -- Toggle the 1Hz clock
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_out <= clk_1hz_reg;
end Behavioral;

