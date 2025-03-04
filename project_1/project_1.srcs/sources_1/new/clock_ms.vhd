library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_ms is
    Port (
        clk_50mhz : in STD_LOGIC; -- 50MHz input clock
        reset : in STD_LOGIC;  -- Active high reset
        clk_1ms : out STD_LOGIC -- 1ms output clock
    );
end clock_ms;

architecture Behavioral of clock_ms is
    signal counter : unsigned(15 downto 0) := (others => '0'); -- 16-bit counter
    signal clk_out_reg : STD_LOGIC := '0'; -- Register for clk_out
begin
    process(clk_50mhz, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
            clk_out_reg <= '0';
        elsif rising_edge(clk_50mhz) then
            if counter = 49999 then
                counter <= (others => '0');
                clk_out_reg <= not clk_out_reg; -- Toggle the output clock
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_1ms <= clk_out_reg;
end Behavioral;
