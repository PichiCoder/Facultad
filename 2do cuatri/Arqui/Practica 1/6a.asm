org 1000h
NUM1 DB 2
NUM2 DB 5
RES DB ?

org 2000h
MOV AL, NUM1
MOV AH, 0
MUL: ADD AH, NUM2
DEC AL
JNZ MUL
MOV RES, AH
hlt
end
