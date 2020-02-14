.global matMult
.equ ws, 4
/*
 int** matMult(int **a, int num_rows_a, int num_cols_a, int** b, int num_rows_b, int num_cols_b){
 int i, j, k;
 int** C = (int**) malloc( num_rows_a * sizeof(int*));
 for (i = 0; i < num_rows_a; ++i) {
 C[i] = (int*)malloc( num_cols_b * sizeof(int));
 for(j = 0; j < num_cols_b; ++j) {
 for(k=0; k<num_cols_a; ++k) {
 C[i][j] += a[i][k] * b[k][j];
 }
 }
 }
 return C;
 }
 */

.text

matMult:
prologue:
push %ebp
movl %esp, %ebp
subl $4*ws, %esp #make space for for local
push %ebx
push %esi
push %edi

#stack after prologue
#num_cols_b
#num_rows_b
#b
#num_cols_a
#num_rows_a
#a
#ret adress
#ebp : old ebp
#i
#j
#k
#esp:c

.equ a,          (2*ws)
.equ num_rows_a, (3*ws)
.equ num_cols_a, (4*ws)
.equ b,          (5*ws)
.equ num_rows_b, (6*ws)
.equ num_cols_b, (7*ws)
.equ i,          (-1*ws)
.equ j,          (-2*ws)
.equ k,          (-3*ws)
.equ c,          (-4*ws)

#int** C = (int**) malloc( num_rows_a * sizeof(int*));
movl num_rows_a(%ebp), %eax #eax = num_rows_a
shll $2, %eax #eax = num_rows_a * sizeof(int*))
push %eax#place malloc's arguement onto the stack
call malloc
addl $1*ws, %esp
movl %eax, c(%ebp)
#eax will be i
#ecx will be j
#edi will be k

#for (i = 0; i < num_rows_a; ++i) {
movl $0, %eax
outer_loop:
cmpl num_rows_a(%ebp), %eax
jge end_outer_loop

#C[i] = (int*)malloc( num_cols_b * sizeof(int));
movl num_cols_b(%ebp), %edx #edx = num_cols_b
shll $2, %edx #edi = num_cols_b * 4
push %edx
movl %eax, i(%ebp) #save i
call malloc
addl $1*ws, %esp #clear arguement for malloc
movl %eax, %edx
movl i(%ebp), %eax
movl c(%ebp), %ecx #ecx = C
movl %edx, (%ecx, %eax, ws) #C[i] = edx

#for(j = 0; j < num_cols_b; ++j) {
movl $0, %ecx
inner_loop:
cmpl num_cols_b(%ebp), %ecx
jge end_inner_loop
#for(k=0; k<num_cols_a; ++k) {
movl $0, (%edx, %ecx, ws)
movl $0, %edi
inner_inner_loop:
cmpl num_cols_a(%ebp), %edi
jge end_inner_inner_loop
#C[i][j] += a[i][k] * b[k][j];
#ebx will be A[i][j]
movl a(%ebp), %ebx #ebx = a
movl (%ebx, %eax, ws), %ebx #ebx = A[i]
movl (%ebx, %edi, ws), %ebx #ebx = A[i][k]

#ebx will be a[i][k] * b[k][j]
#esi will be B[k][j]
movl b(%ebp), %esi #esi = B
movl (%esi, %edi, ws), %esi #esi = B[k]
movl (%esi, %ecx, ws), %esi #esi = B[k][j]


imull %esi, %ebx #ebx = a[i][k] * b[k][j]

addl %ebx, (%edx, %ecx, ws) #C[i][j] = ebx

incl %edi #++k
jmp inner_inner_loop
end_inner_inner_loop:
incl %ecx #++j
jmp inner_loop
end_inner_loop:

incl %eax #++i
jmp outer_loop
end_outer_loop:

movl c(%ebp), %eax

epilogue:
#restore regs
pop %edi
pop %esi
pop %ebx
movl %ebp, %esp
pop %ebp
ret

