
STBSDK ?= $(HOME)/Dev/build
KERNEL_DIR ?= $(STBSDK)/cache/sources/linux-sun8i/sun8i/
TOOLS_PATH ?= $(STBSDK)/cache/toolchains/gcc-linaro-5.5.0-2017.10-x86_64_arm-linux-gnueabihf/bin/

export PATH := $(TOOLS_PATH):$(PATH)

TARGET_PREFIX := arm-linux-gnueabihf-
COMPILE_PREFIX := ${TOOLS_PATH}${TARGET_PREFIX}
CROSS_COMPILE := ${COMPILE_PREFIX}

PWD := $(shell pwd)
ECHO := $(shell which echo)
CPIO := $(shell which cpio)
SED := $(shell which sed)

CC = ${CROSS_COMPILE}gcc
LD = $(CROSS_COMPILE)ld
ARCH = arm
CROSS = ARCH=arm

ET_DIR := $(STBSDK)/../../kerneldrivers/sunxi-tsc

ccflags-y += -I $(ET_DIR) 
ccflags-y += -Wall -Werror -Wextra -Wformat-nonliteral -Wformat=2 -Winvalid-pch -Wmissing-declarations -Wmissing-format-attribute -Wmissing-prototypes -Wswitch-enum -Wno-unused-parameter -Wno-sign-compare -Wno-missing-field-initializers

ccflags-y += -nostdinc -isystem /home/vchagari/Dev/Orangepi/Orangepione/build/cache/toolchains/gcc-linaro-5.5.0-2017.10-x86_64_arm-linux-gnueabihf/bin/../lib/gcc/arm-linux-gnueabihf/5.5.0/include -I/home/vchagari/Dev/Orangepi/Orangepione/build/cache/sources/linux-sun8i/sun8i/arch/arm/include -Iarch/arm/include/generated -Iinclude  -include /home/vchagari/Dev/Orangepi/Orangepione/build/cache/sources/linux-sun8i/sun8i/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-sunxi/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Os -marm -fno-dwarf2-cfi-asm -fno-omit-frame-pointer -mapcs -mno-sched-prolog -fno-ipa-sra -mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp -funwind-tables -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -fno-var-tracking-assignments -pg -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO  -DMODULE

obj-m = tscdrv.o 

default:
	$(MAKE) -C $(KERNEL_DIR) $(CROSS) SUBDIRS=$(PWD) modules

clean:
	$(MAKE) -C $(KERNEL_DIR) SUBDIRS=$(PWD) clean

