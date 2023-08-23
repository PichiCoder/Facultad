;Al no poder usar algo como CADENA DB "aBcd"00H en Vonsim, me tome la libertar de agregar un fin cadena para igualmente hacer uso del ooh que propone el ejercicio.

ORG 3000h; Subrutina Contar_Min

  Contar_Min: MOV BX, AX
  MOV DX, 0
  MOV CX, 0
  LOOP: MOV CL, [BX]

  CMP CL, 0
  JZ FIN ; por si nos topamos con el 00H
  
  INC BX ; tengo listo en BX la siguiente direccion
  
  SUB CL, 61H ;61H=97Dec, que es el valor de 'a' en ASCII
  JS LOOP ; si salto, el carac es MAYUSQ y paso al siguiente caracter
  
  INC DL ;NO salte, entonces cuento +1 minuscula !!!
  JMP LOOP
FIN: ret

org 1000h ;memoria de datos

  CADENA DB "aBcd"
  FIN_CADENA DB 00H

org 2000h ; programa principal

  MOV AX, OFFSET CADENA
  CALL Contar_Min
hlt
end
