i386_ASM_SOURCE_FILES := $(shell find src/i386 -name *.s)
x86_64_ASM_SOURCE_FILES := $(shell find src/x86_64 -name *.asm)
CPP_SOURCE_FILES := $(shell find src/kernel -name *.cpp)

i386_ASM_OBJECT_FILES := $(patsubst src/i386/%.s, build/i386/%.o, $(i386_ASM_SOURCE_FILES))
i386_CPP_OBJECT_FILES := $(patsubst src/kernel/%.cpp, build/i386/%.o, $(CPP_SOURCE_FILES))
x86_64_ASM_OBJECT_FILES := $(patsubst src/x86_64/%.asm, build/x86_64/%.o, $(x86_64_ASM_SOURCE_FILES))
x86_64_CPP_OBJECT_FILES := $(patsubst src/kernel/%.cpp, build/x86_64/%.o, $(CPP_SOURCE_FILES))

i386GCCPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
i386ASPARAMS = --32
i386LDPARAMS = -m elf_i386

x86_64GCCPARAMS = -m elf_x86_64 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore -I src/interfaces -ffreestanding
x86_64NASMPARAMS = -f elf64
x86_64LDPARAMS = -m elf_x86_64


$(i386_ASM_OBJECT_FILES): build/i386/%.o: src/i386/%.s
	mkdir -p $(dir $@) && \
	as $(i386ASPARAMS) -o $@ $(patsubst build/i386/%.o, src/i386/%.s, $@)

$(i386_CPP_OBJECT_FILES): build/i386/%.o: src/kernel/%.cpp
	mkdir -p $(dir $@) && \
    gcc $(i386GCCPARAMS) -c -o $@ $<

.PHONY: build-i386
build-i386: $(i386_ASM_OBJECT_FILES) $(i386_CPP_OBJECT_FILES)
	mkdir -p dist/i386 && \
	ld $(i386LDPARAMS) -o dist/i386/kernel.bin -T targets/i386/linker.ld $(i386_ASM_OBJECT_FILES) $(i386_CPP_OBJECT_FILES)
	cp dist/i386/kernel.bin targets/i386/iso/boot/kernel.bin && \
	grub-mkrescue -o dist/i386/kernel.iso targets/i386/iso



$(x86_64_ASM_OBJECT_FILES): build/x86_64/%.o: src/x86_64/%.asm
	mkdir -p $(dir $@) && \
	nasm $(x86_64NASMPARAMS) -o $@ $(patsubst build/x86_64/%.o, src/x86_64/%.asm, $@)

$(x86_64_CPP_OBJECT_FILES): build/x86_64/%.o: src/kernel/%.cpp
	mkdir -p $(dir $@) && \
    gcc $(x86_64GCCPARAMS) -c -o $@ $<

.PHONY: build-x86_64
build-x86_64: $(x86_64_ASM_OBJECT_FILES) $(x86_64_CPP_OBJECT_FILES)
	mkdir -p dist/x86_64 && \
	ld $(x86_64LDPARAMS) -o dist/x86_64/kernel.bin -T targets/x86_64/linker.ld $(x86_64_ASM_OBJECT_FILES) $(x86_64_CPP_OBJECT_FILES)
	cp dist/x86_64/kernel.bin targets/x86_64/iso/boot/kernel.bin && \
	grub-mkrescue -o dist/x86_64/kernel.iso targets/x86_64/iso