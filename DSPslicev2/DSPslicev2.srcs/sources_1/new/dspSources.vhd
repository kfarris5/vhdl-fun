----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/18/2022 10:01:41 PM
-- Design Name: 
-- Module Name: dspSources - Behavioral
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
use ieee.numeric_std.all;

entity dspSources is
    Port ( clk : in std_logic;
           reset : in std_logic;
           inputSignal : in std_logic;
           delayOut : out std_logic );
end dspSources;

architecture Behavioral of dspSources is

component clkdivider is             --clock divider component
    generic (countMax   : natural := 2);
    port (  clk         : in std_logic;     --system clock
            inputSignal       : in std_logic;
            reset       : in std_logic;     --async reset
            delay      : out std_logic      --signal with 50% duty cycle
            );
end component;

signal delay1sig, delay2sig, delay3sig : std_logic;--pulse signals for internal use
signal ctr : unsigned(4 downto 0);--counter signal 

begin
delay1: clkdivider generic map (countMax => 125000000)  -- 1 sec clock
    port map (clk => clk, 
              reset=> reset, 
              delay => delay1sig, 
              inputSignal => inputSignal);
              
delay2: clkdivider generic map (countMax => 125000000)
    port map (clk => clk, 
              reset=> reset, 
              delay => delay2sig, 
              inputSignal => delay1sig);
              
delay3: clkdivider generic map (countMax => 125000000)
    port map (clk => clk, 
              reset=> reset, 
              delay => delay3sig,
              inputSignal => delay2sig);

delayOut <= delay3sig;

end Behavioral;
