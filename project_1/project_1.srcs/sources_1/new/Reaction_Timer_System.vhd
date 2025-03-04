----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/20/2024 10:54:40 AM
-- Design Name: 
-- Module Name: controller - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--      player_A    : in ; --key3
--      player_B    : in --key 0
--      start       : in --key 1
--      target_confirm : in --key 2
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity Reaction_Timer_System is
  Port (
        clk_50mhz : in std_logic;
        reset     : in std_logic;
        KEYs      : in std_logic_vector(3 downto 0);
        LEDs        : out std_logic_vector(7 downto 0);
        HEX0        : out std_logic_vector(6 downto 0);
        HEX1        : out std_logic_vector(6 downto 0);
        HEX2        : out std_logic_vector(6 downto 0);
        HEX3        : out std_logic_vector(6 downto 0);
        HEX4        : out std_logic_vector(6 downto 0);
        HEX5        : out std_logic_vector(6 downto 0);
        HEX6        : out std_logic_vector(6 downto 0);
        HEX7        : out std_logic_vector(6 downto 0)
  
   );
end Reaction_Timer_System;

architecture Behavioral of Reaction_Timer_System is

component clock_ms
        Port (
            clk_50mhz : in STD_LOGIC;
            reset : in STD_LOGIC;
            clk_1ms : out STD_LOGIC
        );
    end component;
signal clk_1ms_w: std_logic;

 component clock_1ms_1hz
        Port (
            clk_1ms : in STD_LOGIC;
            reset : in STD_LOGIC;
            clk_1hz : out STD_LOGIC
        );
    end component;
signal clk_1hz_w: std_logic;

-- Component Declaration for the Unit Under Test (UUT)
    component keypressed
    Port (
        clock : in STD_LOGIC;
        reset : in STD_LOGIC;
        enable_in : in STD_LOGIC;
        enable_out : out STD_LOGIC
    );
    end component;
signal enable_out_key0, enable_out_key1, enable_out_key2, enable_out_key3: std_logic;

component controller
    port(
        clock   :   in std_logic;
        reset       :   in std_logic;
        clk_1ms     : in std_logic;
        clk_1hz     : in std_logic;
        player_A    : in std_logic; --key3
        player_B    : in std_logic; --key 0
        start       : in std_logic; --key 1
        target_confirm : in std_logic; --key 2
        
        target_score : out unsigned(5 downto 0); --out std_logic_vector(5 downto 0);--HEX7-HEX6
        config_enable_o: out std_logic;
        test_cycles : out unsigned(5 downto 0); --HEX5-HEX4
        score_playerA : out unsigned(5 downto 0);--HEX3-HEX2
        score_playerB : out unsigned(5 downto 0);--HEX1-HEX0
        stimulus_playerA : out std_logic_vector(3 downto 0);
        stimulus_playerB : out std_logic_vector(3 downto 0)
        
    );
end component;

signal target_score_w :  unsigned(5 downto 0); --out std_logic_vector(5 downto 0);--HEX7-HEX6
signal config_enable_o_w:  std_logic;
signal test_cycles_w :  unsigned(5 downto 0); --HEX5-HEX4
signal score_playerA_w :  unsigned(5 downto 0);--HEX3-HEX2
signal score_playerB_w :  unsigned(5 downto 0);--HEX1-HEX0


component Bin_to_BCD
        Port (
            bin : in unsigned(5 downto 0);
            bcd_tens : out STD_LOGIC_VECTOR(3 downto 0);
            bcd_units : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
signal bcd_tens_target_score :  STD_LOGIC_VECTOR(3 downto 0);
signal bcd_units_target_score :  STD_LOGIC_VECTOR(3 downto 0);
signal bcd_tens_test_cycles :  STD_LOGIC_VECTOR(3 downto 0);
signal bcd_units_test_cycles :  STD_LOGIC_VECTOR(3 downto 0);
signal bcd_tens_platerA :  STD_LOGIC_VECTOR(3 downto 0);
signal bcd_units_platerA :  STD_LOGIC_VECTOR(3 downto 0);
signal bcd_tens_platerB :  STD_LOGIC_VECTOR(3 downto 0);
signal bcd_units_platerB :  STD_LOGIC_VECTOR(3 downto 0);

component BCD_to_7Segment
        Port (
            bcd : in STD_LOGIC_VECTOR (3 downto 0);
            seg : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;
    
signal HEX3_w :  STD_LOGIC_VECTOR(6 downto 0);
signal HEX2_w :  STD_LOGIC_VECTOR(6 downto 0);
signal HEX1_w :  STD_LOGIC_VECTOR(6 downto 0);
signal HEX0_w :  STD_LOGIC_VECTOR(6 downto 0);
---------------------------------------------------------------------
begin

 uut1: clock_ms
        Port map (
            clk_50mhz => clk_50mhz,
            reset => reset,
            clk_1ms => clk_1ms_w
        );

uut2: clock_1ms_1hz
        Port map (
            clk_1ms => clk_1ms_w,
            reset => reset,
            clk_1hz => clk_1hz_w
        );



-- Instantiate the Unit Under Test (UUT)
    uut3_key0: keypressed Port Map (
        clock => clk_50mhz,
        reset => reset,
        enable_in => KEYs(0),
        enable_out => enable_out_key0
    );
-- Instantiate the Unit Under Test (UUT)
    uut3_key1: keypressed Port Map (
        clock => clk_50mhz,
        reset => reset,
        enable_in => KEYs(1),
        enable_out => enable_out_key1
    );
-- Instantiate the Unit Under Test (UUT)
    uut3_key2: keypressed Port Map (
        clock => clk_50mhz,
        reset => reset,
        enable_in => KEYs(2),
        enable_out => enable_out_key2
    );
-- Instantiate the Unit Under Test (UUT)
    uut3_key3: keypressed Port Map (
        clock => clk_50mhz,
        reset => reset,
        enable_in => KEYs(3),
        enable_out => enable_out_key3
    );



-- Instantiate the Unit Under Test (UUT)
    uut4: controller port map (
            clock           => clk_50mhz,
            reset           => reset,
            clk_1ms         => clk_1ms_w,
            clk_1hz         => clk_1hz_w,
            player_A        => enable_out_key3,
            player_B        => enable_out_key0,
            start           => enable_out_key1,
            target_confirm  => enable_out_key2,
            target_score    => target_score_w,
            config_enable_o => config_enable_o_w,
            test_cycles     => test_cycles_w,
            score_playerA   => score_playerA_w,
            score_playerB   => score_playerB_w,
            stimulus_playerA=> LEDs(7 downto 4),
            stimulus_playerB=> LEDs(3 downto 0)
        );


-- HEX7-HEX6 Target Display
 uut5_target_Score: Bin_to_BCD Port Map (
        bin => target_score_w,
        bcd_tens => bcd_tens_target_score,
        bcd_units => bcd_units_target_score
    );


 uut6_target_scoreTens: BCD_to_7Segment Port Map (
        bcd => bcd_tens_target_score,
        seg => HEX7
    );    
 
 uut6_target_scoreUnits: BCD_to_7Segment Port Map (
        bcd => bcd_units_target_score,
        seg => HEX6
    );    
 
 
 
 -- HEX5-HEX4: Test Cycle Display
 uut5_test_cycles: Bin_to_BCD Port Map (
        bin => test_cycles_w,
        bcd_tens => bcd_tens_test_cycles,
        bcd_units => bcd_units_test_cycles
    );


 uut6_test_cyclesTens: BCD_to_7Segment Port Map (
        bcd => bcd_tens_test_cycles,
        seg => HEX5
    );    
 
 uut6_test_cyclesUnits: BCD_to_7Segment Port Map (
        bcd => bcd_units_test_cycles,
        seg => HEX4
    );  
 
 
 
 -- HEX3 - HEX0 : Player A and Player B
 uut5_platerA: Bin_to_BCD Port Map (
        bin => score_playerA_w,
        bcd_tens => bcd_tens_platerA,
        bcd_units => bcd_units_platerA
    );
 uut5_platerB: Bin_to_BCD Port Map (
        bin => score_playerB_w,
        bcd_tens => bcd_tens_platerB,
        bcd_units => bcd_units_platerB
    );
 
 
 
 uut6_platerATens: BCD_to_7Segment Port Map (
        bcd => bcd_tens_platerA,
        seg => HEX3_w
    );    
 
 uut6_platerAUnits: BCD_to_7Segment Port Map (
        bcd => bcd_units_platerA,
        seg => HEX2_w
    );  
    
  
  uut6_platerBTens: BCD_to_7Segment Port Map (
        bcd => bcd_tens_platerB,
        seg => HEX1_w
    );    
 
 uut6_platerBUnits: BCD_to_7Segment Port Map (
        bcd => bcd_units_platerB,
        seg => HEX0_w
    );  



disp_process: process(clk_50mhz, reset, config_enable_o_w, test_cycles_w)
    begin
        if reset = '1' then
            HEX3 <= "0000000";
            HEX2 <= "0000000";
            HEX1 <= "0000000";
            HEX0 <= "0000000";
         elsif rising_edge(clk_50mhz) then
            if config_enable_o_w = '1' then --ConF
                HEX3 <= "1000110"; --C
                HEX2 <= "0100011"; --o
                HEX1 <= "0101011"; --n
                HEX0 <= "0001100"; --F
            elsif test_cycles_w = "000000" then -- tESt
                HEX3 <= "0000111"; --t
                HEX2 <= "0000110"; --E
                HEX1 <= "0010010"; --S
                HEX0 <= "0000111"; --t
            else
                HEX3 <= HEX3_w;
                HEX2 <= HEX2_w;
                HEX1 <= HEX1_w;
                HEX0 <= HEX0_w;
            end if;
        end if;
    
    end process;

end Behavioral;
