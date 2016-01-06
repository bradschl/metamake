
/* Entry Point */
ENTRY(Reset_Handler)

/* Highest address of the user mode stack */
_estack = 0x2001FFFC;    /* end of 16K RAM */

/* Minimum required amount of stack */
_Min_Stack_Size = 0x1000; 

/* Heap size */
_Heap_Size = 0x8000;

/* Specify the memory areas */
MEMORY
{
  FLASH (rx)      : ORIGIN = 0x08080200, LENGTH = 511K
  CCM (xrw)       : ORIGIN = 0x10000000, LENGTH = 64k
  RAM (xrw)       : ORIGIN = 0x20000000, LENGTH = 112K
  MEMORY_B1 (rx)  : ORIGIN = 0x60000000, LENGTH = 0K
}

/* Make sure this matches the FLASH area above */
AppCodeStartAddr = 0x08080200;

/* Sections */
INCLUDE "ldscripts/sections.ld"
