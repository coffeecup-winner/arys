--------------------------------------------------------------------------------
-- 16-bit NOT
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity not16 is
    port (
        a: in std_logic_vector(15 downto 0);
        r: out std_logic_vector(15 downto 0)
    );
end not16;

architecture arch of not16 is
begin
    r(0) <= not a(0);
    r(1) <= not a(1);
    r(2) <= not a(2);
    r(3) <= not a(3);
    r(4) <= not a(4);
    r(5) <= not a(5);
    r(6) <= not a(6);
    r(7) <= not a(7);
    r(8) <= not a(8);
    r(9) <= not a(9);
    r(10) <= not a(10);
    r(11) <= not a(11);
    r(12) <= not a(12);
    r(13) <= not a(13);
    r(14) <= not a(14);
    r(15) <= not a(15);
end arch;

--------------------------------------------------------------------------------
-- 16-bit AND
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity and16 is
    port (
        a, b: in std_logic_vector(15 downto 0);
        r: out std_logic_vector(15 downto 0)
    );
end and16;

architecture arch of and16 is
begin
    r(0) <= a(0) and b(0);
    r(1) <= a(1) and b(1);
    r(2) <= a(2) and b(2);
    r(3) <= a(3) and b(3);
    r(4) <= a(4) and b(4);
    r(5) <= a(5) and b(5);
    r(6) <= a(6) and b(6);
    r(7) <= a(7) and b(7);
    r(8) <= a(8) and b(8);
    r(9) <= a(9) and b(9);
    r(10) <= a(10) and b(10);
    r(11) <= a(11) and b(11);
    r(12) <= a(12) and b(12);
    r(13) <= a(13) and b(13);
    r(14) <= a(14) and b(14);
    r(15) <= a(15) and b(15);
end arch;

--------------------------------------------------------------------------------
-- 16-bit OR
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity or16 is
    port (
        a, b: in std_logic_vector(15 downto 0);
        r: out std_logic_vector(15 downto 0)
    );
end or16;

architecture arch of or16 is
begin
    r(0) <= a(0) or b(0);
    r(1) <= a(1) or b(1);
    r(2) <= a(2) or b(2);
    r(3) <= a(3) or b(3);
    r(4) <= a(4) or b(4);
    r(5) <= a(5) or b(5);
    r(6) <= a(6) or b(6);
    r(7) <= a(7) or b(7);
    r(8) <= a(8) or b(8);
    r(9) <= a(9) or b(9);
    r(10) <= a(10) or b(10);
    r(11) <= a(11) or b(11);
    r(12) <= a(12) or b(12);
    r(13) <= a(13) or b(13);
    r(14) <= a(14) or b(14);
    r(15) <= a(15) or b(15);
end arch;

--------------------------------------------------------------------------------
-- 16-bit multiplexor
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity mux16 is
    port (
        a, b: in std_logic_vector(15 downto 0);
        sel: in std_logic;
        r: out std_logic_vector(15 downto 0)
    );
end mux16;

architecture arch of mux16 is
begin
    r(0) <= a(0) when sel = '1' else b(0);
    r(1) <= a(1) when sel = '1' else b(1);
    r(2) <= a(2) when sel = '1' else b(2);
    r(3) <= a(3) when sel = '1' else b(3);
    r(4) <= a(4) when sel = '1' else b(4);
    r(5) <= a(5) when sel = '1' else b(5);
    r(6) <= a(6) when sel = '1' else b(6);
    r(7) <= a(7) when sel = '1' else b(7);
    r(8) <= a(8) when sel = '1' else b(8);
    r(9) <= a(9) when sel = '1' else b(9);
    r(10) <= a(10) when sel = '1' else b(10);
    r(11) <= a(11) when sel = '1' else b(11);
    r(12) <= a(12) when sel = '1' else b(12);
    r(13) <= a(13) when sel = '1' else b(13);
    r(14) <= a(14) when sel = '1' else b(14);
    r(15) <= a(15) when sel = '1' else b(15);
end arch;

--------------------------------------------------------------------------------
-- 16-bit 4-way multiplexor
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity mux4way16 is
    port (
        a, b, c, d: in std_logic_vector(15 downto 0);
        sel: in std_logic_vector(1 downto 0);
        r: out std_logic_vector(15 downto 0)
    );
end mux4way16;

architecture arch of mux4way16 is
signal
    v0, v1: std_logic_vector(15 downto 0);
begin
    mux0: entity work.mux16(arch)
        port map(a => a, b => b, sel => sel(0), r => v0);
    mux1: entity work.mux16(arch)
        port map(a => c, b => d, sel => sel(0), r => v1);
    mux2: entity work.mux16(arch)
        port map(a => v0, b => v1, sel => sel(1), r => r);
end arch;

--------------------------------------------------------------------------------
-- 16-bit 8-way multiplexor
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity mux8way16 is
    port (
        a, b, c, d, e, f, g, h: in std_logic_vector(15 downto 0);
        sel: in std_logic_vector(2 downto 0);
        r: out std_logic_vector(15 downto 0)
    );
end mux8way16;

architecture arch of mux8way16 is
signal
    v0, v1: std_logic_vector(15 downto 0);
begin
    mux0: entity work.mux4way16(arch)
        port map(a => a, b => b, c => c, d => d, sel => sel(1 downto 0), r => v0);
    mux1: entity work.mux4way16(arch)
        port map(a => e, b => f, c => g, d => h, sel => sel(1 downto 0), r => v1);
    mux2: entity work.mux16(arch)
        port map(a => v0, b => v1, sel => sel(2), r => r);
end arch;

--------------------------------------------------------------------------------
-- Demultiplexor
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity dmux is
    port (
        a, sel: in std_logic;
        r0, r1: out std_logic
    );
end dmux;

architecture arch of dmux is
begin
    r0 <= a when sel = '0' else '0';
    r1 <= a when sel = '1' else '0';
end arch;

--------------------------------------------------------------------------------
-- 4-way demultiplexor
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity dmux4way is
    port (
        a: in std_logic;
        sel: in std_logic_vector(1 downto 0);
        r0, r1, r2, r3: out std_logic
    );
end dmux4way;

architecture arch of dmux4way is
signal
    v0, v1: std_logic;
begin
    dmux0: entity work.dmux(arch)
        port map(a => a, sel => sel(1), r0 => v0, r1 => v1);
    dmux1: entity work.dmux(arch)
        port map(a => v0, sel => sel(0), r0 => r0, r1 => r1);
    dmux2: entity work.dmux(arch)
        port map(a => v1, sel => sel(0), r0 => r2, r1 => r3);
end arch;

--------------------------------------------------------------------------------
-- 8-way demultiplexor
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity dmux8way is
    port (
        a: in std_logic;
        sel: in std_logic_vector(2 downto 0);
        r0, r1, r2, r3, r4, r5, r6, r7: out std_logic
    );
end dmux8way;

architecture arch of dmux8way is
signal
    v0, v1: std_logic;
begin
    dmux0: entity work.dmux(arch)
        port map(a => a, sel => sel(2), r0 => v0, r1 => v1);
    dmux4way0: entity work.dmux4way(arch)
        port map(a => v0, sel => sel(1 downto 0), r0 => r0, r1 => r1, r2 => r2, r3 => r3);
    dmux4way1: entity work.dmux4way(arch)
        port map(a => v1, sel => sel(1 downto 0), r0 => r4, r1 => r5, r2 => r6, r3 => r7);
end arch;
