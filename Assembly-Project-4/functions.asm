BITS 32
EXTERN atoi, fact, is_palindrome_c

GLOBAL addstr
section .text
addstr:
    ; setup stack frame
    push ebp
    mov ebp, esp
    
    ; storing ebx on the stack
    push ebx

    ; get the arguments
    mov eax, [ebp+8]
    mov ebx, [ebp+12]

    ; call atoi on eax
    push eax
    call atoi
    add esp, 4

    ; store the result on the stack
    push eax

    ; call atoi on ebx
    push ebx
    call atoi
    add esp, 4

    ; pop the first number into ebx
    pop ebx

    ; add the two numbers
    add eax, ebx

    ; restore stack
    pop ebx
    pop ebp
    ret

GLOBAL is_palindrome_asm
section .text
is_palindrome_asm:
    ; setup stack frame
    push ebp
    mov ebp, esp
    push ebx
    push edx
    push ecx

    ; moves address of the input buffer to ebx
    mov ebx, [ebp+8]

    ; sets edx and ecx to 0 to count up
    xor edx, edx
    xor ecx, ecx

    ; finding the length of the string
    strlen_loop:
        ; if the current char is null
        cmp byte [ebx+ecx], 0
        je strlen_done

        ; increments the length
        inc ecx
        jmp strlen_loop

    strlen_done:
        ; decrements the length to account for the null char
        dec ecx
    
    loop:
        ; if the last char is at or before the first char
        cmp ecx, edx
        jle done

        ; compares first and last char
        mov al, byte [ebx+edx]
        mov bl, byte [ebx+ecx]
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
        ; restore stack
        pop ecx
        pop edx
        pop ebx
        pop ebp
        ret

GLOBAL factstr
section .text
factstr:
    ; setup stack frame
    push ebp
    mov ebp, esp

    ; get the argument
    mov eax, [ebp+8]

    ; call atoi on eax
    push eax
    call atoi
    add esp, 4

    ; call fact on eax
    push eax
    call fact
    add esp, 4

    ; restore stack
    pop ebp
    ret

GLOBAL palindrome_check

section .data
    usrMsg DB 'Enter a string: '
    lenUsrMsg EQU $-usrMsg

    palindromeMsg DB 'It is a palindrome'
    lenPalindromeMsg EQU $-palindromeMsg

    notPalindromeMsg DB 'It is NOT a palindrome'
    lenNotPalindromeMsg EQU $-notPalindromeMsg

    return DB 0xa

section .bss
    buf resb 1024

section .text
palindrome_check:
    ; prints message to ask for a string
    mov eax, 4
    mov ebx, 1
    mov ecx, usrMsg
    mov edx, lenUsrMsg
    int 0x80

    ; reads the string
    mov eax, 3
    mov ebx, 0
    mov ecx, buf
    mov edx, 1024
    int 0x80

    ; calls is_palindrome_c
    push buf
    call is_palindrome_c
    add esp, 4

    ; checks if the string is a palindrome
    cmp eax, 1
    je palindrome

    ; if the string is not a palindrome
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

    ; exit
    mov eax, 1
    mov ebx, 0
    int 0x80

    ; if the string is a palindrome
    palindrome:
        mov eax, 4
        mov ebx, 1
        mov ecx, palindromeMsg
        mov edx, lenPalindromeMsg
        int 0x80

        ; return
        mov eax, 4
        mov ebx, 1
        mov ecx, return
        mov edx, 1
        int 0x80

        ; exit
        mov eax, 1
        mov ebx, 0
        int 0x80