LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;	

ENTITY univ_bin_c IS 
	GENERIC (N	:	INTEGER	:= 24);
	PORT	(  clk       : IN STD_LOGIC;
	         rst       : IN STD_LOGIC;
			   ena       : IN STD_LOGIC;
			   syn_clr   : IN STD_LOGIC;
			   max_tick  : OUT STD_LOGIC;
			   counter   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				MAX_COUNT : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY;

ARCHITECTURE rtl OF univ_bin_c IS
	SIGNAL count_s		: UNSIGNED (N-1 DOWNTO 0); 	
	SIGNAL count_next	: UNSIGNED (N-1 DOWNTO 0);
	SIGNAL bandera_max, bandera_min : STD_LOGIC;
BEGIN 
	count_next <= (OTHERS => '0') WHEN (syn_clr = '1') ELSE
					  count_s + 1	   WHEN (ena ='1') ELSE 	
					  count_s;
	
	PROCESS (clk, rst)
		VARIABLE temp 	:	UNSIGNED(N-1 DOWNTO 0);
	BEGIN 
		IF(rst = '0') THEN 
			temp	:= (OTHERS => '0');
		ELSIF(RISING_EDGE(clk)) THEN 
		 IF(ena = '1') THEN
				temp :=	count_next;
		 ELSE 
		   temp := (OTHERS => '0');
		 END IF;
		END IF;
		counter  <= STD_LOGIC_VECTOR(temp);
		count_s  <= temp;
	END PROCESS;
	
	max_tick	<= '1' WHEN (count_s = UNSIGNED(MAX_COUNT)) ELSE '0';
	
END ARCHITECTURE;	