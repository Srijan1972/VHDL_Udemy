library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;
use IEEE.numeric_std.all;

entity Counter is
	Generic (
		max_val 		: integer := 2**16;
		simulation		: boolean := false);
	Port (
		count 			: out std_logic_vector(integer(ceil(log2(real(max_val)))) - 1 downto 0);
		clk 			: in std_logic;
		reset 			: in std_logic);
end Counter;


architecture behavior of Counter is
	constant bit_depth	: integer := integer(ceil(log2(real(max_val))));
	signal count_reg	: unsigned(bit_depth - 1 downto 0) := (others => '0');
	signal cnter				: unsigned(25 downto 0) := to_unsigned(0, 26);
	constant maxcount			: integer := 100000;
	constant max_count_reg	    : integer := 65536;

	begin
	count <= std_logic_vector(count_reg);

		counter_proc: process(clk)
		begin
			if(rising_edge(clk)) then
				if(reset = '1' or cnter = maxcount) then
					cnter <= (others => '0');
				else
					cnter <= cnter + 1;
				end if;
			end if;
		end process counter_proc;

	synthesis: if simulation = false generate
		second_count_proc: process(clk)
		begin
			if(rising_edge(clk)) then
				if(reset = '1' or count_reg = max_count_reg) then
					count_reg <= (others => '0');
				elsif(cnter = maxcount) then
					count_reg <= count_reg + 1;
				end if;
			end if;
		end process second_count_proc;
	end generate;
	
	sim: if simulation = true generate	
		second_count_proc: process(clk)
		begin
			if(rising_edge(clk)) then
				if(reset = '1' or count_reg = max_count_reg) then 
					count_reg <= (others => '0');
				else
					count_reg <= count_reg + 1;
				end if;
			end if;
		end process second_count_proc;
	end generate;
		
end behavior;