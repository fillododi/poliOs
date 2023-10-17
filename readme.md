# PoliOs: an operating system made by PoliMI students. If you are one, you can contribute!

##  Info:
Made using c++.

No bootloader

## How do I use it?

### Step 1: Compile
(on linux):
```
make loader.o
make kernel.o
```

### Step 2: Install
(on linux, using GRUB):
1.
```
make install
```
2. Add the following at the end of /boot/grub/grub.cfg
```
menuentry 'PoliOs' {
    multiboot /boot/kernel.bin
    boot
}
```
### Or, create an iso image
(on linux. You need grub-mkrescue, mtools and xorriso)
```
make kernel.iso
```
You can now run it on a virtual machine!