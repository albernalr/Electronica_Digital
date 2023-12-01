library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
USE WORK.COMANDOS_LCD_REVC.ALL;

entity LCD1 is


PORT(CLK: IN STD_LOGIC;

-------------------------------------------------------
-------------PUERTOS DE LA LCD (NO BORRAR)-------------
	  RS : OUT STD_LOGIC;									  --
	  RW : OUT STD_LOGIC;									  --
	  ENA : OUT STD_LOGIC;									  --
	  CORD : IN STD_LOGIC;									  --
	  CORI : IN STD_LOGIC;									  --
	  DATA_LCD: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);     --
	  BLCD :  OUT STD_LOGIC_VECTOR(7 DOWNTO 0);       --
-------------------------------------------------------
	  
-----------------------------------------------------------
--------------ABAJO ESCRIBE TUS PUERTOS--------------------	
Boton1 : in  STD_LOGIC;
LED   : out STD_LOGIC := '1';
SAL1   : out STD_LOGIC := '1';		  
COLUMNAS   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); --PUERTO CONECTADO A LAS COLUMNAS DEL TECLADO
FILAS 	  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) --PUERTO CONECTADO A LA FILAS DEL TECLADO
	  );



end LCD1;

architecture Behavioral of LCD1 is

-----------------------------------------------------------------
---------------SE�ALES DE LA LCD (NO BORRAR)---------------------
TYPE RAM IS ARRAY (0 TO  60) OF STD_LOGIC_VECTOR(8 DOWNTO 0);  --
																					--
SIGNAL INST : RAM;													--
																					--
COMPONENT PROCESADOR_LCD_REVC is											--
																					--
PORT(CLK : IN STD_LOGIC;													--
	  VECTOR_MEM : IN STD_LOGIC_VECTOR(8 DOWNTO 0);					--
	  INC_DIR : OUT INTEGER RANGE 0 TO 1024;							--
	  CORD : IN STD_LOGIC;													--
	  CORI : IN STD_LOGIC;													--
	  RS : OUT STD_LOGIC;													--
	  RW : OUT STD_LOGIC;													--
	  DELAY_COR : IN INTEGER RANGE 0 TO 1000;							--
	  BD_LCD : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);			         --
	  ENA  : OUT STD_LOGIC;													--
	  C1A,C2A,C3A,C4A : IN STD_LOGIC_VECTOR(39 DOWNTO 0);       --
	  C5A,C6A,C7A,C8A : IN STD_LOGIC_VECTOR(39 DOWNTO 0);       --
	  DATA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)							--
		);																			--
																					--
end  COMPONENT PROCESADOR_LCD_REVC;										--
																					--
COMPONENT CARACTERES_ESPECIALES_REVC is										--
																					--
PORT( C1,C2,C3,C4:OUT STD_LOGIC_VECTOR(39 DOWNTO 0);				--
		C5,C6,C7,C8:OUT STD_LOGIC_VECTOR(39 DOWNTO 0);				--
		CLK : IN STD_LOGIC													--
		);																			--
																					--
end COMPONENT CARACTERES_ESPECIALES_REVC;	


component  LIB_TEC_MATRICIAL_4X4_INTESC_REVA is
generic( FREQ_CLK : integer := 50_000_000
        );
port( CLK        : in  std_logic;
      COLUMNAS   : in  std_logic_vector(3 downto 0);
      FILAS      : out std_logic_vector(3 downto 0);
      BOTON_PRES : out std_logic_vector(3 downto 0);
      IND        : out std_logic
     );
end component LIB_TEC_MATRICIAL_4X4_INTESC_REVA;
             								--


                  							--

																					--
CONSTANT CHAR1 : INTEGER := 1;											--
CONSTANT CHAR2 : INTEGER := 2;											--
CONSTANT CHAR3 : INTEGER := 3;											--
CONSTANT CHAR4 : INTEGER := 4;											--
CONSTANT CHAR5 : INTEGER := 5;											--
CONSTANT CHAR6 : INTEGER := 6;											--
CONSTANT CHAR7 : INTEGER := 7;											--
CONSTANT CHAR8 : INTEGER := 8;
											--
																					--
																					--
SIGNAL DIR : INTEGER RANGE 0 TO 1024 := 0;							--
SIGNAL VECTOR_MEM_S : STD_LOGIC_VECTOR(8 DOWNTO 0);				--
SIGNAL RS_S, RW_S, E_S : STD_LOGIC;										--
SIGNAL DATA_S : STD_LOGIC_VECTOR(7 DOWNTO 0);						--
SIGNAL DIR_S : INTEGER RANGE 0 TO 1024;								--
SIGNAL DELAY_COR : INTEGER RANGE 0 TO 1000;							--
SIGNAL C1S,C2S,C3S,C4S : STD_LOGIC_VECTOR(39 DOWNTO 0);	      --
SIGNAL C5S,C6S,C7S,C8S : STD_LOGIC_VECTOR(39 DOWNTO 0);  	   --
----------------------------------------------------------------
CONSTANT NUM_INSTRUCCIONES : INTEGER := 23;
CONSTANT ESCALA_1S : INTEGER := 50_000_000 -1;
CONSTANT ESCALA_2S : INTEGER := 750_000_000 -1;
CONSTANT FREQ_CLK : INTEGER := 50_000_000;
CONSTANT DELAY_1MS  : INTEGER := (FREQ_CLK/1000)-1;
CONSTANT DELAY_10MS : INTEGER := (FREQ_CLK/100)-1;
-----------------------------------------------------------------


---------------------------------------------------------
--------------AGREGA TUS SE�ALES AQU�--------------------
signal b                 : std_logic := '0';
signal conta_retardo     : integer range 0 to escala_1s := 1;
signal conta_retardo2     : integer range 0 to escala_1s := 1;
signal conta_retardo3     : integer range 0 to escala_2s := 744_000_000;
signal decenas           : integer range 0 to 9 :=1;
signal unidades          : integer range 0 to 9 :=5;
signal limp              : std_logic := '0';
signal buzz              : std_logic := '0';
signal contador          : integer   :=  0 ;
signal proceso_activo    : std_logic := '0';
signal numa              : integer   :=  0 ;
signal numb              : integer   :=  0 ;
signal numc              : integer   :=  0 ;
signal numd              : integer   :=  0 ;
signal se1g					 : STD_LOGIC_VECTOR(7 downto 0) := X"49";
signal se2g					 : STD_LOGIC_VECTOR(7 downto 0) := X"6E";
signal se3g					 : STD_LOGIC_VECTOR(7 downto 0) := X"67";
signal se4g					 : STD_LOGIC_VECTOR(7 downto 0) := X"72";
signal se5g					 : STD_LOGIC_VECTOR(7 downto 0) := X"65";
signal se6g					 : STD_LOGIC_VECTOR(7 downto 0) := X"73";
signal se7g					 : STD_LOGIC_VECTOR(7 downto 0) := X"65";
signal se8g					 : STD_LOGIC_VECTOR(7 downto 0) := X"10";
signal se9g					 : STD_LOGIC_VECTOR(7 downto 0) := X"6C";
signal se10g					 : STD_LOGIC_VECTOR(7 downto 0) := X"61";
signal se11g					 : STD_LOGIC_VECTOR(7 downto 0) := X"10";
signal se12g					 : STD_LOGIC_VECTOR(7 downto 0) := X"10";
signal se13g					 : STD_LOGIC_VECTOR(7 downto 0) := X"10";
signal se14g					 : STD_LOGIC_VECTOR(7 downto 0) := X"53";
signal se15g					 : STD_LOGIC_VECTOR(7 downto 0) := X"10";
signal se16g					 : STD_LOGIC_VECTOR(7 downto 0) := X"10";
signal s2e1g					 : STD_LOGIC_VECTOR(7 downto 0) := X"43";
signal s2e2g					 : STD_LOGIC_VECTOR(7 downto 0) := X"6F";
signal s2e3g					 : STD_LOGIC_VECTOR(7 downto 0) := X"6E";
signal s2e4g					 : STD_LOGIC_VECTOR(7 downto 0) := X"74";
signal s2e5g					 : STD_LOGIC_VECTOR(7 downto 0) := X"72";
signal s2e6g					 : STD_LOGIC_VECTOR(7 downto 0) := X"61";
signal s2e7g					 : STD_LOGIC_VECTOR(7 downto 0) := X"73";
signal s2e8g					 : STD_LOGIC_VECTOR(7 downto 0) := X"6E";
signal s2e9g					 : STD_LOGIC_VECTOR(7 downto 0) := X"61";
signal s2e10g					 : STD_LOGIC_VECTOR(7 downto 0) := X"10";
signal s2e11g					 : STD_LOGIC_VECTOR(7 downto 0) := X"10";
signal s2e12g					 : STD_LOGIC_VECTOR(7 downto 0) := X"10";
signal s2e13g					 : STD_LOGIC_VECTOR(7 downto 0) := X"10";
signal s2e14g					 : STD_LOGIC_VECTOR(7 downto 0) := X"10";
signal s2e15g					 : STD_LOGIC_VECTOR(7 downto 0) := X"10";
signal s2e16g					 : STD_LOGIC_VECTOR(7 downto 0) := X"10";
signal boton_pres           : std_logic_vector(3 downto 0) := (others => '0');
signal ind                  : std_logic := '0';
signal numi                 : integer   :=  0 ;
signal Boton                : std_logic := '0';
signal clave1					 : integer := 1;
signal clave2					 : integer := 2;
signal clave3					 : integer := 3;
signal clave4					 : integer := 4;
signal clavec1					 : integer := 7;
signal clavec2					 : integer := 8;
signal clavec3					 : integer := 9;
signal clavec4					 : integer := 7;
signal fin   					 : integer := 0;
signal final                : std_logic := '0';
signal camb                : std_logic := '0';
---------------------------------------------------------

BEGIN


-----------------------------------------------------------
------------COMPONENTES PARA LCD (NO BORRAR)---------------
U1 : PROCESADOR_LCD_REVC PORT MAP(CLK  => CLK,				--
									 VECTOR_MEM => VECTOR_MEM_S,	--
									 RS  => RS_S,						--
									 RW  => RW_S,						--
									 ENA => E_S,						--
									 INC_DIR => DIR_S,				--
									 DELAY_COR => DELAY_COR,		--
									 BD_LCD => BLCD,					--
									 CORD => CORD,						--
									 CORI => CORI,						--
									 C1A =>C1S,  					   --	
									 C2A =>C2S,							--
									 C3A =>C3S,							--
									 C4A =>C4S,							--
									 C5A =>C5S,							--
									 C6A =>C6S,							--
									 C7A =>C7S,							--
									 C8A =>C8S,							--
									 DATA  => DATA_S );				--
																			--
U2 : CARACTERES_ESPECIALES_REVC PORT MAP(C1 =>C1S,			--	
									C2 =>C2S,							--
									C3 =>C3S,							--
									C4 =>C4S,							--
									C5 =>C5S,							--
									C6 =>C6S,							--
									C7 =>C7S,						   --
									C8 =>C8S,							--
									CLK => CLK							--
									);										--
																			--
DIR <= DIR_S;															--
VECTOR_MEM_S <= INST(DIR);								--
																			--
RS <= RS_S;																--
RW <= RW_S;																--
ENA <= E_S;																--
DATA_LCD <= DATA_S;

																			--
													                  --
-----------------------------------------------------------


DELAY_COR <= 1000; --Modificar esta variable para la velocidad del corrimiento.

-------------------------------------------------------------------
-----------------ABAJO ESCRIBE TU C�DIGO EN VHDL-------------------

process(CLK)
begin
if rising_edge(CLK) then
	if (Boton1 = '0') then
		Boton <='1';
	end if;
	if final = '1' then
		Boton <= '0';
	end if;
end if;
end process;




process(CLK)
begin
if (Boton = '1') then
	if rising_edge(CLK) then
		 conta_retardo <= conta_retardo+1;
		 if conta_retardo = escala_1s then
			  conta_retardo <= 0;
			  b <= '1';
		 else
			  b <= '0';
		 end if;
	end if;
end if;
end process;

process(CLK)
begin
if (Boton = '1') then
	if rising_edge(CLK) then
		if b = '1' then
		  unidades <= unidades-1;
			if unidades = 0 then
				if decenas > 0 then
					unidades <= 9;
					decenas <= decenas -1;
				end if;
			end if;
		end if;
	end if;
end if;
if (Boton = '0') then
	decenas <= 1;
	unidades <= 5;
end if;
end process;

process(CLK)
begin
if (Boton = '1') then
	if falling_edge(clk) then
		if decenas = 0 then
			if unidades = 0 then
				LED <= '0';
			end if;
		end if;
	end if;
end if;
if (final = '1') then
	LED <= '1';
end if;
end process;


u3 : LIB_TEC_MATRICIAL_4X4_INTESC_REVA
generic map( FREQ_CLK => 50_000_000
           )
port map( CLK        => CLK, 
          COLUMNAS   => COLUMNAS, 
          FILAS      => FILAS, 
          BOTON_PRES => boton_pres,
          IND        => ind
);

process(CLK)
begin
if rising_edge(CLK) then

if (Boton = '0') then
	se1g  <= X"10" ;	
	se2g  <= X"10" ;	
	se3g	<= X"10" ;
	se4g	<= X"54" ;
	se5g	<= X"69" ;
	se6g	<= X"65" ; 
	se7g	<= X"6E" ;
	se8g	<= X"65" ;
	se9g	<= X"73" ;
	se10g <= X"10" ; 
	se11g <= X"10" ;
	
	s2e1g <= X"50" ;
	s2e2g <= X"61" ;
	s2e3g <= X"72" ;
	s2e4g <= X"61" ;
	s2e5g <= X"10" ;
	s2e6g <= X"64" ;
	s2e7g <= X"65" ;
	s2e8g <= X"73" ;
	s2e9g <= X"62" ;
	s2e10g <= X"6C";
	s2e11g <= X"6F";
	s2e12g <= X"71";
		            
end if;
if (Boton = '1') then
	se1g  <= X"49" ;	
	se2g  <= X"6E" ;	
	se3g	<= X"67" ;
	se4g	<= X"72" ;
	se5g	<= X"65" ;
	se6g	<= X"73" ; 
	se7g	<= X"65" ;
	se8g	<= X"10" ;
	se9g	<= X"6C" ;
	se10g <= X"61" ; 
	se11g <= X"10" ;
	
	s2e1g <= X"43";
	s2e2g <= X"6F";
	s2e3g <= X"6E";
	s2e4g <= X"74";
	s2e5g <= X"72";
	s2e6g <= X"61";
	s2e7g <= X"73";
	s2e8g <= X"65";
	s2e9g <= X"6E";
	s2e10g <= X"61";
	s2e11g <= X"10";
	s2e12g <= X"10";
end if;

conta_retardo2 <= conta_retardo2+1;
if conta_retardo2 = escala_1s then
	conta_retardo2 <= 0;
	final <= '0';
end if;
	if (Boton = '1') then
		conta_retardo3 <= conta_retardo3+1;
		if conta_retardo3 = 1 then
			s2e13g <= X"2A";
			s2e14g <= X"2A";
			s2e15g <= X"2A";
			s2e16g <= X"2A";
		end if;
		if conta_retardo3 = escala_2s then
				conta_retardo3 <= 0;
		end if;
		if ind = '1' and numi = 0 then
			if boton_pres = x"B" then
				s2e13g  <= X"31";
				numi  <= numi+1;
				clave1 <= 1;
			end if;
			if boton_pres = x"C" then
				s2e13g  <= X"32";
				numi  <= numi+1;
				clave1 <= 2;
			end if;
			if boton_pres = x"D" then
				s2e13g  <= X"33";
				numi  <= numi+1;
				clave1 <= 3;
			end if;
			if boton_pres = x"6" then
				s2e13g  <= X"34";
				numi  <= numi+1;
				clave1 <= 4;
			end if;
			if boton_pres = x"9" then
				s2e13g  <= X"35";
				numi  <= numi+1;
				clave1 <= 5;
			end if;
			if boton_pres = x"F" then
				s2e13g  <= X"36";
				numi  <= numi+1;
				clave1 <= 6;
			end if;
			if boton_pres = x"5" then
				s2e13g  <= X"37";
				numi  <= numi+1;
				clave1 <= 7;
			end if;
			if boton_pres = x"8" then
				s2e13g  <= X"38";
				numi  <= numi+1;
				clave1 <= 8;
			end if;
			if boton_pres = x"0" then
				s2e13g  <= X"39";
				numi  <= numi+1;
				clave1 <= 9;
			end if;
			if boton_pres = x"7" then
				s2e13g  <= X"30";
				numi  <= numi+1;
				clave1 <= 0;
			end if;
		end if;
		if ind = '1' and numi = 1 then
			if boton_pres = x"B" then
				s2e14g  <= X"31";
				numi  <= numi+1;
				clave2 <= 1;
			end if;
			if boton_pres = x"C" then
				s2e14g  <= X"32";
				numi  <= numi+1;
				clave2 <= 2;
			end if;
			if boton_pres = x"D" then
				s2e14g  <= X"33";
				numi  <= numi+1;
				clave2 <= 3;
			end if;
			if boton_pres = x"6" then
				s2e14g  <= X"34";
				numi  <= numi+1;
				clave2 <= 4;
			end if;
			if boton_pres = x"9" then
				s2e14g  <= X"35";
				numi  <= numi+1;
				clave2 <= 5;
			end if;
			if boton_pres = x"F" then
				s2e14g  <= X"36";
				numi  <= numi+1;
				clave2 <= 6;
			end if;
			if boton_pres = x"5" then
				s2e14g  <= X"37";
				numi  <= numi+1;
				clave2 <= 7;
			end if;
			if boton_pres = x"8" then
				s2e14g  <= X"38";
				numi  <= numi+1;
				clave2 <= 8;
			end if;
			if boton_pres = x"0" then
				s2e14g  <= X"39";
				numi  <= numi+1;
				clave2 <= 9;
			end if;
			if boton_pres = x"7" then
				s2e14g  <= X"30";
				numi  <= numi+1;
				clave2 <= 0;
			end if;
		end if;
		if ind = '1' and numi = 2 then
			if boton_pres = x"B" then
				s2e15g  <= X"31";
				numi  <= numi+1;
				clave3 <= 1;
			end if;
			if boton_pres = x"C" then
				s2e15g  <= X"32";
				numi  <= numi+1;
				clave3 <= 2;
			end if;
			if boton_pres = x"D" then
				s2e15g  <= X"33";
				numi  <= numi+1;
				clave3 <= 3;
			end if;
			if boton_pres = x"6" then
				s2e15g  <= X"34";
				numi  <= numi+1;
				clave3 <= 4;
			end if;
			if boton_pres = x"9" then
				s2e15g  <= X"35";
				numi  <= numi+1;
				clave3 <= 5;
			end if;
			if boton_pres = x"F" then
				s2e15g  <= X"36";
				numi  <= numi+1;
				clave3 <= 6;
			end if;
			if boton_pres = x"5" then
				s2e15g  <= X"37";
				numi  <= numi+1;
				clave3 <= 7;
			end if;
			if boton_pres = x"8" then
				s2e15g  <= X"38";
				numi  <= numi+1;
				clave3 <= 8;
			end if;
			if boton_pres = x"0" then
				s2e15g  <= X"39";
				numi  <= numi+1;
				clave3 <= 9;
			end if;
			if boton_pres = x"7" then
				s2e15g  <= X"30";
				numi  <= numi+1;
				clave3 <= 0;
			end if;
		end if;
		if ind = '1' and numi = 3 then
			if boton_pres = x"B" then
				s2e16g  <= X"31";
				numi  <= numi+1;
				clave4 <= 1;
				fin <= 1;
			end if;
			if boton_pres = x"C" then
				s2e16g  <= X"32";
				numi  <= numi+1;
				clave4 <= 2;
				fin <= 1;
			end if;
			if boton_pres = x"D" then
				s2e16g  <= X"33";
				numi  <= numi+1;
				clave4 <= 3;
				fin <= 1;
			end if;
			if boton_pres = x"6" then
				s2e16g  <= X"34";
				numi  <= numi+1;
				clave4 <= 4;
				fin <= 1;
			end if;
			if boton_pres = x"9" then
				s2e16g  <= X"35";
				numi  <= numi+1;
				clave4 <= 5;
				fin <= 1;
			end if;
			if boton_pres = x"F" then
				s2e16g  <= X"36";
				numi  <= numi+1;
				clave4 <= 6;
				fin <= 1;
			end if;
			if boton_pres = x"5" then
				s2e16g  <= X"37";
				numi  <= numi+1;
				clave4 <= 7;
				fin <= 1;
			end if;
			if boton_pres = x"8" then
				s2e16g  <= X"38";
				numi  <= numi+1;
				clave4 <= 8;
				fin <= 1;
			end if;
			if boton_pres = x"0" then
				s2e16g  <= X"39";
				numi  <= numi+1;
				clave4 <= 9;
				fin <= 1;
			end if;
			if boton_pres = x"7" then
				s2e16g  <= X"30";
				numi  <= numi+1;
				clave4 <= 0;
				fin <= 1;
			end if;
			
			
		end if;
		if fin = 1 then
			if clave1=clavec1 then
				if clave2=clavec2 then
					if clave3=clavec3 then
						if clave4=clavec4 then
							final <= '1';
							fin <= 0;
						end if;
						if clave4/=clavec4 then
							numi <=0;
							fin <= 0;
							s2e13g <= X"2A";
							s2e14g <= X"2A";
							s2e15g <= X"2A";
							s2e16g <= X"2A";
						end if;
					end if;
					if clave3/=clavec3 then
						numi <=0;
						fin <= 0;
						s2e13g <= X"2A";
						s2e14g <= X"2A";
						s2e15g <= X"2A";
						s2e16g <= X"2A";
					end if;
				end if;
				if clave2/=clavec2 then
					numi <=0;
					fin <= 0;
					s2e13g <= X"2A";
					s2e14g <= X"2A";
					s2e15g <= X"2A";
					s2e16g <= X"2A";
				end if;
			end if;
			if clave1/=clavec1 then
				numi <=0;
				fin <= 0;
				s2e13g <= X"2A";
				s2e14g <= X"2A";
				s2e15g <= X"2A";
				s2e16g <= X"2A";
			end if;
		end if;

	end if;
	if (Boton = '0') then
		s2e13g <= X"75";
		s2e14g <= X"65";
		s2e15g <= X"6F";
		s2e16g <= X"10";
		numi <= 0;
	end if;
	if camb = '1' then
		final <= '0';
	end if;
end if;
end process;	


-----------------------------------------------------------------------------------------
-------------------------ABAJO ESCRIBE TU C�DIGO PARA LA LCD-----------------------------



INST(0) <= LCD_INI("00");
INST(1) <= BUCLE_INI(1);
INST(2) <= POS(1,1);
INST(3) <= CHAR_ASCII(se1g);
INST(4) <= CHAR_ASCII(se2g);
INST(5) <= CHAR_ASCII(se3g);
INST(6) <= CHAR_ASCII(se4g);
INST(7) <= CHAR_ASCII(se5g);
INST(8) <= CHAR_ASCII(se6g);
INST(9) <= CHAR_ASCII(se7g);
INST(10) <= CHAR_ASCII(se8g);
INST(11) <= CHAR_ASCII(se9g);
INST(12) <= CHAR_ASCII(se10g);
INST(13) <= CHAR_ASCII(se11g);
INST(14) <= INT_NUM(decenas);
INST(15) <= INT_NUM(unidades);
INST(16) <= CHAR_ASCII(se14g);
INST(17) <= CHAR_ASCII(se15g);
INST(18) <= CHAR_ASCII(se16g);
INST(19) <= POS(2,1);
INST(20) <= CHAR_ASCII(s2e1g);
INST(21) <= CHAR_ASCII(s2e2g);
INST(22) <= CHAR_ASCII(s2e3g);
INST(23) <= CHAR_ASCII(s2e4g);
INST(24) <= CHAR_ASCII(s2e5g);
INST(25) <= CHAR_ASCII(s2e6g);
INST(26) <= CHAR_ASCII(s2e7g);
INST(27) <= CHAR_ASCII(s2e8g);
INST(28) <= CHAR_ASCII(s2e9g);
INST(29) <= CHAR_ASCII(s2e10g);
INST(30) <= CHAR_ASCII(s2e11g);
INST(31) <= CHAR_ASCII(s2e12g);
INST(32) <= CHAR_ASCII(s2e13g);
INST(33) <= CHAR_ASCII(s2e14g);
INST(34) <= CHAR_ASCII(s2e15g);
INST(35) <= CHAR_ASCII(s2e16g);
INST(36) <= BUCLE_FIN(1);
INST(37) <= LIMPIAR_PANTALLA(Boton);
INST(38) <= CODIGO_FIN(1);

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------


end Behavioral;