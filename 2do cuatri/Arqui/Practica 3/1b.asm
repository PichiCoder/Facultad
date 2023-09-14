; 1 b) * Escribir un programa que verifique si la llave de más a la izquierda está prendida. Si es así, mostrar en
; pantalla el mensaje “Llave prendida”, y de lo contrario mostrar “Llave apagada”. Solo importa el valor
; de la llave de más a la izquierda (bit más significativo). Recordar que las llaves se manejan con las
; teclas 0-7

;PIO
PA EQU 30H ; ligado a llaves
PB EQU 31H ; ligado a luces
CA EQU 32H
CB EQU 33H
;1 prendida / entrada
;0 apagada / salida

ORG 3000H
true: MOV BX, OFFSET msj1
MOV AL, OFFSET fin1 - OFFSET msj1
INT 7
ret

false: MOV BX, OFFSET msj2
MOV AL, OFFSET fin2 - OFFSET msj2
INT 7
ret

ORG 1000H
msj1 DB "Llave prendida"
fin1 DB ?
msj2 DB "Llave apagada"
fin2 DB ?

ORG 2000H
MOV AL, 0FFH
OUT CA, AL

IN AL, PA

AND AL, 80H ;comparo si el primer bit esta en 1 o no
JZ noOk
CALL true
JMP fin
noOk: CALL false

fin: INT 0
END
