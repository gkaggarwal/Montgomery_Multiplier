----------------------------------------------------------------------------------
-- Create Date:    14:07:07 04/19/2021 
-- Designer Name:  Gaurav Kumar
-- Module Name:    Array_Multiplier - Behavioral 

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Array_Multiplier is
Generic( K: integer);  
  Port ( A : in  STD_LOGIC_VECTOR (K-1 downto 0);
           B : in  STD_LOGIC_VECTOR (K-1 downto 0);
           P : out  STD_LOGIC_VECTOR (2*K -1 downto 0));
end Array_Multiplier;

architecture Behavioral of Array_Multiplier is

------>>>>>>>>>>Signal And Enitity Declaration For 1 bit Full Adder---->>>>>>>>>>

Component FullAdder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC;
           Carry : out  STD_LOGIC);
end Component;
Signal C1: STD_LOGIC_VECTOR(K-2 downto 0);

------>>>>>>>>>>>>>>>>>>>>------------------------------------>>>>>>>>>>>>>>>>>>>>

------>>>>>>>>>>Signal And Enitity Declaration For 1 bit half Adder---->>>>>>>>>>>

Component HalfAdder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Sum : out  STD_LOGIC;
           Carry : out  STD_LOGIC);
end Component;

Type Partial_Product_Array  IS Array(K-1 downto 0) Of STD_LOGIC_VECTOR(K-1 downto 0);
Signal PP_Array,S,C: Partial_Product_Array;

------>>>>>>>>>>>>>>>>>>>>------------------------------------>>>>>>>>>>>>>>>>>>>>

------>>>>>>>>>>Signal And Enitity Declaration For Partial_Product----->>>>>>>>>>>

Component Partial_Product is
Generic  ( K: integer);
    Port ( A : in  STD_LOGIC_VECTOR (K-1 downto 0);
           B : in  STD_LOGIC;
           P : out  STD_LOGIC_VECTOR (K-1 downto 0));
end Component;

------>>>>>>>>>>>>>>>>>>>>------------------------------------>>>>>>>>>>>>>>>>>>>>

begin

   Generate_Partial_AND: For I in 0 to K-1 Generate
	                    
							PP: Partial_Product generic map(K=>K) port map(A=>A,B=>B(I),P=>PP_Array(I));
	                  
							End Generate Generate_Partial_AND;
 
   S(0) <= PP_Array(0);
   C(0) <= (others=>'0');
   
	S(1)(K-1) <= PP_Array(1)(K-1);
	C(1)(K-1) <= '0';
	Generate_Half_Adder: For I In 1 to K-1 Generate
	                  
							   HA: HalfAdder port map(A=>PP_Array(1)(I-1),B=>S(0)(I),Sum=>S(1)(I-1),Carry=>C(1)(I-1));
							
							   END Generate Generate_Half_Adder;
   
	Generate_Full_Adder: For I In 2 to K-1 Generate
	                          S(I)(K-1) <= PP_Array(I)(K-1);
	                          C(I)(K-1) <= '0';
					              Start: For J In 1 to K-1 Generate
     							            FA: FullAdder port map(A=>PP_Array(I)(J-1),B=>S(I-1)(J),Cin=>C(I-1)(J-1),Sum=>S(I)(J-1),Carry=>C(I)(J-1));
							               END Generate Start;
          					END Generate Generate_Full_Adder;
   
	Loop_Product: For I In 0 to K-1 Generate
	                   P(I)<= S(I)(0);
					  END Generate Loop_Product;
					  
	Carry_Merge_HA: HalfAdder port map(A=>C(K-1)(0),B=>S(K-1)(1),Sum=>P(K),Carry=>C1(0));
		
	Start: For J In 2 to K-1 Generate
            CarryMergeFA: FullAdder port map(A=>C1(J-2),B=>S(K-1)(J),Cin=>C(K-1)(J-1),Sum=>P(J+K-1),Carry=>C1(J-1));
			 END Generate Start;
			 P(2*K-1)<= C1(K-2);
end Behavioral;

