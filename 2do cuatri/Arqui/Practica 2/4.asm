;Escribir un programa que solicite el ingreso de un número (de un dígito) por teclado e inmediatamente lo muestre en la
; pantalla de comandos, haciendo uso de las interrupciones por software INT 6 e INT 7

ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
FIN DB ?

ORG 1500H
NUM DB ?

ORG 2000H

MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN-OFFSET MSJ
INT 7
MOV BX, OFFSET NUM
INT 6
MOV AL, 1
INT 7
MOV CL, NUM

INT 0
END

; Responder brevemente:
; a) Con referencia a la interrupción INT 7, ¿qué se almacena en los registros BX y AL?
; En BX se almacena la direccion del comienzo de la cadena que uno quiere imprimir.
; En AL se guarda el largo (en Bytes, osease celdas de mem) de la cadena en cuestion. 

; b) Con referencia a la interrupción INT 6, ¿qué se almacena en BX?
; En BX se almacena la direccion de mem donde se almacenara el caracter ingresado por teclado.

; c) En el programa anterior, ¿qué hace la segunda interrupción INT 7? 
;    ¿qué queda almacenado en el registro CL?
; En ese caso, INT 7 imprime el caracter que se habia ingresado.
; En CL queda almacenado un nro entre 0 y 255, segun la TABLA ASCII, del caracter ingresado.
