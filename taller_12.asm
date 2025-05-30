; Estructura para fecha
struc Fecha
.dia: resb 1 ; 1 byte para día (1-31)
.mes: resb 1 ; 1 byte para mes (1-12)
.anio: resw 1 ; 2 bytes para año (0-65535)
endstruc
; Ejemplo
fecha_nacimiento:
istruc Fecha
at Fecha.dia, db 15
at Fecha.mes, db 8
at Fecha.anio, dw 1990
iend
; Acceso a campos
mov al, [fecha_nacimiento + Fecha.dia] ; Obtener día
mov [fecha_nacimiento + Fecha.mes], 9 ; Cambiar mes a
septiembre
;*********************************************************************************************
; Estructura para email (máximo 64 caracteres)
struc Email
.longitud: resb 1 ; Longitud del email
.texto: resb 64 ; Texto del email
endstruc
; Ejemplo
mi_email:
istruc Email
at Email.longitud, db 15
at Email.texto, db 'usuario@mail.com', 0
iend
; Acceso y manipulación
movzx ecx, byte [mi_email + Email.longitud] ; Obtener longitud
lea esi, [mi_email + Email.texto] ; Puntero al texto
;*********************************************************************************************
; Estructura para dirección
struc Direccion
.calle: resb 30 ; Nombre de calle
.numero: resw 1 ; Número de casa
.colonia: resb 30 ; Nombre de colonia
.cp: resd 1 ; Código postal
endstruc
; Ejemplo
direccion_casa:
istruc Direccion
at Direccion.calle, db 'Av. Siempre Viva', 0
at Direccion.numero, dw 742
at Direccion.colonia, db 'Springfield', 0
at Direccion.cp, dd 12345
iend
; Acceso a campos
mov ax, [direccion_casa + Direccion.numero] ; Obtener número
lea edi, [direccion_casa + Direccion.calle] ; Puntero a calle
;*********************************************************************************************
; Estructura para CURP (18 caracteres + null terminator)
struc CURP
.texto: resb 19 ; 18 caracteres + null
endstruc
; Ejemplo
mi_curp:
istruc CURP
at CURP.texto, db 'ABCD901234HDFGHI01', 0
iend
; Acceso
lea ebx, [mi_curp + CURP.texto] ; Puntero al texto CURP
;*********************************************************************************************
section .data ; Sección de datos inicializados
num1 db 5 ; Define un byte con valor 5 (primer número a sumar)
num2 db 11 ; Define un byte con valor 11 (segundo número a sumar)
result db 0 ; Reserva un byte para almacenar el resultado (inicializado en 0)
message db "Resultado: ", 0 ; Cadena de texto para mostrar el resultado
section .bss ; Sección de datos no inicializados (reservados)
buffer resb 4 ; Reserva 4 bytes para el buffer de conversión numérica
section .text ; Sección de código ejecutable
global _start ; Punto de entrada del programa (declarado como global)
; Macro para imprimir una cadena de texto
; Parámetro: 1 - Dirección de la cadena a imprimir
%macro PRINT_STRING 1
mov eax, 4 ; Llamada al sistema: sys_write
mov ebx, 1 ; Descriptor de archivo: stdout
mov ecx, %1 ; Dirección de la cadena a imprimir (pasada como parámetro)
mov edx, 13 ; Longitud de la cadena (13 caracteres para "Resultado: ")
int 0x80 ; Interrupción para llamar al sistema
%endmacro
; Macro para imprimir un número de un dígito (0-9)
; Parámetro: 1 - Valor numérico a imprimir
%macro PRINT_NUMBER 1
mov eax, %1 ; Carga el valor numérico (pasado como parámetro)
add eax, '0' ; Convierte el número a su representación ASCII
mov [buffer], eax ; Almacena el carácter ASCII en el buffer
mov eax, 4 ; Llamada al sistema: sys_write
mov ebx, 1 ; Descriptor de archivo: stdout
mov ecx, buffer ; Dirección del buffer con el carácter a imprimir

mov edx, 1 ; Longitud: 1 byte (un solo carácter)
int 0x80 ; Interrupción para llamar al sistema
%endmacro
_start: ; Punto de entrada del programa
mov al, [num1] ; Carga el primer número (5) en el registro AL
add al, [num2] ; Suma el segundo número (11) al valor en AL
mov [result], al ; Almacena el resultado (16) en la variable result
; Mostrar el mensaje y el resultado
PRINT_STRING message ; Llama al macro para imprimir "Resultado: "
PRINT_NUMBER [result] ; Llama al macro para imprimir el valor numérico
; Salir del programa
mov eax, 1 ; Llamada al sistema: sys_exit
mov ebx, 0 ; Código de salida: 0 (éxito)
int 0x80 ; Interrupción para llamar al sistema
;*********************************************************************************************
section .data ; Estructura de datos con 3 números
struc Numeros
.num1: resb 1
.num2: resb 1
.num3: resb 1
endstruc
mis_numeros:
istruc Numeros
at Numeros.num1, db 5
at Numeros.num2, db 7
at Numeros.num3, db 3
iend
message db "La suma de los valores es: ", 0
newline db 10, 0 ; Nueva línea para la salida
section .bss
buffer resb 4 ; Buffer para convertir números a caracteres
suma resb 1 ; Variable para almacenar la suma
section .text
global _start
; Macro para imprimir una cadena
; Parámetro: 1 - Dirección de la cadena
%macro PRINT_STRING 1
mov eax, 4 ; Syscall para 'write'
mov ebx, 1 ; Descriptor de archivo (stdout)
mov ecx, %1 ; Dirección de la cadena
mov edx, 24 ; Longitud del mensaje (ajustar según necesidad)

int 0x80
%endmacro
; Macro para imprimir un número de un dígito
; Parámetro: 1 - Valor numérico
%macro PRINT_NUMBER 1
mov eax, %1 ; Carga el valor numérico
add eax, '0' ; Convierte a ASCII
mov [buffer], eax ; Almacena en buffer
mov eax, 4 ; Syscall para 'write'
mov ebx, 1 ; Descriptor de archivo (stdout)
mov ecx, buffer ; Dirección del buffer
mov edx, 1 ; Longitud (1 byte)
int 0x80
%endmacro
; Macro para calcular e imprimir la suma
%macro PRINT_SUM 0
; Cargar y sumar los tres números
mov al, [mis_numeros + Numeros.num1]
add al, [mis_numeros + Numeros.num2]
add al, [mis_numeros + Numeros.num3]
mov [suma], al ; Guardar resultado en variable suma
; Imprimir el resultado
PRINT_NUMBER [suma]
; Imprimir nueva línea
PRINT_STRING newline
%endmacro
_start:
; Imprime el mensaje inicial
PRINT_STRING message
; Imprime la suma de los valores
PRINT_SUM
; Salir del programa
mov eax, 1 ; Syscall para 'exit'
mov ebx, 0 ; Código de salida
int 0x80