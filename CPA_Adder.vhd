----------------------------------------------------------------------------------
-- Create Date:    21:38:35 04/14/2021 
-- Designer Name:  Gaurav Kumar
-- Module Name:    CPA_Adder - Behavioral 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPA_Adder is
    Generic (K: integer);
    Port ( A : in  STD_LOGIC_VECTOR(K-1 downto 0);
           B : in  STD_LOGIC_VECTOR(K-1 downto 0);
           Cin : in  STD_LOGIC:='0';
           Sum : out  STD_LOGIC_VECTOR(K-1 downto 0);
           Carry : out  STD_LOGIC);
end CPA_Adder;

architecture Behavioral of CPA_Adder is
------>>>>>>>>>>Signal And Enitity Declaration For 1 bit Full Adder---->>>>>>>>>>
Component FullAdder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC;
           Carry : out  STD_LOGIC);
end Component;

Signal C: STD_LOGIC_VECTOR(K downto 1);
------>>>>>>>>>>-------------------------------------------------------<<<<<<<<<<
begin
ADD0: FullAdder port map(A=>A(0),B=>B(0),Cin=>Cin,Sum=>Sum(0),Carry=>C(1));

Generate_Adder:
          For I in 1 to K-1 Generate
			 ADD: FullAdder port map(A=>A(I),B=>B(I),Cin=>C(I),Sum=>Sum(I),Carry=>C(I+1));
          End Generate Generate_Adder;
carry<=C(K);			 
end Behavioral;

