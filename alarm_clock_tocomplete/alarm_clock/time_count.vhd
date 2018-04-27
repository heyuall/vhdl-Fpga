library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.ALARM_TYPES.all;

entity TIME_COUNT is
   port( SET_DATA            : in DISPLAY_4;
         LOAD_T              : in std_logic;
         CLOCK, ONE_MINUTE, 
         RESET               : in std_logic;
         TIME_DATA           : out DISPLAY_4);
end TIME_COUNT;

architecture RTL of TIME_COUNT is
   
   constant ZERO : std_logic_vector(3 downto 0) := "0000";

   -- LS_MIN : Chiffre des unités pour les minutes
   -- MS_MIN : Chiffre des dizaines pour les minutes
   -- LS_HR  : Chiffre des unités pour les heures
   -- MS_HR  : Chiffre des dizaines pour les heures
   signal LS_MIN, MS_MIN, LS_HR, MS_HR : std_logic_vector(3 downto 0);   

begin

   TIME_COUNTER:
   process(CLOCK, RESET)
   begin
   
      if (RESET = '1') then
         LS_MIN <= "0000";
         MS_MIN <= "0000";
         LS_HR <= "0000"; 
         MS_HR <= "0000";
      elsif (CLOCK'event and CLOCK='1') then

         if (LOAD_T = '1') then
				 MS_HR <= SET_DATA(3);
				 LS_HR<= SET_DATA(2);
				 MS_MIN<= SET_DATA(1);
				 LS_MIN<= SET_DATA(0);
			

         elsif ONE_MINUTE = '1' then
				if (MS_HR = "0010" and LS_HR="1001" and  MS_MIN ="0101" and LS_MIN ="1001") then
					LS_MIN <= "0000";
					MS_MIN <= "0000";
					LS_HR <= "0000"; 
					MS_HR <= "0000";
				elsif ( LS_HR="1001" and  MS_MIN ="0101" and LS_MIN ="1001") then
					LS_MIN <= "0000" ;
					MS_MIN <= "0000";
					LS_HR <= "0000"; 
					MS_HR <= MS_HR + 1;
				elsif (  LS_MIN ="0101" and MS_MIN ="1001") then
					LS_MIN <="0000" ;
					MS_MIN <="0000";
					LS_HR <= LS_HR + 1; 
					MS_HR <=MS_HR + 1 ;
				elsif (   LS_MIN ="1001") then
					LS_MIN <="0000" ;
					MS_MIN <=MS_MIN +1;
					LS_HR <= LS_HR + 1; 
					MS_HR <=MS_HR + 1 ;
				else LS_MIN <=LS_MIN +1;
				end if;
				

         end if;
			
       end if;

   end process TIME_COUNTER;

   TIME_DATA <= (MS_HR, LS_HR, MS_MIN, LS_MIN);
            
end RTL ;
