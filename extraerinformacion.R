#Instalando libreria r vest
#install.packages("rvest")
library(rvest)
#funciones que no estan descargadas, llamamos a library para que aparezcan

pagina <- read_html("antiratas.html")
#a es la salida del html, recibo un parámetro
#recordar que el punto corresponde a la clase, me sitúo en inspeccionar
#y busco el div de la noticia en este caso.
#en el caso que no tengamos el read html antiratas dentro de pagina
#y sea una en linea, solo pongo el url en vez de pagina en html nodes

#######EXTRACCION DE TABLA##########
html_nodes(pagina, ".amarillo")

nodesDelHTML <- html_nodes(pagina, ".amarillo")

#la entrada de html text es la salida del html nodes, es decir, nodes del html
#Con html text llamo e imprime lo que llamé de la pagina
#/n son los enter, /t son los tab

html_text(nodesDelHTML)

texto <- (html_text(nodesDelHTML))

#Ahora vamos a limpiar los datos
#El que buscamos, reemplazarlo por nada "" y eso lo quiero aplicar sobre
#el texto o como se llame

gsub("\n","",texto)

#Hasta el momento es algo temporal, debido a que no lo he asignado
#Los tag van solo entre comillas, las classes con punto y los id con #


nodesDelHTML <- html_nodes(pagina, ".rojo")
tabla <- html_nodes(nodesDelHTML, "table")

tabla1 <- html_table(tabla[[1]])
#Tarea: debo sacar los $ 
