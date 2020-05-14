/*
 * ROM spec file
 */
#include "boot.h"

beginseg
	name "code"
	flags BOOT OBJECT
	entry boot
	stack bootStack + STACKSIZE
	include "codesegment.o"
	include "$(ROOT)/usr/lib/PR/rspboot.o"
	include "$(ROOT)/usr/lib/PR/gspF3DEX2.xbus.o"
	include "$(ROOT)/usr/lib/PR/gspF3DEX2.fifo.o"
endseg

beginwave
	name "main"
	include "code"
endwave