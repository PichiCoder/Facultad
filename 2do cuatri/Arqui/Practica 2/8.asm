; Escribir un programa que efectúe la resta de dos números (de un dígito cada uno) ingresados por teclado y muestre el
; resultado en la pantalla de comandos. Antes de visualizarlo el programa debe verificar si el resultado es positivo o negativo
; y anteponer al valor el signo correspondiente.
ORG 1000H

MSJ DB "INGRESE DOS NUMEROS:"
FIN1 DB ?

ORG 1500H
guion DB 45 ; equivalente a 2Dh que es la posicion en la tabla ascii del guion
NUM1 DB ? ; recordar que se guarda en codigo ascii (30h a 39h)
NUM2 DB ?
RES DB ?
FINR DB ?

ORG 3000h
;imprimir msj inicial
inicio: MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN1-OFFSET MSJ
INT 7
ret 

;cargar chars
input1: MOV BX, OFFSET NUM1
INT 6
ret
input2: MOV BX, OFFSET NUM2
INT 6
ret

; imprimir en pantalla
output1:
ADD RES, 30h
MOV BX, OFFSET RES
MOV AL, OFFSET FINR - OFFSET RES
INT 7
ret

output2:
;imprimo el - primero
MOV BX, OFFSET guion
MOV AL, 1
INT 7
;imprimo el resultado
NEG RES ; si tenia por ej un -2 tengo que convertirlo en 2 para sumarle 30h tranquilo
ADD RES, 30h
MOV BX, OFFSET RES
MOV AL, OFFSET FINR - OFFSET RES
INT 7
ret

ORG 2000H

CALL inicio ;leer msj incial
CALL input1 ;ingresar digitos
CALL input2

; paso de ascii a dec
SUB NUM1, 30H
SUB NUM2, 30H

;resto
MOV CL, NUM1
SUB CL, NUM2 ; resta en decimal
MOV RES, CL

;ver si queda negativo
CMP RES, 0
JNS esPos
CALL output2 ; si el resultado fue negativo ahora vemos jeje
JMP final

esPos: CALL output1 ; si el resultado es pos imprimo 'normal'

final: INT 0
END
