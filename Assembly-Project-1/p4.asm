BITS 32

section .data
   titleMsg DB 'The Swapping Program'
   lenTitleMsg EQU $-titleMsg

   userMsg DB 'Please enter a two character string: '
   lenUserMsg EQU $-userMsg

   dispMsg DB 'The answer is: '
   lenDispMsg EQU $-dispMsg

   return DB 0xa

section .bss
   two_char_string resb 2

section .text
   global _start

_start:
   ; prints title message
   mov eax, 4
   mov ebx, 1
   mov ecx, titleMsg
   mov edx, lenTitleMsg
   int 0x80

   ; return
   mov eax, 4
   mov ebx, 1
   mov ecx, return
   mov edx, 1
   int 0x80

   ; prints message to ask for a two character string
   mov eax, 4
   mov ebx, 1
   mov ecx, userMsg
   mov edx, lenUserMsg
   int 0x80

   ; takes in user input for two_char_string
   mov eax, 3
   mov ebx, 0
   mov ecx, two_char_string
   mov edx, 3
   int 0x80

   ; swaps characters
   mov al, [two_char_string]
   mov ah, [two_char_string + 1]
   mov [two_char_string], ah
   mov [two_char_string + 1], al

   ; prints message to display the answer
   mov eax, 4
   mov ebx, 1
   mov ecx, dispMsg
   mov edx, lenDispMsg
   int 0x80

   ; prints the answer
   mov eax, 4
   mov ebx, 1
   mov ecx, two_char_string
   mov edx, 2
   int 0x80

   ; return
   mov eax, 4
   mov ebx, 1
   mov ecx, return
   mov edx, 2
   int 0x80

   ; exit code
   mov eax, 1
   mov ebx, 0
   int 0x80