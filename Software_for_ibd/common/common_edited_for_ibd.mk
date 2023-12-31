#################################################################################################
# << NEORV32 - Application Makefile >>                                                          #
# ********************************************************************************************* #
# BSD 3-Clause License                                                                          #
#                                                                                               #
# Copyright (c) 2023, Stephan Nolting. All rights reserved.                                     #
#                                                                                               #
# Redistribution and use in source and binary forms, with or without modification, are          #
# permitted provided that the following conditions are met:                                     #
#                                                                                               #
# 1. Redistributions of source code must retain the above copyright notice, this list of        #
#    conditions and the following disclaimer.                                                   #
#                                                                                               #
# 2. Redistributions in binary form must reproduce the above copyright notice, this list of     #
#    conditions and the following disclaimer in the documentation and/or other materials        #
#    provided with the distribution.                                                            #
#                                                                                               #
# 3. Neither the name of the copyright holder nor the names of its contributors may be used to  #
#    endorse or promote products derived from this software without specific prior written      #
#    permission.                                                                                #
#                                                                                               #
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS   #
# OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF               #
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE    #
# COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,     #
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE #
# GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED    #
# AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     #
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED  #
# OF THE POSSIBILITY OF SUCH DAMAGE.                                                            #
# ********************************************************************************************* #
# The NEORV32 Processor - https://github.com/stnolting/neorv32              (c) Stephan Nolting #
#################################################################################################


# -----------------------------------------------------------------------------
# USER CONFIGURATION
# -----------------------------------------------------------------------------
# User's application sources (*.c, *.cpp, *.s, *.S); add additional files here
APP_SRC ?= $(wildcard ./*.c) $(wildcard ./*.s) $(wildcard ./*.cpp) $(wildcard ./*.S)

# User's application include folders (don't forget the '-I' before each entry)
APP_INC ?= -I .
# User's application include folders - for assembly files only (don't forget the '-I' before each entry)
ASM_INC ?= -I .

# Optimization
EFFORT ?= -Os

# Compiler toolchain
RISCV_PREFIX ?= riscv32-unknown-elf-

# CPU architecture and ABI
MARCH ?= rv32i_zicsr
MABI  ?= ilp32

# User flags for additional configuration (will be added to compiler flags)
USER_FLAGS ?=

# Relative or absolute path to the NEORV32 home folder
NEORV32_HOME ?= ../..


# GDB arguments
GDB_ARGS ?= -ex "target extended-remote localhost:3333"


# -----------------------------------------------------------------------------
# NEORV32 framework
# -----------------------------------------------------------------------------
# Path to NEORV32 linker script and startup file
NEORV32_COM_PATH = $(NEORV32_HOME)/common
# Path to main NEORV32 library include files
NEORV32_INC_PATH = $(NEORV32_HOME)/lib/include
# Path to main NEORV32 library source files
NEORV32_SRC_PATH = $(NEORV32_HOME)/lib/source


# Core libraries (peripheral and CPU drivers) ###H.ASHUVA LAB
CORE_SRC  = $(wildcard $(NEORV32_SRC_PATH)/*.c)
# Application start-up code
CORE_SRC += $(NEORV32_COM_PATH)/crt0.S

# Linker script
LD_SCRIPT ?= $(NEORV32_COM_PATH)/link.ld

# Main output files

APP_ELF  = my_main.elf
APP_ASM  = main.asm



# -----------------------------------------------------------------------------
# Sources and objects
# -----------------------------------------------------------------------------
# Define all sources
SRC  = $(APP_SRC)
SRC += $(CORE_SRC)

# Define all object files
OBJ = $(SRC:%=%.o)


# -----------------------------------------------------------------------------
# Tools and flags
# -----------------------------------------------------------------------------
# Compiler tools
CC      = $(RISCV_PREFIX)gcc
OBJDUMP = $(RISCV_PREFIX)objdump
OBJCOPY = $(RISCV_PREFIX)objcopy
SIZE    = $(RISCV_PREFIX)size
GDB     = $(RISCV_PREFIX)gdb

# Host native compiler
CC_X86 = gcc -Wall -O -g

# NEORV32 executable image generator
IMAGE_GEN = $(NEORV32_EXG_PATH)/image_gen

# Compiler & linker flags
CC_OPTS  = -march=$(MARCH) -mabi=$(MABI) $(EFFORT) -Wall -ffunction-sections -fdata-sections -nostartfiles -mno-fdiv -fvisibility=hidden -ffreestanding -mcmodel=medany
CC_OPTS += -mstrict-align -mbranch-cost=10 -g -Wl,--gc-sections
CC_OPTS += $(USER_FLAGS)
LD_LIBS =  -lm -lc -lgcc
LD_LIBS += $(USER_LIBS)


# -----------------------------------------------------------------------------
# Application output definitions
# -----------------------------------------------------------------------------
.PHONY: check info help elf_info clean clean_all bootloader
.DEFAULT_GOAL := help

# 'compile' is still here for compatibility
asm:     $(APP_ASM)
elf:     $(APP_ELF)
all:     $(APP_ASM) $(APP_ELF)

# -----------------------------------------------------------------------------
# General targets: Assemble, compile, link, dump
# -----------------------------------------------------------------------------
# Compile app *.s sources (assembly)
%.s.o: %.s
	@$(CC) -c $(CC_OPTS) -I $(NEORV32_INC_PATH) $(ASM_INC) $< -o $@

# Compile app *.S sources (assembly + C pre-processor)
%.S.o: %.S
	@$(CC) -c $(CC_OPTS) -I $(NEORV32_INC_PATH) $(ASM_INC) $< -o $@

# Compile app *.c sources
%.c.o: %.c
	@$(CC) -c $(CC_OPTS) -I $(NEORV32_INC_PATH) $(APP_INC) $< -o $@

# Compile app *.cpp sources
%.cpp.o: %.cpp
	@$(CC) -c $(CC_OPTS) -I $(NEORV32_INC_PATH) $(APP_INC) $< -o $@

# Link object files and show memory utilization
$(APP_ELF): $(OBJ)
	@$(CC) $(CC_OPTS) -T $(LD_SCRIPT) $(OBJ) $(LD_LIBS) -o $@
	@echo "Memory utilization:"
	@$(SIZE) $(APP_ELF)

# Assembly listing file (for debugging)
$(APP_ASM): $(APP_ELF)
	@$(OBJDUMP) -d -S -z  $< > $@

# -----------------------------------------------------------------------------
# Show final ELF details (just for debugging)
# -----------------------------------------------------------------------------
elf_info: $(APP_ELF)
	@$(OBJDUMP) -x $(APP_ELF)


# -----------------------------------------------------------------------------
# Run GDB
# -----------------------------------------------------------------------------
gdb:
	@$(GDB) $(APP_ELF) $(GDB_ARGS)


# -----------------------------------------------------------------------------
# Clean up
# -----------------------------------------------------------------------------
clean:
	@rm -f *.elf *.o *.bin *.out *.asm *.vhd *.hex .gdb_history

clean_all: clean
	@rm -f $(OBJ) $(IMAGE_GEN)


# -----------------------------------------------------------------------------
# Show configuration
# -----------------------------------------------------------------------------
info:
	@echo "------------------------------------------------------"
	@echo "-- Project"
	@echo "------------------------------------------------------"
	@echo "Project folder:        $(shell basename $(CURDIR))"
	@echo "Source files:          $(APP_SRC)"
	@echo "Include folder(s):     $(APP_INC)"
	@echo "ASM include folder(s): $(ASM_INC)"
	@echo "------------------------------------------------------"
	@echo "-- NEORV32"
	@echo "------------------------------------------------------"
	@echo "NEORV32 home folder (NEORV32_HOME): $(NEORV32_HOME)"
	@echo "IMAGE_GEN: $(IMAGE_GEN)"
	@echo "Core source files:"
	@echo "$(CORE_SRC)"
	@echo "Core include folder:"
	@echo "$(NEORV32_INC_PATH)"
	@echo "------------------------------------------------------"
	@echo "-- Objects"
	@echo "------------------------------------------------------"
	@echo "Project object files:"
	@echo "$(OBJ)"
	@echo "------------------------------------------------------"
	@echo "-- RISC-V CPU"
	@echo "------------------------------------------------------"
	@echo "MARCH:      $(MARCH)"
	@echo "MABI:       $(MABI)"
	@echo "------------------------------------------------------"
	@echo "-- Toolchain"
	@echo "------------------------------------------------------"
	@echo "Toolchain:  $(RISCV_TOLLCHAIN)"
	@echo "CC:         $(CC)"
	@echo "OBJDUMP:    $(OBJDUMP)"
	@echo "OBJCOPY:    $(OBJCOPY)"
	@echo "SIZE:       $(SIZE)"
	@echo "DEBUGGER:   $(GDB)"
	@echo "------------------------------------------------------"
	@echo "-- GDB Arguments"
	@echo "------------------------------------------------------"
	@echo "GDB_ARGS:   $(GDB_ARGS)"
	@echo "------------------------------------------------------"
	@echo "-- Libraries"
	@echo "------------------------------------------------------"
	@echo "LIBGCC:"
	@$(CC) -print-libgcc-file-name
	@echo "SEARCH-DIRS:"
	@$(CC) -print-search-dirs
	@echo "------------------------------------------------------"
	@echo "-- Flags"
	@echo "------------------------------------------------------"
	@echo "USER_FLAGS: $(USER_FLAGS)"
	@echo "CC_OPTS:    $(CC_OPTS)"
	@echo "------------------------------------------------------"
	@echo "-- Libraries"
	@echo "------------------------------------------------------"
	@echo "USER_LIBS: $(USER_LIBS)"
	@echo "LD_LIBS:   $(LD_LIBS)"


# -----------------------------------------------------------------------------
# Help
# -----------------------------------------------------------------------------
help:
	@echo "<<< NEORV32 SW Application Makefile >>>"
	@echo "Make sure to add the bin folder of RISC-V GCC to your PATH variable."
	@echo ""
	@echo "=== Targets ==="
	@echo " help       - show this text"
	@echo " check      - check toolchain"
	@echo " info       - show makefile/toolchain configuration"
	@echo " gdb        - run GNU debugging session"
	@echo " asm        - compile and generate <$(APP_ASM)> assembly listing file for manual debugging"
	@echo " elf        - compile and generate <$(APP_ELF)> ELF file"
	@echo " exe        - compile and generate <$(APP_EXE)> executable for upload via default bootloader (binary file, with header)"
	@echo " bin        - compile and generate <$(APP_BIN)> RAW executable file (binary file, no header)"
	@echo " hex        - compile and generate <$(APP_HEX)> RAW executable file (hex char file, no header)"
	@echo " image      - compile and generate VHDL IMEM boot image (for application, no header) in local folder"
	@echo " install    - compile, generate and install VHDL IMEM boot image (for application, no header)"
	@echo " sim        - in-console simulation using default/simple testbench and GHDL"
	@echo " all        - exe + install + hex + bin + asm"
	@echo " elf_info   - show ELF layout info"
	@echo " clean      - clean up project home folder"
	@echo " clean_all  - clean up whole project, core libraries and image generator"
	@echo " bl_image   - compile and generate VHDL BOOTROM boot image (for bootloader only, no header) in local folder"
	@echo " bootloader - compile, generate and install VHDL BOOTROM boot image (for bootloader only, no header)"
	@echo ""
	@echo "=== Variables ==="
	@echo " USER_FLAGS   - Custom toolchain flags [append only]: \"$(USER_FLAGS)\""
	@echo " USER_LIBS    - Custom libraries [append only]: \"$(USER_LIBS)\""
	@echo " EFFORT       - Optimization level: \"$(EFFORT)\""
	@echo " MARCH        - Machine architecture: \"$(MARCH)\""
	@echo " MABI         - Machine binary interface: \"$(MABI)\""
	@echo " APP_INC      - C include folder(s) [append only]: \"$(APP_INC)\""
	@echo " ASM_INC      - ASM include folder(s) [append only]: \"$(ASM_INC)\""
	@echo " RISCV_PREFIX - Toolchain prefix: \"$(RISCV_PREFIX)\""
	@echo " NEORV32_HOME - NEORV32 home folder: \"$(NEORV32_HOME)\""
	@echo " GDB_ARGS     - GDB (connection) arguments: \"$(GDB_ARGS)\""
	@echo ""
