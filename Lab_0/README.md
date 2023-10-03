
Proceso de Instalación en un Disco DURO.

En este Caso uno de los integrantes del grupo contaba con un disco duro extraíble de capacidad de -------- por lo que decidió montar el sistema operativo LINUX MINT MATE, bajado de la siguiente pagina: https://linuxmint.com/edition.php?id=282
 
1.	Instalar RUFUS
Para ello, lo primero que se hizo fue instalar el Rufus en el computador del siguiente enlace https://rufus.ie/es/, este programa nos permite crear USBs de arranque, con las cuales podemos hacer varias cosas, como crear medios de instalación de otros sistemas operativos mediante sus imágenes ISO. 

<p align="center">
 <img src="/Lab_0/src/1.png">    
</p>  

En este caso se usó la versión 4.2.

<p align="center">
 <img src="/Lab_0/src/2.png">    
</p>  
 
2.	Quemar la ISO 

Lo siguiente fue conectar el disco extraible y seleccionarlo dentro de la lista de dispositivos.
Seleccione la opción “GPT para UEFI ” en la opción Esquema de Particiòn. y luego “FAT32” en la opción sistema de archivos, luego en la opción de espacio adicional en la unidad ingrese 1000 GB que es el espacio que usaré para almacenar mis archivos.

Luego, seleccione la opción crear un disco de arranque con Linux Mint MAte, que fue la ISO que descargue Y finalmente le di iniciar. 

No realice particiones de Disco, más que poner el espacio para guardar archivos.

Después de de eso, lo siguiente fue reiniciar el computador y arrancar los sistemas de arranque con esc, y f9, allì aparece mi disco duro Fujitsu, que contenía linux y ya.

3.	Instalaciòn de Herramientas para DIGITAL

En realidad se siguio paso a paso el tutorial de github del profesor, https://github.com/johnnycubides/digital-electronic-1-101/tree/main/installTools

Inicialmente instalando mini-conda y luego activando digital con los códigos: 

$ cd Downloads
$ wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
$ bash Miniconda3-latest-Linux-x86_64.sh # Seguir las instrucciones y reiniciar la terminal

Luego se creó el entorno digital:

(base) $ conda update conda # Actualizar conda
(base) $ conda create -n digital python=3.7 # Configurar digital como variable de entorno y python3.10
(base) $ conda activate digital  # Activar la variable de entorno de conda denominada digital
(digital) $ python --version

<p align="center">
 <img src="/Lab_0/src/3.png">    
</p>   

Fig 1. Instalaciòn de Conda


y finalmente, se instalaron programas como iceprog, Yosys, Iverilog, netlistsvg, graphviz, gtkwave. Siguiendo los códigos del tutorial: 

(digital) $ conda install -c litex-hub nextpnr-ice40
(digital) $ conda install -c litex-hub nextpnr-ecp5
(digital) $ conda install -c litex-hub iceprog
(digital) $ conda install -c litex-hub yosys
(digital) $ conda install -c litex-hub iverilog
(digital) $ conda install -c symbiflow netlistsvg
(digital) $ conda install -c conda-forge graphviz
(digital) $ conda install -c conda-forge gtkwave

<p align="center">
 <img src="/Lab_0/src/4.png">    
</p>  

Fig 2. Instalación de Yossys

<p align="center">
 <img src="/Lab_0/src/5.png">    
</p>  
 
Fig 3. Comprobación de funcionamiento de gtkwave

<p align="center">
 <img src="/Lab_0/src/6.png">    
</p>  

Fig 4. Instalación de graphviz


El último programa en instalarse fue DIgital, se baja un archivo zip del github, se descomprime y se da doble clic en el .jar para iniciarlo, ver imágenes referenciales.

 <p align="center">
 <img src="/Lab_0/src/7.png">    
</p>  

Fig 5. Carpeta Digital.zip descomprimida.

<p align="center">
 <img src="/Lab_0/src/8.png">    
</p>  

Fig 6. Digital funcionando.

 

Tras haberlo instalado correctamente, vamos al inicio de linux y escribimos Digital, damos enter y se nos abre el programa.
 
<p align="center">
 <img src="/Lab_0/src/9.png">    
</p> 

Fig 7. Geany Funcionando.

Finalmente instalamos Geany que es un editor de texto, que permite guardar archivos de verilog, de python y casi cualquier lenguaje de programación. Se usa el comando sudo apt install geany y el baja el programa.
 



