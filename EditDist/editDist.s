.global _start

.data
    string1:
        .space 100

    string2:
        .space 100
    curdist:
        .space 100
    olddist:
        .space 100
    len1:
        .long 0
    len2:
        .long 0
    len1p1:
        .long 0
    len2p1:
        .long 0
    len1m1:
        .long 0
    len2m1:
        .long 0
    i:
        .long 0
    j:
        .long 0
    j1:
        .long 0
    i1:
        .long 0

.text

findmin:
    cmpl %ebx, %eax
    jl ret_time
    movl %ebx, %eax

    ret_time:
    ret
findmin_end:

swap_start:
    mov %eax, %ecx   #temp1 = a
    mov %ebx, %eax   #a = b
    mov %ecx, %ebx   #b = temp1
    ret
swap_end:

strlen:

    movl $0, %eax; #len = 0

    strlen_for_start:


    cmpb $0, (%esi, %eax)
    jz strlen_for_end

    incl %eax # ++len
    jmp strlen_for_start
    strlen_for_end:
    ret #return to where you were called from
end_strlen:

_start:

    movl $string1, %esi
    call strlen
    movl %eax, len1
    add $1, %eax
    movl %eax, len1p1
    sub $2, %eax
    movl %eax, len1m1

    movl $string2, %esi
    call strlen
    movl %eax, len2
    add $1, %eax
    movl %eax, len2p1
    sub $2, %eax
    movl %eax, len2m1

    movl $0, %edi
    for1_start:
        cmpl len2p1, %edi
        jge for1_end
        movl %edi, olddist(, %edi, 4)
        movl %edi, curdist(, %edi, 4)
        add $1, %edi
        jmp for1_start
    for1_end:

    movl $1, %edi             #edi = i
    out_for_start:
        cmpl len1p1, %edi
        jge out_for_end
        movl %edi, curdist

        movl $1, %esi             #esi = j
        jmp inner_for_start
        inner_for_start:
            cmpl len2p1, %esi
            jge inner_for_end

            sub $1, %esi
            sub $1, %edi

            movb string1( , %edi, 1), %al
            movb string2( , %esi, 1), %bl

            add $1, %esi
            add $1, %edi

            cmpb %al, %bl
            jnz else_part

            sub $1, %esi
            movl olddist(, %esi, 4), %eax
            add $1, %esi
            movl %eax, curdist(, %esi, 4)


            add $1, %esi
            jmp inner_for_start

            else_part:

                sub $1, %esi
                movl curdist( , %esi, 4), %eax
                add $1, %esi
                movl olddist( , %esi, 4), %ebx
                call findmin

                sub $1, %esi
                movl olddist(, %esi, 4), %ebx
                add $1, %esi

                add $1, %ebx
                call findmin

                movl %eax ,curdist( , %esi, 4)

                add $1, %esi
                jmp inner_for_start

        inner_for_end:


        movl $0, %edx
        swap_for_start:
            cmpl len2p1, %edx
            jge swap_for_end
            movl olddist(, %edx, 4), %eax
            movl curdist(, %edx, 4), %ebx
            call swap_start
            movl %eax, olddist(, %edx, 4)
            movl %ebx, curdist(, %edx, 4)
            add $1, %edx
            jmp swap_for_start
        swap_for_end:


        jmp out_for_start
    out_for_end:

    movl len2, %ebx
    movl olddist( , %ebx, 4), %eax


    done:
        nop




