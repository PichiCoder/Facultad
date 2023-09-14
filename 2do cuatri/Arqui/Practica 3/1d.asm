;1 d) * Escribir un programa que implemente un encendido y apagado sincronizado de las luces. 
; Un contador, que inicializa en cero, se incrementa en uno una vez por segundo. Por cada incremento, se muestra a
; través de las luces, prendiendo solo aquellas luces donde el valor de las llaves es 1. Entonces, primero
; se enciende solo la luz de más a la derecha, correspondiente al patrón 00000001. Luego se continúa con
; los patrones 00000010, 00000011, y así sucesivamente. El programa termina al llegar al patrón 11111111.

;TIMER
CONT EQU 10H
COMP EQU 11H

;PIC
EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H ;para F10
INT1 EQU 25H ;para el Timer

;PIO
PA EQU 30H ; ligado a llaves
PB EQU 31H ; ligado a luces
CA EQU 32H
CB EQU 33H
;1 prendida / entrada
;0 apagada / salida

ID_Timer EQU 10

ORG 40H
Dir_Rut_Timer DW Rut_Timer


ORG 3000H
Rut_Timer:PUSH AX

INC contador ; la unica accion que me interesa del timer

MOV AL, 0
OUT CONT, AL
MOV AL, 20H
OUT EOI, AL
POP AX
IRET

ORG 1000H
contador DB 01H

ORG 2000H
CLI
;Configuro Llaves como entrada y Luces como salida
MOV AL, 0FFH
OUT CA, AL
MOV AL, 0H
OUT CB, AL

;Configuro el timer
MOV AL, ID_Timer
OUT INT1, AL

MOV AL, 1
OUT COMP, AL
MOV AL, 0
OUT CONT, AL
STI

loop: MOV AL, contador
OUT PA, AL
IN AL, PA ;Consulto estado de las llaves
OUT PB, AL;De acuerdo al estado escribo en las luces
CMP contador, 255
JNZ loop

INT 0
END
