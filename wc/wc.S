.intel_syntax noprefix

.section .text
# on the stack: argc and argv
.global _start
_start:
    mov rdi, QWORD PTR [rsp]
    cmp rdi, 3
    jne wrong_argc

    call exit
    # unreachable

wrong_argc:
    mov rdi, 1 # stdout
    lea rsi, wrong_argc_str
    mov rdx, wrong_argc_str_end - wrong_argc_str
    call write
    call exit

.section .rodata
wrong_argc_str: .string "Usage: wc <input_file> <output_file>\n"
wrong_argc_str_end: