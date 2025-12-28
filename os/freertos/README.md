## FreeRTOS kernel for C28x

The mentioned code is fetched from an official Texas Instruments FreeRTOS port\
[FreeRTOS port for C28x](https://github.com/TexasInstruments/c2000ware-FreeRTOS/tree/REL_C2000Ware_v5.05.00.00/kernel/FreeRTOS/Source)
```
tag: REL_C2000Ware_v5.05.00.00
commit: 6a04433db92938ed380d168bfafdfefc5d88791f
```

Each real time kernel port consists of three files that contain the core kernel
components and are common to every port, and one or more files that are 
specific to a particular microcontroller and or compiler.

+ The FreeRTOS/Source directory contains the three files that are common to 
every port - list.c, queue.c and tasks.c.  The kernel is contained within these 
three files.  croutine.c implements the optional co-routine functionality - which
is normally only used on very memory limited systems.

+ The FreeRTOS/Source/Portable directory contains the files that are specific to 
a particular microcontroller and or compiler.

+ The FreeRTOS/Source/include directory contains the real time kernel header 
files.

See the readme file in the FreeRTOS/Source/Portable directory for more 
information.