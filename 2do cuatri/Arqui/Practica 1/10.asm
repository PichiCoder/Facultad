ORG 3000h
SWAP:
ret

ORG 1000h
primero DW 1111H
segundo DW 2222H

ORG 2000h
mov AX, offset primero
MOV CX, offset segundo
PUSH AX
PUSH CX
CALL SWAP

HLT
END
