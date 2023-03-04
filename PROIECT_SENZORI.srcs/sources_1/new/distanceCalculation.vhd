library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;


entity distanceCalculation is
  Port (
  clk:in std_logic;
  calc_reset:in std_logic; --vine de la trig generator
  pulse:in std_logic; --pulse vine de la senzor  
  
  distance:out std_logic_vector(8 downto 0)); 
end distanceCalculation;


architecture Behavioral of distanceCalculation is
  signal pulse_width:std_logic_vector(21 downto 0);
  signal counter_out:std_logic_vector(21 downto 0);
begin

--counter
process(clk,calc_reset)
begin
   if(calc_reset='1') then 
      counter_out<=(others=> '0');
   elsif rising_edge(clk) then
       if pulse='1' then  
         counter_out<=counter_out+1;
         end if;
         
   end if;    
  
     
end process;   
   
pulse_width<=counter_out;

process(pulse,clk) 
variable result : integer;
variable helper :std_logic_vector(23 downto 0);

begin
   if rising_edge (clk) then 
    if(pulse='0') then 
       helper:= pulse_width * "11"; 
       result:=conv_integer(unsigned(helper(23 downto 13))); 
       
       if (result>458) then 
           distance<=(others=>'1');
       else
           distance<=conv_std_logic_vector(result,9);  
                    
       end if;     
    end if;   
end if;

end process;

end Behavioral;
