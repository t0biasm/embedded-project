/* Default Memory Allocation */
MEMORY
{
    PAGE 0: PROG: origin = 0x000040 length = 0x3fffc0
    PAGE 1: DATA: origin = 0x000000 length = 0x010000
    PAGE 1: DATA1: origin = 0x010000 length = 0x3f0000
}

SECTIONS
{
    .text:  PAGE = 0
    .data:  PAGE = 0
    .cinit: PAGE = 0 /* Used only for C programs */
    .bss:  PAGE = 1
}
