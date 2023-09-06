;Escribir un programa que efectúe la suma de dos números (de un dígito cada uno) ingresados por teclado y muestre el
resultado en la pantalla de comandos. Recordar que el código de cada caracter ingresado no coincide con el número que
representa y que el resultado puede necesitar ser expresado con 2 dígitos
ORG 1000H

MSJ DB "INGRESE DOS NUMEROS:"
FIN1 DB ?

ORG 1500H
uno DB 31h
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
;imprimo el 1 primero
MOV BX, OFFSET uno
MOV AL, 1
INT 7
;imprimo el segundo digito
SUB RES, 10
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

;sumo ambos
MOV CL, NUM1
ADD CL, NUM2 ; suma en decimal
MOV RES, CL

;ver de cuantas cifras queda
CMP RES, 10
JNS sonDos
CALL output1 ; si el resultado era de un digito imprimo directamente y listo
JMP final

sonDos: CALL output2

final: INT 0
END
