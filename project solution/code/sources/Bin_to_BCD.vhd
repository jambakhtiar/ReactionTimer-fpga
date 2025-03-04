library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Bin_to_BCD is
    Port (
        bin : in unsigned(5 downto 0);
        bcd_tens : out STD_LOGIC_VECTOR(3 downto 0);
        bcd_units : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Bin_to_BCD;

architecture Behavioral of Bin_to_BCD is
begin
    process(bin)
        variable temp : INTEGER;
    begin
        temp := to_integer(unsigned(bin));

        if temp < 10 then
            bcd_tens <= "0000";
            bcd_units <= std_logic_vector(to_unsigned(temp, 4));
        elsif temp < 20 then
            bcd_tens <= "0001";
            bcd_units <= std_logic_vector(to_unsigned(temp - 10, 4));
        elsif temp < 30 then
            bcd_tens <= "0010";
            bcd_units <= std_logic_vector(to_unsigned(temp - 20, 4));
        elsif temp < 40 then
            bcd_tens <= "0011";
            bcd_units <= std_logic_vector(to_unsigned(temp - 30, 4));
        elsif temp < 50 then
            bcd_tens <= "0100";
            bcd_units <= std_logic_vector(to_unsigned(temp - 40, 4));
        else
            bcd_tens <= "0101";
            bcd_units <= std_logic_vector(to_unsigned(temp - 50, 4));
        end if;
    end process;
end Behavioral;
