library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_keypressed is
end tb_keypressed;

architecture Behavioral of tb_keypressed is

    -- Component Declaration for the Unit Under Test (UUT)
    component keypressed
    Port (
        clock : in STD_LOGIC;
        reset : in STD_LOGIC;
        enable_in : in STD_LOGIC;
        enable_out : out STD_LOGIC
    );
    end component;

    -- Signals to connect to the UUT
    signal clock : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal enable_in : STD_LOGIC := '1';
    signal enable_out : STD_LOGIC;

    -- Clock period definition
    constant clock_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: keypressed Port Map (
        clock => clock,
        reset => reset,
        enable_in => enable_in,
        enable_out => enable_out
    );

    -- Clock process definitions
    clock_process :process
    begin
        clock <= '0';
        wait for clock_period/2;
        clock <= '1';
        wait for clock_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset state for 20 ns
        reset <= '0';
        wait for 20 ns;	
        reset <= '1';
        wait for 20 ns;

        -- Test Case 1: Press and release the button
        enable_in <= '0';
        wait for 20 ns;
        enable_in <= '1';
        wait for 20 ns;

        -- Test Case 2: Another press and release
        enable_in <= '0';
        wait for 20 ns;
        enable_in <= '1';
        wait for 20 ns;

        -- Test Case 3: Press and hold the button
        enable_in <= '0';
        wait for 40 ns;
        enable_in <= '1';
        wait for 20 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
