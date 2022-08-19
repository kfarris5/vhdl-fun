library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DSPsplice is
  Port ( x : in std_logic;
         y : out std_logic );
end DSPsplice;

architecture Behavioral of DSPsplice is



signal CLK : STD_LOGIC; 
signal A : STD_LOGIC_VECTOR(17 DOWNTO 0);
signal B : STD_LOGIC_VECTOR(17 DOWNTO 0);
signal C : STD_LOGIC_VECTOR(47 DOWNTO 0);
signal P : STD_LOGIC_VECTOR(47 DOWNTO 0);

COMPONENT dsp_macro_0
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    C : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
END COMPONENT;

begin
your_instance_name : dsp_macro_0
  PORT MAP (
    CLK => CLK,
    A => A,
    B => B,
    C => C,
    P => P
  );
your_instance_name2 : dsp_macro_0
  PORT MAP (
    CLK => CLK,
    A => A,
    B => B,
    C => C,
    P => P
  );
  

end Behavioral;
