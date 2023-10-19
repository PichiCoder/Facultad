#6) Escribir un programa que lea tres números enteros A, B y C de la memoria de datos y determine cuántos de ellos son iguales
# entre sí (0, 2 o 3). El resultado debe quedar almacenado en la dirección de memoria D.
# Nota: no anda si esta activado el delay slot

.data
A: .word 1
B: .word 1
C: .word 3
D: .word 0

.text
ld r1, A(r0)
ld r2, B(r0)
ld r3, C(r0)
dadd r4, r0, r0 #para contar igualdades y despues escribirlas en D

bne r1, r2, seguir
daddi r4, r4, 1

seguir: bne r1, r3, seguir2
daddi r4, r4, 1

seguir2: bne r2, r3, fin
daddi r4, r4, 1

fin: sd r4, D(r0)
halt