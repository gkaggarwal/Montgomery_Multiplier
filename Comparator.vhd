----------------------------------------------------------------------------------
-- Create Date:    12:35:45 04/21/2021 
-- Designer Name:  Gaurav Kumar
-- Module Name:    Comparator - Behavioral 

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Comparator is
 Generic ( K: integer:=8); 
    Port ( A : in  STD_LOGIC_VECTOR (K-1 downto 0);
           B : in  STD_LOGIC_VECTOR (K-1 downto 0);
           G : out  STD_LOGIC;
           L : out  STD_LOGIC;
           E : out  STD_LOGIC);
end Comparator;

architecture Behavioral of Comparator is
Signal Integer_A, Integer_B : Integer;
begin

Integer_A <= To_Integer(unsigned (A));
Integer_B <= To_Integer(unsigned (B));
PROCESS(Integer_A,Integer_B)
 BEGIN
 IF( Integer_A /=0 AND Integer_B /=0) then
   IF( Integer_A > Integer_B) Then
	  G<='1';
	  L<='0';
	  E<='0';
	ELSIF( Integer_A < Integer_B) Then
	  G<='0';
	  L<='1';
	  E<='0';
   ELSIF( Integer_A = Integer_B) Then
	  G<='0';
	  L<='0';
	  E<='1';
	END IF;
  ELSE
     G<='0';
	  L<='0';
	  E<='0';	 
  END IF;
 END PROCESS;
end Behavioral;

