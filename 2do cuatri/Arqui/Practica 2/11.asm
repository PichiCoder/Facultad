;Constantes
EOI EQU 20H ; recordar que es la misma direccion que el PIC
IMR EQU 21H
IRR EQU 22H
ISR EQU 23H
INT0 EQU 24H

POS_enVectorDe_F10 EQU 10 ; el 'ID' de la subrutina


ORG 40 ; el ID*4
Dir_Rutina_Para_F10 DW RUTINA_F10

ORG 3000H
RUTINA_F10: PUSH AX
;Impresion de la letra al presionar F10
MOV letra, CL
MOV BX, OFFSET letra
MOV AL, 1
INT 7
;
MOV AL, EOI
OUT EOI, AL
POP AX
INT 0 ; porque quiero que el programa finalize una vez que apreto F10 y se imprime el caracter
;IRET
;si en vez del int 0 pongo IRET, el programa queda en loop e imprime un caracter cada vez que apretas F10


recorrer_abecedario: MOV CL, 41H
Sig_Letra: INC CL
CMP CL, 5AH ; la Z en char
JZ recorrer_abecedario
JMP Sig_Letra
ret

ORG 1500H
letra DB ? ; la direccion para guardar la letra que debe imprimirse

ORG 2000H

CLI
MOV AL, 0FEH
OUT IMR, AL
MOV AL, POS_enVectorDe_F10
OUT INT0, AL
STI

CALL recorrer_abecedario

END
