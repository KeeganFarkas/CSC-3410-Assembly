BITS 32

section .data
   titleMsg DB 'The Multiplying Program'
   lenTitleMsg EQU $-titleMsg

   userMsg DB 'Please enter a single digit number: '
   lenUserMsg EQU $-userMsg

   dispMsg DB 'The answer is: '
   lenDispMsg EQU $-dispMsg

   return DB 0xa

section .bss
   num1 resb 1
   num2 resb 1
   num3 resb 1

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

   ; prints message to ask for a single digit number
   mov eax, 4
   mov ebx, 1
   mov ecx, userMsg
   mov edx, lenUserMsg
   int 0x80

   ; takes in user input for num1
   mov eax, 3
   mov ebx, 0
   mov ecx, num1
   mov edx, 2
   int 0x80

   ; prints message to ask for a single digit number
   mov eax, 4
   mov ebx, 1
   mov ecx, userMsg
   mov edx, lenUserMsg
   int 0x80

   ; takes in user input for num2
   mov eax, 3
   mov ebx, 0
   mov ecx, num2
   mov edx, 2
   int 0x80

   ; clears ax and moves num1 and num2 into registers
   xor ax, ax
   mov al, [num1]
   mov ah, [num2]

   ; converts to decimal
   sub al, '0'
   sub ah, '0'

   ; multiplies the numbers and then converts back to ASCII
   imul ah
   add al, '0'
   mov [num3], al

   ; prints message to display the answer
   mov eax, 4
   mov ebx, 1
   mov ecx, dispMsg
   mov edx, lenDispMsg
   int 0x80

   ; prints the answer
   mov eax, 4
   mov ebx, 1
   mov ecx, num3
   mov edx, 1
   int 0x80

   ; return
   mov eax, 4
   mov ebx, 1
   mov ecx, return
   mov edx, 1
   int 0x80

   ; exit code
   mov eax, 1
   mov ebx, 0
   int 0x80