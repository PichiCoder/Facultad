; c) Escribir un programa que imprime “UNIVERSIDAD NACIONAL DE LA PLATA” en la impresora a
; través del HAND-SHAKE. La comunicación se establece por interrupciones emitidas desde el
; HAND-SHAKE cada vez que la impresora se desocupa.

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
              INC BX
              DEC CL
              JNZ volver
              ;Desactivar interrupciones si ya terminamos de imprimir
              MOV AL, 0FFH
              OUT IMR, AL
              
              volver: MOV AL, 20H
              OUT EOI, AL
              IRET

ORG 1000H
str DB "UNIVERSIDAD NACIONAL DE LA PLATA"
fin db ?

ORG 2000H
CLI
;CONFIG DEL PIC
MOV AL, 11111011b ; 1111 1011 al IMR para habilitar impresora
OUT IMR, AL
MOV AL, POS_VECTOR_IMPRESORA
OUT INT2, AL

; Config Handshake para interrupcion
IN AL, ESTADO ; Tomo estado actual
OR AL, 80H ; 80H = 10000000
OUT ESTADO, AL ; Estado = 1xxxxxxx

MOV BX, OFFSET str
MOV CL, OFFSET fin - OFFSET str
STI

loop: CMP CL, 0
JNZ loop

INT 0
END
