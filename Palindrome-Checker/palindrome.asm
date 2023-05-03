BITS 32

section .data
    userMsg DB 'Please enter a string: '
    lenUserMsg EQU $-userMsg

    palindromeMsg DB 'It is a palindrome'
    lenPlaindromeMsg EQU $-palindromeMsg

    notPalindromeMsg DB 'It is NOT a palindrome'
    lenNotPalindromeMsg EQU $-notPalindromeMsg

    return DB 0xa

section .bss
    buf resb 1024

section .text
    global _start

_start:

while:
    ; prints message to ask for a string
    mov eax, 4
    mov ebx, 1
    mov ecx, userMsg
    mov edx, lenUserMsg
    int 0x80

    ; return
    mov eax, 4
    mov ebx, 1
    mov ecx, return
    mov edx, 1
    int 0x80

    ; reads the string
    mov eax, 3
    mov ebx, 0
    mov ecx, buf
    mov edx, 1024
    int 0x80

    ; jumps to exit statement if a newline is entered
    cmp byte [buf], 10
    je end_while

    ; calls checkPalindrome procedure
    dec eax
    mov ecx, eax
    mov esi, buf
    push ecx
    push esi
    call checkPalindrome
    pop esi
    pop ecx

    ; checks if checkPalindrome returned 1
    cmp eax, 1
    je is_palindrome

is_not_palindrome:
    ; prints message that the string is not a palindrome
    mov eax, 4
    mov ebx, 1
    mov ecx, notPalindromeMsg
    mov edx, lenNotPalindromeMsg
    int 0x80

    ; return
    mov eax, 4
    mov ebx, 1
    mov ecx, return
    mov edx, 1
    int 0x80
    jmp while

is_palindrome:
    ; prints message that the string is a palindrome
    mov eax, 4
    mov ebx, 1
    mov ecx, palindromeMsg
    mov edx, lenPlaindromeMsg
    int 0x80

    ; return
    mov eax, 4
    mov ebx, 1
    mov ecx, return
    mov edx, 1
    int 0x80
    jmp while

end_while:
    ; exit code
    mov eax, 1
    mov ebx, 0
    int 0x80

; function to check if a string is a palindrome
checkPalindrome:
    ; saves stack
    push ebp
    mov ebp, esp

    ; moves address and length of input buffer to esi and ecx
    mov esi, [ebp+8]
    mov ecx, [ebp+12]

    ; decrements length again so that esi+ecx is the last char
    dec ecx

    ; sets edx to 0 to count up
    mov edx, 0
    
  loop:
    ; if the last char is at or before the first char
    cmp ecx, edx
    jle done

    ; compares first and last char
    mov al, byte [esi+edx]
    mov bl, byte [esi+ecx]
    cmp al, bl
    jne not_palindrome

    ; increments first char and decrements last char
    inc edx
    dec ecx
    jmp loop

  not_palindrome:
    ; returns 0 since it is not a palindrome
    mov eax, 0
    jmp end

  done:
    ; returns 1 since it is a palindrome
    mov eax, 1

  end:
    ; restores stack
    leave
    ret