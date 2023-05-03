#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <string.h>

// asm function prototypes
int addstr(char *a, char *b);
int is_palindrome_asm(char *s);
int factstr(char *s);
void palindrome_check();

// c function prototypes
int fact(int n);
int is_palindrome_c(char *s);

int main() {
    // variable to store user input
    int usrInput;

    // prompt user for input
    printf("1) Add two numbers together\n");
    printf("2) Test if a string is a palindrome (C -> ASM)\n");
    printf("3) Print the factorial of a number\n");
    printf("4) Test if a string is a palindrome (ASM -> C)\n");

    // get user input
    printf("Enter a number 1-4: ");
    scanf("%d", &usrInput);

    // validating user input
    while (usrInput < 1 || usrInput > 4) {
        printf("Invalid input\n");
        printf("Enter a number 1-4: ");
        scanf("%d", &usrInput);
    }

    // switch statement to determine which function to call
    switch (usrInput) {
        case 1: {
            // variables to store user input
            char *a = malloc(100), *b = malloc(100);

            // prompt user for first input
            printf("Enter the first number: ");
            scanf("%s", a);

            // prompt user for second input
            printf("Enter the second number: ");
            scanf("%s", b);

            // call addstr function
            printf("The sum of %s and %s is %d\n", a, b, addstr(a, b));

            // free memory
            free(a);
            free(b);
            break;
        }
        case 2:{
            // variable to store user input
            char *s = malloc(1024);

            // prompt user for input
            printf("Enter a string: ");
            scanf("%s", s);

            // call is_palindrome_asm function
            if(is_palindrome_asm(s))
                printf("%s is a palindrome\n", s);
            else
                printf("%s is not a palindrome\n", s);
            
            // free memory
            free(s);
            break;
        }
        case 3:{
            char *s = malloc(100);

            // prompt user for input
            printf("Enter a number: ");
            scanf("%s", s);

            // call factstr function
            printf("The factorial of %s is %d\n", s, factstr(s));

            // free memory
            free(s);
            break;
        }
        case 4:{
            palindrome_check();
            break;
        }
    }

    return 0;
}

// function to get the factorial of a number
int fact(int n) {
    // base case
    if (n == 0)
        return 1;
    // recursive case
    else
        return n * fact(n - 1);
}

// function to check if a string is a palindrome
int is_palindrome_c(char *s) {
    // variable to store the length of the string
    int len = strlen(s) - 1;

    // loop to check if the string is a palindrome
    for (int i = 0; i < len / 2; i++) {
        if (s[i] != s[len - i - 1])
            return 0;
    }

    return 1;
}