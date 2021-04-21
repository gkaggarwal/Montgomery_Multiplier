----------------------------------------------------------------------------------
-- Create Date:    15:00:59 04/19/2021 
-- Designer Name:  gaurav Kumar
-- Module Name:    Partial_Product - Behavioral 

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Partial_Product is
Generic  ( K: integer);
    Port ( A : in  STD_LOGIC_VECTOR (K-1 downto 0);
           B : in  STD_LOGIC;
           P : out  STD_LOGIC_VECTOR (K-1 downto 0));
end Partial_Product;

architecture Behavioral of Partial_Product is

begin

   Generate_Product: For I in 0 to K-1 Generate
                          P(I) <= (A(I) AND B);
						   END Generate Generate_Product;
end Behavioral;

