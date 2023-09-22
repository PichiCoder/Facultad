; c) * Escribir un programa que solicita el ingreso de cinco caracteres por teclado y los envía de a uno por
; vez a la impresora a través de la PIO a medida que se van ingresando. No es necesario mostrar los
; caracteres en la pantalla.

;PIO
PA EQU 30H ; Asociado a Estado
PB EQU 31H  ; Asociado a Dato
CA EQU 32H
CB EQU 33H
; 1 entrada / prendido
; 0 salida / apagado


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

imprimir: PUSH AX
        PUSH BX
        CALL poll ; por las dudas por si la impresora no esta llegando bien.
        MOV AL, [BX]
        OUT PB, AL ; para imprimir!
        CALL strobe1
        CALL strobe0
        POP BX
        POP AX
        RET 

ORG 1000H
char DB ?

ORG 2000H
CALL config_pio
MOV CL, 5
MOV BX, OFFSET char
MOV AL, 1
CALL strobe0

loop: INT 6
; llamo al modulo para imprimir, que es un poquito mas complejo que el de imprimir un char del 2a.
CALL imprimir
DEC CL
JNZ loop

int 0
end