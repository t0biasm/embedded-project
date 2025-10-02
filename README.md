# Embedded Project
Repository for embedded software development

## Build Commands
- Build SW project
```starlark
bazel build --config=f2838 //f2838/swe/app:app
```

## Prerequisites
- Bazel version 8.1.1
- Installed TI CL2000 compilation tooling. Location path: C:/tools/cl2000.zip \
[C2000 CGT](https://www.ti.com/tool/download/C2000-CGT/22.6.0.LTS)

## MCU
Under following link, MCU specific sheets can be found \
[F28388D Documentation](https://dev.ti.com/tirex/explore/node?node=A__AJ2S52t6KipWImg.HzDMUw__c2000ware_devices_package__coGQ502__LATEST)

Used F2838 driver library (MCAL) version: v5.05.00.00 \
[F2838x MCAL](https://github.com/TexasInstruments/c2000ware-core-sdk/tree/REL_C2000Ware_v5.05.00.00/driverlib/f2838x/driverlib_cm)

Technical reference manual \
[F2838x Technical Reference Manual](https://www.ti.com/document-viewer/lit/html/spruii0)

