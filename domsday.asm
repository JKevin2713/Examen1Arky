SSeg Segment
     db 64 Dup (?)
SSeg EndS
 
Datos Segment
    ; Define las constantes
    year dw 0     ; Año
    month db 0    ; Mes
    day db 0      ; Día
    doomsday db 0 ; Día de la semana de doomsday
    weekday db 0  ; Día de la semana de la fecha especificada
Datos EndS

codigo Segment 
   Assume CS:codigo, DS:Datos
inicio:
    ; Calcular el siglo
    mov ax, year
    mov bl, 100
    div bl
    mov cl, al

    ; Calcular el siglo ancla
    mov bx, 5   ; 1900 es un siglo ancla, entonces bx=5 (0x05)
    mov ax, cx  ; año / 100
    cmp ax, bx
    je  calcusiglo
    sub bx, ax
    mov ax, bx
    and ax, 0x03
    add bx, ax

calcusiglo:
    mov ax, year
    mov bl, 100
    div bl
    mul bl
    sub ax, bx
    mov cx, ax

    ; Calcular el día de la semana de doomsday para el mes especificado
    mov ax, month
    sub ax, 3
    cmp ax, 0
    jl  calculardoomsday
    add ax, 12

calculardoomsday:
    mov bx, 7
    div bx
    mov dx, ax
    mov bx, 0x0a
    mul bx
    add ax, doomsday
    sub ax, dx
    mov bx, 7
    div bx
    mov doomsday, ah

    ; Calcular el día de la semana de la fecha especificada
    mov ax, day
    add ax, cx
    mov bx, 4
    mul bx
    add ax, doomsday
    mov bx, 7
    div bx
    mov weekday, ah

    ; Imprimir el resultado
    ; Suponga que el valor del día de la semana de la fecha especificada ya está almacenado en la variable weekday
    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
	
codigo EndS 			;Fin del segmento de codigo.
     End Inicio			;Fin del programa la etiqueta al final dice en que punto debe comenzar el programa.