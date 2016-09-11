#!/bin/bash
#
# makefirmware.sh
# Copyright (C) 2016 Damien Zammit <damien@zamaudio.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#

FIRMWARE=$1

LINES=$(od -t x4 -w4 -v -An --endian=big $FIRMWARE|wc -l)
FWLEN=$(printf "0x%08x," $LINES)
FWHEX=$(od -t x4 -w4 -v -An --endian=big $FIRMWARE|awk '{print "0x"$1","}')
SHA1HASH=$(python ../signsmu.py $1 | awk '{print $1","}')

echo "
#ifndef _SMUFIRMWARE_H
#define _SMUFIRMWARE_H

UINT32  FirmwareTN[] = {
 0x000a00cb,
 0x00000040,"
echo "$FWLEN"
echo " 0x00010100,"
echo "$SHA1HASH"
echo " 0x0001d97c,
 0x0001da8c,
 0x00000000,
 0x0001daad,
 0x0001dabc,
 0x0001d9d0,
 0x0001dbf4,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0x00000000,
 0xaa55aa55,"
echo "$FWHEX"
echo "};"
echo "#endif"