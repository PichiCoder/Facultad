ORG 3000h
ROTARIZQ: MOV BX, AX
MOV DL, BYTE PTR [BX] ; me guardo el byte en DL
ADD DL, DL
ADC DL, 0
MOV BYTE PTR [BX], DL
ret

ORG 1000h
miByte DB 10010100b

ORG 2000h
mov AX, offset miByte ; pasamos el byte por referencia por registro
CALL ROTARIZQ

HLT
END
