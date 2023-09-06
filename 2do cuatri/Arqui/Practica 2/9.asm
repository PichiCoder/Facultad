; Escribir un programa que aguarde el ingreso de una clave de cuatro caracteres por teclado sin visualizarla en pantalla. En
; caso de coincidir con una clave predefinida (y guardada en memoria) que muestre el mensaje "Acceso permitido", caso
; contrario el mensaje "Acceso denegado".

ORG 1000H
MSJ0 DB "Ingresar clave: "
FIN0 DB ?
CLAVE DB "b3b3"
FINC db ?
MSJ1 DB "Acceso permitido"
FIN1 DB ?
MSJ2 db "Acceso denegado"
FIN2 DB ?

ORG 1500H
ingreso DB ?
FINing DB ?

ORG 3000h
;imprimir msj inicial
inicio: MOV BX, OFFSET MSJ0
MOV AL, OFFSET FIN0-OFFSET MSJ0
INT 7
ret 

;cargar 4 chars
input: MOV CX, OFFSET ingreso
loop: MOV BX, CX
INT 6
INC CX
DEC DL
JNZ loop
ret

; imprimir en pantalla
outputNo:MOV BX, OFFSET MSJ2
MOV AL, OFFSET FIN2-OFFSET MSJ2
INT 7
ret

outputOk:MOV BX, OFFSET MSJ1
MOV AL, OFFSET FIN1-OFFSET MSJ1
INT 7
ret

ORG 2000H
MOV DL, 4
CALL inicio ;leer msj incial
CALL input ;ingresar chars

MOV DX, OFFSET CLAVE
MOV CX, OFFSET ingreso
MOV AH, 4
; Comparando clave guardada con la ingresada
loop2: MOV BX, CX
MOV AL, [BX]
MOV BX, DX
CMP AL, [BX]
JNZ Denegado ; a la primera que el char no es igual, saltamos a imprimir acceso denegado
INC CX ; para moverme en los chars 
INC DX
DEC AH ; para controlar el loop hasta 4 maximo
JNZ loop2
CALL outputOk
JMP final

Denegado: CALL outputNo

final: INT 0
END
