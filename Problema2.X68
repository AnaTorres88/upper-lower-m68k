*-----------------------------------------------------------
* Title      : Problema 2
* Written by : Ana Laura Torres Gonzalez
* Date       : 12/08/2023
* Description: Problema 2 del laboratorio 2
*-----------------------------------------------------------
CR  EQU       $0D
LF  EQU       $0A

START: ORG    $1000
* Carga dialogo WRITE en memoria
    LEA WRITE,A1
    MOVE #0,D2
    MOVE #1,A3
* Muestra mensaje WRITE
    MOVE #14,D0
    TRAP #15
* Lee input de WRITE
    MOVE #2,D0 ;lee el input de la cadena
    TRAP #15
    MOVE A1,A0
    MOVE A1,D3

*Mostrar mensaje CHOOSE
SR_CHOOSE:
    LEA CHOOSE,A1     
    MOVE #14,D0
    TRAP #15
    MOVE.B D1,D4
 
* Lee input CHOOSE
    MOVE #4,D0 ;Lee input num
    TRAP #15
* Elección del usuario 1: mayusculas, 2: minusculas   
    CMP.B #1,D1
    BEQ  LOOP_UPPER ; pasa a subrutina de mayusculas si 1
    CMP.B #2,D1
    BEQ LOOP_LOWER ; pasa a subrutina de minusculas si 2
    BNE SR_CHOOSE
   
*Subrutina para mayusculas
* Ciclo
LOOP_UPPER:
    TST.B (A0) ; si es 0, pasa a termina, pasa a sub rutina FINISHED
    BEQ FINISHED 

    CMP.B #97,(A0)  ; Comparar con ASCII el valor de 'a'
    BLT NOT_LOWER   ; Si es por debajo de 'a', no es minúscula it's not a minuscula
    CMP.B #122,(A0) ; Comparar con ASCII el valor de 'z'
    BGT NOT_LOWER   ; Si es por encima de 'z', no es minúscula
    SUB.B #32,(A0)   ; Transformar a minuscula

NOT_LOWER:
    CMP.B #32,(A0)+ ; Compara con ASCII el valor del espacio
    BNE NOT_SPACE_U   ; Si no es espacio, Realizar subrutina 
    BRA LOOP_UPPER  ; Regresar al loop

NOT_SPACE_U:
    BRA LOOP_UPPER   ; Regresar al loop

*Subrutina para minusculas

LOOP_LOWER:
    TST.B (A0) ;si es 0, pasa a termina, pasa a sub rutina FINISHED
    BEQ FINISHED 

    CMP.B #65,(A0)  ; Comparar con ASCII el valor de 'A'
    BLT NOT_UPPER   ; Si es por debajo de 'A', no es mayúscula
    CMP.B #90,(A0) ; Compara con ASCII el value de 'Z'
    BGT NOT_UPPER   ; Si es por encima de 'z', no es mayúscula
    ADD.B #32,(A0)   ; Convert uppercase to lowercase

NOT_UPPER:
    CMP.B #32,(A0)+ ; Compare with ASCII value of space
    BNE NOT_SPACE_L   ; If not space, proceed to transformation
    BRA LOOP_LOWER  ; Jump back to the beginning of the loop

NOT_SPACE_L:
    BRA LOOP_LOWER   ; Continue the loop
   
FINISHED:
    MOVE D3,A1 ;Set A1 to D2
    MOVE #14,D0
    TRAP #15
    SIMHALT


*Mensajes
WRITE: DC.B    'ESCRIBE ALGO: ',CR,LF,0
CHOOSE: DC.B    'Transforma a 1-MAYUSCULAS, 2-MINUSCULAS: ',CR,LF,0
        END     START








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
