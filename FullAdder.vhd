----------------------------------------------------------------------------------
-- Create Date:    14:17:06 04/19/2021 
-- Designer Name:  Gaurav Kumar
-- Module Name:    FullAdder - Behavioral 

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC;
           Carry : out  STD_LOGIC);
end FullAdder;

architecture Behavioral of FullAdder is

begin

Sum <= A XOR B XOR Cin;
Carry <= ( (A AND B) OR (B AND Cin) OR (A AND Cin) );   

end Behavioral;

