    ;   DIRECCIONAMIENTO INMEDIATO
section .data
msg db 'Resultado: ', 0
section .bss
buffer resb 1
section .text
global _start
_start:
mov eax, 4
mov ebx, 1
mov ecx, msg
mov edx, 11
int 0x80
mov [buffer], byte 64
mov eax, 4
mov ebx, 1
mov ecx, buffer
mov edx, 1
int 0x80
mov eax, 1
xor ebx, ebx
int 0x80
    ;   INDIRECTO
section .data
msg db 'Resultado: ', 0
char db '@' ; Definimos el carácter '@' en memoria
section .bss
buffer resb 1
section .text
global _start
_start:
mov eax, 4
mov ebx, 1
mov ecx, msg
mov edx, 11
int 0x80
mov al, [char] ; Cargamos el valor apuntado por char en AL
mov [buffer], al ; Almacenamos AL en la dirección apuntada por buffer
mov eax, 4
mov ebx, 1
mov ecx, buffer
mov edx, 1
int 0x80
mov eax, 1
xor ebx, ebx
int 0x80