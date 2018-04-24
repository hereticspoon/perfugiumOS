CC = i686-elf-gcc
LD = i686-elf-gcc

CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra

all: kernel.o driver/vga.o kernel_image kernel_iso

kernel.o: kernel.c 
	$(CC) $(CFLAGS) -c $^ -o $@ 

driver/vga.o: driver/vga.c
	$(CC) $(CFLAGS) -c $^ -o $@

kernel_image: linker.ld boot.o kernel.o
	i686-elf-gcc -T linker.ld -o perfugium.bin -ffreestanding -O2 -nostdlib boot.o kernel.o driver/vga.o -lgcc

kernel_iso: perfugium.bin grub.cfg
	cp perfugium.bin isodir/boot/perfugium.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o perfugium.iso isodir
