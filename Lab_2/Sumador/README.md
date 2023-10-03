# Proceso para crear un Sumador. 

## Creaciòn de los circuitos en DIGITAL

<p align="center">
 <img src="/Lab_2/Sumador/src/2.PNG">    
</p>  
<p align="center">
 Circuito Sumador completo de 2 bits   
</p> 


<p align="center">
 <img src="/Lab_2/Sumador/src/3.PNG">    
</p>  
<p align="center">
 Circuito Sumador completo de 4 bits   
</p> 

# 2. Implementaciòn de los circuitos en Verilog y Geany

## Creacion del banco de pruebas

Creamos un archivo _tb.v que serà nuestra testbech, en este caso se ajustó, teniendo en cuenta las 9 entradas, creando un array de [8:0] inputs;  y su variaciòn hasta 512, con un for.  A cada valor del array se le asoció un valor de las entradas del Sumador de cuatro bits. Así mismo, se creó un array de [4:0], con 5 espacios para las salida outs y se asignó a cada salida un valor.


<p align="center">
 <img src="/Lab_2/Sumador/src/10.PNG">    
</p>  
<p align="center">
 Fig 7. Código Verilog del testbech del Sumador de 4 bits.
</p> 


## 2.3 Finalmente, teniendo el testbech correctamente, se usan los códigos siguientes para crear el archivo que se abrirá en gtkwave.

// iverilog -o top.vvp Sumador4bits_tb.v Sumador4bits.v

// vvp top.vvp

// gtkwave top.vcd

Implementaciòn de los circuitos en gtkwave
Finalmente, con el código anterior se nos abre la ventana de gtkwave, aquí podemos observar la señal, en este caso sólo nos enfocaremos en un sumador de todo el circuito para ver si quedó bien:

<p align="center">
 <img src="/Lab_2/Sumador/src/11.PNG">    
</p>  
<p align="center">
 Simulación de un sumador. 
</p> 

Vemos que las entradas si se suman en conjunto con el carry en el Sumador 1 de nuestro circuito, por lo que decimos que quedó bien programado esta seccion y seguimos a verificar como se comporta con las 9 entradas al mismo tiempo

<p align="center">
 <img src="/Lab_2/Sumador/src/12.PNG">    
</p>  
<p align="center">
 Simulacion de un Sumador de 4 bits 
</p> 

Verificamos que todo sea correcto poniendo el cursor en un punto para ver qué valor tenemos, en este caso estamos sumando 01000 y 01001 y vemos que en la salida obtenemos 10001
