;Escribir un programa que solicite el ingreso de un número (de un dígito) por teclado y muestre en pantalla dicho
; número expresado en letras. Luego que solicite el ingreso de otro y así sucesivamente. Se debe finalizar la ejecución al
; ingresarse en dos vueltas consecutivas el número cero.

ORG 1000H

MSJ DB "INGRESE UN NUMERO:"
FIN1 DB ?
tabla_nros DB 1,2,3,4,5,6,7,8,9
nros DB "cero", "uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve"
enLetras DB ?
FIN2 DB ?

ORG 1500H

NUM DB ? ; recordar que se guarda en codigo ascii (30h a 39h)

ORG 3000h
inicio: MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN1-OFFSET MSJ
INT 7
ret 

input: MOV BX, OFFSET NUM
INT 6
ret

output:
ret

contar0s: INC AH
ret

ORG 2000H
MOV AH, 00h ; para contar ceros despues

loop: CALL inicio ;leer msj incial
CALL input ;ingresar digito

CMP NUM, 00h ;para ver si es un cero
JZ contar0s
CMP AH, 2 ; si da 0 es porque el 0 ya se ingreso dos veces y hay que terminar.
JZ final 

CALL output ;imprimir el nro en palabras. Ej 7 --> 'siete'
JMP loop

final: INT 0
END
