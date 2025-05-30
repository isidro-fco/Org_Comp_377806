    ;   1.Comparador de Números: Escribir un programa que reciba dos números y determine si son iguales, si uno es mayor que el otro, o si son negativos.
section .data
msg_equal db "Los numeros son iguales", 10, 0
len_equal equ $ - msg_equal
msg_greater db "El primer numero es mayor", 10, 0
len_greater equ $ - msg_greater
msg_less db "El segundo numero es mayor", 10, 0
len_less equ $ - msg_less
section .text
global _start
_start:
; Asignamos números para comparar
MOV EAX, 5 ; Primer número
MOV EBX, 10 ; Segundo número
CMP EAX, EBX ; Comparamos los números
JE igual ; Si son iguales, saltamos a 'igual'
JG mayor ; Si num1 > num2, saltamos a 'mayor'
JL menor ; Si num1 < num2, saltamos a 'menor'
igual:
MOV EDX, len_equal
MOV ECX, msg_equal
JMP imprimir
mayor:
MOV EDX, len_greater
MOV ECX, msg_greater
JMP imprimir
menor:
MOV EDX, len_less
MOV ECX, msg_less
JMP imprimir
imprimir:
MOV EAX, 4 ; Llamada al sistema para escribir
MOV EBX, 1 ; Salida estándar
INT 80H ; Interrupción del sistema
JMP fin
fin:
MOV EAX, 1 ; Llamada al sistema para salir
XOR EBX, EBX ; Código de salida 0
INT 80H
    ;   2. Clasificación de Números: Leer un número y clasificarlo como positivo, negativo o cero.
section .data
msg_positive db "El numero es positivo", 10, 0
len_positive equ $ - msg_positive ; Calcula la longitud del mensaje positivo
msg_negative db "El numero es negativo", 10, 0
len_negative equ $ - msg_negative ; Calcula la longitud del mensaje negativo
msg_zero db "El numero es cero", 10, 0
len_zero equ $ - msg_zero ; Calcula la longitud del mensaje cero
section .text
global _start
_start:
MOV EAX, -5 ; Número a clasificar
CMP EAX, 0 ; Comparamos con 0
JZ cero ; Si es igual a 0, saltamos a 'cero'
JG positivo ; Si es mayor a 0, saltamos a 'positivo'
JL negativo ; Si es menor a 0, saltamos a 'negativo'
cero:
MOV EDX, len_zero
MOV ECX, msg_zero
JMP imprimir
positivo:
MOV EDX, len_positive
MOV ECX, msg_positive
JMP imprimir
negativo:
MOV EDX, len_negative
MOV ECX, msg_negative
JMP imprimir
imprimir:
MOV EAX, 4 ; sys_write (imprimir)
MOV EBX, 1 ; stdout (salida estándar)
INT 80H ; Llamada al sistema
JMP fin
fin:
MOV EAX, 1 ; sys_exit (terminar programa)
XOR EBX, EBX ; Código de salida 0 (éxito)
INT 80H
    ;   3. Par o Impar: Leer un número y determinar si es par o impar usando únicamente la bandera de paridad (PF).
section .data
msg_par db "El numero es par", 10, 0
len_par equ $ - msg_par ; Longitud de msg_par
msg_impar db "El numero es impar", 10, 0
len_impar equ $ - msg_impar ; Longitud de msg_impar
section .text
global _start
_start:
MOV EAX, 4 ; Número a verificar (puedes cambiarlo)
TEST EAX, 1 ; Verifica el bit menos significativo (LSB)
JZ par ; Si ZF=1 (resultado 0), el número es par
JMP impar ; Si ZF=0 (resultado 1), el número es impar
par:
MOV EDX, len_par
MOV ECX, msg_par
JMP imprimir
impar:
MOV EDX, len_impar
MOV ECX, msg_impar
JMP imprimir
imprimir:
MOV EAX, 4 ; sys_write (imprimir mensaje)
MOV EBX, 1 ; stdout (salida estándar)
INT 80H ; Llamada al sistema
JMP fin
fin:
MOV EAX, 1 ; sys_exit (terminar programa)
XOR EBX, EBX ; Código de salida 0 (éxito)
INT 80H
    ;   4. Simulación de Overflow: Pedir dos números y sumarlos, verificando si ocurre desbordamiento con la bandera OF (Overflow Flag). Imprimir un mensaje si se detecta overflow.
section .data
msg_overflow db "Se detecto overflow en la suma", 10, 0
len_overflow equ $ - msg_overflow ; Calcula la longitud del mensaje
section .text
global _start
_start:
MOV EAX, 2147483647 ; Número grande (2³¹ - 1, el máximo en un entero con signo de 32 bits)
MOV EBX, 1 ; Número a sumar (provocará overflow si se suma 1)
ADD EAX, EBX ; Realiza la suma (EAX = EAX + EBX)
JO overflow_detectado ; Salta si hay overflow (OF=1)
JMP fin ; Si no hay overflow, termina el programa
overflow_detectado:
MOV EDX, len_overflow ; Longitud del mensaje
MOV ECX, msg_overflow ; Mensaje a imprimir
MOV EAX, 4 ; sys_write (llamada al sistema para escribir)
MOV EBX, 1 ; stdout (salida estándar)
INT 80H ; Llama al kernel
fin:
MOV EAX, 1 ; sys_exit (terminar programa)
XOR EBX, EBX ; Código de salida 0 (éxito)
INT 80H
    ;   5. Simulación de Acarreo: Realizar una suma entre dos números y verificar si hay un acarreo con la bandera CF (Carry Flag). Mostrar si se generó un acarreo o no.
section .data
msg_carry db "Se genero un acarreo en la suma", 10, 0
len_carry equ $ - msg_carry ; Calcula la longitud del mensaje
section .text
global _start
_start:
MOV AL, 255 ; AL = 255 (valor máximo para 8 bits sin signo)
MOV BL, 1 ; BL = 1
ADD AL, BL ; AL = AL + BL (255 + 1 = 0 con acarreo)
JC carry_detectado ; Salta si hay acarreo (CF=1)
JMP fin ; Si no hay acarreo, termina
carry_detectado:
MOV EDX, len_carry ; Longitud del mensaje
MOV ECX, msg_carry ; Mensaje a imprimir
MOV EAX, 4 ; sys_write (llamada al sistema para escribir)
MOV EBX, 1 ; stdout (salida estándar)
INT 80H ; Llama al kernel
fin:
MOV EAX, 1 ; sys_exit (terminar programa)
XOR EBX, EBX ; Código de salida 0 (éxito)
INT 80H
    ;   6. Mínimo y Máximo de Tres Números: Leer tres números e identificar el menor y el mayor.
section .data
msg_min_max db "Minimo: 3, Maximo: 7", 10, 0
len_min_max equ $ - msg_min_max ; Longitud del mensaje
section .text
global _start
_start:
MOV EAX, 3 ; Primer número
MOV EBX, 7 ; Segundo número
MOV ECX, 5 ; Tercer número
; Encontrar el mínimo (se almacenará en EDX)
MOV EDX, EAX ; Suponemos que EAX es el mínimo inicial
CMP EDX, EBX
JLE check_ecx_min
MOV EDX, EBX
check_ecx_min:
CMP EDX, ECX
JLE min_found
MOV EDX, ECX
min_found:
; Encontrar el máximo (se almacenará en ESI)
MOV ESI, EAX ; Suponemos que EAX es el máximo inicial
CMP ESI, EBX
JGE check_ecx_max
MOV ESI, EBX
check_ecx_max:
CMP ESI, ECX
JGE max_found
MOV ESI, ECX
max_found:
; Aquí podrías convertir EDX (min) y ESI (max) a ASCII para mostrarlos
; Pero por simplicidad, usaremos el mensaje predefinido
MOV EDX, len_min_max
MOV ECX, msg_min_max
JMP imprimir
imprimir:
MOV EAX, 4 ; Llamada al sistema para escribir
MOV EBX, 1 ; Salida estándar
INT 80H ; Interrupción del sistema
JMP fin
fin:
MOV EAX, 1 ; Llamada al sistema para salir
XOR EBX, EBX ; Código de salida 0
INT 80H
    ;   7. Ordenamiento de Dos Números. Leer dos números e intercambiarlos si no están en orden ascendente usando solo saltos condicionales.
section .data
msg_ordenado db "Numeros ordenados ascendentemente", 10, 0
len_ordenado equ $ - msg_ordenado ; Longitud del mensaje
section .text
global _start
_start:
MOV EAX, 10 ; Primer número
MOV EBX, 5 ; Segundo número
; Verificar si necesitamos intercambiar
CMP EAX, EBX
JLE ya_ordenado ; Si EAX <= EBX, ya están ordenados
; Intercambiar los valores
XCHG EAX, EBX
ya_ordenado:
; Imprimir mensaje
MOV EDX, len_ordenado
MOV ECX, msg_ordenado
MOV EAX, 4 ; sys_write
MOV EBX, 1 ; stdout
INT 80H
; Mostrar los números ordenados (opcional)
; Aquí podrías agregar código para mostrar EAX y EBX
fin:
MOV EAX, 1 ; sys_exit
XOR EBX, EBX ; Código de salida 0
INT 80H
    ;   8. Ciclo de Conteo sin Comparaciones: Implementar un contador de 0 a 9.
section .data
msg_count db "Contador: "
nums times 10 db 0 ; Espacio para los números
len equ $ - msg_count
section .text
global _start
_start:
MOV ECX, 0 ; Inicializamos contador
MOV EDI, nums ; Puntero a buffer de números
fill_buffer:
ADD CL, '0' ; Convertir número a ASCII
MOV [EDI], CL ; Almacenar dígito
INC EDI ; Mover puntero
SUB CL, '0' ; Restaurar valor numérico
INC ECX ; Incrementar contador
CMP ECX, 10 ; ¿Llegamos a 10?
JL fill_buffer ; Si no, continuar
; Añadir terminación de línea
MOV byte [EDI], 10 ; Carácter de nueva línea
; Imprimir mensaje
MOV EDX, len ; Longitud del mensaje
MOV ECX, msg_count ; Mensaje a imprimir
MOV EAX, 4 ; sys_write
MOV EBX, 1 ; stdout
INT 80H
fin:
MOV EAX, 1 ; sys_exit
XOR EBX, EBX ; Código de salida 0
INT 80H