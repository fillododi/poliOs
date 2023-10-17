global long_mode_start

extern start

section .text
bits 64

long_mode_start:
    ;load 0 into necessary registers
    mov ax, 0
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    call start
