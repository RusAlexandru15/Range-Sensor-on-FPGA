library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity pwm_buzz is
  Port (
        clk:in std_logic;
        distance:in std_logic_vector(7 downto 0);
        buzzer : out STD_LOGIC
   );
end pwm_buzz;

architecture Behavioral of pwm_buzz is
   signal counter_pwm: std_logic_vector (7 downto 0) := (others => '0');

   signal clk_256:std_logic:='0';
   constant CNT_256KHZ : integer :=391; 
   signal num_256Khz:std_logic_vector(8 downto 0);

begin

  divclk: process (clk)
    begin
    if rising_edge(clk) then

         if (num_256Khz = CNT_256KHZ - 1) then
            clk_256<=not(clk_256);
            num_256Khz <= (others=>'0');
        else
            num_256Khz <= num_256Khz + 1;
        end if;
    end if;
   end process;


  pwm: process(clk_256)
   begin
    if rising_edge(clk_256) then 

       if(counter_pwm =256) then 
          counter_pwm<=(others=>'0');
       else
          counter_pwm<=counter_pwm+'1'; 
       end if;


       if (counter_pwm<distance) then 
          buzzer<='1';
       else
           buzzer<='0';
       end if;

    end if;
   end process; 


end Behavioral;