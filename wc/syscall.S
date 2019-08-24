.intel_syntax noprefix
#include <sys/syscall.h>

.section .text

# args: rdi, rsi, rdx, r10, r8, r9
# number: rax
# clobber: rcx, r11

# void exit(int code)
.global exit
exit:
    mov rax, SYS_exit_group
    syscall
    ret

# void close(int fd)
.global close
close:
    mov rax, SYS_close
    syscall
    ret

# int open(int fd, int flags)
.global open
open:
    mov rax, SYS_open
    syscall
    ret

# int write(int fd, char *str, int length)
.global write
write:
    mov rax, SYS_write
    syscall
    ret

# int read(int fd, char *buf, int length)
.global read
read:
    mov rax, SYS_read
    syscall
    ret