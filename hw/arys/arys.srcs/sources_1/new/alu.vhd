--------------------------------------------------------------------------------
-- Half adder (sum of two bits)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
    port (
        a, b: in std_logic;
        r, carry: out std_logic
    );
end half_adder;

architecture arch of half_adder is
begin
    r <= a xor b;
    carry <= a and b;
end arch;

--------------------------------------------------------------------------------
-- Full adder (sum of three bits)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port (
        a, b, c: in std_logic;
        r, carry: out std_logic
    );
end full_adder;

architecture arch of full_adder is
signal
    v0, c0, c1: std_logic;
begin
    half_adder0: entity work.half_adder(arch)
        port map(a => a, b => b, r => v0, carry => c0);
    half_adder1: entity work.half_adder(arch)
        port map(a => v0, b => c, r => r, carry => c1);
    carry <= c0 or c1;
end arch;

--------------------------------------------------------------------------------
-- 16-bit add
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity add16 is
    port (
        a, b: in std_logic_vector(15 downto 0);
        r: out std_logic_vector(15 downto 0)
    );
end add16;

architecture arch of add16 is
signal
    c: std_logic_vector(15 downto 0);
begin
    half_adder0: entity work.half_adder(arch)
        port map(a => a(0), b => b(0), r => r(0), carry => c(0));
    full_adder0: entity work.full_adder(arch)
        port map(a => a(1), b => b(1), c => c(0), r => r(1), carry => c(1));
    full_adder1: entity work.full_adder(arch)
        port map(a => a(2), b => b(2), c => c(1), r => r(2), carry => c(2));
    full_adder2: entity work.full_adder(arch)
        port map(a => a(3), b => b(3), c => c(2), r => r(3), carry => c(3));
    full_adder3: entity work.full_adder(arch)
        port map(a => a(4), b => b(4), c => c(3), r => r(4), carry => c(4));
    full_adder4: entity work.full_adder(arch)
        port map(a => a(5), b => b(5), c => c(4), r => r(5), carry => c(5));
    full_adder5: entity work.full_adder(arch)
        port map(a => a(6), b => b(6), c => c(5), r => r(6), carry => c(6));
    full_adder6: entity work.full_adder(arch)
        port map(a => a(7), b => b(7), c => c(6), r => r(7), carry => c(7));
    full_adder7: entity work.full_adder(arch)
        port map(a => a(8), b => b(8), c => c(7), r => r(8), carry => c(8));
    full_adder8: entity work.full_adder(arch)
        port map(a => a(9), b => b(9), c => c(8), r => r(9), carry => c(9));
    full_adder9: entity work.full_adder(arch)
        port map(a => a(10), b => b(10), c => c(9), r => r(10), carry => c(10));
    full_adder10: entity work.full_adder(arch)
        port map(a => a(11), b => b(11), c => c(10), r => r(11), carry => c(11));
    full_adder11: entity work.full_adder(arch)
        port map(a => a(12), b => b(12), c => c(11), r => r(12), carry => c(12));
    full_adder12: entity work.full_adder(arch)
        port map(a => a(13), b => b(13), c => c(12), r => r(13), carry => c(13));
    full_adder13: entity work.full_adder(arch)
        port map(a => a(14), b => b(14), c => c(13), r => r(14), carry => c(14));
    full_adder14: entity work.full_adder(arch)
        port map(a => a(15), b => b(15), c => c(14), r => r(15), carry => c(15));
    -- Result carry `c(15)` is ignored
end arch;

--------------------------------------------------------------------------------
-- 16-bit increase
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity inc16 is
    port (
        a: in std_logic_vector(15 downto 0);
        r: out std_logic_vector(15 downto 0)
    );
end inc16;

architecture arch of inc16 is
begin
    add0: entity work.add16(arch)
        port map(a => a, b => "0000000000000001", r => r);
end arch;

--------------------------------------------------------------------------------
-- 16-bit zero or negate
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity zero_neg16 is
    port (
        a: in std_logic_vector(15 downto 0);
        zero, neg: in std_logic;

        r: out std_logic_vector(15 downto 0)
    );
end zero_neg16;

architecture arch of zero_neg16 is
signal
    v0, v1: std_logic_vector(15 downto 0);
begin
    mux0: entity work.mux16(arch)
        port map(a => a, b => "0000000000000000", sel => zero, r => v0);
    not0: entity work.not16(arch)
        port map(a => v0, r => v1);
    mux1: entity work.mux16(arch)
        port map(a => v0, b => v1, sel => neg, r => r);
end arch;

--------------------------------------------------------------------------------
-- ALU
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity alu is
    port (
        a, b: in std_logic_vector(15 downto 0);
        zero_a, zero_b: in std_logic;
        neg_a, neg_b, neg_out: in std_logic;
        op_add: in std_logic;

        r: out std_logic_vector(15 downto 0);
        is_zero: out std_logic;
        is_neg: out std_logic
    );
end alu;

architecture arch of alu is
signal
    a0, b0, r_add, r_and, r_mux, r_fin: std_logic_vector(15 downto 0);
begin
    zero_neg0: entity work.zero_neg16(arch)
        port map(a => a, zero => zero_a, neg => neg_a, r => a0);
    zero_neg1: entity work.zero_neg16(arch)
        port map(a => b, zero => zero_b, neg => neg_b, r => b0);
    add0: entity work.add16(arch)
        port map(a => a0, b => b0, r => r_add);
    and0: entity work.and16(arch)
        port map(a => a0, b => b0, r => r_and);
    mux0: entity work.mux16(arch)
        port map(a => r_and, b => r_add, sel => op_add, r => r_mux);
    zero_neg2: entity work.zero_neg16(arch)
        port map(a => r_mux, zero => '0', neg => neg_out, r => r_fin);
    is_zero <= '1' when r_fin = "0000000000000000" else '0';
    is_neg <= '1' when r_fin(15) = '1' else '0';
    r <= r_fin;
end arch;
