BITS 32

section .data
   titleMsg DB 'The Dividing Program'
   lenTitleMsg EQU $-titleMsg

   userMsg DB 'Please enter a single digit number: '
   lenUserMsg EQU $-userMsg

   dispMsgQ DB 'The quotient is: '
   lenDispMsgQ EQU $-dispMsgQ

   dispMsgR DB 'The remainder is: '
   lenDispMsgR EQU $-dispMsgR

   return DB 0xa

section .bss
   num1 resb 1
   num2 resb 1
   num3 resb 1
   num4 resb 1

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
   mov ch, [num2]
   
   ; converts to decimal
   sub al, '0'
   sub ch, '0'

   ; divides the numbers and then converts back to ASCII
   idiv ch
   add al, '0'
   add ah, '0'
   mov [num3], al
   mov [num4], ah

   ; prints message to display the quotient
   mov eax, 4
   mov ebx, 1
   mov ecx, dispMsgQ
   mov edx, lenDispMsgQ
   int 0x80

   ; prints the quotient
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

   ; prints message to display the remainder
   mov eax, 4
   mov ebx, 1
   mov ecx, dispMsgR
   mov edx, lenDispMsgR
   int 0x80

   ; prints the remainder
   mov eax, 4
   mov ebx, 1
   mov ecx, num4
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