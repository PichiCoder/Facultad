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

POS_VECTOR_CLK EQU 10

ORG 40
DIR_RUT_CLK DW RUTINA_CLK

ORG 3000H
RUTINA_CLK:PUSH AX
;accion que me interesa por segundo
MOV AL, contador
OUT PA, AL
IN AL, PA ;Consulto estado de las llaves
OUT PB, AL ;De acuerdo al estado escribo en las luces
INC contador

MOV AL, 0
OUT CONT, AL ; reseteo
MOV AL, 20H
OUT EOI, AL
POP AX
IRET

ORG 1000H
contador DB 01H

ORG 2000H
CLI
;Configuro Llaves y Luces como salida
MOV AL, 0H
OUT CA, AL
MOV AL, 0H
OUT CB, AL

;config del PIC
MOV AL, 0FDH ; muevo 1111 1101 AL IMR para tener habilitado el Timer
OUT IMR, AL ; recordar que OUT es escribir en memoria de E/S

;Configuro el timer
MOV AL, POS_VECTOR_CLK
OUT INT1, AL ; config del timer

MOV AL, 1
OUT COMP, AL
MOV AL, 0
OUT CONT, AL
STI

loop: CMP contador, 255
JNZ loop ; si ya hice todo el loop que se pide de las luces corto el programa al no volver el contador a 0

INT 0
END
