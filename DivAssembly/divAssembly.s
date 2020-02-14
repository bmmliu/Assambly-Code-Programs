.global _start

.data
    dividend:
        .space 4

    divisor:
        .space 4

.text

_start:
    movl dividend, %ebx  #dividend = ebx
    movl divisor, %edx   #divisor = edx

    movl $0, %eax        #quotient = 0 = eax
    movl $1, %ecx        #i = 1 = ecx

start_while1:
    cmpl %ebx, %edx
    jg end_while1
    shl $1, %edx
    shl $1, %ecx
    jmp start_while1
end_while1:

start_while2:
    cmpl $1, %ecx
    jbe end_while2
    shr $1, %edx
    shr $1, %ecx

    cmpl %ebx, %edx
    jg start_while2

    add %ecx, %eax
    sub %edx, %ebx
    jmp start_while1
end_while2:

    movl %ebx, %edx


    done:
        nop


