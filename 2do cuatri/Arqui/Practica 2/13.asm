;13) Modificar el programa anterior para que también cuente minutos (00:00 - 59:59), 
;pero que actualice la visualización en pantalla cada 10 segundos

CONT EQU 10H
COMP EQU 11H
EOI EQU 20H
IMR EQU 21H
TIMER EQU 25H

POS_VECTOR_CLK EQU 10

ORG 40
DIR_RUT_CLK DW RUTINA_CLK

ORG 1000H
minutero DB 30H ; X?:??
DB 30H ; ?X:??
DB ':'
DB 30H ; ??:X?
DB 30H ; ??:?X
DB ' '
FINM DB ?

limite DB 0 ; para controlar cuando se llega a 60 segs

ORG 3000H
RUTINA_CLK: PUSH AX

;para controlar minutos usamos el limite
INC limite
INC minutero+3 ; primer digito de los segundos
CMP limite, 6
JNZ RESET ; Si no da 0, osea no pasaron 60 segs, se imprime valor actual de minutero
MOV limite, 0

INC minutero+1

CMP minutero+3, 36H ;para controlor decenas de segundos
JNZ RESET
MOV minutero+3, 30H

CMP minutero+1, 3AH
JNZ RESET
MOV minutero+1, 30H
INC minutero
CMP minutero, 36H
JNZ RESET
MOV minutero, 30H

RESET: INT 7
MOV AL, 0
OUT CONT, AL ; Aca seteo el conteo a 0
MOV AL, EOI
OUT EOI, AL
POP AX
IRET

ORG 2000H
CLI
;config del PIC
MOV AL, 0FDH ; muevo 1111 1101 AL IMR para tener habilitado el Timer
OUT IMR, AL ; recordar que OUT es escribir en memoria de E/S

MOV AL, POS_VECTOR_CLK
OUT TIMER, AL ; pongo ID en INT1
;

;config del Timer
MOV AL, 10
OUT COMP, AL ; COMP lo pongo en 10 porque quiero la interrupcion cada 10 segundos
MOV AL, 0
OUT CONT, AL
;
MOV BX, OFFSET minutero
MOV AL, OFFSET FINM-OFFSET minutero

STI

LAZO: JMP LAZO

END
