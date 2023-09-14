;14) Implementar un reloj similar al utilizado en los partidos de básquet, que arranque y detenga su marcha al presionar
; sucesivas veces la tecla F10 y que finalice el conteo al alcanzar los 30 segundos.

CONT EQU 10H
COMP EQU 11H
EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H
INT1 EQU 25H

POS_VECTOR_CLK EQU 10
POS_VECTOR_F10 EQU 20

ORG 40
DIR_RUT_CLK DW RUTINA_CLK
ORG 80
DIR_RUTINA_F10 DW RUTINA_F10

ORG 3000H

RUTINA_F10: PUSH AX ; Se guarda el valor de AX porque se va a usar
IN AL, IMR ; Recupero el valor actual del IMR
XOR AL, 00000010B ; Y cambio la linea correspondiente al TIMER 
OUT IMR, AL ; aca habilito el uso del Timer
MOV AL, EOI ; Se finaliza la atencion de la interrupcion F10
OUT EOI, AL
POP AX ; Se recupera el valor que contenia AX al entrar en la rutina
IRET

ORG 3500H

RUTINA_CLK: PUSH AX ; Se guarda el valor de AX, porque se va a usar
;Lo que tiene que ver con el incremento de SEG y SEG+1 es lo mismo que lo del punto 12 para imprimir el paso de los segundos.
INC SEG+1
CMP SEG+1, 3AH
JNZ RESET
MOV SEG+1, 30H
INC SEG
CMP SEG, 33H ; para ver si el primer digito es 30 y cortar el programa
JNZ RESET
MOV DL, 1 ; Pongo en TRUE el flag de finalizacion
MOV AL, 0FFH ; Deshabilito interrupciones en IMR
OUT IMR, AL
;
RESET: MOV AL, 2 ; El contador tiene 2 caracteres
INT 7 ; Se imprime el valor actual
MOV AL, 0 ; Se vuelve a cero el contador del TIMER
OUT CONT, AL
MOV AL, EOI ; Se finaliza la atencion de la interrupcion
OUT EOI, AL
POP AX ; Se recupera el valor que contenia AX al entrar en la rutina
IRET

ORG 1000H

SEG DB 30H ; Decena
DB 30H ; Unidad
FIN DB ?

ORG 2000H

CLI
MOV AL, 0FEH
OUT IMR, AL ; se configura IMR para que solo ande el F10
MOV AL, POS_VECTOR_F10
OUT INT0, AL ; config de INT0

MOV AL, POS_VECTOR_CLK
OUT INT1, AL ; config del timer

MOV AL, 1
OUT COMP, AL ; pongo 1 en COMP
MOV AL, 0
OUT CONT, AL ; pongo 0 en CONT
MOV BX, OFFSET SEG ; me guardo Direccion del contador
MOV DL, 0
STI

LAZO: CMP DL, 0
JZ LAZO

INT 0
END
