library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.ALARM_TYPES.all;

entity PULSE_GEN is
  port (CLOCK, RESET : in  std_logic;  
        HALF_SECOND  : out std_logic;  
        ONE_MINUTE   : out std_logic); 
end PULSE_GEN;

architecture Behavioral of pulse_gen is
begin
  process (CLOCK, RESET)
    variable counter_i : integer range 0 to 49999999 :=0;
	 variable counter_j :integer range 0 to 119 :=0;
	 
  begin
  		if RESET = '1' then
		counter_i :=0;
		counter_j := 0;

		elsif (rising_edge(CLOCK)) then
		 counter_i := counter_i +1;
		 
			if counter_i = 49999999 then
				counter_i := 0;
				HALF_SECOND <= '1';
				counter_j := counter_j + 1;
			else HALF_SECOND <= '0';
			end if;
			
			if counter_j = 119 then
				ONE_MINUTE <=  '1';
			
				counter_j := 0;
			else
				ONE_MINUTE <= '0';

			end if;
			
		end if;
	end process;
end Behavioral;
