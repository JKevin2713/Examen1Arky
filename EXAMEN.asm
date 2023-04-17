
datos segment
    LineCommand db 0ffh Dup (?)
	mvacio db 'La linea de comando esta vacia $'
	Nombres db 'Examen 1 Kevin y Emily $'
	bienvenida db 'Bienvenido al Calendario $'
	opc1 db '1. Calendario mensual $'
	opc2 db '2. Calendario Anual $'
	erroropc db 'El numero no es una opcion correcta'
	machote db 'D  L  K  M  J  V  S $'
	yearm db 'Year: $'
	mesm db 'Mes: $'
	s1 db 'S1$'
	s2 db 'S2$'
	s3 db 'S3$'
	s4 db 'S4$'
	s5 db 'S5$'
	fila db ?
	columna db ?
	mes dw ?
	year dw ?
	auxmes db ?
	TextColor db ?
	cantidaddias db ?
	
	diasemana db ?
	siglo dw ?
	doomsiglo db ?
	doomyear db ?
	aux db ?
	residuo db ?
	temp1 db ?
	temp2 db ?
	temp3 db ?
	
datos Ends

pila segment
	dw 256 dup(?)
pila Ends

include macrosE.asm

codigo segment
	Assume CS:codigo, DS:datos, SS:pila

printAX proc
; imprime a la salida estándar un número que supone estar en el AX
; supone que es un número positivo y natural en 16 bits.
; lo imprime en decimal.  
    
    push AX
    push BX
    push CX
    push DX

    xor cx, cx
    mov bx, 10
ciclo1PAX: xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne ciclo1PAX
    mov ah, 02h
ciclo2PAX: pop DX
    add dl, 30h
    int 21h
    loop ciclo2PAX

    pop DX
    pop CX
    pop BX
    pop AX
    ret
printAX endP

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
	
	mov columna, 1
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
	jmp SalirC
	
Sacarmes:
	xor ax, ax
	SacaMes
	
	mov ax, mes
	cmp ax, 1
	je enero
	cmp ax, 2
	je febreros
	cmp ax, 3
	je marzos
	cmp ax, 4
	je abrils
	cmp ax, 5
	je mayos
	cmp ax, 6 
	je junios
	cmp ax, 7
	je julios
	cmp ax, 8
	je agostos
	cmp ax, 9
	je septiembres
	cmp ax, 10
	je octubres
	cmp ax,11
	je noviembres
	cmp ax, 12
	je diciembres
febreros:
	jmp febrero
marzos:
	jmp marzo
abrils:
	jmp abril
mayos:
	jmp mayo
junios:
	jmp junio
julios:
	jmp julio
agostos:
	jmp agosto
septiembres:
	jmp septiembre
octubres:
	jmp octubre
noviembres:
	jmp noviembre
diciembres:
	jmp diciembre
	
enero:
	bisiestoenerom year, auxmes
	mov cantidaddias, 31
	jmp salirdiasemana
febrero:
	bisiestofebrerom year, auxmes, cantidaddias
	jmp salirdiasemana
marzo:
	mov auxmes, 7
	mov cantidaddias, 31
	jmp salirdiasemana
abril:
	mov auxmes, 4
	mov cantidaddias, 30
	jmp salirdiasemana
mayo:
	mov auxmes, 9
	mov cantidaddias, 31
	jmp salirdiasemana
junio:
	mov auxmes, 6
	mov cantidaddias, 30
	jmp salirdiasemana
julio:
	mov auxmes, 11
	mov cantidaddias, 31
	jmp salirdiasemana
agosto:
	mov auxmes, 8
	mov cantidaddias, 31
	jmp salirdiasemana
septiembre:
	mov auxmes, 5
	mov cantidaddias, 30
	jmp salirdiasemana
octubre:
	mov auxmes, 10
	mov cantidaddias, 31
	jmp salirdiasemana
noviembre:
	mov auxmes, 7
	mov cantidaddias, 30
	jmp salirdiasemana
diciembre:
	mov auxmes, 12
	mov cantidaddias, 31
	jmp salirdiasemana
	
salirdiasemana:

	
	Calculadoomsday Year, siglo, doomsiglo, temp1, residuo, aux, temp2, temp3, doomyear
	
	mov fila, 2
	MoverC columna, fila
	imprimir opc1
	mov fila, 3
	MoverC columna, fila
	imprimir opc2
	mov fila, 4
	MoverC columna, fila
	xor ax, ax
	mov ah, 01h
	int 21h
	
	cmp al, 31h
	je op1
	cmp al, 32h
	;je op2
	jmp msg
op1:
	ClearScreen
	mov columna, 1
	mov fila, 0
	MoverC columna, fila
	imprimir yearm
	mov ax, year
	call printAX
	mov fila, 1
	MoverC columna, fila
	imprimir mesm
	mov ax, mes
	call printAX
	mov fila, 2
	MoverC columna, fila
	imprimir machote
	xor cx, cx
	mov cl, auxmes
	mov ah, doomyear
form:
	cmp cl, 1
	je imprimirmes
	cmp ah, 0
	je reiniciaah
	jmp siguemes
reiniciaah:
	mov ah, 6
	dec cl
	cmp cl, 1
	je imprimirmes
siguemes:
	dec ah
	loop form
	
imprimirmes:
	cmp ah, 0
	je impdomingos
	cmp ah, 1
	je impluness
	cmp ah, 2
	je impmartess
	cmp ah, 3
	je impmiercoless
	cmp ah, 4
	je impjuevess
	cmp ah, 5
	je impvierness
	cmp ah, 6
	je impsabados
impdomingos:
	jmp impdomingo
impluness:
	jmp implunes
impmartess:
	jmp impmartes
impmiercoless:
	jmp impmiercoles
impjuevess:
	jmp impjueves
impvierness:
	jmp impviernes
impsabados:
	jmp impsabado
	
impdomingo:
	xor ax, ax
	mov fila, 3
	mov columna, 1
	MoverC columna, fila
	mov ax, 1
	imprimed
	jmp salirc
implunes:
	xor ax, ax
	mov fila, 3
	mov columna, 4
	MoverC columna, fila
	mov ax, 1
	imprimel
	jmp salirc
impmartes:
	xor ax, ax
	mov fila, 3
	mov columna, 7
	MoverC columna, fila
	mov ax, 1
	imprimek
	jmp salirc
impmiercoles:
	xor ax, ax
	mov fila, 3
	mov columna, 10
	MoverC columna, fila
	mov ax, 1
	imprimem
	jmp salirc
impjueves:
	xor ax, ax
	mov fila, 3
	mov columna, 13
	MoverC columna, fila
	mov ax, 1
	imprimej
	jmp salirc
impviernes:
	xor ax, ax
	mov fila, 3
	mov columna, 16
	MoverC columna, fila
	mov ax, 1
	imprimev
	jmp salirc
impsabado:
	xor ax, ax
	mov fila, 3
	mov columna, 19
	MoverC columna, fila
	mov ax, 1
	imprimes
	jmp salirc

	
op2:
	jmp calendarioa
msg:
	jmp salirC
	
calendarioa:
	
SalirC:
	mov ax,4c00h
	int 21h

codigo Ends
	End main	