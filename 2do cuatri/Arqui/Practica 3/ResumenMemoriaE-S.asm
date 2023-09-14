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
