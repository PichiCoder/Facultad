;TIMER
CONT EQU 10H
COMP EQU 11H

;PIC
EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H ;para F10
INT1 EQU 25H ;para el Timer
INT2 EQU 26H ; para IMPRESORA
;hasta INT7 en 2BH

;PIO
PA EQU 30H ; ligado a llaves y ESTADO de impresora
PB EQU 31H ; ligado a luces y DATO de impresora
CA EQU 32H ; Esto es para configurar el modo de PA (si es entrada o salida)
CB EQU 33H ; idem para PB
;1 prendida / entrada
;0 apagada / salida
;Las llaves siempre tienen que configurarse como entrada.
;   Son modificadas externamente, las tratamos como hardware.
;   Podemos leer el estado de las llaves mediante "IN AL, PA"

;Las luces siempre tienen que configurarse como salida
;   Pueden cambiarse directamente con "OUT PB, AL" teniendo en AL el valor para cada lampara.
;   Podemos por ejemplo leer el estado de las llaves y prender las luces correspondientes con: "IN AL, PA" y luego "OUT PB, AL".

;HANDSHAKE
DATO EQU 40H
ESTADO EQU 41H


;Para cualquiera de las 3 interrupciones que aprendimos hay que cumplir con estas cosas claves:
; 1) Configuracion del PIC y extras: 
;    - la interrupcion debe tenre un ID (representando la posicion en el vector de interrupciones).
;    - En la pos de memoria ID*4 debe estar la direccion de la rutina de atencion a la interrupcion.
;    - Entre CLI y STI en el ppal:
;       - Habilitar la interrupcion en el PIC escribiendo en el IMR de acuerdo a que INT habilitamos o no. Ej para habilitar el F10 --> "OUT IMR, AL", donde AL = 1111 1110b.
;       - Colocar en el int correspondiente (INT0 o 24H para el F10) el ID de la interrupcion.
;       - Caso TIMER: configurar tambien COMP con valor que querramos que se compare el contador. Ej: "OUT COMP, AL" donde AL = 10 para que el TIMER genere una interrupcion a los 10 segundos.
;                   Si al atender la interrupcion reseteamos el contador a 0, el TIMER va a generar una interrupcion cada 10 segundos.
;       - Caso IMPRESORA-Handshake por Interrupcion: configurar ESTADO con el primer bit en 1 para que funcione por interrupcion:
;            IN AL, ESTADO ; Tomo estado actual
;            OR AL, 80H 
;            OUT ESTADO, AL ; Estado = 1xxxxxxx
;           Ademas, cuando identificamos que terminamos de imprimir la cadena, en la rutina debemos cambiar el estado a 0 para que deje de interrumpir y tambien desactivar la int en el PIC.
                    IN AL, HAND_ESTADO ; Tomo estado actual
                    AND AL, 07FH ; 7FH = 01111111
                    OUT HAND_ESTADO, AL ; Estado = 0xxxxxxx
;2) Cada vez que se termina de atender una interrupcion, la subrutina debe terminar con:
;       ...
;       MOV AL, 20H
;       OUT EOI, AL
;       IRET

; CASO IMPRESORA POR POLLING:
; - Mediante Handshake
; No tenemos que configurar el PIC.
; Tenemos que configurar el ESTADO de la impresora con el primer bit en 0 para que funcione por polling:
;            IN AL, ESTADO ; Tomo estado actual
;            AND AL, 07FH ; 0111 1111 
;            OUT ESTADO, AL ; Estado = 0xxxxxxx
; Tenemos que buscar la manera de consultar el Estado de la impresora para verificar si podemos mandarle un char o no para imprimir:
; Yo suelo usar una subrutina "poll" para eso:
; poll: IN AL, ESTADO
;       AND AL, 1 ; porque ultimo bit del estado representa el BUSY.
;       JNZ poll
;       RET
; Con lo mencionado anteriormente ya estaria para usar el handshake enviando datos a la impresora si esta desocupada.

; - Mediante PIO tenemos que configurar lo siguiente:

;   - Poner PA (Estado) como entrada y PB (Dato) como salida:
        config_pio: MOV AL, 01H
                    OUT CA, AL
                    MOV AL, 0H
                    OUT CB, AL
                    RET

;   - Configurar el polling por el mismo motivo que en el handshake pero hay que tener en cuenta que en medio tenemos que configura el Strobe, anteultimo bit del ESTADO.
;   - Generar flanco ascendente del Strobe entre la impresion de caracteres. Strobe=0 -> Imprimo -> Strobe=1 ---> repito secuencia...
strobe0: IN AL, PA
		AND AL, 0FDH ; 1111 1101
		OUT PA, AL
		RET
		
strobe1:IN AL, PA
		OR AL, 02H ;0000 0010
		OUT PA, AL
		RET
