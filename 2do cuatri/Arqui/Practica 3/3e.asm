; 3) d) Escribir un programa que solicite el ingreso de cinco caracteres por teclado y los almacene en memoria.
; Una vez ingresados, que los envíe a la impresora a través del HAND-SHAKE, en primer lugar tal cual
; fueron ingresados y a continuación en sentido inverso. Utilizar el HAND-SHAKE en modo consulta de
; estado. ¿Qué diferencias encuentra con el ejercicio 2c?
; e) Idem d), pero ahora utilizar el HAND-SHAKE en modo interrupciones.

;PIC
EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H ;para F10
INT1 EQU 25H ;para el Timer
INT2 EQU 26H ;para impresora
;hasta INT7 en 2BH
;HANDSHAKE
DATO EQU 40H
ESTADO EQU 41H

POS_VECTOR_IMPRESORA EQU 20

ORG 80
DIR_RUT_IMPRESORA DW RUT_IMPRESORA

ORG 3000H
RUT_IMPRESORA:MOV AL, [BX]
              OUT DATO, AL
              ADD BX, DX
              DEC CL
              JNZ volver
              ;Desactivar interrupciones si ya terminamos de imprimir
              MOV AL, 0FFH
              OUT IMR, AL
              
              volver: MOV AL, 20H
              OUT EOI, AL
              IRET

ORG 1000H
str DB ?

ORG 2000H
CLI
;CONFIG DEL PIC
MOV AL, 11111011b 
OUT IMR, AL
MOV AL, POS_VECTOR_IMPRESORA
OUT INT2, AL

; Config Handshake para interrupcion
IN AL, ESTADO ; Tomo estado actual
OR AL, 80H ; 80H = 10000000
OUT ESTADO, AL ; Estado = 1xxxxxxx

;ingresar chars
MOV BX, OFFSET str
MOV CL, 5
loop: INT 6
INC BX
DEC CL
JNZ loop

MOV BX, OFFSET str
MOV CL, 5
MOV DX, 1 ; para hacer magia mas adelante jajaja
STI
; Cuando sale de la rutina porque termino de imprimir en orden, se bloquean las ints, 
; por eso tengo que toquetear para imprimir al reves con la misma rutina y habilitar devuelta

MOV BX, OFFSET str + 4
MOV DX, -1 ; pa recorrer de 1004 a 1003, 1002...
MOV CL, 5
;habilito 
MOV AL, 11111011b 
OUT IMR, AL

loop2: JMP loop2

INT 0
END
