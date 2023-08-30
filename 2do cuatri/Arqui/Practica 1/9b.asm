ORG 3000h
ROTARIZQ: MOV BX, AX
MOV DL, BYTE PTR [BX] ; me guardo el byte en DL
ADD DL, DL
JC sum1
JMP FIN
sum1: INC DL
FIN: MOV BYTE PTR [BX], DL
ret

ORG 4000h
ROTARIZQ_N: CALL ROTARIZQ
  DEC CX
  JNZ ROTARIZQ_N
  ret


ORG 1000h
miByte DB 10010100b

ORG 2000h
mov AX, offset miByte ; pasamos el byte por referencia por registro
mov CX, 2 ; para pasar nro de rotaciones
CALL ROTARIZQ_N

HLT
END
