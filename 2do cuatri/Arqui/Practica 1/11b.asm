ORG 3000h
RESTO:
MOV DX, 00 ; para devolver resultado por rutina mas tarde
loop: SUB AX, CX
CMP AX, CX
JS FIN
JMP loop
FIN:ret ; AX = el resto 

ORG 1000h
primero DW 11
segundo DW 2

ORG 2000h
MOV AX, primero
MOV CX, segundo

CALL RESTO ; deberia retornar primero MOD segundo
          ; Ejemplo 11 MOD 2 = 1

HLT
END
