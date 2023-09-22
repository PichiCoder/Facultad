; 3) d) Escribir un programa que solicite el ingreso de cinco caracteres por teclado y los almacene en memoria.
; Una vez ingresados, que los envíe a la impresora a través del HAND-SHAKE, en primer lugar tal cual
; fueron ingresados y a continuación en sentido inverso. Utilizar el HAND-SHAKE en modo consulta de
; estado. ¿Qué diferencias encuentra con el ejercicio 2c?

;HANDSHAKE
DATO EQU 40H
ESTADO EQU 41H

ORG 3000H
poll: PUSH AX
    IN AL, ESTADO
    AND AL, 1
    JNZ poll
    POP AX
    ret

ORG 1000H
str DB ?

ORG 2000H
; Config Handshake para POLLING
IN AL, ESTADO ; Tomo estado actual
AND AL, 01111111b ; 
OUT ESTADO, AL ; Estado = 0xxxxxxx

;ingresar chars
MOV BX, OFFSET str
MOV CL, 5
loop: INT 6
INC BX
DEC CL
JNZ loop

;imprimir tal cual ingresados
MOV BX, OFFSET str
MOV CL, 5
loop2: CALL poll
MOV AL, [BX]
OUT DATO, AL
INC BX
DEC CL
JNZ loop2

;imprimir en sentido inverso
MOV BX, OFFSET str + 4
MOV CL, 5
loop3: CALL poll
MOV AL, [BX]
OUT DATO, AL
DEC BX
DEC CL
JNZ loop3

loop4: JMP loop4 ; por si no termina de imprimir

INT 0
END
