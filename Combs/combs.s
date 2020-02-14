/*comb_helper(int number, int inc, int len, int k, int* counter, int* temp, int** matrix, int* items) {
 
 if (inc == k) {
 for (int i = 0; i < k; i++)
 matrix[*counter][i] = temp[i];
 (*counter)++;
 }
 
 for (int i = number; i < len; i++) {
 temp[inc] = items[i];
 comb_helper(i+1, inc+1, len, k, counter, temp, matrix, items);
 }
 }
 
 
 int** get_combs(int* items, int k, int len) {
 int counter = 0;
 int num = num_combs(len, k);
 int temp[k];
 int **matrix = malloc(sizeof(int*) * num);
 for (int i = 0; i < num; i++)
 matrix[i] = malloc(sizeof(int) * k);
 comb_helper(0, 0, len, k, &counter, temp, matrix, items);
 return matrix;
 }*/
.global get_combs
.equ ws, 4

.text
get_combs:
#prologue
push %ebp
movl %esp, %ebp
subl $4*ws, %esp

.equ items, 2*ws
.equ k, 3*ws
.equ len, 4*ws

.equ counter, -1*ws
.equ num, -2*ws
.equ temp, -3*ws
.equ matrix, -4*ws

#counter = 0
movl $0, counter(%ebp)

#num = num_combs(len, k)
push k(%ebp)
push len(%ebp)
call num_combs
addl $2*ws, %esp
movl  %eax, num(%ebp)

# temp[k]
movl k(%ebp), %ebx
shll $2, %ebx
push %ebx
call malloc
addl $1*ws, %esp
movl %eax, temp(%ebp)

#**matrix = malloc(sizeof(int*) * num)
movl num(%ebp), %eax
shll $2, %eax
push %eax
call malloc
addl $1*ws, %esp
movl %eax, matrix(%ebp)


#for (int i = 0; i < num; i++)

movl $0, %esi
for_loop1:
cmpl num(%ebp), %esi
jge end_for_loop1
movl matrix(%ebp), %ebx
#matrix[i] = malloc(sizeof(int) * k)
movl k(%ebp), %eax
shll $2, %eax
push %eax
call malloc
movl %eax, (%ebx, %esi, ws)
incl %esi
jmp for_loop1

end_for_loop1:
#comb_helper(0, 0, len, k, &counter, temp, matrix, items)
push items(%ebp)
movl matrix(%ebp), %eax
push %eax
push temp(%ebp)
leal counter(%ebp), %eax
push %eax
push k(%ebp)
push len(%ebp)
push $0
push $0
call comb_helper
addl $8*ws, %esp

#eilogue
movl matrix(%ebp), %eax
movl %ebp, %esp
pop %ebp
ret

comb_helper:
#prologue
push %ebp
movl %esp, %ebp

.equ number, 2*ws
.equ inc, 3*ws
.equ len, 4*ws
.equ k, 5*ws
.equ counter, 6*ws
.equ temp, 7*ws
.equ matrix, 8*ws
.equ items, 9*ws


#if (inc == k)
movl k(%ebp), %eax
cmpl inc(%ebp), %eax
jnz if_end

movl $0, %edi
#for (int i = 0; i < k; i++)
for1:
cmpl k(%ebp), %edi
jge for_end1

#matrix[*counter][i] = temp[i]
#temp[i]
movl temp(%ebp), %ecx
movl (%ecx, %edi, ws), %ecx

#matrix[*counter]
movl counter(%ebp), %esi
movl (%esi), %esi
movl matrix(%ebp), %eax
movl (%eax, %esi, ws), %eax
movl %ecx, (%eax, %edi, ws)

incl %edi

jmp for1

for_end1:
#(*counter++)
movl counter(%ebp), %edx
movl (%edx), %edx
incl %edx
movl counter(%ebp), %eax
movl %edx, (%eax)
jmp epilogue

if_end:
#for (int i = number; i < len; i++)
movl number(%ebp), %edi # i = edi


for2:
cmpl len(%ebp), %edi
jge end_for2

#temp[inc] = items[i];
movl items(%ebp), %ecx
movl (%ecx, %edi, ws), %ecx #ecx = items[i]
movl temp(%ebp), %ebx
movl inc(%ebp), %eax
movl %ecx,(%ebx, %eax, ws)

#comb_helper(i+1, inc+1, len, k, &counter, temp, matrix, items)
push items(%ebp)
movl matrix(%ebp), %eax
push %eax
push temp(%ebp)
push counter(%ebp)
push k(%ebp)
push len(%ebp)

movl inc(%ebp), %eax
incl %eax
push %eax

movl %edi, %eax
incl %eax
push %eax

call comb_helper

addl $8*ws, %esp

incl %edi
jmp for2

end_for2:

epilogue:
movl matrix(%ebp), %eax
movl %ebp, %esp
pop %ebp
ret






