# RISC-V Single-Cycle Processor

This project implements a RISC-V single-cycle processor using Verilog HDL.

## Folder Structure
- src/  : RTL source files
- tb/   : Testbench
- docs/ : Diagrams

## Simulation
iverilog -o sim src/*.v tb/processor_tb.v
vvp sim
