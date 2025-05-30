    ;   A usando SHL
section .data
    char db 0
    newline db 10

section .text
    global _start

_start:
    ; Imprimir 'A' usando SHL
    mov al, 0x20    ; 00100000 (32 en decimal)
    shl al, 1       ; 01000000 (64 en decimal)
    or al, 1        ; 01000001 (65 en decimal) -> 'A'
    mov [char], al

    ; Escribir el carácter 'A'
    mov eax, 4      ; sys_write
    mov ebx, 1      ; stdout
    mov ecx, char   ; dirección del carácter
    mov edx, 1      ; longitud
    int 0x80

    ; Escribir nueva línea
    mov eax, 4      ; sys_write
    mov ebx, 1      ; stdout
    mov ecx, newline ; dirección del newline
    mov edx, 1      ; longitud
    int 0x80

    ; Salir del programa
    mov eax, 1      ; sys_exit
    xor ebx, ebx    ; código de salida 0
    int 0x80
    
    ;   A usando SHR
section .data
    char db 0
    newline db 10 

section .text
    global _start

_start:
    ; Imprimir 'A' usando SHR
    mov al, 0xB2       ; 10110010 (178 en decimal)
    shr al, 1          ; 01011001 (89 en decimal) -> No es 'A'
    
    ; Corrección para obtener "A" (01000001)
    mov al, 0x82       ; 10000010 (130 en decimal)
    shr al, 1          ; 01000001 (65 en decimal) -> 'A'
    mov [char], al

    ; Escribir el carácter 'A'
    mov eax, 4         ; sys_write (corregido "exx" a "eax")
    mov ebx, 1         ; stdout
    mov ecx, char      ; dirección del carácter
    mov edx, 1         ; longitud (añadido registro edx faltante)
    int 0x80           ; Corregido "int 0x80" a "int 0x80"

    ; Escribir nueva línea
    mov eax, 4         ; sys_write
    mov ebx, 1         ; stdout
    mov ecx, newline   ; dirección del newline (corregido "medline")
    mov edx, 1         ; longitud
    int 0x80           ; Corregido "int 0x80"

    ; Salir del programa
    mov eax, 1         ; sys_exit
    xor ebx, ebx       ; código de salida 0
    int 0x80           ; Corregido "int 0x80"

    ;   A usando ROR
section .data
    char db 0
    newline db 10      ; Corregido "meeline" a "newline"

section .text
    global _start      ; Añadido espacio después de "global"

_start:
    ; Imprimir 'A' usando ROR (Rotate Right)
    mov al, 0x42       ; 01000010 (66 en decimal) -> 'B'
    ror al, 1          ; Rotar a la derecha: 00100001 (33 en decimal) -> No es 'A'
    
    ; Corrección para obtener "A" (01000001)
    mov al, 0x82       ; 10000010 (130 en decimal)
    ror al, 1          ; 01000001 (65 en decimal) -> 'A' (CF=1)
    mov [char], al

    ; Escribir el carácter 'A'
    mov eax, 4         ; sys_write (corregido "esx" a "eax")
    mov ebx, 1         ; stdout
    mov ecx, char      ; dirección del carácter (corregido "ebx" a "ecx")
    mov edx, 1         ; longitud (corregido "inv exx,1" a "mov edx,1")
    int 0x80

    ; Escribir nueva línea
    mov eax, 4         ; sys_write
    mov ebx, 1         ; stdout
    mov ecx, newline   ; dirección del newline (corregido "nealine")
    mov edx, 1         ; longitud (corregido "eko" a "edx")
    int 0x80

    ; Salir del programa
    mov eax, 1         ; sys_exit
    xor ebx, ebx       ; código de salida 0
    int 0x80

    ;   A usando ROL
section .data
    char db 0
    newline db 10      ; Corregido "meeline" a "newline"

section .text
    global _start      ; Añadido espacio después de "global"

_start:
    ; Generar 'A' usando ROL (Rotate Left)
    mov al, 0xA0       ; 10100000 (160 en decimal)
    rol al, 1          ; Rotar a la izquierda: 01000001 (65 en decimal) -> 'A' (CF=1)
    mov [char], al

    ; Escribir el carácter 'A'
    mov eax, 4         ; sys_write
    mov ebx, 1         ; stdout
    mov ecx, char      ; dirección del carácter
    mov edx, 1         ; longitud
    int 0x80

    ; Escribir nueva línea
    mov eax, 4         ; sys_write
    mov ebx, 1         ; stdout
    mov ecx, newline   ; dirección del newline (corregido "necline")
    mov edx, 1         ; longitud
    int 0x80

    ; Salir del programa
    mov eax, 1         ; sys_exit
    xor ebx, ebx       ; código de salida 0
    int 0x80