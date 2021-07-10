# GHDL + Xilinx project template using makefiles

## Root
Source is supposed to be located in `src/` and testbenches in `testbench/`.
Makefile supports compiling using ghdl, starting the program for specified
time and viewing the result in wave viewer.

## Xil folder
In `xil` folder, makefile for Xilinx _toolchain_ can be found.
It supports everything from synthesis to uploading bit file
to the device.

## Setup
For setup, top level entity has to be set in root `Makefile`.

For xil setup, no special need is except from installing dependencies.

## Dependencies
- root
  - ghdl
  - gtkview
- xil
  - xflow (for synthesis, implementation and config)
  - impact (for flashing on device)

