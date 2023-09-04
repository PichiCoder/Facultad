;Escribir un programa que solicite el ingreso de un número (de un dígito) por teclado y muestre en pantalla dicho
; número expresado en letras. Luego que solicite el ingreso de otro y así sucesivamente. Se debe finalizar la ejecución al
; ingresarse en dos vueltas consecutivas el número cero.

ORG 1000H

MSJ DB "INGRESE UN NUMERO:"
FIN1 DB ?
nros DB 30h,"cero  ", 31h, "uno   ", 32h, "dos   ", 33h, "tres  ", 34h, "cuatro", 35h, "cinco ", 36h, "seis  ", 37h, "siete ", 38h, "ocho  ", 39h, "nueve "
enLetras DB ?
FIN2 DB ?

ORG 1500H

NUM DB ? ; recordar que se guarda en codigo ascii (30h a 39h)

ORG 3000h
;imprimir msj inicial
inicio: MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN1-OFFSET MSJ
INT 7
ret 

;cargar char
input: MOV BX, OFFSET NUM
INT 6
ret

;Reuso del punto 5 jeje
ES_NUM: CMP Byte PTR [BX], 30h ; evaluo si es >=30h, osea que caracter>=0
JNS mayorA30h
MOV DL,00h
JMP fin ; si diese negativo, ya sabriamos que no es 0-9.
mayorA30h: CMP Byte PTR [BX], 40h ; evaluo si char <= 39h para saber que si es mayor a 9, osea otro char nada que ver.
JS esNum
MOV DL,00h
JMP fin
esNum: MOV DL, 0FFh
MOV DH, Byte PTR [BX]
fin: ret 

; imprimir, si es que era un digito jeje
; el nro a traducir a texto lo tengo en codigo ascci en DH
output: 
MOV BX, OFFSET nros
loop3: CMP [BX], DH
JZ coinc
INC BX
JMP loop3

coinc: INC BX
MOV AL, 6
INT 7
ret

ORG 2000H
MOV AH, 00h ; para contar ceros despues

loop: CALL inicio ;leer msj incial
CALL input ;ingresar digito

;toda esta pelotudez de comparar el 0 me queda asi por no poder usar una subrutina de mierda
; que no se porque me tira Stack Underflow...
CMP NUM, 30h ;para ver si se ingreso un cero
JZ contar0s
JMP seguir
contar0s: INC AH
seguir: CMP AH, 2 ; si 2-2=0 es porque el 0 ya se ingreso dos veces y hay que terminar.
JZ final 

CALL ES_NUM ; compruebo que digito es. SI lo es, queda guardado en DH

CALL output ;imprimir el nro en palabras. Ej 7 --> 'siete'
JMP loop

final: INT 0
END
