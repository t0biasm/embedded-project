# C2000 SW Platform
SW Platform for SW builds supporting the Texas Instruments C2000 MCU family

## Build Commands
- Build SW project
```starlark
bazel build --config=c2000 //machine/evalBoard/tmdscncd28p65x/swe/app:app
bazel build --config=atmega32u4 //machine/evalBoard/arduinoLeonardo:app
```

## Prerequisites
- Installed TI CL2000 compilation tooling. Location path: C:/tools/cl2000.zip \
[C2000 CGT](https://www.ti.com/tool/download/C2000-CGT/22.6.0.LTS)
