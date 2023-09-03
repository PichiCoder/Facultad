;Escribir un programa que muestre en pantalla las letras del abecedario, sin espacios, intercalando mayúsculas y
; minúsculas (AaBb…), sin incluir texto en la memoria de datos del programa. Tener en cuenta que el código de “A” es 41H,
; el de “a” es 61H y que el resto de los códigos son correlativos según el abecedario.

ORG 1000H
abecedario DB ?

ORG 3000h
Mayus_min: MOV DH, CL
MOV [BX], DH ; agrego A...
INC BX
ADD DH, 20h
MOV [BX], DH ; Agrego a...
INC BX
RET 

ORG 2000H

MOV BX, OFFSET abecedario
MOV CL, 41h ; donde empezamos --> ' A '
MOV DL, 26 ; cant letras del abecedario

loop: CALL Mayus_min ; agrego Aa, Bb, Cc... a la memoria de datos.

INC CL ; para moverme a siguiente letra
DEC DL ; para controlar la cantidad de veces que hago la operacion
JNZ loop 

; Para imprimir
MOV BX, OFFSET abecedario
MOV AL, 52 ; 26 * 2
INT 7
INT 0
END
