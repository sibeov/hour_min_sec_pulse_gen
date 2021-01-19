library ieee;
use ieee.std_logic_1164.all;
-- USE ieee.std_logic_textio.ALL;
-- USE ieee.std_logic_arith.ALL;
-- USE ieee.numeric_bit.ALL;
use ieee.numeric_std.all;
-- USE ieee.std_logic_signed.ALL;
-- USE ieee.std_logic_unsigned.ALL;
-- USE ieee.math_real.ALL;
-- USE ieee.math_complex.ALL;

entity hms_pulse_gen_tb is
end entity hms_pulse_gen_tb;

architecture sim of hms_pulse_gen_tb is

    -- Constans
    constant TBC_CLK_FRQ : integer := 50;
    constant TBC_CLK_PRD : time    := (1 sec / TBC_CLK_FRQ);

    -- Clock signals
    signal clk_ena       : boolean := false;

    -- Inputs and outputs
    signal clk_tb        : std_logic;
    signal rst_n_tb      : std_logic            := '1';

    signal sec_i_tb      : unsigned(6 downto 0) := (others => '0');
    signal min_i_tb      : unsigned(6 downto 0) := (others => '0');
    signal hour_i_tb     : unsigned(6 downto 0) := (others => '0');

    signal sec_o_tb      : std_logic            := '0';
    signal min_o_tb      : std_logic            := '0';
    signal hour_o_tb     : std_logic            := '0';

begin

    clk_tb <= (not clk_tb) after (TBC_CLK_PRD / 2) when (clk_ena = true) else '0';

    DUT : entity work.hms_pulse_gen(rtl)
        generic map(
            C_CLK_FRQ => TBC_CLK_FRQ
        )
        port map(
            clk    => clk_tb,
            rst_n  => rst_n_tb,

            sec_i  => sec_i_tb,
            min_i  => min_i_tb,
            hour_i => hour_i_tb,

            sec_o  => sec_o_tb,
            min_o  => min_o_tb,
            hour_o => hour_o_tb
        );

    p_stim : process
    begin
        clk_ena <= false;
        wait for 1 min;

        clk_ena  <= true;
        rst_n_tb <= '0';
        wait for 0 min;
        rst_n_tb <= '1';
        wait for 1 min;

        clk_ena <= false;
        wait for 1 min;
        wait;
    end process p_stim;

end architecture;