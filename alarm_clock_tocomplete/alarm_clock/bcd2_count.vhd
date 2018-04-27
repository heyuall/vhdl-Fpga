--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:    08:51:37 04/25/08
-- Design Name:    
-- Module Name:    bcd2_count - Behavioral
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

use work.ALARM_TYPES.all;

entity BCD2_COUNT is
  generic (MSMAX, LSMAX : integer);
  port (CLOCK, RESET : in  std_logic;
        LOAD_EN      : in  std_logic;
        LOAD_DATA    : in  DISPLAY_2;
        COUNT_EN     : in  std_logic;
        OP_DATA      : out DISPLAY_2);
end BCD2_COUNT;

architecture RTL of BCD2_COUNT is

  constant NINE : std_logic_vector(3 downto 0) := "1001";
  signal MS, LS: std_logic_vector(3 downto 0);

begin

  BC: process (CLOCK, RESET)
  begin
    if RESET = '1' then
	 MS <= "0000";
	 LS <= "0000";

    elsif CLOCK'event and CLOCK='1' then
	 
      if LOAD_EN = '1' then
			ls <=  LOAD_DATA (0);
			ms <=  LOAD_DATA (1);

      elsif COUNT_EN = '1' then
			if LS = lsmax AND MS = MSMAX then
				MS <= "0000";
				LS <= "0000";
			
			elsif ms < msmax then
				if ls < lsmax then
				ls <= ls + 1;
				else 
					MS <= MS + 1;
					LS <= "0000";
				end if;
			else 
			ls <= ls+1;

					
			end if;

      end if;
    end if;
  end process BC;

  OP_DATA <= (MS ,LS);
              
end RTL;
