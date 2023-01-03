library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity KelseysSeniorDesign is
port(   clk,rst: in std_logic;
        SW: in std_logic_vector(3 downto 0);
        pwm_out,amp,squareout : out std_logic);
end KelseysSeniorDesign;

architecture Behavioral of KelseysSeniorDesign is

signal counter : Unsigned(7 downto 0):= (others => '0');
signal counter2 : Unsigned(7 downto 0):= (others => '0');
signal dacout_temp : unsigned(15 downto 0):= (others => '0');
signal clkDivider: Unsigned(15 downto 0):= (others => '0');
signal clkDivided:std_logic:= '0';
signal pwmCntr,pwmCntr_shifted : unsigned(7 downto 0);--pulse counter signal
signal clear : std_logic;--counter clear signal

begin

process(clk)
begin
if (rising_edge(clk)) then
clkDivider <= clkDivider + 1 ;
end if;
end process;

clkDivided<=clkDivider(14);

process(clkDivided,rst)
begin
if rst='1' then
counter <= (others=>'0');
dacout_temp <= (others=>'0');
elsif (rising_edge(clkDivided)) then
    if counter = x"FF" then
        dacout_temp <= (others=>'0');
        squareout <= '1';
        if counter2 = x"FF" then
            counter <= (others=>'0');       
        end if;
     else
        counter <= counter + 1 ; 
        dacout_temp <= dacout_temp + 1;
        squareout <= '0';           
    end if;         
end if;    
end process;

process(clkDivided,rst)
begin
if rst='1' then
counter2 <= (others=>'0');
elsif (rising_edge(clkDivided)) then
    if counter = x"FF" then
        if counter2 = x"FF" then
            counter2 <= (others=>'0');
        else
            counter2 <=counter2 + 1;    
        end if;
    end if;     
end if; 
end process;

process(clk, rst)
    begin
        if(rst = '1') then--resets to zero if the reset is pressed
            pwm_out <= '0';
        elsif(rising_edge(clk)) then--triggers on the rising edge of the clock
            if(clear = '1') then--resets the counter to 0 if the counter reaches maxcount
               pwm_out <= '0';
            else
                if(((dacout_temp) > pwmCntr_shifted) and (pwmCntr_shifted > 0)) then
                    pwm_out <= '1';
                else
                    pwm_out <= '0';
                end if;            
            end if;
        end if;
end process;

process(clk, rst)
    begin
        if(rst = '1') then--resets to zero if the reset is pressed
            pwmCntr <= (others=>'0');
        elsif(rising_edge(clk)) then--triggers on the rising edge of the clock
            if(clear = '1') then--resets the counter to 0 if the counter reaches maxcount
               pwmCntr <=  (others=>'0');
            else
               pwmCntr <= pwmCntr + 1;--adding one to the counter           
            end if;
        end if;
end process;
amp <= SW(0);
clear <= '1' when (pwmCntr = X"FF") else '0';--when counter reaches maxcount sets the clear signal to 1 to clear the counter
with SW(3 downto 1) select
    pwmCntr_shifted <=
        (pwmCntr) when "000", 
        (pwmCntr srl 1) when "001", 
        (pwmCntr srl 2) when "010", 
        (pwmCntr srl 3) when "011", 
        (pwmCntr srl 4) when "100",
        (pwmCntr srl 5) when "101", 
        (pwmCntr srl 6) when "110",
        (pwmCntr srl 7) when others;
        
end Behavioral;