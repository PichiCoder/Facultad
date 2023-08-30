ORG 3000h
SWAP: MOV BX, SP
ADD BX, 2 ; me paro en la direccion guardada de segundo
MOV CX, [BX] ; queda en CX direccion de segundo

ADD BX, 2 ; me paro en la direccion guardada de primero en la pila
MOV AX, [BX] ; queda en AX direccion de primero

MOV BX, CX
MOV CX, [BX] ; tengo segundo en CX

MOV BX, AX ; pongo la direccion de primero en BX
MOV DX, [BX] ; me guardo primero en DX

MOV WORD PTR [BX], CX ; pongo a segundo en la direccion de primero

MOV BX, SP
ADD BX, 2 ; me paro en la direccion guardada de segundo
MOV CX, [BX] ; queda en CX direccion de segundo
MOV BX, CX ; BX apunta a segundo

MOV WORD PTR [BX], DX ; pongo a primero en la direccion de segundo

ret

ORG 1000h
primero DW 1111H
segundo DW 2222H

ORG 2000h
MOV AX, offset primero
MOV CX, offset segundo
PUSH AX
PUSH CX
CALL SWAP

HLT
END
