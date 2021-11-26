library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Debouncer circuit:
-- se bottone cambia, si resetta counter
-- se bottone non cambia, counter=counter-1
-- se counter = 0 ==> valore bottone stabile
-- si attiva l'uscita per un periodo di clock solo se valore stabile =/= segnale bottone nel ciclo precedente

entity Debouncer is
    port(button_in : in std_logic;
         clock : in std_logic;
         reset : in std_logic;
         pulse_out : out std_logic
        );
end Debouncer;

architecture Behavioural of Debouncer is
    constant MAX_COUNTS : integer := 15; -- lui tira un impulso ogni 15 cicli di clock, se la pressione dura più di 15 cicli
    constant BTN_ACTIVE_LOGIC : std_logic := '1';

    signal counter : integer := 0;
    signal state : std_logic := '0'; -- 0: idle, 1: wait_time
begin
    process(reset, clock)
    begin
        if (reset = '1') then
            pulse_out <= '0';
            state <= '0';
        elsif (rising_edge(clock)) then
            case(state) is
                when '0' =>
                    if(button_in = BTN_ACTIVE_LOGIC) then
                        state <= '1';
                    else
                        state <= '0';
                    end if;
                    pulse_out <= '0';
                when '1' =>
                    if (counter = MAX_COUNTS) then
                        counter <= 0;
                        if (button_in = BTN_ACTIVE_LOGIC) then
                            pulse_out <= '1';
                        end if;
                        state <= '0';
                    else
                        counter <= counter + 1;
                    end if;
                when others =>
                    
            end case;
        end if;
    end process;
end architecture Behavioural;