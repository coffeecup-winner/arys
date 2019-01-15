library ieee;
use ieee.std_logic_1164.all;

entity top is
    port (
        sw: in std_logic_vector(15 downto 0);
        led: out std_logic_vector(15 downto 0)
    );
end top;

architecture arch of top is
begin
    and_unit: entity work.and16(arch)
        port map(a => sw, b => "1111111111111111", r => led);
end arch;
