; a) * Escribir un programa para imprimir la letra 'A' utilizando la impresora a traves de la PIO

;PIO
PA EQU 30H ; Asociado a Estado
PB EQU 31H  ; Asociado a Dato
CA EQU 32H
CB EQU 33H
; 1 entrada / prendido
; 0 salida / apagado

ORG 3000H
config_pio: MOV AL, 01H ;0000 0001
			OUT CA, AL ; Strobe como salida y Busy como entrada
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

ORG 1000H
char DB 'A'

ORG 2000H

CALL config_pio
MOV AL, char
OUT PB, AL ; para imprimir!

CALL strobe0
CALL strobe1
loop: JMP loop ; por si no llega a imprimir

int 0
end