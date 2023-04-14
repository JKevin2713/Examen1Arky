
datos segment
    LineCommand db 0ffh Dup (?)
	mvacio db 'La linea de comando esta vacia $'
	Nombres db 'Examen 1 Kevin y Emily $'
	bienvenida db 'Bienvenido al Calendario $'
	machote db 'D  L  K  M  J  V  S $'
	yearm db 'Year: $'
	mesm db 'Mes: $'
	fila db ?
	columna db ?
	mes dw ?
	year dw ?
	doom db ?
	TextColor db ?
datos Ends

pila segment
	dw 256 dup(?)
pila Ends

include macrosE.asm

codigo segment
	Assume CS:codigo, DS:datos, SS:pila
	
	GetCommanderLine Proc Near
        LongLC    EQU   80h
      
        Mov   Bp,Sp 
        Mov   Ax,Es
        Mov   Ds,Ax
        Mov   Di,2[Bp]
        Mov   Ax,4[Bp]
        Mov   Es,Ax
        Xor   Cx,Cx
        Mov   Cl,Byte Ptr Ds:[LongLC]
        dec   cl
        Mov   Si,2[LongLC]
        cld                          
        Rep   Movsb
		Ret   2*2
	GetCommanderLine EndP

main:
	xor ax, ax
	mov ax, datos
	mov ds, ax
	
	mov dl, 0
	mov TextColor, dl
    ClearScreen TextColor
	
	mov columna, 0
	mov fila, 0
	MoverC columna, fila
	Imprimir Nombres
	
	mov fila, 1
	MoverC columna, fila
	Imprimir bienvenida

    push ds
    Mov   Ax,Seg LineCommand      
    Push  Ax
    Lea   Ax,LineCommand	       
    Push  Ax
    Call  GetCommanderLine		 
	pop ds
	
    xor si, si
Recorrido: inc si
	cmp linecommand[si], 'a'
		je SacarYear
		
	cmp linecommand[si], 'm'
		je Sacarmes
		
	cmp linecommand[si], ''
		je vacio
		
	cmp linecommand[si], '/'
		jmp Recorrido
	
    ;Entro a la condicion de if de LineCommand[si] == 'a'
SacarYear:
	xor ax, ax
	SacaYear
	jmp Recorrido
	
vacio:
	;imprimir mvacio
	jmp SalirC
	
Sacarmes:
	xor ax, ax
	SacaMes
	
	mov fila, 2
	MoverC columna, fila
	imprimir yearm
	xor ax, ax
	mov ax, year
	printAX
	
	mov fila, 3
	MoverC columna, fila
	imprimir mesm
	xor ax, ax
	mov ax, mes
	printAXM
	
	mov fila, 4
	MoverC columna, fila
	imprimir machote
	
SalirC:
	mov ax,4c00h
	int 21h

codigo Ends
	End main	