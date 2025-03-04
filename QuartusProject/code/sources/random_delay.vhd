library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity random_delay is
    port (
        clk       : in std_logic;
        reset     : in std_logic;
        delay_out : out std_logic
    );
end entity;

architecture Behavioral of random_delay is
    signal counter : unsigned(13 downto 0) := (others => '0');
    signal delay   : std_logic := '0';
begin
    process (clk, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
            delay <= '0';
        elsif rising_edge(clk) then				
                if counter = x"2710" then  -- Arbitrary large number for random delay
                    delay <= '1';
                    counter <= "00000000000000";
                else
                    delay <= '0';
                    counter <= counter + 1;
                end if;
        end if;
    end process;

    delay_out <= delay;
end architecture;
