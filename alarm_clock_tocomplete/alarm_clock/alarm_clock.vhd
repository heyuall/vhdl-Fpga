--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:    21:24:09 05/22/08
-- Design Name:    
-- Module Name:    alarm_clock - Behavioral
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alarm_clock is port
(
	AL, HR, MN, ALARM_ON, CLOCK, RESET : in std_logic;
	SOUND_A : out std_logic;
	SEL : out std_logic_vector(3 downto 0);
	DISP_8SEG: out std_logic_vector(7 downto 0)
);
end alarm_clock;

architecture Behavioral of alarm_clock is
	component control PORT	(
		AL, HR, MN, CLOCK, RESET : in std_logic;
		SHOW_T, LOAD_T, SHOW_A, LOAD_A, INC_HOUR, INC_MIN : out std_logic
	);
	end component;

	component pulse_gen PORT (
		CLOCK, RESET : in std_logic;
		ONE_MINUTE, HALF_SECOND : out std_logic
	);
	end component;

	component time_set PORT
	(
			CLOCK, RESET, HALF_SECOND, INC_MIN, INC_HOUR, SHOW_T, SHOW_A : in std_logic;
			ALARM_DATA, TIME_DATA : in DISPLAY_4;
			SET_DATA : out DISPLAY_4
	);
	end component;

	component alarm_reg4 PORT
	( 
		CLOCK, LOAD_A, RESET: in std_logic;
		SET_DATA: in DISPLAY_4;
		ALARM_DATA: out DISPLAY_4
	);
	end component;

	component time_count PORT
	(
	 	SET_DATA            : in DISPLAY_4;
      LOAD_T              : in std_logic;
      CLOCK, ONE_MINUTE, 
      RESET               : in std_logic;
      TIME_DATA           : out DISPLAY_4
	);
	end component;

	component DDRV4 PORT 
	(
		  TIME_DATA    : in DISPLAY_4;
        ALARM_DATA   : in DISPLAY_4;
        SET_DATA     : in DISPLAY_4;
        SHOW_T       : in std_logic;
        ALARM_ON     : in  std_logic;
        SHOW_A       : in  std_logic;
        SOUND_A      : out std_logic;
        DISP_7SEG    : out DISP7_T
	  );
	end component;

	component nexys3Affich port (
		CLOCK: std_logic;
		DISP_7SEG : in DISP7_T;
		S8_SEG: out std_logic_vector(7 downto 0);
		SEL : out std_logic_vector( 3 downto 0)
		);
	end component;

	signal HALF_SECOND, INC_MIN, INC_HOUR, SHOW_T, SHOW_A, LOAD_A, LOAD_T, ONE_MINUTE	: std_logic;
	signal SET_DATA, ALARM_DATA, TIME_DATA : DISPLAY_4;
	signal DISP_7SEG :  DISP7_T;
	  
begin

	 CONTROLfSM: control PORT MAP(
			AL	=> AL,
			HR	=> HR,
			MN	=> MN,
			CLOCK => CLOCK,
			RESET => RESET,
			SHOW_T => SHOW_T,
			LOAD_T => LOAD_T,
			SHOW_A => SHOW_A,
			LOAD_A => LOAD_A,
			INC_HOUR => INC_HOUR,
			INC_MIN => INC_MIN
	);
	
	PULSEgEN: pulse_gen PORT MAP(
		CLOCK => CLOCK,
		RESET => RESET,
		ONE_MINUTE => ONE_MINUTE, 
		HALF_SECOND => HALF_SECOND
	);

	TIMEsET: time_set PORT MAP(
		CLOCK => CLOCK,
		RESET => RESET,
		HALF_SECOND => HALF_SECOND,
		INC_MIN => INC_MIN,
		INC_HOUR => INC_HOUR,
		SHOW_T => SHOW_T,
		SHOW_A => SHOW_A,
		ALARM_DATA => ALARM_DATA,
		TIME_DATA => TIME_DATA,
		SET_DATA => SET_DATA
	);

	ALARMrEGISTER:	alarm_reg4 PORT MAP(
		CLOCK => CLOCK,
		LOAD_A => LOAD_A,
		RESET => RESET,
		SET_DATA => SET_DATA,
		ALARM_DATA => ALARM_DATA
	);

	TIMEcOUNT: time_count PORT MAP(
		
		SET_DATA => SET_DATA,
		LOAD_T => LOAD_T,
		CLOCK => CLOCK,
		ONE_MINUTE => ONE_MINUTE,
		RESET => RESET,
		TIME_DATA => TIME_DATA
	);

	DISPLAYdRIVER: ddrv4 PORT MAP(
		SET_DATA => SET_DATA,
		ALARM_DATA => ALARM_DATA,
		TIME_DATA => TIME_DATA,
		SHOW_A => SHOW_A,
		SHOW_T => SHOW_T,
		ALARM_ON => ALARM_ON,
		SOUND_A => SOUND_A,
		DISP_7SEG => DISP_7SEG
		);
	Nexys3A: nexys3Affich PORT MAP(
		CLOCK => CLOCK,
		DISP_7SEG => DISP_7SEG,
		S8_SEG => DISP_8SEG,
		SEL => SEL
	);

end Behavioral;
