library ieee;
use ieee.std_logic_1164.all;

entity top is
    port (
        i0: in std_logic;
        i1: in std_logic;
        o0: out std_logic
    );
end top;

architecture arch of top is
begin
    o0 <= i0 and i1;
end arch;
