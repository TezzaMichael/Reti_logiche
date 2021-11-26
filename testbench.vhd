library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY tb_alu IS
END tb_alu;
 
ARCHITECTURE behavior OF tb_alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    component Debouncer
    port(
         clock : in  std_logic;
         reset : in  std_logic;
         button_in : in  std_logic;
         pulse_out : out  std_logic
        );
    end component;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal button_in : std_logic := '0';

    --Outputs
   signal pulse_out : std_logic;

   -- clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: Debouncer PORT MAP (
          clock => clock,
          reset => reset,
          button_in => button_in,
          pulse_out => pulse_out
        );

   -- clock process definitions
   clock_process :process
   begin
        clock <= '0';
        wait for clock_period/2;
        clock <= '1';
        wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin        
        button_in <= '0';
        reset <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;
        reset <= '0';
      wait for clock_period*10;
        --first activity
        button_in <= '1';   wait for clock_period*2;
        button_in <= '0';   wait for clock_period*1;
        button_in <= '1';   wait for clock_period*1;
        button_in <= '0';   wait for clock_period*20;
        --second activity
        button_in <= '1';   wait for clock_period*1;
        button_in <= '0';   wait for clock_period*1;
        button_in <= '1';   wait for clock_period*1;
        button_in <= '0';   wait for clock_period*2;
        button_in <= '1';   wait for clock_period*20;
        button_in <= '0';   
      wait;
   end process;

END;