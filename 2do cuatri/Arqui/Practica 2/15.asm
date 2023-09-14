; 15) Escribir un programa que implemente un conteo regresivo a partir de un valor ingresado desde el teclado. El conteo
; debe comenzar al presionarse la tecla F10. El tiempo transcurrido debe mostrarse en pantalla, actualizándose el valor cada segundo.

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

RUTINA_F10: PUSH AX
MOV AL, 0FCH
OUT IMR, AL ; habilito el Timer
MOV AL, 20H
OUT EOI, AL
POP AX
IRET

ORG 3500H

RUTINA_CLK: PUSH AX
imprimir: MOV AL, 1 ; El contador tiene 1 caracter
INT 7 ; Se imprime el valor actual que apunta BX
DEC valorIngresado
CMP valorIngresado, 30H
JNS imprimir
MOV DL, 1 ; Pongo en TRUE el flag de finalizacion
MOV AL, 20H ; Se finaliza la atencion de la interrupcion
OUT EOI, AL

POP AX
IRET

ORG 1000H
valorIngresado DB ?

ORG 2000H

CLI
MOV AL, 0FEH
OUT IMR, AL ; se configura IMR para que solo ande el F10
MOV AL, POS_VECTOR_F10
OUT INT0, AL ; config de INT0

MOV AL, POS_VECTOR_CLK
OUT INT1, AL ; config del timer

MOV BX, OFFSET valorIngresado ; me guardo Direccion de lo que hay que imprimir
MOV DL, 0

INT 6 ; para leer el valor que se ingrese por teclado

;configuro el timer para que interrumpa una vez por segundo
MOV AL, 1
OUT COMP, AL ; pongo el valor en COMP
MOV AL, 0
OUT CONT, AL ; pongo 0 en CONT por las dudas

STI

LAZO: CMP DL, 0
JZ LAZO

INT 0
END
