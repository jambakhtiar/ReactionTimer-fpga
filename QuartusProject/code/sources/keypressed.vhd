library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity keypressed is
    Port (
        clock : in STD_LOGIC;
        reset : in STD_LOGIC;
        enable_in : in STD_LOGIC;
        enable_out : out STD_LOGIC
    );
end keypressed;

architecture Behavioral of keypressed is
    type state_type is (KEY_FREE, KEY_PRESSED, KEY_RELEASED);
    signal key_state, next_key_state : state_type;
begin

    -- STATE MACHINE: REGISTER BLOCK
    process (clock, reset)
    begin
        if reset = '0' then
            key_state <= KEY_FREE;
        elsif rising_edge(clock) then
            key_state <= next_key_state;
        end if;
    end process;

    -- STATE MACHINE: REGISTER INPUT LOGIC
    process (key_state, enable_in)
    begin
        next_key_state <= key_state;
        
        case key_state is
            when KEY_FREE =>
                if enable_in = '0' then
                    next_key_state <= KEY_PRESSED;
                end if;

            when KEY_PRESSED =>
                if enable_in = '1' then
                    next_key_state <= KEY_RELEASED;
                end if;

            when KEY_RELEASED =>
                next_key_state <= KEY_FREE;

            when others =>
                next_key_state <= KEY_FREE;
        end case;
    end process;

    -- OUTPUT MACHINE
    process (key_state)
    begin
        enable_out <= '0';
        
        case key_state is
            when KEY_FREE =>
                enable_out <= '0';
                
            when KEY_PRESSED =>
                enable_out <= '0';
                
            when KEY_RELEASED =>
                enable_out <= '1';
                
            when others =>
                enable_out <= 'X';
        end case;
    end process;

end Behavioral;
