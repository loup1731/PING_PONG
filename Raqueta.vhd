LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
---------------------------------------------------------------------------------------------------
ENTITY Raqueta IS
	PORT (	clk			  :      IN  STD_LOGIC;
				rst			  :      IN  STD_LOGIC;
				Boton_Arriba  :		IN	 STD_LOGIC;
				Boton_Abajo	  :		IN  STD_LOGIC;
            Raqueta		  : 		OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END ENTITY;
---------------------------------------------------------------------------------------------------
ARCHITECTURE LOGICA OF Raqueta IS
---------------------------------------------------------------------------------------------------
	TYPE estado IS (Raqueta_Inicio, Estado_1, Estado_2, Estado_3, Estado_4, Estado_5);
	SIGNAL	Estado_Actual, Siguiente_Estado	:	estado; 
	SIGNAL   Posicion_Raqueta				      : 	STD_LOGIC_VECTOR (7 DOWNTO 0);
---------------------------------------------------------------------------------------------------
BEGIN
---------------------------------------------------------------------------------------------------
	Cambio_Estado	:	PROCESS (rst, clk)
	BEGIN
	
	   IF (rst = '1') THEN 	
			Estado_Actual	<=		Raqueta_Inicio;
			Raqueta 			<= 	"11100000";
				
		ELSIF (RISING_EDGE(clk)) THEN
			Estado_Actual	<=		Siguiente_Estado;
			Raqueta		   <= 	Posicion_Raqueta;
	   END IF;
	END PROCESS;
---------------------------------------------------------------------------------------------------
	Movimiento_Raqueta	:	PROCESS(Estado_Actual, Boton_Arriba, Boton_Abajo)
	BEGIN

			CASE Estado_Actual IS
			
				WHEN Raqueta_Inicio	=>
				
					Posicion_Raqueta	<=		"11100000";
					
					IF (Boton_Abajo = '0') THEN
							Siguiente_Estado	<=		Estado_1;
					ELSE
							Siguiente_Estado	<=		Raqueta_Inicio;
					END IF;
					
				WHEN Estado_1	=>
				
					Posicion_Raqueta	<= 	"01110000";
					
					IF ((Boton_Arriba = '0') AND (Boton_Abajo = '1')) THEN
						Siguiente_Estado	<=		Raqueta_Inicio;
					ELSIF ((Boton_Arriba = '1') AND (Boton_Abajo = '0')) THEN
						Siguiente_Estado	<= 	Estado_2;
					ELSE	
						Siguiente_Estado 	<= 	Estado_1;
					END IF;
					
				WHEN Estado_2	=>
				
					Posicion_Raqueta	<= 	"00111000";
					
					IF ((Boton_Arriba = '0') AND (Boton_Abajo = '1')) THEN
						Siguiente_Estado	<=		Estado_1;
					ELSIF ((Boton_Arriba = '1') AND (Boton_Abajo = '0')) THEN
						Siguiente_Estado	<= 	Estado_3;
					ELSE	
						Siguiente_Estado 	<= 	Estado_2;
					END IF;
					
				WHEN Estado_3	=>
				
					Posicion_Raqueta	<= 	"00011100";
					
					IF ((Boton_Arriba = '0') AND (Boton_Abajo = '1')) THEN
						Siguiente_Estado	<=		Estado_2;
					ELSIF ((Boton_Arriba = '1') AND (Boton_Abajo = '0')) THEN
						Siguiente_Estado	<= 	Estado_4;
					ELSE	
						Siguiente_Estado 	<= 	Estado_3;
					END IF;
					
				WHEN Estado_4	=>
				
					Posicion_Raqueta	<= 	"00001110";
					
					IF ((Boton_Arriba = '0') AND (Boton_Abajo = '1')) THEN
						Siguiente_Estado	<=		Estado_3;
					ELSIF ((Boton_Arriba = '1') AND (Boton_Abajo = '0')) THEN
						Siguiente_Estado	<= 	Estado_5;
					ELSE	
						Siguiente_Estado 	<= 	Estado_4;
					END IF;
					
				WHEN Estado_5	=>
				
					Posicion_Raqueta	<= 	"00000111";
					IF((Boton_Arriba = '0') AND (Boton_Abajo = '1')) THEN
						Siguiente_Estado	<=		Estado_4;
					ELSE	
						Siguiente_Estado	<= 	Estado_5;
					END IF;
					
				END CASE;
---------------------------------------------------------------------------------------------------
	END PROCESS;
END ARCHITECTURE;