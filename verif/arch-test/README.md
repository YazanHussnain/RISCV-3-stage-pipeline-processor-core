# Architectural Test Integration (stub)

This directory is a placeholder for future RISC-V architectural test integration
(validating the core against the RV32I instruction set using the official
`riscv-arch-test` suite).

**Status: not implemented.** `make arch-test` currently prints a stub message.

## Background / options for later

The upstream `riscv-arch-test` repo has two generations:

- **RISCOF era (≤ 3.x):** signature-compare flow. Compile each test, run on the DUT
  and on a reference model (Spike/Sail), diff the dumped signature region. Lighter DUT
  requirements (minimal boot).
- **ACT4 (v4.0.0, 2026):** replaces RISCOF. Uses the UDB toolchain (uv + Ruby + the
  `udb` gem) to generate self-checking ELFs, with **Sail** as the mandatory reference
  model. Boots every test through `RVTEST_BOOT_TO_MMODE`, so it requires a fairly
  complete machine-mode CSR + trap implementation in the DUT.

## What integration would need from this core

A sim-only top-level harness that:
1. loads a compiled test image into the (word-addressed) instruction/data memories,
2. detects test completion (e.g. a store to a `tohost` address), and
3. dumps the signature region for comparison.

Known RTL gaps to close before the RV32I suite can pass:
- complete Zicsr (`csrrw/csrrs/csrrc` + immediate forms, `mscratch`) and machine-mode
  trap entry/`mret` (required by the ACT4 environment),
- treat `FENCE` as a NOP,
- robust `ECALL`/`EBREAK` decode,
- the store-routing path keys UART selection off `instruction[31]`, which misroutes
  ordinary stores with negative immediates — needs address-based decode instead.

The core's memories are already parameterized (`INIT_FILE` / `DEPTH`, with `+imem=` /
`+dmem=` plusargs), which is the main hook a future harness needs.
