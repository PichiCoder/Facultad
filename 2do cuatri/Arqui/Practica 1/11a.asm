ORG 3000h
DIV:
MOV BX, SP
ADD BX, 2 ; me paro en la direccion guardada de segundo
MOV CX, [BX] ; CX=segundo

ADD BX, 2 ;
MOV AX, [BX] ; AX = primero

MOV DX, 00 ; para devolver resultado por rutina mas tarde
loop: SUB AX, CX
JNS entra
JMP FIN
entra: INC DX
JMP loop
FIN: POP BX ; guardo el IP momentaneamente
    PUSH DX ; pusheo en la pila el resultado del DIV
    PUSH BX ; vuelvo a poner el IP al tope de la pila
  ret

ORG 1000h
primero DW 11
segundo DW 2

ORG 2000h
MOV AX, primero
PUSH AX

MOV CX, segundo
PUSH CX
; el tema es Cuantas veces entra segundo en primero ?
CALL DIV ; deberia retornar primero DIV segundo
          ; Ejemplo 11 DIV 2 = 5

HLT
END
