library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.ALARM_TYPES.all;

entity ALARM_REG4 is
  port (CLOCK, RESET : in  std_logic;
        SET_DATA     : in  DISPLAY_4;
        LOAD_A       : in  std_logic;
        ALARM_DATA   : out DISPLAY_4);
end ALARM_REG4;

architecture RTL of ALARM_REG4 is

begin

  ALREG: process (CLOCK, RESET)
  begin
    if RESET = '1' then
      ALARM_DATA <= (others => (others => '0'));
    elsif CLOCK'event and CLOCK='1' then
      if LOAD_A = '1' then
        ALARM_DATA <= SET_DATA;
      end if;
    end if;
  end process ALREG;

end RTL;
