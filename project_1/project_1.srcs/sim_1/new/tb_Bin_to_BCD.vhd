library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity tb_Bin_to_BCD is
end tb_Bin_to_BCD;

architecture Behavioral of tb_Bin_to_BCD is
    signal bin : unsigned(5 downto 0);
    signal bcd_tens : STD_LOGIC_VECTOR(3 downto 0);
    signal bcd_units : STD_LOGIC_VECTOR(3 downto 0);

    component Bin_to_BCD
        Port (
            bin : in unsigned(5 downto 0);
            bcd_tens : out STD_LOGIC_VECTOR(3 downto 0);
            bcd_units : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
begin
    uut: Bin_to_BCD Port Map (
        bin => bin,
        bcd_tens => bcd_tens,
        bcd_units => bcd_units
    );

    process
    begin
        bin <= "000000"; wait for 10 ns; -- 0
        bin <= "000001"; wait for 10 ns; -- 1
        bin <= "000010"; wait for 10 ns; -- 2
        bin <= "000011"; wait for 10 ns; -- 3
        bin <= "000100"; wait for 10 ns; -- 4
        bin <= "000101"; wait for 10 ns; -- 5
        bin <= "000110"; wait for 10 ns; -- 6
        bin <= "000111"; wait for 10 ns; -- 7
        bin <= "001000"; wait for 10 ns; -- 8
        bin <= "001001"; wait for 10 ns; -- 9
        bin <= "001010"; wait for 10 ns; -- 10
        bin <= "001011"; wait for 10 ns; -- 11
        bin <= "001100"; wait for 10 ns; -- 12
        bin <= "001101"; wait for 10 ns; -- 13
        bin <= "001110"; wait for 10 ns; -- 14
        bin <= "001111"; wait for 10 ns; -- 15
        bin <= "010000"; wait for 10 ns; -- 16
        bin <= "010001"; wait for 10 ns; -- 17
        bin <= "010010"; wait for 10 ns; -- 18
        bin <= "010011"; wait for 10 ns; -- 19
        bin <= "010100"; wait for 10 ns; -- 20
        bin <= "010101"; wait for 10 ns; -- 21
        bin <= "010110"; wait for 10 ns; -- 22
        bin <= "010111"; wait for 10 ns; -- 23
        bin <= "011000"; wait for 10 ns; -- 24
        bin <= "011001"; wait for 10 ns; -- 25
        bin <= "011010"; wait for 10 ns; -- 26
        bin <= "011011"; wait for 10 ns; -- 27
        bin <= "011100"; wait for 10 ns; -- 28
        bin <= "011101"; wait for 10 ns; -- 29
        bin <= "011110"; wait for 10 ns; -- 30
        bin <= "011111"; wait for 10 ns; -- 31
        bin <= "100000"; wait for 10 ns; -- 32
        bin <= "100001"; wait for 10 ns; -- 33
        bin <= "100010"; wait for 10 ns; -- 34
        bin <= "100011"; wait for 10 ns; -- 35
        bin <= "100100"; wait for 10 ns; -- 36
        bin <= "100101"; wait for 10 ns; -- 37
        bin <= "100110"; wait for 10 ns; -- 38
        bin <= "100111"; wait for 10 ns; -- 39
        bin <= "101000"; wait for 10 ns; -- 40
        bin <= "101001"; wait for 10 ns; -- 41
        bin <= "101010"; wait for 10 ns; -- 42
        bin <= "101011"; wait for 10 ns; -- 43
        bin <= "101100"; wait for 10 ns; -- 44
        bin <= "101101"; wait for 10 ns; -- 45
        bin <= "101110"; wait for 10 ns; -- 46
        bin <= "101111"; wait for 10 ns; -- 47
        bin <= "110000"; wait for 10 ns; -- 48
        bin <= "110001"; wait for 10 ns; -- 49
        bin <= "110010"; wait for 10 ns; -- 50
        bin <= "110011"; wait for 10 ns; -- 51
        bin <= "110100"; wait for 10 ns; -- 52
        bin <= "110101"; wait for 10 ns; -- 53
        bin <= "110110"; wait for 10 ns; -- 54
        bin <= "110111"; wait for 10 ns; -- 55
        bin <= "111000"; wait for 10 ns; -- 56
        bin <= "111001"; wait for 10 ns; -- 57
        bin <= "111010"; wait for 10 ns; -- 58
        bin <= "111011"; wait for 10 ns; -- 59
        bin <= "111100"; wait for 10 ns; -- 60
        bin <= "111101"; wait for 10 ns; -- 61
        bin <= "111110"; wait for 10 ns; -- 62
        bin <= "111111"; wait for 10 ns; -- 63
        wait;
    end process;
end Behavioral;
