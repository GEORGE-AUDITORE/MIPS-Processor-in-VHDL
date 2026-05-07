# MIPS Processor in VHDL

A university project focused on the design and implementation of a simplified **single-cycle MIPS processor** using **VHDL** and simulated through **ModelSim**.

The project follows a **Harvard Architecture** approach, utilizing separate instruction and data memories, and demonstrates the fundamental operation of a CPU datapath, control logic, and arithmetic execution pipeline.

---

## Overview

This project implements a simplified MIPS CPU capable of executing a subset of MIPS instructions through a single-cycle architecture.

The processor was developed modularly, with each hardware component implemented as an independent VHDL module and verified using dedicated testbenches.

The goal of the project was to understand:

- CPU datapath design
- Control unit implementation
- Register operations
- ALU functionality
- Memory access
- Branching logic
- Hardware simulation and testing using ModelSim

---

## Features

### Implemented Components

- Program Counter (PC)
- Instruction Memory
- Data Memory
- Register File
- Arithmetic Logic Unit (ALU)
- Main Control Unit
- ALU Control Unit
- Sign Extension Unit
- Shift Left Unit
- Adders
- Multiplexers
- Branch Logic

---

## Supported Instructions

| Instruction | Description |
|---|---|
| `add` | Register addition |
| `addi` | Immediate addition |
| `sw` | Store word |
| `beq` | Branch if equal |
| `bne` | Branch if not equal |

---

## Architecture

The CPU is implemented as a:

- **Single-Cycle Processor**
- **Harvard Architecture**
  - Separate Instruction Memory
  - Separate Data Memory

Every instruction completes execution in a single clock cycle.

---

## Project Structure

```text
├── ALU.vhd
├── ALUcontrol.vhd
├── Control.vhd
├── PC.vhd
├── Registerfile.vhd
├── Datamem.vhd
├── Imem.vhd
├── Signextension.vhd
├── Leftshift.vhd
├── Adder32.vhd
├── 32mux2to1.vhd
├── 5Mux2to1.vhd
├── MIPS.vhd
│
├── Testbenches
│   ├── ALU_tb.vhd
│   ├── Control_tb.vhd
│   ├── Registerfile_tb.vhd
│   ├── Datamem_tb.vhd
│   ├── Imem_tb.vhd
│   └── ...
│
└── README.md
```

---

## Testing & Simulation

Each major hardware module includes its own dedicated testbench for verification.

Testing was performed using:

- **ModelSim**
- VHDL simulations
- Waveform analysis

The final integrated processor was tested through the top-level `MIPS.vhd` module.

---

## Technologies Used

- **VHDL**
- **ModelSim**
- Digital Logic Design Principles
- MIPS Architecture Concepts

---

## Learning Objectives

Through this project, the following concepts were explored:

- CPU architecture fundamentals
- Hardware description languages
- Sequential and combinational logic
- Control signal generation
- Memory interaction
- Simulation and debugging of digital systems

---

## How to Run

### Requirements

- ModelSim (or compatible VHDL simulator)

### Steps

1. Clone the repository:

```bash
git clone <repository-url>
```

2. Open the project in ModelSim

3. Compile all `.vhd` files

4. Run the desired testbench:

```tcl
vsim work.ALU_tb
run -all
```

Or simulate the complete processor:

```tcl
vsim work.MIPS
run -all
```

---

## Notes

This project was developed as part of a university Digital Systems / Computer Architecture course and is intended for educational purposes.

---

## Author

Developed by George Auditore as a university project.
