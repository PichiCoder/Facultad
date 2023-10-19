# 7) * Escribir un programa que recorra una TABLA de diez números enteros y determine cuántos elementos son mayores que X.
# El resultado debe almacenarse en una dirección etiquetada CANT. El programa debe generar además otro arreglo llamado RES
# cuyos elementos sean ceros y unos. Un ‘1’ indicará que el entero correspondiente en el arreglo TABLA es mayor que X,
# mientras que un ‘0’ indicará que es menor o igual.

.data
TABLA: .word 2, 4, 6, 8, 10, 3, 11, 7, 9, 5 
tablaExtent: .word 10
X: .word 5
CANT: .word 0 #para contar cuantos cumplen la condicion de mayores a X
RES: .word 0 # arreglo booleano, 1 para el que es mayor que X, ‘0’ para el que es menor o igual.

.text
dadd r2, r0, r0 #para ir sumando 8 y moverse en TABLA/RES

daddi r1, r0, 1 #para despues comparar booleano
ld r9, tablaExtent(r0)
ld r11, X(r0) #nro condicion mayor
dadd r10, r0, r0 #para contar y despues guardar en cant

loop: ld r8, TABLA(r2) #nro en posicion r2(0 la primera vez) de la tabla
 slt r13, r11, r8 # Si "r11<r8" (osea "X < valorTabla") r13 = 1, sino r13 = 0.
 sd r13, RES(r2) #guardo res en la tabla booleana
 beq r13, r1, contar #si r13==r1 el nro era mayor
 j seguir
 contar: daddi r10, r10, 1
 seguir: daddi r2, r2, 8 #para avanzar en la tabla
 daddi r9, r9, -1 #para controlar si termine la tabla
 bnez r9, loop

sd r10, CANT(r0)

halt