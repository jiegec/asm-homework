.intel_syntax noprefix

.section .text

# int getline(int fd, char *buf, int len)
# return the number of bytes written sans 0 and LF
# return -1 on EOF, -2 on fail
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
    je good

    push rdx
    mov rdx, 1
    call read
    pop rdx

    cmp rax, 0
    je eof
    jl fail

    mov r8b, BYTE PTR [rsi]
    cmp r8, 0x0a
    je good

    add rbx, 1
    add rsi, 1

    jmp loop

fail:
    mov rax, -2
    jmp end

good:
    mov rax, rbx
    jmp end

eof:
    mov r8, -1
    mov rax, rbx
    test rbx, rbx
    cmovz rax, r8
    jmp end

end:
    mov BYTE PTR[rsi], 0
    jmp quit

invalid_arg:
    mov rax, -2
    jmp quit

quit:
    pop rbx
    ret