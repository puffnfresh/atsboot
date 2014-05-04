LD=i386-elf-ld
ATSOPT=patsopt
CC=gcc
CCFLAGS=-std=c99 -I${PATSHOME}/ccomp/runtime -I${PATSHOME} -D_ATS_CCOMP_RUNTIME_NONE -D_ATS_CCOMP_EXCEPTION_NONE -Wall -Wextra -Wno-unused -Wno-unused-parameter --target=i386-intel-linux -Os -m32 -nostdlib -fno-stack-protector -ffunction-sections -fdata-sections -fomit-frame-pointer -Wl,--gc-sections -g
NASM=nasm
QEMU=qemu-system-i386

all: floppy.img

.SUFFIXES: .o .dats .asm

.PHONY: clean run

%_dats.c: %.dats
	$(ATSOPT) -o $@ -d $<

%_dats.o: %_dats.c
	$(CC) $(CCFLAGS) -c $<

.asm.o:
	$(NASM) -f elf32 -o $@ $<

loader.bin: loader.asm
	$(NASM) -o $@ -f bin $<

floppy.img: loader.bin main.bin
	dd if=/dev/zero of=$@ bs=512 count=2 &>/dev/null
	cat $^ | dd if=/dev/stdin of=$@ conv=notrunc &>/dev/null

main.bin: linker.ld main_dats.o
	$(LD) -m elf_i386 -o $@ -T $^

run: floppy.img
	$(QEMU) -fda $<

clean:
	rm -f *.bin *.o *.img
