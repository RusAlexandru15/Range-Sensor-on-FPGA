library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;


entity trigger is
  Port (
  clk:in std_logic;
  
  trig:out std_logic);
end trigger;

architecture Behavioral of trigger is

 signal counter_reset :std_logic;
 signal counter_out:std_logic_vector(23 downto 0);

 
 constant ms250:std_logic_vector(23 downto 0):="101111101011110000100000"; --250 microsecunde
 constant ms250_100us:std_logic_vector(23 downto 0):="101111101100111111101000"; --250+100us 
 constant ms250_100usV2:std_logic_vector(23 downto 0):="101111101111111110101000"; --250+100us 


 
begin

counter:process(clk,counter_reset)
        begin
        if(counter_reset='0') then 
           counter_out<=(others=>'0');
        elsif rising_edge(clk) then
           counter_out<=counter_out+ 1; 
        end if; 
        end process;
        
  process(clk)
  begin
    if (counter_out>ms250 and counter_out<ms250_100usV2) then 
       trig<='1';
    else 
       trig<='0';   
    end if;
    
    if(counter_out=ms250_100usV2) then 
      counter_reset<='0';
    else 
      counter_reset<='1';
    end if;     
  end process;      
  



end Behavioral;
