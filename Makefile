# RISC-V 3-stage pipeline core — Verilator build/sim
# Targets:
#   make lint       lint the synthesizable core (Datapath hierarchy)
#   make sim        compile + simulate the full design testbench (tb_RISCV)
#   make run        run the already-built simulation
#   make arch-test  (stub) RISC-V architectural test integration — not yet implemented
#   make clean      remove build artifacts

VERILATOR ?= verilator

# Lint is clean with no warning suppressions. (--timing is needed for the
# delays/event-controls in the testbench; the two genuinely-intentional
# constructs in ControlStatusReg use scoped /* verilator lint_off */ pragmas.)
VFLAGS ?=

CORE_F   := sim/core.f
DESIGN_F := sim/design.f
TOP      := tb_RISCV
SIM_BIN  := sim/obj_dir/V$(TOP)

# Demo program/data images loaded into the parameterized memories at run time.
IMEM ?= sw/Instructions.mem
DMEM ?= sw/DataMemory.mem

.PHONY: lint sim run wave arch-test clean

lint:
	$(VERILATOR) --lint-only $(VFLAGS) -f $(CORE_F) --top-module Datapath

$(SIM_BIN): $(DESIGN_F) $(wildcard rtl/core/*.sv) $(wildcard rtl/peripherals/*.sv) rtl/top/RISCV.sv verif/tb/tb_RISCV.sv
	$(VERILATOR) --binary --timing $(VFLAGS) -f $(DESIGN_F) \
		--top-module $(TOP) --Mdir sim/obj_dir -o V$(TOP)

sim: $(SIM_BIN) run

run: $(SIM_BIN)
	@# tb_RISCV terminates with $stop (Verilator returns non-zero); that is the
	@# testbench's intended end, so don't treat it as a build failure.
	-$(SIM_BIN) +imem=$(IMEM) +dmem=$(DMEM)

wave:
	@echo "Build with --trace and open the dumped .vcd in gtkwave."

# --- Stub -------------------------------------------------------------------
# Architectural-test (riscv-arch-test / RISCOF / ACT4) integration is planned
# but not yet implemented. See verif/arch-test/README.md.
arch-test:
	@echo "[stub] arch-test integration not implemented yet — see verif/arch-test/README.md"

clean:
	rm -rf sim/obj_dir sim/*.vcd
