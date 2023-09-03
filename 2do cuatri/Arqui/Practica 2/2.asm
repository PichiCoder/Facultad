;Escribir un programa que muestre en pantalla todos los caracteres disponibles 
; en el simulador MSX88, comenzando con el caracter cuyo código es el número 01H.
ORG 1000H
MSJ DB ?
FIN DB ?

ORG 2000H

MOV BX, OFFSET MSJ
MOV CL, 01H
loop:MOV [BX], CL
INC BX
INC CL
CMP CL, 255
JNZ loop 

SUB CL, 1
MOV BX, OFFSET MSJ
MOV AL, CL
INT 7
INT 0
END
