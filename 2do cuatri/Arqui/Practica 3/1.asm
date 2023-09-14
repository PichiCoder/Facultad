; 1 a) Escribir un programa que encienda las luces con el patrón 11000011, o sea, solo las primeras y las
; últimas dos luces deben prenderse, y el resto deben apagarse
;PIO
PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H
;1 entrada
;0 salida

ORG 3000H

ORG 1000H
valorIngresado DB ?

ORG 2000H
;configuro CB con todos los bits de salida. Pensar en 'Salida hacia las luces', que es el dispositivo.
; Si pusiesemos todos unos seria para leer el estado de las luces, estas serian la entrada de informacion.
MOV AL, 0H
OUT CB, AL

;configuro PB
MOV AL, 11000011b
OUT PB, AL

INT 0
END
