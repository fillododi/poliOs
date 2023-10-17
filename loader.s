#PREPARES REGISTERS FOR THE KERNEL, THEN STARTS IT

.set MAGICNUMBER, 0x1badb002
.set FLAGS, (1 << 0 | 1 << 1)
.set CHECKSUM, -(MAGICNUMBER + FLAGS)

.section .multiboot #the result of this is having the multiboot structure on eax and the magic number on ebx
    .long MAGICNUMBER
    .long FLAGS
    .long CHECKSUM

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
