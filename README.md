# 🚀 RISC-V 32-bit Pipelined Processor Core

A custom 5-stage pipelined RISC-V (RV32I) processor core implemented from scratch in SystemVerilog. 

## 📌 Overview
This project is an educational implementation of the RISC-V architecture. It starts as a Single-Cycle design and is gradually being upgraded to a fully pipelined architecture to explore computer organization, instruction decoding, and datapath routing concepts.

## 🏗️ Architecture Details
* **Instruction Set:** RV32I
* **Data Width:** 32-bit
* **Design Language:** SystemVerilog
* **Reference:** *Digital Design and Computer Architecture, RISC-V Edition* (Sarah L. Harris & David Money Harris)

## 🚧 Current Progress
- [x] Control Unit (Main Decoder & ALU Decoder)
- [ ] Arithmetic Logic Unit (ALU)
- [ ] Register File
- [ ] Datapath Routing (Single-Cycle)
- [ ] Pipeline Registers (IF/ID, ID/EX, EX/MEM, MEM/WB)
- [ ] Hazard Unit (Forwarding & Stalling)

## 🛠️ Tools Used
* **Simulation & Synthesis:** Xilinx Vivado
* **Version Control:** Git
