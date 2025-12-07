# Embedded Project
Repository for embedded software development

## Build Commands
- Build SW project
```starlark
bazel build --config=c28 //machine/evalBoard/tmdscncd28p65x/swe/app:app
bazel build --config=atmega32u4 //machine/evalBoard/arduinoLeonardo:app
```

## Prerequisites
- Bazel version 8.1.1
- Installed TI CL2000 compilation tooling. Location path: C:/tools/cl2000.zip \
[C2000 CGT](https://www.ti.com/tool/download/C2000-CGT/22.6.0.LTS)

## MCU
Under following link, MCU specific sheets can be found \
[F28P650DK9 Documentation](https://dev.ti.com/tirex/explore/node?node=A__ACuCzyjm65lS7oGVsP08EQ__c2000ware_devices_package__coGQ502__LATEST)

Used F28P65 driver library (MCAL) version: v5.05.00.00 \
[F28P65XxMCAL](https://github.com/TexasInstruments/c2000ware-core-sdk/tree/REL_C2000Ware_v5.05.00.00/driverlib/f28p65x/driverlib)

Technical reference manual \
[F28P65x Technical Reference Manual](https://www.ti.com/lit/ug/spruiz1b/spruiz1b.pdf?ts=1761634546685&ref_url=https%253A%252F%252Fdev.ti.com%252F)

## Test Setup

### Daughter Card/Docking Station
[TMDSHSECDOCK](https://www.ti.com/lit/ug/spruij6a/spruij6a.pdf?ts=1761663995340)

### Evaluation Board
[TMDSCNCD28P65X](https://www.ti.com/lit/ug/spruj90b/spruj90b.pdf?ts=1761617006565)

