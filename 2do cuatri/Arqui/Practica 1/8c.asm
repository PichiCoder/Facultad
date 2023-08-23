ORG 3000h; Subrutina Contar_Voc

  Contar_Voc: MOV CL, 41H ;este bloque asqueroso seria repetirlo 4 veces mas
  CMP AL, CL ; con los valores 45h y 65h, 49h y 69h, 4Fh y 6Fh, 55h y 75h
  JZ Vocal
  MOV CL, 61H
  CMP AL, CL
  JZ Vocal
  ;
  ;
  ;
  
  Vocal: MOV DX, 0FFH
  JMP FIN
  NoVocal: MOV DX, 00H
FIN: ret

org 1000h ;memoria de datos

  CARACTER DB "a"
  FIN_CADENA DB 00H

org 2000h ; programa principal

  MOV AL, CARACTER
  CALL Contar_Voc
hlt
end
