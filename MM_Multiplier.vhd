----------------------------------------------------------------------------------
-- Create Date:    12:54:40 04/20/2021 
-- Designer Name:  Gaurav Kumar
-- Module Name:    MM_Multiplier - Behavioral 

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity MM_Multiplier is
    Generic (K: integer:=8);
	 Port ( X : in  STD_LOGIC_VECTOR (K-1 downto 0);
           Y : in  STD_LOGIC_VECTOR (K-1 downto 0);
           Z : out  STD_LOGIC_VECTOR (K-1 downto 0));
end MM_Multiplier;

architecture Behavioral of MM_Multiplier is

-->>>>>>>>>>Signal And Enitity Declaration For K bit Multiplier Mod N-->>>>>>>>>>

Constant int_M:integer:=239;
Constant inv_M:integer:=241;
Constant M: STD_LOGIC_VECTOR(K-1 downto 0):= CONV_STD_LOGIC_VECTOR(int_M,K);
Constant inverse_M: STD_LOGIC_VECTOR(2*K-1 downto 0):= CONV_STD_LOGIC_VECTOR(inv_M,2*K);
Constant int_R:integer:= 2**K; -- such that GCD(R,N)=1
Constant R: STD_LOGIC_VECTOR(K-1 downto 0):= CONV_STD_LOGIC_VECTOR(int_R,K);

------>>>>>>>>>>-------------------------------------------------------<<<<<<<<<<

-->>>>>>>>>>Signal And Enitity Declaration For K bit Array Multiplier-->>>>>>>>>>

COmponent Array_Multiplier is
Generic( K: integer);  
  Port ( A : in  STD_LOGIC_VECTOR (K-1 downto 0);
         B : in  STD_LOGIC_VECTOR (K-1 downto 0);
         P : out  STD_LOGIC_VECTOR (2*K-1 downto 0));
end Component;

Signal Product,Product2 : STD_LOGIC_VECTOR(2*K-1 downto 0); 
Signal Product1 : STD_LOGIC_VECTOR(4*K-1 downto 0); 

------>>>>>>>>>>-------------------------------------------------------<<<<<<<<<<

----->>>>>>>>>>Signal And Enitity Declaration For K bit Mod 2**K------->>>>>>>>>>

Component Mod_2k is
 Generic ( K: integer);
    Port ( A : in  STD_LOGIC_VECTOR (4*K-1 downto 0);
           Z : out  STD_LOGIC_VECTOR (K-1 downto 0));
end Component;

Signal Mod_Product : STD_LOGIC_VECTOR(K-1 downto 0); 

------>>>>>>>>>>-------------------------------------------------------<<<<<<<<<<

----->>>>>>>>>>Signal And Enitity Declaration For K bit Mod 2**K------->>>>>>>>>>

Component CPA_Adder is
    Generic (K: integer);
    Port ( A : in  STD_LOGIC_VECTOR(K-1 downto 0);
           B : in  STD_LOGIC_VECTOR(K-1 downto 0);
           Cin : in  STD_LOGIC:='0';
           Sum : out  STD_LOGIC_VECTOR(K-1 downto 0);
           Carry : out  STD_LOGIC);
end Component;

Signal Sum: STD_LOGIC_VECTOR(2*K-1 downto 0);
Signal Sum1: STD_LOGIC_VECTOR(K-1 downto 0);
SIgnal Carry,Carry1: STD_LOGIC;
------>>>>>>>>>>-------------------------------------------------------<<<<<<<<<<

----->>>>>>>>>>Signal And Enitity Declaration For K bit Comparator----->>>>>>>>>>

Component Comparator is
 Generic ( K: integer:=8); 
    Port ( A : in  STD_LOGIC_VECTOR (K-1 downto 0);
           B : in  STD_LOGIC_VECTOR (K-1 downto 0);
           G : out  STD_LOGIC;
           L : out  STD_LOGIC;
           E : out  STD_LOGIC);
end Component;
Signal G,L,E: STD_LOGIC;
------>>>>>>>>>>-------------------------------------------------------<<<<<<<<<<

begin

AM0:    Array_Multiplier generic map(K=>K) port map(A=>X,B=>Y,P=>Product);

AM1:    Array_Multiplier generic map(K=>2*K) port map(A=>Product,B=>inverse_M,P=>Product1);

MOD2K:  Mod_2k generic map(K=>K) port map(Product1,Mod_Product);

AM2:    Array_Multiplier generic map(K=>K) port map(A=>Mod_Product,B=>M,P=>Product2);

ADD0:   CPA_Adder generic map(K=> 2*K) port map(A=>Product2,B=>Product,Sum=>Sum,Carry=>Carry);

CMP0:   Comparator generic map(K=>K) port map(A=>Sum(2*K-1 downto K),B=>M,G=>G,L=>L,E=>E);

ADD1:   CPA_Adder generic map(K=> K) port map(A=>Sum(2*K-1 downto K),B=>M,Cin=>'1',Sum=>Sum1,Carry=>Carry1);

Process(G,L,E)
 Begin
  IF (G='1' OR E='1') Then
    Z <= Sum1;
  ELSE
    Z <= Sum(2*K-1 downto K);
  END IF;
END PROCESS;
end Behavioral;



