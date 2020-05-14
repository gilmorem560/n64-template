#include <ultra64.h>
#include <PR/ramrom.h>
#include <assert.h>

#include "boot.h"

/* needed by makerom to mark end of code segment */
extern char _codeSegmentEnd[];

/* stack for synchronization in boot */
u64 bootStack[STACKSIZE/sizeof(u64)];

OSPiHandle *handler;

void boot(void)
{
	/* entry */
}