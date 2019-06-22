#Instalando libreria r vest
#install.packages("rvest")
library('rvest')
#funciones que no estan descargadas, llamamos a library para que aparezcan

pagina <- read_html("antiratas.html")
#a es la salida del html, recibo un parámetro
#recordar que el punto corresponde a la clase, me sitúo en inspeccionar
#y busco el div de la noticia en este caso.
#en el caso que no tengamos el read html antiratas dentro de pagina
#y sea una en linea, solo pongo el url en vez de pagina en html nodes

#######EXTRACCION DE TEXTO##########
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
texto <- gsub("\n","",texto)

gsub("\r","",texto)
texto <- gsub("\r","",texto)

gsub ("\t","",texto)
texto <- gsub ("\t","",texto)


print (texto)
#Hasta el momento es algo temporal, debido a que no lo he asignado
#Los tag van solo entre comillas, las classes con punto y los id con #

#Separando cada una de las palabras

splitEspacioTexto <- strsplit(texto," ")[[1]]
print(splitEspacioTexto)

#Pasando todas las palabras a minuscula con tolower, para que no diferencie las palabras y as� 
#generalizo el texto (debido a que pueden haber palabras dps del punto que parten con
#mayuscula y q se pueden repetir pero en minuscula, por lo tanto asi lo generalizo)

splitEspacioTexto <- tolower(splitEspacioTexto)

#contando palabras
unlistTexto <- unlist(splitEspacioTexto)
print(unlistTexto)

#unlist te enumera las palabras del texto

tablaPalabras <- table(unlistTexto)
print (tablaPalabras)

#table(unlistTexto) este me cuenta las veces que se repite la palabra

dfPalabras <- as.data.frame(tablaPalabras)

#data frame me hace tabla con lo anterior y asi queda mas ordenado

#Inentar ordenar las cosas con separacion de ;

#DEBO ALMACENAR LA INFORMACIOOOOON, SINO LA PIerdo, DE ESTA FORMA SE GUARDA EN CSV
write.csv(dfPalabras, file="Palabras.csv")

#TAMBIEN PUEDO ALMACENARLO COMO TXT O CSV
#write.table(dfPalabras, file="Palabras.csv o txt", sep = ";")

#############################
#####EXTRACCION DE TABLA#####
#############################
#webpage de amaru es el nodesDeHtml 

#extrayendo los eltos de la tabla
nodesDelHTML <- html_nodes(pagina, ".rojo")


#Extrayendo el contenido de la tabla usando tag table, contenedor de tabla x amaru
tabla <- html_nodes(nodesDelHTML, "table")

#Extraccion informacion tabla1, pueod poner [1][[1]] para introducirme bien a la tabla 
#cuando esta tabla me aparece con dos o mas posiciones
#[1,2] fila, columna

tabla1 <- html_table(tabla[1][[1]])
print(tabla1[1,2])

#En caso de tener otra tabla, necesito poner tabla2 <- html_table(tabla[2][[1]])

#Tarea: debo sacar los $ 

write.table(tabla1, file="Tabla1.csv", sep = ";")
#si lo abro en sublime los precios me aparecen entre comillas, es decir,
#me los toma como texto y deberia ser numerico, ademas con la distincion entre paises
#de las separaciones de decimal y miles, debemos cambiarlos

#Pongo $ antes del nombre del encabezado para que me lea en esa parte
gsub ("\\$","",tabla1$`Santa Isabel`)
tabla1$`Santa Isabel` <- gsub ("\\$","",tabla1$`Santa Isabel`)
print(tabla1$`Santa Isabel`)

tabla1$Jumbo <- gsub ("\\$","",tabla1$Jumbo)
print(tabla1$Jumbo)

tabla1$`Santa Isabel` <- gsub("[.]", "",tabla1$`Santa Isabel`)
print(tabla1$`Santa Isabel`)

tabla1$Jumbo <- gsub("[.]", "",tabla1$Jumbo)
print(tabla1$Jumbo)

#Ahora debo decirle que son numeros

tabla1$`Santa Isabel` <- as.numeric(tabla1$`Santa Isabel`)
tabla1$Jumbo <- as.numeric(tabla1$Jumbo)

write.table(tabla1, file="Tabla1.csv", sep = ";")

#cambiando puntos por comas
tabla1$`Santa Isabel` <- gsub(",",".",tabla1$`Santa Isabel`)
tabla1$Jumbo <- gsub(",",".",tabla1$Jumbo)

#Combinando dos tablas 
#tablaMerge <- rbind(tabla1,tabla2)

##Graficarrrrrrrr
#TablaMerge %>% (Trabajaremos con lo que esta sucediendo arriba)
#ggplot () + (grafico)
#aes (x= Supermercado, y= Santa Isabel)

####GRAFICO 1 DE BARRAS: 
## geom_bar(stat="identity")

###GRAFICO 2 al reves
## coord_flip()

###########################
#####GRAFOOOOOOOOOO########
###########################


###FERIA CHILENA DEL LIBRO: https://www.feriachilenadellibro

paginaChilenaDelLibro <- "https://www.feriachilenadellibro.cl/"

#guardo la pagina con read_html
paginaChilenaRead <- read_html(paginaChilenaDelLibro)

paginaChilenaNodesReferencias <- html_nodes(paginaChilenaRead, ".product-item-photo")

#saca info contenida dentro de un atributo (los tag tienen atributos) las clases, href
#cualquier cosa contenida dentro del < > del tag
html_attr(paginaChilenaNodesReferencias, "href")

links <- html_attr(paginaChilenaNodesReferencias, "href")

for (i in length(links)){
  print(i)
contenedor_link <- print(read_html(links[[i]]))  
}


for (i in links){
  print(i)
  lecturaLibro <- read_html(i)
  precios <- html_text(html_nodes(lecturaLibro,".price"))
  print(precios)
}
