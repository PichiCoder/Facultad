;Interrupción por hardware: tecla F10.
; Escribir un programa que, mientras ejecuta un lazo infinito, cuente el número de veces que se presiona la tecla F10 y
; acumule este valor en el registro DX.
Explicar detalladamente:
a) La función de los registros del PIC: ISR, IRR, IMR, INT0-INT7, EOI. Indicar la dirección de cada uno.
b) Cuáles de estos registros son programables y cómo trabaja la instrucción OUT.
c) Qué hacen y para qué se usan las instrucciones CLI y STI


;Constantes
PIC EQU 20H
EOI EQU 20H
N_F10 EQU 10 ; Para el lugar del vector en la tabla de vectores


ORG 40 ; Lugar del vector * 4 (porque cada entrada ocupa 4bytes) = 40
IP_F10 DW RUT_F10  ; Aquí va la dirección de la primera instrucción del servicio que atiende a la interrupción.
; Esta dirección tiene una etiqueta RUT_F10, que seria la direccion 3000H

ORG 2000H
;CLI y STI activan y desactivan interrupciones.
CLI

;Estas dos instrucciones cargan en el registro IMR el valor FEh, poniendo el bit 0 en 0 y los
; restantes bits en 1, enmascarando todas las interrupciones menos la INT0 que corresponde a la tecla F10.
MOV AL, 0FEH
OUT PIC+1, AL 

;Estas dos instrucciones escriben, en el registro INT0 del PIC, el valor de la posición en la tabla
; de vectores, en éste registro se buscará dicha posición para la interrupción producida por F10.
MOV AL, N_F10
OUT PIC+4, AL

;En el registro DX vamos a contar cuántas veces fué presionada la tecla F10.
MOV DX, 0

STI

LAZO: JMP LAZO

ORG 3000H
RUT_F10: PUSH AX
INC DX
;La CPU debe indicarle al controlador PIC la culminación del servicio a cada interrupción de hardware.
MOV AL, EOI
;Por ende, al final de la rutina de servicio de interrupción se deberá escribir en el registro de
; comandos EOI, un comando (número) que indique el mencionado final.
;La dirección del registro coincide con el valor a escribir (OUT 20H, 20H)
OUT EOI, AL
POP AX

;La instrucción IRET es similar a una instrucción RET, por utilizar la pila, pero recupera una copia del registro de
; estado y la dirección de retorno. Extrae 6 bytes de la pila: 4 para la dirección de retorno y 2 para el registro de estado.
IRET
END

;a) 
;EOI (End of Interruption) indica que la interrupcion fue gestionada.
;      Direccion 20H
      
;El IMR (Interrupt Mask Register) indica, tambien mediante bit 1, indica cuales son las interrupciones que estan enmascaradas.
 ;     Direccion 21H
      
;El IRR (Interrupt Request Register) indica, mediante bit 1, los pedidos de interrupcion que deben gestionarse.
;      Direccion 22H
      
;El ISR (In Service Register) indica, mediante bit 1, la interrupcion que esta siendo atendida en este momento.
;      Direccion 23H
      
;INT0-INT7: guardan la direccion del vector correspondiente. Ese vector contiene la direccion de la porcion de codigo que gestiona la interrupcion.
;    Direcciones: 24H a 2BH

;b) Los programables son al menos el IMR, EOI y INT0-7.
  
