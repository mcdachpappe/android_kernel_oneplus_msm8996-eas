#!/bin/bash
# Bash Color
green='\033[01;32m'
red='\033[01;31m'
blink_red='\033[05;31m'
restore='\033[0m'

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

# Compile Path to out 
	o="O=/home/holyangel/android/Kernels/op3p/out"

# CPU threads
	th="-j4"
############################################################
# Start Compile
############################################################

	echo "	Starting compile.."
	make "$o" $th
	echo "	First pass completed!"
	echo "	"
