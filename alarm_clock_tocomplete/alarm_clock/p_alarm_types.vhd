library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package ALARM_TYPES is

  -- 7 segment encoding constants for digits 0 to 9
		constant ZERO_SEG		: std_logic_vector( 6 downto 0) := "0000001";
	   constant ONE_SEG		: std_logic_vector( 6 downto 0) := "1001111";
	   constant TWO_SEG		: std_logic_vector( 6 downto 0) := "0010010";
		constant THREE_SEG	: std_logic_vector( 6 downto 0) := "0000110";
		constant FOUR_SEG		: std_logic_vector( 6 downto 0) := "1001100";
		constant FIVE_SEG		: std_logic_vector( 6 downto 0) := "0100100";
	   constant SIX_SEG		: std_logic_vector( 6 downto 0) := "0100000";
		constant SEVEN_SEG	: std_logic_vector( 6 downto 0) := "0001111";
		constant EIGHT_SEG	: std_logic_vector( 6 downto 0) := "0000000";
		constant NINE_SEG 	: std_logic_vector( 6 downto 0) := "0000100";
		constant ERROR_SEG	: std_logic_vector( 6 downto 0) := "0110000";

  -- 2 and 4 digit BCD data types for labs 10 and 12 onwards
  type DISPLAY_T is array (natural range <>) of std_logic_vector(3 downto 0);
  subtype DISPLAY_2 is DISPLAY_T(1 downto 0);
  subtype DISPLAY_4 is DISPLAY_T(3 downto 0);

  type DISP7_T is array (3 downto 0) of std_logic_vector(6 downto 0);

end ALARM_TYPES;
