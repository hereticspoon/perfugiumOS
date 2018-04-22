all: kernel kernel_image kernel_iso

kernel: kernel.c
	i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

kernel_image: linker.ld boot.o kernel.o
	i686-elf-gcc -T linker.ld -o perfugium.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

kernel_iso: perfugium.bin grub.cfg
	cp perfugium.bin isodir/boot/perfugium.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o perfugium.iso isodir
