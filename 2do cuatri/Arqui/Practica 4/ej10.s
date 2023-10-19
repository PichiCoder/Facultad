# 10) Escribir un programa que cuente la cantidad de veces que un determinado caracter aparece en una cadena de texto. 
# Observar cómo se almacenan en memoria los códigos ASCII de los caracteres (código de la letra “a” es 61H). 
# Utilizar la instrucción lbu (load byte unsigned) para cargar códigos en registros. 
# La inicialización de los datos es la siguiente:

.data
cadena: .asciiz "adbdcdedfdgdhdid" # cadena a analizar
#Como es .asciiz, en la celda de memoria donde este el ultimo char de la cadena, se completa con 0s lo que
# falte para completar la celda (recordar que es de 16 bytes = 64 bits).
car: .asciiz "d" # caracter buscado
cant: .word 0 # cantidad de veces que se repite el caracter car en cadena

.text
lbu r1, car(r0) # cargo "d" en el registro

dadd r11, r0, r0 #para moverme en la cadena

dadd r12, r0, r0 # para contar apariciones y despues cargarlo en cant

loop: lbu r10, cadena(r11) # cargar char
  beq r1, r10, contar # comparar r1 ("d") con el char actual que esta en r10
  j seguir
  contar: daddi r12, r12, 1
  seguir: daddi r11, r11, 1 #me muevo de a un 1 byte, que es lo que ocupa cada char.
  bnez r10, loop # si char actual == 0 corto el loop

sd r12, cant(r0)

halt