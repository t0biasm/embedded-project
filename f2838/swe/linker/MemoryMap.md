# TMSF28388x Memory Maps

# Table of Contents

- [C28x Memory Map](#c28x-memory-map)
- [C28x Flash Memory Map](#c28x-flash-memory-map)
- [EMIF Chip Select Memory Map](#emif-chip-select-memory-map)
- [CM Memory Map](#cm-memory-map)
- [CM Flash Memory Map](#cm-flash-memory-map)

## C28x Memory Map
| MEMORY                          | SIZE     | START ADDRESS | END ADDRESS | CLA ACCESS | DMA ACCESS | ECC/PARITY | ACCESS PROTECTION | SECURITY |
|---------------------------------|----------|---------------|-------------|------------|------------|------------|-------------------|----------|
| M0 RAM                          | 1K x 16  | 0x0000 0000   | 0x0000 03FF |            |            | ECC        | Yes               |          |
| M1 RAM                          | 1K x 16  | 0x0000 0400   | 0x0000 07FF |            |            | ECC        | Yes               |          |
| PieVectTable                    | 512 x 16 | 0x0000 0D00   | 0x0000 0EFF |            |            |            |                   |          |
| CPUx.CLA1 → CPUx MSGRAM         | 128 x 16 | 0x0000 1480   | 0x0000 14FF | Yes        |            | Parity     |                   |          |
| CPUx → CPUx.CLA1 MSGRAM         | 128 x 16 | 0x0000 1500   | 0x0000 157F |            |            | Parity     |                   |          |
| CPUx.CLA1 → CPUx.DMA MSGRAM     | 128 x 16 | 0x0000 1680   | 0x0000 16FF | Yes        | Yes        | Parity     |                   |          |
| CPUx.DMA → CPUx.CLA1 MSGRAM     | 128 x 16 | 0x0000 1700   | 0x0000 177F | Yes        | Yes        | Parity     |                   |          |
| LS0 RAM                         | 2K x 16  | 0x0000 8000   | 0x0000 87FF | Yes        |            | ECC        | Yes               | Yes      |
| LS1 RAM                         | 2K x 16  | 0x0000 8800   | 0x0000 8FFF | Yes        |            | ECC        | Yes               | Yes      |
| LS2 RAM                         | 2K x 16  | 0x0000 9000   | 0x0000 97FF | Yes        |            | ECC        | Yes               | Yes      |
| LS3 RAM                         | 2K x 16  | 0x0000 9800   | 0x0000 9FFF | Yes        |            | ECC        | Yes               | Yes      |
| LS4 RAM                         | 2K x 16  | 0x0000 A000   | 0x0000 A7FF | Yes        |            | ECC        | Yes               | Yes      |
| LS5 RAM                         | 2K x 16  | 0x0000 A800   | 0x0000 AFFF | Yes        |            | ECC        | Yes               | Yes      |
| LS6 RAM                         | 2K x 16  | 0x0000 B000   | 0x0000 B7FF | Yes        |            | ECC        | Yes               | Yes      |
| LS7 RAM                         | 2K x 16  | 0x0000 B800   | 0x0000 BFFF | Yes        |            | ECC        | Yes               | Yes      |
| D0 RAM                          | 2K x 16  | 0x0000 C000   | 0x0000 C7FF |            |            | ECC        | Yes               | Yes      |
| D1 RAM                          | 2K x 16  | 0x0000 C800   | 0x0000 CFFF |            |            | ECC        | Yes               | Yes      |
| GS0 RAM(1)                      | 4K x 16  | 0x0000 D000   | 0x0000 DFFF | Yes        |            | Parity     | Yes               |          |
| GS1 RAM(1)                      | 4K x 16  | 0x0000 E000   | 0x0000 EFFF | Yes        |            | Parity     | Yes               |          |
| GS2 RAM(1)                      | 4K x 16  | 0x0000 F000   | 0x0000 FFFF | CLA DATA ROM(5) |    | Parity     | Yes               |          |
| GS3 RAM(1)                      | 4K x 16  | 0x0001 0000   | 0x0001 0FFF | Yes        |            | Parity     | Yes               |          |
| GS4 RAM(1)                      | 4K x 16  | 0x0001 1000   | 0x0001 1FFF | Yes        |            | Parity     | Yes               |          |
| GS5 RAM(1)                      | 4K x 16  | 0x0001 2000   | 0x0001 2FFF | Yes        |            | Parity     | Yes               |          |
| GS6 RAM(1)                      | 4K x 16  | 0x0001 3000   | 0x0001 3FFF | Yes        |            | Parity     | Yes               |          |
| GS7 RAM(1)                      | 4K x 16  | 0x0001 4000   | 0x0001 4FFF | Yes        |            | Parity     | Yes               |          |
| GS8 RAM(1)                      | 4K x 16  | 0x0001 5000   | 0x0001 5FFF | Yes        |            | Parity     | Yes               |          |
| GS9 RAM(1)                      | 4K x 16  | 0x0001 6000   | 0x0001 6FFF | Yes        |            | Parity     | Yes               |          |
| GS10 RAM(1)                     | 4K x 16  | 0x0001 7000   | 0x0001 7FFF | Yes        |            | Parity     | Yes               |          |
| GS11 RAM(1)                     | 4K x 16  | 0x0001 8000   | 0x0001 8FFF | Yes        |            | Parity     | Yes               |          |
| GS12 RAM(1)                     | 4K x 16  | 0x0001 9000   | 0x0001 9FFF | Yes        |            | Parity     | Yes               |          |
| GS13 RAM(1)                     | 4K x 16  | 0x0001 A000   | 0x0001 AFFF | Yes        |            | Parity     | Yes               |          |
| GS14 RAM(1)                     | 4K x 16  | 0x0001 B000   | 0x0001 BFFF | Yes        |            | Parity     | Yes               |          |
| GS15 RAM(1)                     | 4K x 16  | 0x0001 C000   | 0x0001 CFFF | Yes        |            | Parity     | Yes               |          |
| EtherCAT RAM (direct access)(2) | 8K x 16  | 0x0003 0800   | 0x0003 27FF | Yes        |            | Parity     |                   |          |
| CM → CPUx MSGRAM0               | 1K x 16  | 0x0003 8000   | 0x0003 83FF | Yes        |            | Parity     | Yes               | Yes      |
| CM → CPUx MSGRAM1               | 1K x 16  | 0x0003 8400   | 0x0003 87FF | Yes        |            | Parity     | Yes               |          |
| CPUx → CM MSGRAM0               | 1K x 16  | 0x0003 9000   | 0x0003 93FF | Yes        |            | Parity     | Yes               | Yes      |
| CPUx → CM MSGRAM1               | 1K x 16  | 0x0003 9400   | 0x0003 97FF | Yes        |            | Parity     | Yes               |          |
| CPU1 → CPU2 MSGRAM0             | 1K x 16  | 0x0003 A000   | 0x0003 A3FF | Yes        |            | Parity     | Yes               | Yes      |
| CPU1 → CPU2 MSGRAM1             | 1K x 16  | 0x0003 A400   | 0x0003 A7FF | Yes        |            | Parity     | Yes               |          |
| CPU2 → CPU1 MSGRAM0             | 1K x 16  | 0x0003 B000   | 0x0003 B3FF | Yes        |            | Parity     | Yes               | Yes      |
| CPU2 → CPU1 MSGRAM1             | 1K x 16  | 0x0003 B400   | 0x0003 B7FF | Yes        |            | Parity     | Yes               |          |
| USB RAM(2)                      | 2K x 16  | 0x0004 1000   | 0x0004 17FF | Yes        |            |            |                   |          |
| CAN A Message RAM               | 2K x 16  | 0x0004 9000   | 0x0004 97FF |            |            | Parity     |                   |          |
| CAN B Message RAM               | 2K x 16  | 0x0004 B000   | 0x0004 B7FF |            |            | Parity     |                   |          |
| TI OTP(4)                       | 1K x 16  | 0x0007 0000   | 0x0007 03FF |            |            | ECC        |                   |          |
| User OTP                        | 1K x 16  | 0x0007 8000   | 0x0007 83FF | Yes(3)     |            |            |                   |          |
| Flash                           | 256K x16 | 0x0008 0000   | 0x000B FFFF |            |            | ECC        | Yes               |          |
| Secure ROM                      | 32K x 16 | 0x003E 0000   | 0x003E 7FFF |            |            | Parity     |                   | Yes      |
| Boot ROM                        | 96K x 16 | 0x003E 8000   | 0x003F FFFF |            |            | Parity     |                   |          |
| Pie Vector Fetch Error          | 1 x 16   | 0x003F FFBE   | 0x003F FFBF |            |            | Parity     |                   |          |
| Default Vectors                 | 64 x 16  | 0x003F FFC0   | 0x003F FFFF |            |            | Parity     |                   |          |
| CLA Data ROM                    | 4K x 16  | 0x0100 1000   | 0x0100 1FFF |            |            |            |                   |          |


## C28x Flash Memory Map
| SECTOR                | SIZE     | START ADDRESS | END ADDRESS |
|------------------------|----------|---------------|-------------|
| **OTP Sectors**        |          |               |             |
| TI OTP                 | 1K x 16  | 0x0007 0000   | 0x0007 03FF |
| User OTP(1)            | 1K x 16  | 0x0007 8000   | 0x0007 83FF |
| **Flash Sectors**      |          |               |             |
| Sector 0               | 8K x 16  | 0x0008 0000   | 0x0008 1FFF |
| Sector 1               | 8K x 16  | 0x0008 2000   | 0x0008 3FFF |
| Sector 2               | 8K x 16  | 0x0008 4000   | 0x0008 5FFF |
| Sector 3               | 8K x 16  | 0x0008 6000   | 0x0008 7FFF |
| Sector 4               | 32K x 16 | 0x0008 8000   | 0x0008 FFFF |
| Sector 5               | 32K x 16 | 0x0009 0000   | 0x0009 7FFF |
| Sector 6               | 32K x 16 | 0x0009 8000   | 0x0009 FFFF |
| Sector 7               | 32K x 16 | 0x000A 0000   | 0x000A 7FFF |
| Sector 8               | 32K x 16 | 0x000A 8000   | 0x000A FFFF |
| Sector 9               | 32K x 16 | 0x000B 0000   | 0x000B 7FFF |
| Sector 10              | 8K x 16  | 0x000B 8000   | 0x000B 9FFF |
| Sector 11              | 8K x 16  | 0x000B A000   | 0x000B BFFF |
| Sector 12              | 8K x 16  | 0x000B C000   | 0x000B DFFF |
| Sector 13              | 8K x 16  | 0x000B E000   | 0x000B FFFF |
| **Flash ECC Locations**|          |               |             |
| TI OTP ECC             | 128 x 16 | 0x0107 0000   | 0x0107 007F |
| User OTP ECC           | 128 x 16 | 0x0107 1000   | 0x0107 107F |
| Flash ECC (Sector 0)   | 1K x 16  | 0x0108 0000   | 0x0108 03FF |
| Flash ECC (Sector 1)   | 1K x 16  | 0x0108 0400   | 0x0108 07FF |
| Flash ECC (Sector 2)   | 1K x 16  | 0x0108 0800   | 0x0108 0BFF |
| Flash ECC (Sector 3)   | 1K x 16  | 0x0108 0C00   | 0x0108 0FFF |
| Flash ECC (Sector 4)   | 4K x 16  | 0x0108 1000   | 0x0108 1FFF |
| Flash ECC (Sector 5)   | 4K x 16  | 0x0108 2000   | 0x0108 2FFF |
| Flash ECC (Sector 6)   | 4K x 16  | 0x0108 3000   | 0x0108 3FFF |
| Flash ECC (Sector 7)   | 4K x 16  | 0x0108 4000   | 0x0108 4FFF |
| Flash ECC (Sector 8)   | 4K x 16  | 0x0108 5000   | 0x0108 5FFF |
| Flash ECC (Sector 9)   | 4K x 16  | 0x0108 6000   | 0x0108 6FFF |
| Flash ECC (Sector 10)  | 1K x 16  | 0x0108 7000   | 0x0108 73FF |
| Flash ECC (Sector 11)  | 1K x 16  | 0x0108 7400   | 0x0108 77FF |
| Flash ECC (Sector 12)  | 1K x 16  | 0x0108 7800   | 0x0108 7BFF |
| Flash ECC (Sector 13)  | 1K x 16  | 0x0108 7C00   | 0x0108 7FFF |


## EMIF Chip Select Memory Map
| EMIF CS                      | SIZE     | START ADDRESS | END ADDRESS | CLA ACCESS | DMA ACCESS |
|-------------------------------|----------|---------------|-------------|------------|------------|
| EMIF1 CS0n – Data(1)          | 256M x16 | 0x8000 0000   | 0x8FFF FFFF | Yes        |            |
| EMIF1 CS0n – Program + Data(1)| 1M x 16  | 0x0020 0000   | 0x002F FFFF | Yes        |            |
| EMIF1 CS2n – Program + Data   | 2M x 16  | 0x0010 0000   | 0x002F FFFF | Yes        |            |
| EMIF1 CS3n – Program + Data   | 512K x16 | 0x0030 0000   | 0x0037 FFFF | Yes        |            |
| EMIF1 CS4n – Program + Data   | 393K x16 | 0x0038 0000   | 0x003D FFFF | Yes        |            |
| EMIF2 CS0n – Data(2)          | 32M x 16 | 0x9000 0000   | 0x91FF FFFF |            |            |
| EMIF2 CS2n – Program + Data(2)| 4K x 16  | 0x0000 2000   | 0x0000 2FFF | Data only  |            |


## CM Memory Map
| MEMORY                    | SIZE     | START ADDRESS | END ADDRESS | µDMA ACCESS | ENET DMA ACCESS | ECC/PARITY | ACCESS PROTECTION | SECURITY |
|----------------------------|----------|---------------|-------------|-------------|-----------------|------------|-------------------|----------|
| Boot ROM                   | 64K x 8  | 0x0000 0000   | 0x0000 FFFF |             |                 | Parity     | Yes(1)            |          |
| Secure ROM                 | 32K x 8  | 0x0001 0000   | 0x0001 7FFF |             |                 | Parity     | Yes(1)            | Yes      |
| Flash                      | 512K x 8 | 0x0020 0000   | 0x0027 FFFF |             |                 | ECC        | Yes(1)            | Yes      |
| TI OTP(2)                  | 2K x 8   | 0x0038 0000   | 0x0038 07FF |             |                 | ECC        | Yes(1)            |          |
| User OTP                   | 2K x 8   | 0x003C 0000   | 0x003C 07FF |             |                 | ECC        | Yes(1)            |          |
| C1 RAM                     | 8K x 8   | 0x1FFF C000   | 0x1FFF DFFF |             |                 | Parity     | Yes(1)            | Yes      |
| C0 RAM                     | 8K x 8   | 0x1FFF E000   | 0x1FFF FFFF |             |                 | Parity     | Yes(1)            | Yes      |
| S0 RAM                     | 16K x 8  | 0x2000 0000   | 0x2000 3FFF | Yes         | Yes             | Parity     | Yes(1)            |          |
| S1 RAM                     | 16K x 8  | 0x2000 4000   | 0x2000 7FFF | Yes         | Yes             | Parity     | Yes(1)            |          |
| S2 RAM                     | 16K x 8  | 0x2000 8000   | 0x2000 BFFF | Yes         | Yes             | Parity     | Yes(1)            |          |
| S3 RAM                     | 16K x 8  | 0x2000 C000   | 0x2000 FFFF | Yes         | Yes             | Parity     | Yes(1)            |          |
| E0 RAM                     | 16K x 8  | 0x2001 0000   | 0x2001 3FFF | Yes         | Yes             | ECC        | Yes(1)            |          |
| CPU1 → CM MSGRAM0          | 2K x 8   | 0x2008 0000   | 0x2008 07FF | Yes         | Yes             | Parity     | Yes(1)            | Yes      |
| CPU1 → CM MSGRAM1          | 2K x 8   | 0x2008 0800   | 0x2008 0FFF | Yes         | Yes             | Parity     | Yes(1)            |          |
| CM → CPU1 MSGRAM0          | 2K x 8   | 0x2008 2000   | 0x2008 27FF | Yes         | Yes             | Parity     | Yes(1)            | Yes      |
| CM → CPU1 MSGRAM1          | 2K x 8   | 0x2008 2800   | 0x2008 2FFF | Yes         | Yes             | Parity     | Yes(1)            |          |
| CPU2 → CM MSGRAM0          | 2K x 8   | 0x2008 4000   | 0x2008 47FF | Yes         | Yes             | Parity     | Yes(1)            | Yes      |
| CPU2 → CM MSGRAM1          | 2K x 8   | 0x2008 4800   | 0x2008 4FFF | Yes         | Yes             | Parity     | Yes(1)            |          |
| CM → CPU2 MSGRAM0          | 2K x 8   | 0x2008 6000   | 0x2008 67FF | Yes         | Yes             | Parity     | Yes(1)            | Yes      |
| CM → CPU2 MSGRAM1          | 2K x 8   | 0x2008 6800   | 0x2008 6FFF | Yes         | Yes             | Parity     | Yes(1)            |          |
| Bit Band RAM Zone          | 32M x 8  | 0x2200 0000   | 0x23FF FFFF | Yes         | Yes             | Parity     | Yes(1)            |          |
| CAN A Message RAM          | 4K x 8   | 0x4007 2000   | 0x4007 2FFF |             |                 | Parity     | Yes(1)            |          |
| CAN B Message RAM          | 4K x 8   | 0x4007 6000   | 0x4007 6FFF |             |                 | Parity     | Yes(1)            |          |
| MCAN Message RAM           | 17K x 8  | 0x4007 8000   | 0x4007 C3FF |             |                 | ECC        | Yes(1)            |          |
| EtherCAT RAM (direct access)| 16K x 8 | 0x400B 1000   | 0x400B 4FFF | Yes         | Yes             | Parity     | Yes(1)            |          |


## CM Flash Memory Map
| SECTOR                 | SIZE     | START ADDRESS | END ADDRESS |
|-------------------------|----------|---------------|-------------|
| **OTP Sectors**         |          |               |             |
| TI OTP                  | 2K x 8   | 0x0038 0000   | 0x0038 07FF |
| User OTP(1)             | 2K x 8   | 0x003C 0000   | 0x003C 07FF |
| **Flash Sectors**       |          |               |             |
| Sector 0                | 16K x 8  | 0x0020 0000   | 0x0020 3FFF |
| Sector 1                | 16K x 8  | 0x0020 4000   | 0x0020 7FFF |
| Sector 2                | 16K x 8  | 0x0020 8000   | 0x0020 BFFF |
| Sector 3                | 16K x 8  | 0x0020 C000   | 0x0020 FFFF |
| Sector 4                | 64K x 8  | 0x0021 0000   | 0x0021 FFFF |
| Sector 5                | 64K x 8  | 0x0022 0000   | 0x0022 FFFF |
| Sector 6                | 64K x 8  | 0x0023 0000   | 0x0023 FFFF |
| Sector 7                | 64K x 8  | 0x0024 0000   | 0x0024 FFFF |
| Sector 8                | 64K x 8  | 0x0025 0000   | 0x0025 FFFF |
| Sector 9                | 64K x 8  | 0x0026 0000   | 0x0026 FFFF |
| Sector 10               | 16K x 8  | 0x0027 0000   | 0x0027 3FFF |
| Sector 11               | 16K x 8  | 0x0027 4000   | 0x0027 7FFF |
| Sector 12               | 16K x 8  | 0x0027 8000   | 0x0027 BFFF |
| Sector 13               | 16K x 8  | 0x0027 C000   | 0x0027 FFFF |
| **Flash ECC Locations** |          |               |             |
| TI OTP ECC              | 256 x 8  | 0x0088 0000   | 0x0088 00FF |
| User OTP ECC            | 256 x 8  | 0x0088 8000   | 0x0088 80FF |
| Flash ECC (Sector 0)    | 2K x 8   | 0x0080 0000   | 0x0080 07FF |
| Flash ECC (Sector 1)    | 2K x 8   | 0x0080 0800   | 0x0080 0FFF |
| Flash ECC (Sector 2)    | 2K x 8   | 0x0080 1000   | 0x0080 17FF |
| Flash ECC (Sector 3)    | 2K x 8   | 0x0080 1800   | 0x0080 1FFF |
| Flash ECC (Sector 4)    | 8K x 8   | 0x0080 2000   | 0x0080 3FFF |
| Flash ECC (Sector 5)    | 8K x 8   | 0x0080 4000   | 0x0080 5FFF |
| Flash ECC (Sector 6)    | 8K x 8   | 0x0080 6000   | 0x0080 7FFF |
| Flash ECC (Sector 7)    | 8K x 8   | 0x0080 8000   | 0x0080 9FFF |
| Flash ECC (Sector 8)    | 8K x 8   | 0x0080 A000   | 0x0080 BFFF |
| Flash ECC (Sector 9)    | 8K x 8   | 0x0080 C000   | 0x0080 DFFF |
| Flash ECC (Sector 10)   | 2K x 8   | 0x0080 E000   | 0x0080 E7FF |
| Flash ECC (Sector 11)   | 2K x 8   | 0x0080 E800   | 0x0080 EFFF |
| Flash ECC (Sector 12)   | 2K x 8   | 0x0080 F000   | 0x0080 F7FF |
| Flash ECC (Sector 13)   | 2K x 8   | 0x0080 F800   | 0x0080 FFFF |
