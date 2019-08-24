.intel_syntax noprefix

.section .text

# int getline(int fd, char *buf, int len)
.global getline
getline:
    push rbx # callee saved
    cmp rdx, 1
    jl invalid_arg 
    sub rdx, 1

    mov rbx, 0
    # rbx = offset

loop:
    cmp rbx, rdx
    je end

    push rdx
    mov rdx, 1
    call read
    pop rdx

    cmp rax, 0
    je end # EOF
    jl fail

    mov r8b, BYTE PTR [rsi]
    cmp r8, 0x0a
    je good

    add rbx, 1
    add rsi, 1

    jmp loop

fail:
    mov rax, -1
    jmp end

good:
    mov rax, rbx
    jmp end

end:
    mov BYTE PTR[rsi], 0
    jmp quit

invalid_arg:
    mov rax, -1
    jmp quit

quit:
    pop rbx
    ret