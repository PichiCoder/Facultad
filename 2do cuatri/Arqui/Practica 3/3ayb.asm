; Escribir un programa que imprime “INGENIERIA E INFORMATICA” en la impresora a través del
; HAND-SHAKE. La comunicación se establece por consulta de estado (polling). ¿Qué diferencias encuentra con el ejercicio 2b?
; Respuestas
; a) respecto al ejercicio 2b, esto es mas sencillo de implementar. Presenta menos configuraciones para hacer lo mismo.
;b) Comunicacion directa casi sin configuraciones. El PIO es configurable por completo, lo que permite una flexibilidad muy grande a la hora de usarlo con otros dispositivos a diferencia del HANDSHAKE que es exclusivamente para la impresora.

;HANDSHAKE
DATO EQU 40H
ESTADO EQU 41H


ORG 3000H
poll: IN AL, ESTADO
      AND AL, 1
      JNZ poll
      ret

ORG 1000H
str DB "INGENIERIA E INFORMATICA"
fin db ?

ORG 2000H
;Configuro el Handshake para el polling
IN AL, ESTADO ; Tomo estado actual
AND AL, 07FH ; 7FH = 01111111
OUT ESTADO, AL ; Estado = 0xxxxxxx

MOV BX, OFFSET str
MOV CL, OFFSET fin - OFFSET str

loop: CALL poll
MOV AL, [BX]
OUT DATO, AL
INC BX
DEC CL
JNZ loop

loop2: JMP loop2 ; para que termine de imprimir lo que esta en el buffer


INT 0
END
