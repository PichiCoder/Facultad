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
flag DB 1

ORG 3000H
RUTINA_F10: PUSH AX
;Accion del F10: quiero que al presionarlo se reinicie el timer!
;Entonces hago lo siguiente:
MOV AL, 0
OUT CONT, AL ; seteo el conteo a 0 para reiniciar el Timer
;
MOV AL, EOI
OUT EOI, AL ; ESCRIBO 20h en para indicar que atendi el F10
POP AX
IRET

RUTINA_CLK: PUSH AX
; solo me tengo que preocupar de que si el conteo llego a 30 y no se presiono el F10 se tiene que resetear el conteo.
MOV AL, 0
OUT CONT, AL ; seteo el conteo a 0 para reiniciar el Timer
; Como variante, si quisiera que el programa termine al llegar a contar los 30 segundos haria lo siguiente con mi variable flag:
;" MOV flag, 0 ", y en el programa ppal pongo el loop aprovechando esta condicion para cortar.
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
OUT INT0, AL ; pongo ID en INT0

MOV AL, POS_VECTOR_CLK
OUT INT1, AL ; pongo ID en INT1
;

;config del Timer
MOV AL, 30
OUT COMP, AL ; COMP lo pongo en 30 porque quiero la interrupcion cada 30 segundos
MOV AL, 0
OUT CONT, AL
STI

loop: JMP loop

; El loop si usara la variante para cortar el programa:
;" loop: CMP flag, 0 "
;" JNZ loop "

INT 0
END
