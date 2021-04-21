----------------------------------------------------------------------------------
-- Create Date:    13:06:11 04/20/2021 
-- Designer Name:  Gaurav kumar
-- Module Name:    Mod_2k - Behavioral 

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mod_2k is
 Generic ( K: integer);
    Port ( A : in  STD_LOGIC_VECTOR (4*K-1 downto 0);
           Z : out  STD_LOGIC_VECTOR (K-1 downto 0));
end Mod_2k;

architecture Behavioral of Mod_2k is

begin

Z(K-1 downto 0)<= A(K-1 downto 0);

--Start: For I in K to 2*K-1 Generate
--          Z(I)<='0';
--	    End Generate Start;

end Behavioral;

