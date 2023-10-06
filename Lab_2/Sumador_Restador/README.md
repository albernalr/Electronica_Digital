# Creaciòn de los circuitos en DIGITAL

Una vez han sido creados los circuitos restador, y sumador de 4 bits por separado, son llamados estos en el software Digital como módulos independientes en un nuevo circuito que los integra, en el cual mediante la señal de control Ctrl se  hace uso de un conjunto de 17 compuertas AND a forma de multiplexor, para elegir la operación suma (Ctrl = 1) o resta (Ctrl = 0), como se muestra a continuaciòn: 



Cabe mencionar que la entrada Cin está únicamente conectada al sumador, puesto que el restador no la requiere, por la forma como fue construido; y una vez las señales de entrada pasan por cada módulo de suma o resta respectivamente, estos proporcionan como salidas S1,S2,S3,S4,Co. 

Debido a la cantidad de entradas, la tabla de verdad es extensa por lo que si se desea obtener la tabla completa, se recomienda dirigirse al archivo .dig del Sumador-Restador de 4 bits y abrir la tabla de verdad.


Implementaciòn de los circuitos en Verilog y Geany

2.1 Para comprobar que el circuito funciona correctamente, lo exportamos a Verilog desde Digital y lo abrimos en geany. ver figura 6. 

2.2 Ahì creamos un archivo _tb.v que serà nuestra testbech, en este caso se ajustó, teniendo en cuenta las 9 entradas, creando un array de [8:0] inputs;  y su variaciòn hasta 256, con un for.  A cada valor del array se le asoció un valor de las entradas del restador de cuatro bits. para mejor detalle ver figura 7. Así mismo, se creó un array de [4:0], con 5 espacios para las salida outs y se asignó a cada salida un valor.
 



Fig 6. Archivo verilog exportado del Restador 4 bits.

Fig 7. Código Verilog del testbench del Restador de 4 bits.

2.3 Finalmente, teniendo el testbench correctamente, se usan los códigos siguientes para crear el archivo que se abrirá en gtkwave.

// iverilog -o top.vvp restSum_tb.v restSum.v

// vvp top.vvp

// gtkwave top.vcd

Implementaciòn de los circuitos en gtkwave
Finalmente, con el código anterior se abre la ventana de gtkwave, en donde es posible observar lo siguiente: A modo de ejemplo se tiene en primer lugar la señal de control Ctrl=1 lo que indica que se realizará una suma, a continuaciòn teniendo en cuenta que el orden de los números de la MSB a la LSB es A4,A3,A2,A1 y B4,B3,B2,B1 respectivamente, se tiene que para los números 

A4
A3
A2
A1
B4
B3
B2
B1
0
0
0
1
0
0
1
1


El resultado de su suma es: 


Co
S4
S3
S2
S1
0
0
1
0
0











 lo que efectivamente puede confirmarse al verificar en el gtkwave la respectiva operación. Ver figura 8. 

Fig 8. Imagen de gtkwave circuito Sumador_Restador de 4 bits, operaciòn suma .

Del mismo modo, a modo de ejemplo, se tiene en segundo lugar que para una señal de control Ctrl = 0 indica que se realizarà una resta, por lo que para los números:


A4
A3
A2
A1
B4
B3
B2
B1
0
0
0
1
0
0
1
1


Su resta: 

 
Co
S4
S3
S2
S1
1
1
1
1
0


A sabiendas de que el resultado se encuentra en complemento A2, y que es el Co el bit que da información sobre el signo del número que resulta de la operación, lo que puede nuevamente identificarse en el gtkwave. Ver la figura 9.
 

Fig 9. Imagen de gtkwave circuito Sumador_Restador de 4 bits, operación resta.
