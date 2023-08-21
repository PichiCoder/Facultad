org 1000h
NUM1 DB ?
NUM2 DB ?
RES DW ?

; inciso a)
org 2000h
MOV AL, NUM1
MOV AH, 0
MUL: ADD AH, NUM2
DEC AL
MOV RES, AH
hlt
end
