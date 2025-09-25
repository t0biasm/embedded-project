## FreeRTOS kernel for C28x

The mentioned code is fetched from following open source MIT repository\
[FreeRTOS port for C28x](https://github.com/IvanZuy/freertos_c28x)
```
commit: 52a94f13dbcbb62c4fe8616434eab9a5670b9868
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