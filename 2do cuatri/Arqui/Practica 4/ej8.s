# 8) * Escribir un programa que multiplique dos números enteros utilizando sumas repetidas 
#(similar a Ejercicio 6 o 7 de la Práctica 1). 
# El programa debe estar optimizado para su ejecución con la opción Delay Slot habilitada.

.data 
nro1: .word 2
nro2: .word 4
res: .word 0

.text
ld r1, nro1(r0)
ld r2, nro2(r0) #lo uso como contador de veces que tengo que sumar al nro1
dadd r8, r0, r0 #para ir sumando

sumar: daddi r2, r2, -1
  bnez r2, sumar
  dadd r8, r8, r1

sd r8, res(r0)

halt

# 25 Ciclos
# 17 instrucciones
# 1.471 CPI