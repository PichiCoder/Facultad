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
  DEC CL
  JNZ ROTARIZQ_N
  ret

ORG 5000h
ROTARDER: MOV CL, 8
SUB CL, CH ; tengo que hacer 8-N rotaciones hacia la izq. CL=8-N
CALL ROTARIZQ_N
ret

ORG 1000h
miByte DB 10010100b

ORG 2000h
mov AX, offset miByte ; pasamos el byte por referencia por registro
MOV CH, 6 ; cantidad de rotaciones hacia la derecha
CALL ROTARDER

HLT
END
