library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.digital_clock_common.all;

entity hms_pulse_gen is
    generic (
        C_CLK_FRQ : integer := GC_CLK_FRQ -- GC_CLK_FRQ def in digital_clock_common
    );
    port (
        clk    : in std_logic;
        rst_n  : in std_logic;

        sec_i  : in unsigned(6 downto 0);
        min_i  : in unsigned(6 downto 0);
        hour_i : in unsigned(6 downto 0);

        sec_o  : out std_logic;
        min_o  : out std_logic;
        hour_o : out std_logic
    );
end entity hms_pulse_gen;

architecture rtl of hms_pulse_gen is
begin
    sec_o  <= '1' when (sec_i = 0) and (rst_n /= '0') else '0';
    min_o  <= '1' when (sec_i = 0) and (min_i = 0) and (rst_n /= '0') else '0';
    hour_o <= '1' when (sec_i = 0) and (min_i = 0) and (hour_i = 0) and (rst_n /= '0') else '0';
end architecture;