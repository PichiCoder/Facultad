.data
A: .word 1
B: .word 3
arreglo: .word 0

.code
dadd r3, r0, r0 ; r3 = 0

ld r2, B(r0)
ld r1, A(r0)

sd r1, arreglo(r3) ;pongo valor r1 en primer pos del arreglo


loop: daddi r2, r2, -1
dsll r1, r1, 1

daddi r3, r3, 8 ; r3 += 8
sd r1, arreglo(r3) ;pongo sig. valor de r1 en sig. pos. del arreglo

bnez r2, loop

halt