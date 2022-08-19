----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/18/2022 09:50:33 PM
-- Design Name: 
-- Module Name: clock - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity clkdivider is
    generic (countMax : natural := 2);
    Port ( clk      : in std_logic;
           reset    : in std_logic;
           inputSignal :in std_logic;
           delay   : out std_logic);
end clkdivider;
architecture Behavioral of clkdivider is
signal cnt : natural range 0 to countMax-1;
begin
process(clk,reset)--counter for clock divider, just need clk and reset in sensitivity list
    begin
        if reset='1' then--async reset
            cnt<=0;--sets cnt to 0
        elsif rising_edgE(clk) then--looking at the rising edge of the system clock
            if (cnt = countMax-1)  then--see if the counter has counted up to the generic passed in
                cnt <= 0;--sets to 0 if counter is at max
            else
                cnt <= cnt+1;--adds one to counter till it reaches the maximium amount
            end if;
        end if;
end process;
delay <= inputSignal when cnt=countMax-1 else '0';--pulse out once the counter has reached it's max
end Behavioral;

