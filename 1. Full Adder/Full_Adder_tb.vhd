library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

use std.textio.all;
use ieee.std_logic_textio.all;

entity Full_Adder_tb is
end;

architecture test of Full_Adder_tb is
component Full_Adder_2
port (
	S		: out std_logic;
	C_out	: out std_logic;
	x		: in std_logic;
	y 		: in std_logic;
	C_in	: in std_logic);
end component;

signal x_in					: std_logic;
signal y_in					: std_logic;
signal c_in					: std_logic;
signal s_out				: std_logic;
signal c_out				: std_logic;
signal s_expected			: std_logic;
signal c_out_expected		: std_logic;

signal inputs 				: std_logic_vector(2 downto 0);
signal outputs				: std_logic_vector(1 downto 0);

begin
	dev_to_test:	Full_Adder_2 port map (
		S => s_out, C_out => c_out,
		x => x_in, y => y_in, C_in => c_in);
		
	-- create test outputs
	inputs <= c_in & y_in & x_in;
	c_out_expected <= outputs(1);
	s_expected <= outputs(0);
	
	expected_proc : process(inputs)
		begin
			case inputs is
			when "000" => outputs <= "00";
			when "001" => outputs <= "01";
			when "010" => outputs <= "01";
			when "011" => outputs <= "10";
			when "100" => outputs <= "01";
			when "101" => outputs <= "10";
			when "110" => outputs <= "10";
			when "111" => outputs <= "11";
			when others => outputs <= (others => 'X');
			end case;
		end process expected_proc;
		
		stimulus : process
		
		-- variables for test bench
		variable ErrCnt	: integer := 0;
		variable WriteBuf : line ;
		
		begin
			for i in std_logic range '0' to '1' loop
				c_in <= i;
				for j in std_logic range '0' to '1' loop
					y_in <= j;
					for k in std_logic range '0' to '1' loop
						x_in <= k;
						
						wait for 10 ns;
						if (c_out_expected /= c_out) then
						write(WriteBuf, string'("ERROR FA test failed at c_out: x = "));
						write(WriteBuf, x_in); write(WriteBuf, string'(", y = "));
						write(WriteBuf, y_in); write(WriteBuf, string'(", c_in = "));
						write(WriteBuf, c_in);
						
						writeline(Output, WriteBuf);
						ErrCnt := ErrCnt+1;
						
						end if;
						
						if(s_expected /= s_out) then
						write(WriteBuf, string'("ERROR FA test failed at sum: x = "));
						write(WriteBuf, x_in); write(WriteBuf, string'(", y = "));
						write(WriteBuf, y_in); write(WriteBuf, string'(", c_in = "));
						write (WriteBuf, c_in);
						
						writeline(Output, WriteBuf);
						ErrCnt := ErrCnt+1;
					end if;
				end loop; -- k
			end loop;  -- j
		end loop; -- i
		
		if (ErrCnt = 0) then
			report "SUCCESS! Full Adder Test Completed.";
		else
			report "The Full Adder is broken." severity warning;
		end if;
	end process stimulus;
end test;