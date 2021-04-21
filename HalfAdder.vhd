----------------------------------------------------------------------------------
-- Create Date:    14:22:19 04/19/2021 
-- Designer Name:  Gaurav Kumar
-- Module Name:    HalfAdder - Behavioral 

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HalfAdder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Sum : out  STD_LOGIC;
           Carry : out  STD_LOGIC);
end HalfAdder;

architecture Behavioral of HalfAdder is

begin

Sum <= A XOR B;
Carry <= A AND B;

end Behavioral;

