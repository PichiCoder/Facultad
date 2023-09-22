; Respuestas
; a) respecto al ejercicio 2b, esto es mas sencillo de implementar. Presenta menos configuraciones para hacer lo mismo.
;b) Comunicacion directa casi sin configuraciones. El PIO es configurable por completo, lo que permite una flexibilidad muy grande a la hora de usarlo con otros dispositivos a diferencia del HANDSHAKE que es exclusivamente para la impresora.

;TIMER
CONT EQU 10H
COMP EQU 11H

;PIC
EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H ;para F10
INT1 EQU 25H ;para el Timer
;hasta INT7 en 2BH

;PIO
PA EQU 30H ; ligado a llaves
PB EQU 31H ; ligado a luces
CA EQU 32H
CB EQU 33H
;1 prendida / entrada
;0 apagada / salida

;HANDSHAKE
DATO EQU 40H
ESTADO EQU 41H


ORG 3000H
poll: IN AL, ESTADO
      AND AL, 1
      JNZ poll
      ret

ORG 1000H
str DB "INGENIERIA E INFORMATICA"
fin db ?

ORG 2000H
;Configuro el Handshake para el polling
IN AL, ESTADO ; Tomo estado actual
AND AL, 07FH ; 7FH = 01111111
OUT ESTADO, AL ; Estado = 0xxxxxxx

MOV BX, OFFSET str
MOV CL, OFFSET fin - OFFSET str

loop: CALL poll
MOV AL, [BX]
OUT DATO, AL
INC BX
DEC CL
JNZ loop


INT 0
END
