# 9) Escribir un programa que implemente el siguiente fragmento escrito en un lenguaje de alto nivel:
 # while a > 0 do
  # begin
   # x := x + y;
   # a := a - 1;
  # end;
# Ejecutar con la opción Delay Slot habilitada.

# Osea x, y, a debieran ser variables definidas e inicializadas al compilar. 
# Entonces, despues de la ejecucion del programa las variables a, x cambian su contenido.

# El tema es que mas alla de eso esta el considerar si el programa modifica el contenido por cada
#   iteracion o mantiene ese resultado en un buffer (analogamente un registro del cpu en este caso) 
#   y al terminar de iterar escribe el resultado final en memoria, osea en x y a que fueron modificados.


.data
x: .word 0
y: .word 2
a: .word 5

.text
ld r3, a(r0)
ld r1, x(r0)
ld r2, y(r0)

loop: daddi r3, r3, -1
 bnez r3, loop
 dadd r1, r1, r2

sd r3, a(r0)
sd r1, x(r0)

halt