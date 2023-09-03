;Modificar el programa anterior agregando una subrutina llamada ES_NUM que verifique si el caracter ingresado es
; realmente un número. De no serlo, el programa debe mostrar el mensaje “CARACTER NO VALIDO”. 
; La subrutina debe recibir el código del caracter por referencia desde el programa principal y 
; debe devolver vía registro el valor 0FFH en caso de tratarse de un número o el valor 00H en caso contrario. 
;Tener en cuenta que el código del “0” es 30H y el del “9” es 39H.

ORG 1000H

MSJ DB "INGRESE UN NUMERO:"
FIN1 DB ?
MSJ2 DB "CARACTER NO VALIDO"
FIN2 DB ?

ORG 1500H

NUM DB ?

ORG 3000h

ES_NUM: CMP Byte PTR [BX], 30h ; evaluo si es >=30h, osea que caracter>=0
JNS mayorA30h
MOV DL,00h
JMP fin ; si diese negativo, ya sabriamos que no es 0-9.
mayorA30h: CMP Byte PTR [BX], 40h ; evaluo si char <= 39h para saber que si es mayor a 9, osea otro char nada que ver.
JS esNum
MOV DL,00h
JMP fin
esNum: MOV DL, 0FFh
fin: ret 

ORG 2000H

MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN1-OFFSET MSJ
INT 7

MOV BX, OFFSET NUM
INT 6

; la rutina devuelve resultado por DL
CALL ES_NUM 
CMP DL, 00h
JNZ es_Char ; si no es 0 es un nro, todo ok.

MOV BX, OFFSET MSJ2
MOV AL, OFFSET FIN2-OFFSET MSJ2
INT 7 ; podemos jumpear a la rutina!

es_Char: MOV BX, OFFSET NUM
MOV AL, 1
INT 7
MOV CL, NUM

INT 0
END
