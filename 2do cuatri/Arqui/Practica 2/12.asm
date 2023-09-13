;Interrupción por hardware: TIMER.
;Implementar a través de un programa un reloj segundero que muestre en pantalla los segundos transcurridos (00-59 seg)
; desde el inicio de la ejecución.

; a) Cómo funciona el TIMER y cuándo emite una interrupción a la CPU.
; b) La función que cumplen sus registros, la dirección de cada uno y cómo se programan.

; a) Cómo funciona el TIMER y cuándo emite una interrupción a la CPU.
; b) La función que cumplen sus registros, la dirección de cada uno y cómo se programan.

;Respuestas:
; El temporizador tiene dos registros de 8 bits.
; - COMP, ubicado en 10H, es el registro de comparacion.
; - CONT, en 11H, es el registro contador, se incrementa  una vez por segundo automaticamente.
; - Cuando COMP = CONT se genera una interrupcion del timer.
; El timer esta configurado a la linea 1 del PIC, INT1 ubicada en 25H


TIMER EQU 10H
PIC EQU 20H
EOI EQU 20H
N_CLK EQU 10

ORG 40
IP_CLK DW RUT_CLK

ORG 1000H
SEG DB 30H
DB 30H
FIN DB ?

ORG 3000H
RUT_CLK: PUSH AX
INC SEG+1
CMP SEG+1, 3AH
JNZ RESET
MOV SEG+1, 30H
INC SEG
CMP SEG, 36H
JNZ RESET
MOV SEG, 30H
RESET: INT 7
MOV AL, 0
OUT TIMER, AL
MOV AL, EOI
OUT PIC, AL
POP AX
IRET

ORG 2000H
CLI
;config del PIC
MOV AL, 0FDH ; 1111 1101
OUT PIC+1, AL ; PIC: registro IMR
MOV AL, N_CLK
OUT PIC+5, AL ; PIC: registro INT1
;

;config del Timer
MOV AL, 1
OUT TIMER+1, AL ; TIMER: registro COMP lo pongo en 1
MOV AL, 0
OUT TIMER, AL ; TIMER: registro CONT lo pongo en 0
;
MOV BX, OFFSET SEG
MOV AL, OFFSET FIN-OFFSET SEG

STI

LAZO: JMP LAZO

END
