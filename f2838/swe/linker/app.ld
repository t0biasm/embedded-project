/* Minimal linker command file for TMS320F28388D */
MEMORY
{
    PAGE 0: PROG: origin = 0x000040 length = 0x3fffc0
    PAGE 1: DATA: origin = 0x000000 length = 0x010000
    PAGE 1: DATA1: origin = 0x010000 length = 0x3f0000
}

SECTIONS
{
    /* Code and read-only data */
    .const:     PAGE = 0
    .text:      PAGE = 0
    .cinit:     PAGE = 0
    .pinit:     PAGE = 0

    /* Data */
    .bss:       PAGE = 1
    .stack:     PAGE = 1
    .sysmem:    PAGE = 1
    .data:      PAGE = 0
    .switch:    PAGE = 1
}
