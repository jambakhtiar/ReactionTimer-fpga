library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCD_to_7Segment is
    Port (
        bcd : in STD_LOGIC_VECTOR (3 downto 0);
        seg : out STD_LOGIC_VECTOR (6 downto 0)
    );
end BCD_to_7Segment;

architecture Behavioral of BCD_to_7Segment is
begin
    process(bcd)
    begin
        case bcd is
            when "0000" => seg <= "1000000"; -- 0
            when "0001" => seg <= "1111001"; -- 1
            when "0010" => seg <= "0100100"; -- 2
            when "0011" => seg <= "0110000"; -- 3
            when "0100" => seg <= "0011001"; -- 4
            when "0101" => seg <= "0010010"; -- 5
            when "0110" => seg <= "0000010"; -- 6
            when "0111" => seg <= "1111000"; -- 7
            when "1000" => seg <= "0000000"; -- 8
            when "1001" => seg <= "0010000"; -- 9
            when others => seg <= "1111111"; -- All segments off
        end case;
    end process;
end Behavioral;
