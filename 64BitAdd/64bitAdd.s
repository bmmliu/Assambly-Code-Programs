.global _start

.data
    num1:
        .space 64

    num2:
        .space 64

.text

_start:

    movl num1, %edx
    movl num1 + 4, %eax
    movl num2, %ecx
    movl num2 + 4, %ebx

    add %ebx, %eax
    adc %ecx, %edx

    done:
        nop


