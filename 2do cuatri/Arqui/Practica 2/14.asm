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

ORG 1000H
SEG DB 30H ; Decena
DB 30H ; Unidad
FIN DB ?

ORG 3000H

RUTINA_CLK: PUSH AX ; Se guarda el valor de AX, porque se va a usar el registro
INC SEG+1
CMP SEG+1, 3AH
JNZ RESET
MOV SEG+1, 30H
INC SEG
CMP SEG, 33H
JNZ RESET
MOV DL, 1 ; Pongo en TRUE el flag de finalizacion
MOV AL, 0FFH ; Deshabilito interrupciones en IMR
OUT IMR, AL
RESET: MOV AL, 2 ; El contador tiene 2 caracteres
INT 7 ; Se imprime el valor actual
MOV AL, 0 ; Se vuelve a cero el contador del TIMER
OUT CONT, AL
MOV AL, EOI ; Se finaliza la atencion de la interrupcion
OUT EOI, AL
POP AX ; Se recupera el valor que contenia AX al entrar en la rutina
IRET

ORG 3500H

RUTINA_F10: PUSH AX ; Se guarda el valor de AX, porque se va a usar el registro
IN AL, IMR ; Recupero el valor actual del IMR
XOR AL, 00000010B ; Y cambio la linea correspondiente al TIMER
OUT IMR, AL
MOV AL, EOI ; Se finaliza la atencion de la interrupcion
OUT EOI, AL
POP AX ; Se recupera el valor que contenia AX al entrar en la rutina
IRET
ORG 2000H
CLI
MOV AL, 0FEH
OUT IMR, AL ; PIC: registro IMR
MOV AL, POS_VECTOR_F10
OUT INT0, AL ; PIC: registro INT0, F10

MOV AL, POS_VECTOR_CLK
OUT INT1, AL ; PIC: registro INT1, TIMER

MOV AL, 1
OUT COMP, AL ; TIMER: registro COMP
MOV AL, 0
OUT CONT, AL ; TIMER: registro CONT
MOV BX, OFFSET SEG ; Direccion del contador
MOV DL, 0
STI

LAZO: CMP DL, 0
JZ LAZO

INT 0
END
