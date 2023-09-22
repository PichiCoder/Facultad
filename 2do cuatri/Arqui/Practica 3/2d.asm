; d) * Escribir un programa que solicite ingresar caracteres por teclado y que recién al presionar la tecla F10
; los envíe a la impresora a través de la PIO. No es necesario mostrar los caracteres en la pantalla.

; El programa no anda bien pero es que hay un conflicto entre lo que piden, que es ingresar
; chars indefinidamente (para lo que se usa INT6 en loop si o si, no queda otra) 
; y eso no se puede interrumpir normalmente con el F10

;PIC 
EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H

POS_VECTOR_F10 EQU 10

;PIO
PA EQU 30H ; Asociado a Estado
PB EQU 31H  ; Asociado a Dato
CA EQU 32H
CB EQU 33H
; 1 entrada / prendido
; 0 salida / apagado

ORG 40
DIR_RUTINA_F10 DW RUTINA_F10

ORG 3000H

config_pio: MOV AL, 01H
			OUT CA, AL ;Pongo Busy como entrada y Strobe como salida
			MOV AL, 0H
			OUT CB, AL ;siempre salida porque son los datos que le pasamos a la impresora para imprimir
			RET

strobe0: IN AL, PA ; para consultar estado y guardarlo en AL
		AND AL, 0FDH ; 1111 1101 para poner Strobe en 0
		OUT PA, AL ; cambio el estado de la impresora
		RET
		
strobe1:IN AL, PA
		OR AL, 02H ;0000 0010
		OUT PA, AL
		RET

;es para leer el estado de la impresora y checkear si esta ocupada
poll: IN AL, PA 
		AND AL, 01H
		JNZ poll
		RET

ORG 3500H

RUTINA_F10: PUSH AX
        ;lo que queremos que se ejecute al apretar F10
        MOV BX, OFFSET str ; volvemos a poner en BX la primer pos de memoria de la cadena.
        loop2: CALL poll
        MOV AL, [BX]
        OUT PB, AL ; para imprimir!
        CALL strobe1
        CALL strobe0
        INC BX
        DEC CL
        JNZ loop2
        MOV flag, 1 ; para que despues de que se impriman los chars corte el programa
        ;
        POP AX
        MOV AL, 20H
        OUT EOI, AL
        IRET

ORG 1000H
flag DB 0
str DB ?

ORG 2000H
CLI
;config PIC
MOV AL, 0FEH
OUT IMR, AL ; para habilitar el F10

MOV AL, POS_VECTOR_F10
OUT INT0, AL ; asociar int0 con id de la interrupcion

CALL config_pio
MOV BX, OFFSET str
CALL strobe0
MOV CL, 0
STI

;ingresando chars
loop1: CMP flag, 1
JZ fin 
INT 6
INC CL ; para contar cuantos chars voy
INC BX
JMP loop1

fin: int 0
end