/* Default Memory Allocation */
MEMORY
{
    ROM_APP:    origin = 0x00080000,    length = 0x00400000,
    RAM_APP:    origin = 0x00000400,    length = 0x00000400,
}

SECTIONS
{
    .text       :  > ROM_APP
    .data       :  > ROM_APP
    .cinit      :  > ROM_APP
    .bss        :  > ROM_APP
    .TI.ramfunc :  > ROM_APP
    .stack      :  > RAM_APP
}
