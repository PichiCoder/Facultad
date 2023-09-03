;6 - Escribir un programa que solicite el ingreso de un número (de un dígito) por teclado y muestre en pantalla dicho
; número expresado en letras. Luego que solicite el ingreso de otro y así sucesivamente. Se debe finalizar la ejecución al
; ingresarse en dos vueltas consecutivas el número cero.

ORG 1000H

MSJ DB "INGRESE UN NUMERO:"
FIN1 DB ?
MSJ2 DB "CARACTER NO VALIDO"
FIN2 DB ?

ORG 1500H

NUM DB ?

ORG 3000h
ret 

ORG 2000H

MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN1-OFFSET MSJ
INT 7

MOV BX, OFFSET NUM
INT 6


es_Char: MOV BX, OFFSET NUM
MOV AL, 1
INT 7
MOV CL, NUM

INT 0
END
