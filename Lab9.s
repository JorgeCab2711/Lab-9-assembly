@operaciones lab9

.global suma
suma:
    add r4, r1, r0
    mov r0,r4
    mov pc,lr

.global resta 
resta:
    sub r4,r1,r0
    mov r0,r4
    mov pc,lr

.global Multiplicacion
Multiplicacion:
    mul r4,r1,r0
    mov r0,r4
    mov pc,lr

.global modulo
modulo:
    mov r10,#0 //Contador
    add r10,#1
    sub r8,r7
    cmp r8,#0
    bne modulo
    mov r8, r10

outDiv:
    mul r8,r8,r5
    mov r6,r7
    sub r6,r7
    mov r1,r6

.global potencia
potencia:
    pot:
        mul r1,r1,r1
        sub r0,#1
        cmp r0,#1
        cmp r0,#0
        beq potenciar
        b pot
    potenciar:
        mov r0,r1
        mov pc,lr

