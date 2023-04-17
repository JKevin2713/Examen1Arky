ClearScreen Macro 
       PushA
       mov       ah,07		;Prepara servicio 07 para la int 10h. (desplazamiento de ventana hacia abajo).
       mov       al,25		;Número de líneas por desplazar en este caso total de filas 25.
       mov       bh,07h	;Atributo con que se va a desplazar; es decir; color. 00 = negro.
       mov       ch,00		;En donde comienza: fila de la esquina superior izquierda.
       mov       cl,00		;En donde comienza: columna de la esquina superior izquierda.
       mov       dh,25		;En donde termina:  fila de la esquina inferior derecha.
       mov       dl,80		;En donde termina:  columna de la esquina inferior derecha.
       int       10h		;ejecute la int 10h/ servicio 07h, desplaze la ventana hacia abajo.
       PopA
EndM
imprimed Macro
whiled:
	call printAX
	inc columna
	inc columna
	inc columna
	MoverC columna, fila
	inc ax
	cmp columna, 19
	jnle cambiarfila
	jmp sigueimprimiendo
cambiarfila:
	inc fila
	mov columna, 1
	MoverC columna, fila
sigueimprimiendo:
	cmp al, cantidaddias
	jnle saled
	jmp whiled
saled:
EndM
imprimel Macro
whilel:
	call printAX
	inc columna
	inc columna
	inc columna
	MoverC columna, fila
	inc ax
	cmp columna, 19
	jnle cambiarfilal
	jmp sigueimprimiendol
cambiarfilal:
	inc fila
	mov columna, 1
	MoverC columna, fila
sigueimprimiendol:
	cmp al, cantidaddias
	jnle salel
	jmp whilel
salel:
EndM
imprimek Macro
whilek:
	call printAX
	inc columna
	inc columna
	inc columna
	MoverC columna, fila
	inc ax
	cmp columna, 19
	jnle cambiarfilak
	jmp sigueimprimiendok
cambiarfilak:
	inc fila
	mov columna, 1
	MoverC columna, fila
sigueimprimiendok:
	cmp al, cantidaddias
	jnle salek
	jmp whilek
salek:
EndM
imprimem Macro
whilem:
	call printAX
	inc columna
	inc columna
	inc columna
	MoverC columna, fila
	inc ax
	cmp columna, 19
	jnle cambiarfilam
	jmp sigueimprimiendom
cambiarfilam:
	inc fila
	mov columna, 1
	MoverC columna, fila
sigueimprimiendom:
	cmp al, cantidaddias
	jnle salem
	jmp whilem
salem:
EndM
imprimej Macro
whilej:
	call printAX
	inc columna
	inc columna
	inc columna
	MoverC columna, fila
	inc ax
	cmp columna, 19
	jnle cambiarfilaj
	jmp sigueimprimiendoj
cambiarfilaj:
	inc fila
	mov columna, 1
	MoverC columna, fila
sigueimprimiendoj:
	cmp al, cantidaddias
	jnle salej
	jmp whilej
salej:
EndM
imprimev Macro
whilev:
	call printAX
	inc columna
	inc columna
	inc columna
	MoverC columna, fila
	inc ax
	cmp columna, 19
	jnle cambiarfilav
	jmp sigueimprimiendov
cambiarfilav:
	inc fila
	mov columna, 1
	MoverC columna, fila
sigueimprimiendov:
	cmp al, cantidaddias
	jnle salev
	jmp whilev
salev:
EndM
imprimes Macro
whiles:
	call printAX
	inc columna
	inc columna
	inc columna
	MoverC columna, fila
	inc ax
	cmp columna, 19
	jnle cambiarfilas
	jmp sigueimprimiendos
cambiarfilas:
	inc fila
	mov columna, 1
	MoverC columna, fila
sigueimprimiendos:
	cmp al, cantidaddias
	jnle sales
	jmp whiles
sales:
EndM

Calculadoomsday Macro Year, siglo, doomsiglo, temp1, residuo, aux, temp2, temp3, doomyear
    mov ax, year
    mov bx, 100
    div bx
    mov cl, al
	cmp ah, 0
	inc cl
	mov siglo, cx
	
	;calcula el doomsday del siglo
	xor cx, cx
	mov bl, 4
	div bl
	cmp ah, 0    ;martes
	je martes
	cmp ah, 1	 ;domingo
	je domingo
	cmp ah, 2	 ;viernes
	je viernes
	cmp ah, 3	 ;miercoles
	je miercoles
	
martes:
	mov cl, 2
	jmp seguircalculo
domingo:
	mov cl, 0
	jmp seguircalculo
viernes:
	mov cl, 5
	jmp seguircalculo
miercoles:
	mov cl, 3
	jmp seguircalculo
	
seguircalculo:
	mov doomsiglo, cl
	
	;calcula el doomsday del year
	xor ax, ax
	xor bx, bx
	mov ax, year
	mov bl, 100
	div bl
	mov cl, ah
	mov aux, cl
	
	xor ax, ax
	mov al, aux
	mov bl, 12
	div bl
	mov cl, al
	mov temp1, cl
	xor cx, cx
	mov residuo, ah
	xor ax, ax
	mov al, residuo
	mov bl, 4
	div bl
	mov cl, al
	mov temp2, cl
	mov ah, temp1
	mov al, residuo
	add ah, al
	mov al, temp2
	add ah, temp2
	mov temp3, ah
	xor ax, ax
	xor bx, bx
	mov al,temp3
	mov bl, 7
	div bl
	mov al, doomsiglo
	add ah, al
	mov doomyear, ah
EndM

SacaYear Macro
		inc si			;Incrementamos si una unidad
		mov al,LineCommand[si] ; Pasamos lo que tiene LineCommand[si] a al
		sub al, 30h     ; Convertimos el carácter en su equivalente en ASCII a su valor decimal
		xor ah, ah
		xor dx, dx
		
forY: 
	mov bl, 10		; Pasamos un 10 al bl
	mul bl			; Multiplicamos 10 con lo el 10 del bl
	inc si			;Incrementamos si una unidad
	mov cl, LineCommand[si] ; Pasamos lo que tiene LineCommand[si] a cl
	sub cl, 30h		; Convertimos el carácter en su equivalente en ASCII a su valor decimal
	xor ch, ch       ; Limpiamos el registro ch
	add al, cl      ; Agregamos los que tiene cl a al 
	mov year, ax  ; Almacenamos lo que tiene ax a month	
	inc dx
	cmp dx, 3       ; Comparamos el contador con una constante N
	jne forY     	; Si el contador no es igual a N, saltamos al inicio del ciclo
EndLoop:
EndM

SacaMes Macro
	inc si			;Incrementamos si una unidad
	mov al,LineCommand[si] ; Pasamos lo que tiene LineCommand[si] a al
	sub al, 30h     ; Convertimos el carácter en su equivalente en ASCII a su valor decimal
	xor ah, ah       ; Limpiamos el registro ah
	xor dx, dx
	mov bl, 10		; Pasamos un 10 al bl
	mul bl			; Multiplicamos 10 con lo el 10 del bl
	inc si			;Incrementamos si una unidad
	mov cl, LineCommand[si] ; Pasamos lo que tiene LineCommand[si] a cl
	sub cl, 30h		; Convertimos el carácter en su equivalente en ASCII a su valor decimal
	xor ch, ch       ; Limpiamos el registro ch
	add al, cl      ; Agregamos los que tiene cl a al 
	mov mes, ax  ; Almacenamos lo que tiene ax a month
EndM

Imprimir Macro Mensaje
	mov ah, 09h
	mov dx, offset mensaje
	int 21h
EndM

MoverC Macro X,Y
       PushA
       mov   ah,02
       mov	 bh,00
       mov	 dl,X
       mov	 dh,Y
       int 	 10h
       PopA
EndM

bisiestoenerom Macro year, auxmes
	;mov ax, year
	;mov bx, 400
	;div bx
	;mov cl, al
	;cmp ah, 0
	;je bisiestoenero
	
	;mov ax, year
	;mov bl, 4
	;div bl
	mov cl, al
	cmp ah, 0
	je bisiestoenero
	
	mov ax, year
	mov bl, 100
	div bl
	mov cl, al
	cmp ah, 0
	je nobisiestoenero
bisiestoenero:
	mov auxmes, 4
	jmp salir
nobisiestoenero:
	mov auxmes, 3
salir:
EndM

bisiestofebrerom Macro year, auxmes, cantidaddias
	;verificar si es bisiesto
	mov ax, year
	mov bx, 400
	div bx
	mov cl, al
	cmp ah, 0
	je bisiesto
	
	mov ax, year
	mov bl, 4
	div bl
	mov cl, al
	cmp ah, 0
	je bisiesto
	
	mov ax, year
	mov bl, 100
	div bl
	mov cl, al
	cmp ah, 0
	je nobisiesto
	
nobisiesto:
	mov auxmes, 28
	mov cantidaddias, 28
	jmp salirbisiestofebrero
bisiesto:
	mov auxmes, 29
	mov cantidaddias, 29
salirbisiestofebrero:

EndM


PushA Macro 
       push      ax		;Guarda los todos los registro en... 
       push      bx		;...la pila del programa.
       push      cx		;Preparación para rutinas
       push      dx		;Debe tener cuidado de llamar a la...
       push      si		;...siguiente macro (PopAllRegs) para...
       push      di		;poner equilibrar la pila...
       push      bp		;...sino lo hace el programa se cae...
       push      sp		;...y da un error.
       push      ds		;Note que el último elemento del pushallregs...
       push      es		;...es el primer elemento en salir en popallregs.
       push      ss
       pushf			;Guarda el registro de banderas en la pila.
EndM				;Su contra parte es la macro siguiente. 

PopA Macro
       popf		        ;...la pila del programa.
       pop       ss	        ;Esto se hace después de la llamada a una rutina
       pop       es	        ;Debe tener cuidado de llamar a esta...
       pop       ds	        ;...macro (PopAllRegs) para...
       pop       sp	        ;poner equilibrar la pila...
       pop       bp		;...solamente después de haber...
       pop       di		;...llamado antes a pushallregs.
       pop       si		; Sino se produce un error en el programa.
       pop       dx
       pop       cx
       pop       bx
       pop       ax
EndM