# Flashing AVR Binary SW Builds

## Tools
### AVRDUDE
#### GitHub Repository
[avrdude](https://github.com/avrdudes/avrdude)
#### Tool Release Page
[Releases](https://github.com/avrdudes/avrdude/releases)
#### Documentation
[User Manual](avrdude.pdf)

#### Flash Instruction
##### Windows
Set to bootloader (if not flashed initially).
The COM port number can be found within the windows device manager.
The Leonardo is tricky - it needs to be reset into bootloader mode before flashing, which is done by opening its serial port at 1200 baud and closing it GitHub. You have about 10 seconds to run avrdude after this.
```
mode COMx BAUD=1200 PARITY=N DATA=8 STOP=1
```
Command Breakdown:

- `-p m32u4` Target chip
- `-c avr109` Programmer protocol (the Leonardo's bootloader) GNU
- `-P /dev/ttyACM0` Serial port (use COM3, COM4, etc. on Windows)
- `-b 57600` Baud rate
- `-D` Disable chip erase (faster, preserves bootloader)
- `-U flash:w:main.hex:i` Write hex file to flash memory

Example command line instruction for a ATmega32U4 flash (if device is within bootloader mode)
```cmd
avrdude -p m32u4 -c avr109 -P COMx -b 57600 -D -U flash:w:<path-to-hex-folder>\app.hex:i
```
Command Breakdown:

- `-p m32u4` Target chip
- `-c avr109` Programmer protocol (the Leonardo's bootloader) GNU
- `-P /dev/ttyACM0` Serial port (use COM3, COM4, etc. on Windows)
- `-b 57600` Baud rate
- `-D` Disable chip erase (faster, preserves bootloader)
- `-U flash:w:main.hex:i` Write hex file to flash memory