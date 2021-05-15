.global main
.type main,%function


main:
	stmfd sp!,{lr}
	
	//inicio del programa
		ldr r0,=Welcome
		bl printf
		
	Menu:
		ldr r0,=strMenu
		bl puts
		ldr r0,=txtIn
		bl puts
		ldr r0,= option
		ldr r1,=command
		bl scanf
		
	OpcionesMenu:
		ldr r4,=command
		ldrb r4,[r4]
		
		cmp r4, #'+'
		beq Operar1
		
		cmp r4, #'*'
		beq Operar2
		
		cmp r4,#'P'
		beq Operar3
		
		cmp r4, #'M'
		beq Operar4
		
		cmp r4, #'='
		beq show
		
		cmp r4, #'1'
		beq Execute1c
		
		cmp r4, #'2'
		beq Execute2c
		
		cmp r4, #'C'
		beq Concatenar
		
		cmp r4, #'q'
		beq End
		bne ErrorChar
	
	
	Operar1:
		ldr r0,=inputOp 
		bl puts
		ldr r0, =formatForPrint
		ldr r1,=data1 
		bl scanf
		
		// Validación 
		cmp r0,#0
		beq Falla
		bl getchar
		
		//Carga de datos 
		ldr r0,=data1
		ldr r0,[r0]
		ldr r1,=data2
		ldr r1,[r1]
		
		//Execute
		bl suma 
		mov r1,r0

		ldr r0,= res 
		ldr r2,= data2 
		str r1,[r2]
		b Menu
		
	Operar2:
		ldr r0,=inputOp 
		bl puts
		ldr r0, =formatForPrint
		ldr r1,=data1 
		bl scanf
		
		// Validación 
		cmp r0,#0
		beq Falla
		bl getchar
		
		//Carga de datos 
		ldr r0,=data1
		ldr r0,[r0]
		ldr r1,=data2
		ldr r1,[r1]
		
		//Execute
		bl Multiplicacion 
		mov r1,r0
		
		ldr r0,= res 
		ldr r2,= data2 
		str r1,[r2]
		b Menu
		
	Operar3:
		
		ldr r0,=inputOp 
		bl puts
		ldr r0, =formatForPrint
		ldr r1,=data1 
		bl scanf
		
		//Check data
		cmp r0,#0
		beq Falla
		bl getchar
		
		@load data

		ldr r0,=data1
		ldr r0,[r0]
		ldr r1,=data2
		ldr r1,[r1]
		
		//Execute
		bl potencia 
		mov r1,r0
		
		//Save data
		ldr r0,= res 
		ldr r2,= data2 
		str r1,[r2]
		b Menu

//El usuario ingresa el dato
Operar4:
		ldr r0,=inputOp 
		bl puts
		ldr r0, =formatForPrint
		ldr r1,=data1 
		bl scanf
		
		// Validación 
		cmp r0,#0
		beq Falla
		bl getchar
		
		//Carga de datos 
		ldr r0,=data1
		ldr r0,[r0]
		ldr r1,=data2
		ldr r1,[r1]
		
		//Execute
		bl modulo  
		mov r1,r0
		
		//Guarda valor
		Mov r1,r2 
		ldr r0,= res 
		b Menu
	
	show:
		ldr r0,= res 
		ldr r1,=data2
		ldr r1,[r1]
		bl printf
		bl getchar
		b Menu
		
	Execute1c:
		ldr r0,=inputData	
		bl puts
		
		ldr r0, =cad
		ldr r1,=inputCad
		bl scanf
		bl getchar
		
		ldr r1,=inputCad
		ldr r1,[r1]
		ldr r0,=FinalAnsw
		bl printf
		b Menu



	Execute2c:
		ldr r0,=inputData	
		bl puts
		ldr r0, =cad
		ldr r1,=inputCad
		bl scanf
		bl getchar
		
		ldr r7,=inputCad
		ldr r7,[r7]
		b Menu
		
	Concatenar:
		ldr r0,= cad
		ldr r1,[r6]
		bl printf
		ldr r0,=cad2
		ldr r1,[r7]
		bl printf
	
	//Programacion defensiva error en el caracter
	ErrorChar:
		ldr r0,=Falla
		bl puts
		bl getchar
		b Menu

	
	//Programacion defensiva error de dato no valido
	Error:
		ldr r0,=Falla
		bl puts
		bl getchar
		b Menu
		
//etiqueta de terminacion del programa
	End:
		ldr r0,=out
		bl puts
		mov r0, #0
		mov r3, #0
		ldmfd sp!, {lr}
		bx lr

.data
.align 2

//Variables generales

data1:				.word	0 
inputCad:				.asciz "                           "
FinalAnsw:		.asciz "El respuesta final es: %s\n"
data2:				.word	0 

option:				.asciz "%c" 
cad:				.asciz "%s"
cad2:			.asciz "%s\n"
formatForPrint:			.asciz	"%d"
command:			.byte 0



//Mensajes generales al usuario
inputOp: 	.asciz "Ingrese un número: "
inputData: 	.asciz "Ingrese un dato: "
Falla:			.asciz	"Error, intente nuevamente."
out:			.asciz	"Hasta Pronto!"			
Welcome:	.asciz "                Calculadora                  \n"
strMenu:		.asciz " + Suma\n * Multiplicacion \n M Mod\n P Potencia\n = Resultado de la Execute \n 1 Cadena \n 2 Segunda cadena \n C Concatenar cadenas \n q Apagar Calculadora \n"
txtIn:	.asciz	"Ingrese uno de los simbolos del menu: "
res: 		.asciz "El resultado es es: %d\n"

