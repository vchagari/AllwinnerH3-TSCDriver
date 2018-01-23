# All Rights Reserved.
#
# This is UNPUBLISHED PROPRIETARY SOURCE CODE of Ethertronics;
# the contents of this file may not be disclosed to third parties, copied
# or duplicated in any form, in whole or in part, without the prior
# written permission of Ethertronics Corporation.
#
#
# Copyright (c) 2017, Ethertronics.
# All rights reserved.
# 
# Redistribution and use in binary & source form, without
# modification, are permitted provided that the following conditions are
# met:
# 
# - Redistributions must reproduce the above copyright notice and the
#   following disclaimer in the documentation and/or other materials
#   provided with the distribution.
# - Neither the name of Ethertronics nor the names of its suppliers
#   may be used to endorse or promote products derived from this software
#   without specific prior written permission.
# 
# Ethertronics grants a world-wide, royalty-free, non-exclusive license
# to make, have made, use, import, offer to sell and
# sell ("Utilize") this software, but solely to the extent that any
# such license is necessary to Utilize the software alone, or in
# combination with an operating system licensed under an approved Open
# Source license as listed by the Open Source Initiative at
# http://opensource.org/licenses.  The license shall not apply to
# any other combinations which include this software.  No hardware per
# se is licensed hereunder.
# 
# DISCLAIMER.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
# CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
# BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
# OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
# TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
# USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
# DAMAGE.
 
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

