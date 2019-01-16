library ieee;
use ieee.std_logic_1164.all;

entity top is
    port (
        sw: in std_logic_vector(15 downto 0);
        btn_center, btn_up, btn_left, btn_right, btn_down : in std_logic;

        led: out std_logic_vector(15 downto 0)
    );
end top;

architecture arch of top is
begin
    alu: entity work.alu(arch)
        port map(
            a => sw, b => "0101010101010101",
            zero_a => btn_left, zero_b => btn_right,
            neg_a => btn_up, neg_b => btn_down, neg_out => btn_center,
            op_add => '1',
            r => led
        );
end arch;
