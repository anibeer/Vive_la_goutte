library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity DecodeurInstructions is 
port(
     IR : in std_logic_vector(7 downto 0);
     C,Z, clck: in std_logic;
	  jump_PC, inc_PC, ld_IR, ld_IR_lsn, wr, en_Accu : out std_logic;
	  AOP : out std_logic_vector(2 downto 0)
	  );
end DecodeurInstructions;


architecture behavior of DecodeurInstructions is 
type mc_state_type is
	(FETCH, DECODE, EXECUTE);
variable mnemo:std_logic_vector(3 downto 0) := ( others => '0');
begin
	process (all)
		case mc_state_type is
		WHEN FETCH:
			inc_PC <= '1';
			ld_IR <= '1';
		WHEN DECODE:
			inc_PC <= '0';
			ld_IR <= '0';
			mnemo(3) <= IR(7);
			mnemo(2) <= IR(6);
			mnemo(1) <= IR(5);
			mnemo(0) <= IR(4);
			case mnemo is
				WHEN "0100" =>
				WHEN "0011" =>
				WHEN "0111" =>
					ld_IR_lsn <= '1';
					
				WHEN Others
					ld_IR_lsn = '0';
			end case;
		WHEN EXECUTE:
			mnemo(3) <= IR(7);
			mnemo(2) <= IR(6);
			mnemo(1) <= IR(5);
			mnemo(0) <= IR(4);
			case mnemo is
				WHEN "0101" =>
				WHEN "0010" =>
					AOP <= "001";
					wr <= '0';
				WHEN "0110" =>
					AOP <= "100";
					wr <= '0';
				WHEN "0111" =>
					AOP <= "010";
					wr <= '0';
				WHEN "0011" =>
					wr <= '1';
				WHEN others
					case IR is
					 WHEN "00000000" =>
						C <= '0';
					 WHEN "00000001" =>
					   C <= '1';
					 WHEN "00000010" =>
						if C = '1'
							inc_PC <= '1';
						end if;
					 WHEN "000000011" =>
						if Z = '1'
							inc_PC <= '1';
						end if;
					end case;
			  end case;

	end process;
end behavior;

