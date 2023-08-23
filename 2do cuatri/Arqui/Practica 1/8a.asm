;En el ejercicio se plantea que la cadena termina en 00h, ejemplo 'abcd'00h pero en el vonsim esto no se puede.
;Por ende, esta resolucion compila en Vonsim y queda en loop infinito porque no podemos meter ese 00hn al final.
;Peeero... cumple y andaria bien con lo que pide el ejercicio si se metiese algo como "abcd"00h que se debe poder con el simulador viejo.

ORG 3000H ; Subrutina 
LONGITUD: MOV BX, AX
MOV DL, 0
MOV CH, 0
LOOP: MOV CL, [BX]
CMP CL, DL
JZ FIN
INC BX
INC DL
DEC CL
JNS LOOP
FIN: ret

org 1000h
CADENA DB "abcd"
RES DW ?

org 2000h

MOV AX, OFFSET CADENA
CALL LONGITUD
hlt
end
