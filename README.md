# RISC-V 3-Stage Pipeline Processor Core

A 3-stage pipelined RISC-V (RV32I) processor core in SystemVerilog, with a forwarding/
hazard unit, partial machine-mode CSRs, and FPGA demo peripherals (UART, seven-segment
display). Pipeline stages: **Fetch | Decode-Execute | Memory-Writeback**.

## Repository layout

```
rtl/
  core/         datapath, control, ALU, register file, pipeline registers,
                CSR, load/store unit, instruction/data memories, hazard unit
  peripherals/  UART stack, seven-segment stack, clock divider
  top/          RISCV.sv  — FPGA top level
verif/
  tb/           SystemVerilog testbenches (tb_RISCV, tb_UART, tb_sevenSeg)
  arch-test/    placeholder for future RISC-V architectural test integration (stub)
sim/            Verilator filelists (core.f, design.f); build output (gitignored)
sw/             demo program/data memory images (*.mem)
docs/           design notes and planning specs
Makefile        Verilator lint / sim entry points
```

## Prerequisites

- [Verilator](https://verilator.org) 5.x (tested with 5.042)
- A C++ toolchain (for the Verilated binary)

## Usage

```bash
make lint    # lint the synthesizable core (Datapath hierarchy)
make sim     # compile + simulate the full design testbench (tb_RISCV)
make run     # re-run the already-built simulation
make clean   # remove build artifacts
```

The instruction/data memories are parameterized (`INIT_FILE` / `DEPTH`) and can be
loaded at run time via plusargs:

```bash
./sim/obj_dir/Vtb_RISCV +imem=sw/Instructions.mem +dmem=sw/DataMemory.mem
```

## Architectural tests (RV32I) — stub

Validating the core against the official `riscv-arch-test` suite is planned but not yet
implemented. `make arch-test` currently prints a stub message; see
[`verif/arch-test/README.md`](verif/arch-test/README.md) for the intended approach and
the known RTL gaps to close first.
