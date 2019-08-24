.intel_syntax noprefix
#include <sys/syscall.h>

.section .text

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