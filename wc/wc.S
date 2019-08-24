.intel_syntax noprefix

.set O_RDONLY, 0
.set O_WRONLY, 1
.set O_CREAT, 64

.section .text
# on the stack: argc and argv
.global _start
_start:
    mov rdi, QWORD PTR [rsp] # argc
    cmp rdi, 3
    jne wrong_argc

    mov rdi, QWORD PTR [rsp + 16] # argv[1]
    mov rsi, O_RDONLY
    call open
    cmp rax, 0
    jl open_fail

    mov rbx, rax # input fd

    mov rdi, QWORD PTR [rsp + 24] # argv[2]
    mov rsi, O_WRONLY | O_CREAT
    mov rdx, 0755
    call open
    cmp rax, 0
    jl open_fail

    mov r12, rax # output fd

    mov r13, 0 # row num

loop:
    mov rdi, rbx
    lea rsi, buffer
    mov rdx, buffer_end - buffer
    call getline
    cmp rax, buffer_end - buffer
    je loop # long line, again
    cmp rax, 0
    je end_loop # EOF
    jl read_fail
    add r13, 1
    jmp loop

end_loop:
    mov rdi, r12
    mov rsi, r13
    call putnum

    call exit
    # unreachable

wrong_argc:
    mov rdi, 1 # stdout
    lea rsi, wrong_argc_str
    mov rdx, wrong_argc_str_end - wrong_argc_str
    call write
    call exit

open_fail:
    mov rdi, 1 # stdout
    lea rsi, open_fail_str
    mov rdx, open_fail_str_end - open_fail_str
    call write
    call exit

read_fail:
    mov rdi, 1 # stdout
    lea rsi, read_fail_str
    mov rdx, read_fail_str_end - read_fail_str
    call write
    call exit

.section .rodata
wrong_argc_str: .string "Usage: wc <input_file> <output_file>.\n"
wrong_argc_str_end:
open_fail_str: .string "Open/create file failed.\n"
open_fail_str_end:
read_fail_str: .string "Read input file failed.\n"
read_fail_str_end:

.section .data
buffer: .space 1024
buffer_end: