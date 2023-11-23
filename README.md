# Query 

La pagina contiene 3 botones, cada uno hace una query diferente, tuve complicaciones para poder hacer que los datos se vieran en la UI pero conseguí que se imprimieran en la terminal como alternativa.
El orden que recomiendo para poder apreciar los cambios es.

 - Get Existing Chats
 - AddNewChat
 - Get Existing Chats
 - Update Existing Chat
 - Get Existing Chats

esto con la finalidad de usar el botón de Get Existing Chat para poder ver toda la colección y después de cada cambio poder verlos.

# AddNewChat

Este botón crea un documento en la colección chats e introduce todos los datos y estructura necesarios para la base de datos, en el botón ya hay por defecto un chat que además de poner los datos de chatters, lasmodification, createdate etc. se le añade a contento las palabras Hola y Mundo. 

## Get Existing Chats

Este Botón mostrara toda la colección de chat con su contenido, estos datos se imprimirán en la terminal, esto se consiguió a través de un for que recorre toda la colección con querys.

## Update Existing Chat

Este botón añadirá un valor en content, que esta dentro de la colección de chats, dentro de la colección de message, la cual le añadira la palabra "palabra", esto se hizo ya que el content el cual el query esta apuntando ya tiene una palabra la cual dice "siguiente " y después se le añadirá siguiente palabra 

