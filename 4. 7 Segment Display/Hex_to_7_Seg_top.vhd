library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Hex_to_7_Seg_top is
port (
	seg_out		: out std_logic_vector(6 downto 0);
	enable0		: out std_logic;
	enable1		: out std_logic;
	enable2		: out std_logic;
	enable3		: out std_logic;
	hex_in_0	: in std_logic_vector(3 downto 0);
	hex_in_1	: in std_logic_vector(3 downto 0);
	clk 		: in std_logic;
	reset		: in std_logic);
end Hex_to_7_Seg_top;


architecture behavior of Hex_to_7_Seg_top is
-----------------------------------------------------
-- Component Instantiations
-- 7 segment display
-- Even though we are using 2 7 segment displays we
-- still only need to instantiate the component once
-----------------------------------------------------
-- What is the component name?
-- Hint: it's the entity name of the VHDL design we are instantiating
component ?
port (
	seven_seg 		: out std_logic_vector(6 downto 0);
	hex 			: in std_logic_vector(3 downto 0));
end component;

-- Signals for holding each 7 segment displays value
signal Seg_0	: std_logic_vector(6 downto 0);
signal Seg_1	: std_logic_vector(6 downto 0);

-- Signals for Multiplexing the 7 Segment Display
-- The BASYS 3 Board has a default input clock of 100MHz
-- a 20-bit counter is required to count to 200000
-- we will be counting to 200000 to achieve a 500Hz refresh rate
-- This is computed by 100,000,000 / 500 = 200,000
signal counter		: unsigned(20 downto 0) := to_unsigned(0, 21); -- counts every clock pulse
constant maxcount	: integer := 200000; -- change this value to change your refresh rate
signal toggle		: std_logic_vector(1 downto 0) := "10"; -- used to control which display is active

begin
		-- Instantiate 2 instances of the Hex_to_7_Seg.vhd design file
		-- Hint: These names are the same as your component names
		seg1 : ?
			port map (Seg_1, hex_in_1);
		seg0 : ?
			port map (Seg_0, hex_in_0);
			
		-- Signal Assignments (This all happens continuously)	
		enable0 <= toggle(0); -- if signal toggle's LSB is 0 then the specified
							  -- 7 segment display associated with it is turned on
							  
		enable1 <= toggle(1); -- if signal toggle's MSB is 0 then the specified
							  -- 7 segment display associated with it is turned on
							  
		enable2 <= '1';		-- Turns a 7 segment display off (never changes)
		enable3 <= '1';		-- Turns a 7 segment display off (never changes)
			
		-- Counter Process that counts every clock pulse
		counter_proc: process(clk)
		begin
			if(rising_edge(clk)) then
				if(reset = '1' or counter = maxcount) then
					-- How do you set the signal counter back to 0?
					-- Hint: what VHDL keyword assigns all unspecified 
					--       values in an unsigned data type to '1' or '0'
					counter <= ?;
				else
					-- We want to increment the count here
					-- how do we do that?
					?
				end if;
			end if;
		end process counter_proc;
		
		-- Process that checks if signal counter has reached a value
		-- of constant maxcount
		-- if so we invert the toggle signal so that whichever display
		-- is active becomes inactive and the inactive display is now active
		-- We want this process to be evaluated every single clock cycle
		-- What should we place in the sensitivity list to achieve this?
		-- Hint: It is a port member of the Design Entity
		toggle_count_proc: process(clk)
		begin
			if(rising_edge(clk)) then
				if(reset = '1') then
					toggle <= toggle;
				elsif(counter = maxcount) then
					toggle <= not toggle;
				end if;
			end if;
		end process toggle_count_proc;
		
		-- Toggle the seven segment displays
		-- This process is evaluated when the toggle signal changes
		-- or either of the Seg_0 or Seg_1 signals change state
		toggle_proc: process(?, ?, ?)
		begin
			if(toggle(1) = '1') then
				seg_out <= Seg_1;
			else
				seg_out <= Seg_0;
			end if;
		end process toggle_proc;
end behavior;
