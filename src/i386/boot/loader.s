.section .text

.extern start
.extern callConstructors
.global loader

loader:
    mov $stack, %esp
    call callConstructors
    push %eax
    push %ebx
    call start

_stop:
    cli
    hlt
    jmp _stop

.section .bss

.space 2*1024*1024 #2MB
stack:
