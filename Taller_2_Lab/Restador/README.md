# Proceso para crear un restador. 

## Creaciòn de los circuitos en DIGITAL

Inicialmente partimos de crear un medio restador usando el software de Digital, para ello realizamos una tabla de verdad con entradas A y B y una salida S, que corresponde a la resta y C_out, de cómo se realiza la resta, partimos de que:

1-0 = 1  
0-1 = 1 y se activa el carry out, indicando que está negativo.  
1-1 = 0.   
0-0 = 0.  

Así entonces la tabla de verdad queda:

<img align="center" src="/Taller_2_Lab/Restador/src/2.png">

Fig 1. Tabla de verdad medio restador.  

Analizando la tabla es facìl ver, que la columna rest, tiene forma de una compuerta XOR cuyo valor serà 1, solo cuando sean diferentes. y para la columna de C_out tendremos entonces que se parece a una AND, Con la entrada de ‘A’ negada. Construimos el circuito para este medio restador en digital.  

 
![Image](/Taller_2_Lab/Restador/src/2.png)  
Fig 2. Circuito RTL para el medio restador.  

Luego se diseñó en digital un restador completo, en este caso a partir de la tabla de verdad obtenemos su diseño, que contiene una compuerta XOR de 3 entradas, junto con dos AND y OR, ver Fig 3.  

 
![Image](/Taller_2_Lab/Restador/src/3.png)
Fig 3. Circuito RTL Restador Completo.  

Partiendo de lo anterior, entonces se realiza el restador de 4 bits, que tendrá 8 entradas, es decir dos números de 4 bits, que se restaràn entre sì, se sabe que el c_0ut de un circuito irà conectado al c_in del otro, pues se irà acumulado, ya que la resta se harà bit a bit.
Ver figura 4. 

A su vez tendremos 5 salidas, 4 correspondientes a los bits restados y una 5, correspondiente al C_out del sistema total, este indicarà si el número sale o no en complemento a2, en dado caso que sea 1, el número es negativo y los 4 bits deberán ser convertidos de complemento a dos a binario positivo.

![Image](/Taller_2_Lab/Restador/src/4.png)
Fig 4. Circuito RTL del Restador de 4 Bits.  

![Image](/Taller_2_Lab/Restador/src/5.png)
Fig 5. Tabla de Verdad abreviada del restador de 4 bits.  

Si se desea obtener la tabla completa, ir al archivo .dig del restador de 4 bits y abrir la tabla de verdad.

En este caso la resta se hace del vector A - el vector B, en dado caso de que B sea mayor a A, el C_out serà 1, indicando que el número es negativo y está en complemento a dos y debe ser convertido. Como podemos ver en la tercera fila de la tabla en la figura 5, la resta es 0011 que en decimal es 3, con el 0101 que en decimal es 5, lo que nos debe dar -2, en la tabla observamos el valor 11110, el primer dígito correspondiente al C_out es negativo lo que indica que el valor està en complemento a dos, al pasarlo queda 0010, que corresponde al 2, y el C_out negativo, actúa como un menos.

Si por el contrario, el C_out tiene valor de 0, la respuestà està correcta y no debe pasarse a complemento a dos.

Como en el caso 0100 = A y B=0001 , en decimal la resta es 4-1 que da 3 positivo, es decir 00011.

# 2. Implementaciòn de los circuitos en Verilog y Geany

## 2.1 Para comprobar que el circuito funciona correctamente, lo exportamos a Verilog desde Digital y lo abrimos en geany. ver figura 6. 

## 2.2 Ahì creamos un archivo _tb.v que serà nuestra testbech, en este caso se ajustó, teniendo en cuenta las 8 entradas, creando un array de [7:0] inputs;  y su variaciòn hasta 256, con un for.  A cada valor del array se le asoció un valor de las entradas del restador de cuatro bits. para mejor detalle ver figura 7. Así mismo, se creó un array de [4:0], con 5 espacios para las salida outs y se asignó a cada salida un valor.
 

![Image](/Taller_2_Lab/Restador/src/6.png) 
Fig 6. Archivo verilog exportado del Restador 4 bits.

![Image](/Taller_2_Lab/Restador/src/7.png)
Fig 7. Código Verilog del testbech del Restador de 4 bits.

## 2.3 Finalmente, teniendo el testbech correctamente, se usan los códigos siguientes para crear el archivo que se abrirá en gtkwave.

// iverilog -o top.vvp Restador4bits_tb.v Restador4bits.v

// vvp top.vvp

// gtkwave top.vcd

Implementaciòn de los circuitos en gtkwave
Finalmente, con el código anterior se nos abre la ventana de gtkwave, aquí podemos observar la señal binaria correspondiente. Ver figura 8. 


Como podemos observar, se presenta el caso en el que el negativo es mayor que el positivo y ahì tenemos un C_0ut que està asignado en outs[4]= 1 y el resto de valores en 1, esto quiere decir que deben ser convertidos de complemento a dos a su forma binaria. Que da como resultado 0001 es decir 1, y el c_out indica menos 1.

Obsérvese, que el bit para el vector A, de menor valor es inputs[4] y para el vector B es inputs[0], así entonces obtenemos.

Vector A = [0000] B =[0001] lo que en decimal sería A-B= -1 = 0 -  1=-1.

![Image](/Taller_2_Lab/Restador/src/8.png) 
Fig 8. Imagen de gtkwave circuito Restador de 4 bits,  C_out negativo.

Por otro lado, tenemos el caso en el que, el C_out da positivo, indicando que el número mayor es positivo, por ejemplo veamos el ejemplo de la figura 9. tenemos:

A=[1010] y B= [0100] asi entonces A-B= 10 - 4 = 6 positivo.

Si nos fijamos en los Outs, el outs[4] que corresponde al C_out està en 0, el numero no debe ser convertido de complemento a dos. el resultado de la salida es:

S= [00110] = 6.

 

![Image](/Taller_2_Lab/Restador/src/9.png)
Fig 9. Imagen de gtkwave circuito Restador de 4 bits,  C_out positivo.

Una cosa curiosa para notar, es que en la gráfica el gtkwave escribe los valores en Hexadecimal.



