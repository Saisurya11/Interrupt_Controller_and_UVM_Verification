# 🧩Verification of Parametrizable Interrupt Controller 

## Overview
This project presents a **parametrizable UVM-based verification environment** for a **priority Interrupt Controller**. Interrupts are ubiquitous in real-time systems, and mismanagement can lead to missed deadlines, system instability, or complete failure. This VIP ensures robust verification by simulating realistic interrupt scenarios, testing priority handling, and validating the design under corner cases.

---

## Features

- **Configurable Priorities**  
  Supports Increasing, Decreasing, and Random priority assignments for all channels.

- **Dynamic Interrupt Injection**  
  New interrupts can be injected while others are being serviced, ensuring real-world accuracy.

- **Constrained-Random Sequences**  
  All scenarios are tested using constrained-randomization for full functional coverage, including corner cases like simultaneous requests and nested interrupts.

- **Self-Checking Scoreboard**  
  A golden model compares expected vs actual behavior to detect subtle mismatches or errors.

- **Regression-Ready & Reusable**  
  Testbench designed for long-term use across multiple designs, supporting scalability and modularity.

- **Edge Case Handling**  
  Supports nested interrupts, priority inversion, and simultaneous interrupt bursts.

---

## Test Scenarios

1. **Priority Configurations**
   - Increasing order
   - Decreasing order
   - Random assignment

2. **Dynamic Interrupts**
   - Interrupts injected while servicing other channels  
   - Multiple simultaneous interrupt requests

3. **Functional Coverage**
   - Coverage metrics for all 16 channels  
   - Corner case and boundary condition coverage

---

## Industry Applicability

- **SoCs & Microcontrollers:** Ensures timely handling of critical interrupts in real-time embedded systems.  
- **FPGA Prototyping:** Verifies interrupt logic before hardware deployment.  
- **ASIC Verification:** Detects priority mismanagement, nested interrupts, and race conditions before tape-out.  
- **Multi-Core Systems:** Scalable environment that adapts to multi-core architectures with multiple interrupt sources.


