--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:    08:32:39 05/09/08
-- Design Name:    
-- Module Name:    control - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description:
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CONTROL is
  port (CLOCK, RESET : in  std_logic;
        AL           : in  std_logic;
        MN           : in  std_logic;
        HR           : in  std_logic;
        SHOW_A       : out std_logic;
        LOAD_A       : out std_logic;
        SHOW_T       : out std_logic;
        LOAD_T       : out std_logic;
        INC_HOUR     : out std_logic;
        INC_MIN      : out std_logic);
end CONTROL;

architecture RTL of CONTROL is

  type STATE_T is (SHOW_TIME, SHOW_ALARM,
                   INC_AL_MIN, INC_AL_HR,
                   INC_TI_MIN, INC_TI_HR,
                   TIME_SET, ALARM_SET);
  signal STATE : STATE_T;

begin

  FSM : process (CLOCK, RESET)
  begin
    if RESET = '1' then
      STATE <= SHOW_TIME;
    elsif CLOCK'event and CLOCK='1' then
      case STATE is
        when SHOW_TIME =>

        when SHOW_ALARM =>

        when INC_TI_HR =>

        when INC_TI_MIN =>  

        when TIME_SET =>
          STATE <= SHOW_TIME;
        when INC_AL_HR =>

        when INC_AL_MIN =>

        when ALARM_SET =>
          STATE <= SHOW_ALARM;
      end case;
    end if;
  end process FSM;

  SHOW_A   <= '1' when STATE = SHOW_ALARM else '0';
  LOAD_A   <= '1' when STATE = ALARM_SET else '0';

  SHOW_T   <= 
  LOAD_T   <= 

  with STATE select
    INC_HOUR    <= '1' when ,
                   '0' when others;

  with STATE select
    INC_MIN     <= '1' when ,
                   '0' when others;
                 
end RTL;

