#!/bin/bash
############################################################
### Single run script for HolyDragon Kernel
############################################################

# This is a cleanup and single run build script for testing purposes.
# This does not zip anything for you, only executes a normal build. 

# Minimum requirements to build:
# Already working build environment :P 
#
# In this script: 
# You will need to change the 'Source Path to kernel tree' to match your current path to this source.
# You will need to change the 'Compile Path to out' to match your current path to this source.
# You will also need to edit the '-j32' under 'Start Compile' section and adjust that to match the amount of cores you want to use to build.
# 
# In Makefile: 
# You will need to edit the 'CROSS_COMPILE=' line to match your current path to this source.
# 
# Once those are done, you should be able to execute './run.sh' from terminal and receive an Image.gz-dtb file in arch/arm64/boot/

############################################################
# Build Script Variables
############################################################ 

# Source defconfig used to build
	dc=HD_defconfig

# Source Path to kernel tree
	k=/home/holyangel/android/Kernels/msm8996

# Source Path to clean(empty) out folder
	co=$k/out

# Compile Path to out 
	o="O=/home/holyangel/android/Kernels/msm8996/out"

############################################################
# Cleanup
############################################################

	echo "	Cleaning up out directory"
	rm -Rf out/
	echo "	Out directory removed!"

############################################################
# Make out folder
############################################################

	echo "	Making new out directory"
	mkdir -p "$co"
	echo "	Created new out directory"

############################################################
# Establish defconfig
############################################################

	echo "	Establishing build environment.."
	make "$o" "$dc"

############################################################
# Start Compile
############################################################

	echo "	First pass started.."
	make "$o" -j32
	echo "	First pass completed!"
	echo "	"
