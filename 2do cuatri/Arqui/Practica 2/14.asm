;Implementar un reloj similar al utilizado en los partidos de básquet, que arranque y detenga su marcha al presionar
; sucesivas veces la tecla F10 y que finalice el conteo al alcanzar los 30 segundos.

CONT EQU 10H
COMP EQU 11H
EOI EQU 20H
IMR EQU 21H
F10 EQU 24H
TIMER EQU 25H

POS_VECTOR_CLK EQU 10
POS_VECTOR_F10 EQU 20

ORG 40
DIR_RUT_CLK DW RUTINA_CLK
ORG 80
DIR_RUTINA_F10 DW RUTINA_F10

ORG 1000H
flag DB 0

ORG 3000H
RUTINA_F10: PUSH AX
;Accion del F10: quiero que al presionarlose reinicie el timer!
;Entonces hago lo siguiente:
MOV AL, 0
OUT CONT, AL ; seteo el conteo a 0 para reiniciar el Timer
;
MOV AL, EOI
OUT EOI, AL ; ESCRIBO 20h en para indicar que atendi el F10
POP AX
IRET

RUTINA_CLK: PUSH AX
;

;
MOV AL, 0
OUT CONT, AL ; seteo el conteo a 0 para reiniciar el Timer
MOV AL, EOI
OUT EOI, AL
POP AX
IRET

ORG 2000H
CLI
;config del PIC
MOV AL, 0FCH ; muevo 1111 1100 AL IMR para tener habilitado el Timer y el F10
OUT IMR, AL ; recordar que OUT es escribir en memoria de E/S

MOV AL, POS_VECTOR_F10
OUT F10, AL ; pongo ID en INT0

MOV AL, POS_VECTOR_CLK
OUT TIMER, AL ; pongo ID en INT1
;

;config del Timer
MOV AL, 30
OUT COMP, AL ; COMP lo pongo en 30 porque quiero la interrupcion cada 30 segundos
MOV AL, 0
OUT CONT, AL
STI

loop: JMP loop

END
