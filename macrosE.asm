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

printAXM Macro
; imprime a la salida estándar un número que supone estar en el AX
; supone que es un número positivo y natural en 16 bits.
; lo imprime en decimal.  

    push AX
    push BX
    push CX
    push DX

    xor cx, cx
    mov bx, 10
ciclo1PAXM: xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne ciclo1PAXM
    mov ah, 02h
	
ciclo2PAXM: pop DX
    add dl, 30h
    int 21h
    loop ciclo2PAXM

    pop DX
    pop CX
    pop BX
    pop AX
EndM

printAX Macro
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