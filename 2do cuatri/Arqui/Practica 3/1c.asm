;1 c) Escribir un programa que permite encender y apagar las luces mediante las llaves. El programa no
; deberá terminar nunca, y continuamente revisar el estado de las llaves, y actualizar de forma
; consecuente el estado de las luces. La actualización se realiza simplemente prendiendo la luz i si la llave
; i correspondiente está encendida (valor 1), y apagándola en caso contrario. Por ejemplo, si solo la
; primera llave está encendida, entonces solo la primera luz se debe quedar encendida.

;PIO
PA EQU 30H ; ligado a llaves
PB EQU 31H ; ligado a luces
CA EQU 32H
CB EQU 33H
;1 prendida / entrada
;0 apagada / salida


ORG 2000H
;Configuro A y B
MOV AL, 0FFH
OUT CA, AL
MOV AL, 0H
OUT CB, AL

loop:IN AL, PA ;Consulto estado de las llaves
OUT PB, AL;De acuerdo al estado escribo en las luces
JMP loop

fin: INT 0
END
