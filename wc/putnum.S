.intel_syntax noprefix

.section .text

# void putnum(int fd, int number)
.global putnum
putnum:
    cmp rsi, 0
    je zero
    cmp rsi, 10
    jl one_digit

    mov rdx, 0
    mov rax, rsi
    mov rcx, 10
    div rcx # / eax, % edx
    push rdx
    mov rsi, rax
    call putnum
    pop rsi

one_digit:
    add rsi, '0'
    push rsi
    mov rsi, rsp # little endian
    mov rdx, 1
    call write
    pop rsi
    ret

zero:
    lea rsi, zero_str
    mov rdx, zero_str_end - zero_str
    call write
    ret

.section .rodata
zero_str: .string "0"
zero_str_end: