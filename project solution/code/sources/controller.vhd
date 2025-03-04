
-----------------------------------------------------

-- FSM model consists of two concurrent processes
-- state_reg and comb_logic
-- we use case statement to describe the state 
-- transistion. All the inputs and signals are
-- put into the process sensitive list.  
-----------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-----------------------------------------------------

entity controller is
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
end controller;

-----------------------------------------------------------

architecture FSM of controller is
    
    --define the states of FSM model
    type state_type is( IDLE, CONFIG,WAIT_for_START, DELAY_TIMER, STIMULUS, 
                        POINTS_ASSIGN, INC_SCORE, COMPARE_SCORE, SEC_DELAY, 
                        WINNER, SP1_2, SP2_2, PENALTY);
    signal next_state, current_state: state_type;      

    -- internal registers
    signal target_score_reg :  unsigned(5 downto 0):= "000000";
    signal test_cycles_reg :  unsigned(5 downto 0):= "000000";
    signal score_playerA_reg : unsigned(5 downto 0):= "000000";
    signal score_playerB_reg :  unsigned(5 downto 0):= "000000";
        
    -- configuration
    signal config_enable : std_logic :='0';
    signal config_done : std_logic;
    --signal target : std_logic;
    
    --timer 
    signal timer_enable : std_logic :='0';
    signal timer_done : std_logic :='0';
    
    --stopwatch
    signal stopwatch_enable : std_logic :='0';
    signal sp1_done : std_logic :='0';
    signal sp2_done : std_logic :='0';
    signal sp1_time : unsigned(23 downto 0);
    signal sp2_time : unsigned(23 downto 0);
    signal sp1_time_w : unsigned(23 downto 0);
    signal sp2_time_w : unsigned(23 downto 0);
   
    -- 1 second signal
    signal sec_en : std_logic := '0';
    signal sec_done : std_logic := '0';
    signal sec_count : unsigned(1 downto 0) := "00";
    
    -- for 5 second delay
   type state_type_5s is (IDLE_5s, RUN_5s, STOP_5s);
    signal state_5s : state_type_5s := IDLE_5s;
    signal sec5_en : std_logic := '0';
    signal sec5_done : std_logic := '0';
    signal sec5_count : unsigned(2 downto 0) := "000";
    
    
    
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
       
       -- Component declaration of the unit under test (UUT)
    component random_delay
        port (
            clk       : in std_logic;
            reset     : in std_logic;
            delay_out : out std_logic
        );
    end component;
    
    -- Component declaration of the unit under test (UUT)
    component stopwatch_ms
        port (
            clk_1ms         : in std_logic;
            reset           : in std_logic;
            en              : in std_logic;
            key_pressed     : in std_logic;
            time_out        : out unsigned(23 downto 0);
            swatch_stopped  : out std_logic
        );
    end component;
    
    
    
    
    
    begin

-- Instantiate the Unit Under Test (UUT)
    uut1: config_fsm
        port map (
            clk            => clk_1hz,
            reset          => reset,
            inc_button     => player_B, --key0
            config_enable  => config_enable,
            confirm_button => target_confirm,
            target_score   => target_score_reg, --HEX7-HEX6
            config_done    => config_done
        );

    uut2: random_delay
        port map (
            clk       => clk_1ms,
            reset     => reset,
            delay_out => timer_done
        );


    -- Instantiate the Unit Under Test (UUT)
    spA: stopwatch_ms
        port map (
            clk_1ms        => clk_1ms,
            reset          => reset,
            en             => stopwatch_enable,
            key_pressed    => player_A,
            time_out       => sp1_time_w,
            swatch_stopped => sp1_done
        );
spB: stopwatch_ms
        port map (
            clk_1ms        => clk_1ms,
            reset          => reset,
            en             => stopwatch_enable,
            key_pressed    => player_B,
            time_out       => sp2_time_w,
            swatch_stopped => sp2_done
        );







        --concurrent process#1: state registers
        state_reg: process(clock, reset)
        begin

            if(reset ='1') then
                current_state <= IDLE;
            elsif (clock'event and clock='1') then
                current_state <= next_state;
            end if;
        end process;

        --concurrent process#2: combinational logic
        comb_logic: process(current_state, start, player_A, player_B, target_confirm)
        begin

            --use case statement to show the state transition
            case current_state is
                when IDLE =>    
                                test_cycles_reg <= "000000"; --HEX5-HEX4
                                score_playerA_reg <= "000000";--HEX3-HEX2
                                score_playerB_reg <= "000000";--HEX1-HEX0
                                stimulus_playerA <= "0000";
                                stimulus_playerB <= "0000";
                                config_enable <= '0';
                                timer_enable <='0';
                                stopwatch_enable <= '0';
                                sec_en <= '0';
                                sec5_en <= '0';
                                
                            if start='1' then
                                next_state <=CONFIG;
                            else
                                next_state <=IDLE;
                            end if;
                
                when CONFIG =>
                                test_cycles_reg <= "000000"; --HEX5-HEX4
                                score_playerA_reg <= "000000";--HEX3-HEX2
                                score_playerB_reg <= "000000";--HEX1-HEX0
                                stimulus_playerA <= "0000";
                                stimulus_playerB <= "0000";
                                config_enable <= '1';
                               
                               if config_done = '1' then
                                   next_state <= WAIT_for_START;
                               else
                                   next_state <= CONFIG;
                               end if;
                               
                when WAIT_for_START=>
                                config_enable <= '0';
                                if start = '1' then
                                    next_state <= DELAY_TIMER;
                                else
                                    next_state <= WAIT_for_START;
                                end if;
                
                when DELAY_TIMER=>
                                sec_en <= '0';
                                if player_A = '1' then 
                                    next_state <= SP1_2;
                                elsif player_B = '1' then
                                    next_state <= SP2_2;
                                else
                                    if timer_done = '1' then
                                        next_state <= STIMULUS;
                                    else
                                        next_state <= DELAY_TIMER;
                                    end if;
                                end if;
                when STIMULUS =>                                
                                stopwatch_enable <= '1';
                                stimulus_playerA <= "1111";
                                stimulus_playerB <= "1111";
                                next_state <= POINTS_ASSIGN;
                                
                when POINTS_ASSIGN =>
                                stopwatch_enable <= '0';
                                stimulus_playerA <= "0000";
                                stimulus_playerB <= "0000";                                
                                if (sp1_done ='1' and sp2_done = '1') then
                                    next_state <= COMPARE_SCORE;
                                    sp1_time <=sp1_time_w;
                                    sp2_time <=sp2_time_w; 
                                end if;
                 when INC_SCORE =>
                                next_state <= COMPARE_SCORE;
                                test_cycles_reg <= test_cycles_reg + 1;
                                if sp1_time < sp2_time then
                                    score_playerA_reg <= score_playerA_reg + 1;
                                elsif sp2_time < sp1_time then
                                    score_playerB_reg <= score_playerB_reg + 1;
                                end if;    
                 when COMPARE_SCORE =>
                                if (score_playerA_reg or score_playerB_reg) = target_score_reg then 
                                      next_state <= WINNER;
                                 else
                                      next_state <= SEC_DELAY;
                                 end if;
                                      
                  when SEC_DELAY => 
                                sec_en <= '1';
                                if sec_done = '1' then
                                    next_state <= DELAY_TIMER;
                                end if;

                                     
                               
                  when WINNER =>
                                    sec5_en <= '1';
                               if sec5_done = '1' then
                                    next_state <= IDLE;
                               end if;       
                               
                               if score_playerA_reg > score_playerB_reg then
                                    stimulus_playerA <= "1111";
                                    stimulus_playerB <= "0000";
                                elsif score_playerB_reg > score_playerA_reg then
                                    stimulus_playerA <= "0000";
                                    stimulus_playerB <= "1111";
                                elsif score_playerA_reg = score_playerB_reg then
                                    stimulus_playerA <= "1111";
                                    stimulus_playerB <= "1111";
                                end if;         
                               
                  when SP1_2 => 
                               score_playerA_reg <= score_playerA_reg - 2;
                               next_state <= PENALTY;
                  when SP2_2 =>
                               score_playerB_reg <= score_playerB_reg - 2;
                               next_state <= PENALTY;
                  when PENALTY =>
                                if score_playerA_reg < 0 then
                                    if score_playerB_reg < 0 then
                                        next_state <= CONFIG;
                                    else
                                        next_state <= WINNER;
                                    end if;
                                elsif score_playerA_reg > 0 then
                                    if score_playerB_reg >0 then
                                        next_state <= DELAY_TIMER;
                                     else
                                        next_state <= WINNER;
                                     end if;    
                                 
                                elsif score_playerB_reg < 0 then
                                    if score_playerA_reg < 0 then
                                        next_state <= CONFIG;
                                    else
                                        next_state <= WINNER;
                                    end if;
                                elsif score_playerB_reg > 0 then
                                    if score_playerA_reg >0 then
                                        next_state <= DELAY_TIMER;
                                     else
                                        next_state <= WINNER;
                                     end if;    
                                end if;
                when others =>
                            next_state <= IDLE;
            
            end case;
        
        end process;
              
        second_delay: process(reset, clk_1ms) begin
            if reset = '1' then
                sec_count <= "00";
                sec_done <= '0';
             else
                if sec_en = '1' then
                    sec_count <= sec_count + 1;
                    if sec_count = "01" then
                        sec_done <= '1';
                    else 
                        sec_done <= '0';
                    end if;
                 end if;
             end if;         
        end process;
        
        five_sec_delay: process (clk_1hz, reset)
    begin
        if reset = '1' then
            state_5s <= IDLE_5s;
            sec5_done <= '0';
        elsif rising_edge(clk_1hz) then
            case state_5s is
                when IDLE_5s =>
                    sec5_done <= '0';
                    if sec5_en = '1' then
                        state_5s <= RUN_5s;
                    end if;

                when RUN_5s =>
                        sec5_count <= sec5_count + 1;
                        if sec5_count = "101" then
                            state_5s <= STOP_5s;
                         end if;   

                when STOP_5s =>
                    sec5_done <= '1';
                    sec5_count <= "000";
                    state_5s <= IDLE_5s;
            end case;
        end if;
    end process;
        
        
    config_enable_o <= config_enable;
    target_score <= target_score_reg;
    score_playerA <= score_playerA_reg;
    score_playerB <= score_playerB_reg;
    test_cycles <= test_cycles_reg;
 end FSM;

                                
