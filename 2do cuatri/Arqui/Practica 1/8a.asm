;En el ejercicio se plantea que la cadena termina en 00h, ejemplo 'abcd'00h pero en el vonsim esto no se puede.
; por eso me tome la libertad de agregar la variable FIN_CADENA DB 00H

ORG 3000H ; Subrutina 
  LONGITUD: MOV BX, AX
  MOV DX, 0
  MOV CX, 0
  LOOP: MOV CL, [BX]
  CMP CL, 0
  JZ FIN
  INC BX
  INC DL
  JMP LOOP
FIN: ret

org 1000h

  CADENA DB "abcd"
  FIN_CADENA DB 00H

org 2000h

  MOV AX, OFFSET CADENA
  CALL LONGITUD
  
hlt
end
