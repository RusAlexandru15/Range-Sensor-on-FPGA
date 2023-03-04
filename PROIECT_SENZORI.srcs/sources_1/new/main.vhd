
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;


entity main is
  Port (
   clk:in std_logic;
   pulse:in std_logic;
   buzzer:out std_logic;
   trig:out std_logic;
   led:out std_logic_vector(8 downto 0)
   );
end main;

architecture Behavioral of main is

 
 signal trig1:std_logic;
 signal distance1:std_logic_vector(8 downto 0);
 signal forSSd:std_logic_vector(17 downto 0);
 
 signal hundreds1:std_logic_vector(3 downto 0);
 signal tens1:std_logic_vector(3 downto 0);
 signal unit1:std_logic_vector(3 downto 0);

begin
   
      
  triggerGenerator: entity WORK.trigger port map (
                clk => clk,
                trig=>trig1
               );
               
  trig<=trig1;      
        
  distanceCalculation: entity work.distanceCalculation port map(
                  clk=>clk,
                  calc_reset=>trig1,
                  pulse=>pulse,
                  distance=>distance1
                 
               );  
   
          
           
   buzzer1 :entity work.pwm_buzz port map(
                  clk=>clk,
                  distance=>distance1(7 downto 0),
                  buzzer=>buzzer
               );
   led<=distance1;            

end Behavioral;
