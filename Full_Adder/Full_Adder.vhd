library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Full_Adder is
port (
	S			: out std_logic;
	C_out		: out std_logic;
	x			: in std_logic;
	y			: in std_logic;
	C_in		: in std_logic);
end Full_Adder;

architecture behavior of Full_Adder is

signal inputs	: std_logic_vector(2 downto 0);
signal outputs	: std_logic_vector(1 downto 0);

begin
inputs <= C_in & x & y;
C_out <= outputs(1);
S <= outputs(0);

adder_proc : process(inputs)
begin
	case inputs is
		when "000" =>
			outputs <= "00";
		when "001" =>
			outputs <= "01";
		when "010" =>
			outputs <= "01";
		when "011" =>
			outputs <= "10";
		when "100" =>
			outputs <= "01";
		when "101" =>
			outputs <= "10";
		when "110" =>
			outputs <= "10";
		when "111" =>
			outputs <= "11";
		when others =>
			outputs <= (others => 'X');
	end case;
end process adder_proc;
end behavior;