library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Mult is
generic (
	input_size		: integer := 4);
port (
	product					: out unsigned(2*input_size - 1 downto 0);
	data_ready				: out std_logic;
	input_1					: in unsigned(input_size - 1 downto 0);
	input_2 				: in unsigned(input_size - 1 downto 0);
	start 					: in std_logic;
	reset 					: in std_logic;
	clk 					: in std_logic);
end Mult;


architecture behavior of Mult is
type state_type is(init, load, right_shift, done);
signal state, nxt_state	: state_type;

signal shift				: std_logic;
signal add					: std_logic;
signal load_data			: std_logic;

constant maxcount			: integer := input_size - 1;
signal input_1_reg			: unsigned(input_size - 1 downto 0) := (others => '0');
signal sum					: unsigned(input_size downto 0) := (others => '0');
signal product_reg			: unsigned(2*input_size - 1 downto 0) := (others => '0');
signal count 				: integer range 0 to maxcount + 1 := 0;
signal start_count_lead		: std_logic := '0';
signal start_count_follow	: std_logic := '0';
signal start_count			: std_logic := '0';

begin
	state_proc: process(clk)
		begin
		if rising_edge(clk) then
			if(reset = '1') then
				state <= init;
			else
				state <= nxt_state;
			end if;
		end if;
	end process state_proc;
	
	state_machine: process(state, start, start_count, count, product_reg(0))
		begin
		nxt_state <= state;
		shift <= '0';
		add <= '0';
		load_data <= '0';
		data_ready <= '0';
		
		case state is
			when init =>
				if(start_count = '1') then
					nxt_state <= load;
				else
					nxt_state <= init;
				end if;
			when load =>
				load_data <= '1';
				nxt_state <= right_shift;
			when right_shift =>
				shift <= '1';
				if(count /= maxcount) then
					nxt_state <= right_shift;
				else
					nxt_state <= done;
				end if;
				if(product_reg(0) = '1') then
					add <= '1';
				end if;
			when done =>
				data_ready <= '1';
				if(start = '0') then
					nxt_state <= init;
				else
					nxt_state <= done;
				end if;
			when others =>
				nxt_state <= init;
		end case;
	end process state_machine;
	
	start_count <= start_count_lead and (not start_count_follow);
	
	start_count_proc: process(clk)
		begin
		if(rising_edge(clk)) then
			if(reset = '1') then
				start_count_lead <= '0';
				start_count_follow <= '0';
			else
				start_count_lead <= start;
				start_count_follow <= start_count_lead;
			end if;
		end if;
	end process start_count_proc;
	
	count_proc: process(clk)
		begin
		if(rising_edge(clk)) then
			if((start_count = '1') or (reset = '1')) then
				count <= 0;
			elsif(state = right_shift) then
				count <= count + 1;
			end if;
		end if;
	end process count_proc;
	
	
	sum <= ('0' & product_reg(2*input_size - 1 downto input_size)) + ('0' & input_1_reg);
	
	mult_proc: process(clk)
		begin
		if(rising_edge(clk)) then
			if(reset = '1') then
				product_reg <= (others => '0');
				input_1_reg <= (others => '0');
			elsif(load_data = '1') then
				product_reg(input_size*2 - 1 downto input_size) <= (others => '0');
				product_reg(input_size -1 downto 0) <= input_2;
				input_1_reg <= input_1;
			elsif(add = '1') then
				product_reg <= sum(input_size downto 0) & product_reg(input_size - 1 downto 1);
			elsif(shift = '1') then	
				product_reg <= '0' & product_reg(input_size*2 - 1 downto 1);
			end if;
		end if;
	end process mult_proc;
	
	product <= product_reg;
end behavior;