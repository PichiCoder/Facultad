; 1) e) Escribir un programa que encienda una luz a la vez, de las ocho conectadas al puerto paralelo del
; microprocesador a traves de la PIO, en el siguiente orden de bits:
; 0-1-2-3-4-5-6-7-6-5-4-3-2-1-0-1-2-3-4-5-6-7-6-5-4-3-2-1-0-1-..., es decir, 00000001, 00000010,
; 00000100, etc. Cada luz debe estar encendida durante un segundo. El programa nunca termina.

CONT EQU 10H
COMP EQU 11H
EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H
INT1 EQU 25H

POS_VECTOR_CLK EQU 10

;PIO
PA EQU 30H
PB EQU 31H ;ligado a luces
CA EQU 32H
CB EQU 33H
; 1 entrada / prendido
; 0 salida / apagado

ORG 40
DIR_RUT_CLK DW RUTINA_CLK

ORG 3000H
RUTINA_CLK:PUSH AX
          ;
          MOV AL, CL
          OUT PB, AL ; para prender la luz que corresponde
          ADD CL, CL ; multiplico por dos el valor actual 1 --> 2, 2 --> 4 ... 1 --> 01, 01 --> 10
          OUT CONT, AL
          MOV AL, 20H
          OUT EOI, AL
          POP AX
          IRET

ORG 2000H
CLI
;config Timer
MOV AL, 0FDH ; 1111 0010
OUT IMR, AL
MOV AL, POS_VECTOR_CLK
OUT INT1, AL

MOV AL, 1
OUT COMP, AL
MOV AL, 0
OUT CONT, AL

;config pio para luces
MOV AL, 00H
OUT CB, AL 

MOV CL, 1 ; para empezar con la luz 0000 0001
MOV CH, 0
STI

loop: JMP loop

int 0
end