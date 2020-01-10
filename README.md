# TIS-100
This SystemVerilog implementation of the Zachtronics archetecture outlined in the TIS-100 game manual aims to be backwards compatable, and include *enough* features to be reasonably useful.

## 16-bit opcode format
4 bits for opcode. 1 bit to select immedeate value (1) or \<SRC\> (0). 11 bit data word or <SRC>.

## 11-bit word size
The TIS-100 game by Zachtronics 

## ISA
### **NOP/XOR**

  NOP/XOR is a two purpose instruction. In order to be backwards compatable with the game manual, a NOP instruction is all zeros. This transaltes into an XOR of the ACC and the NIL source. Zero is the identity element of XOR and therefore the the opcode will not alter the state of the node and a NOP will be executed.
 
 |  0000   | SEL | [10:0]           |
 |---------|-----|------------------| 
 | NOP/XOR |  0  | \<SRC\>          |
 | NOP/XOR |  1  | 11-bit immedeate |
 
### **MOV**

MOV has three modes:
  1. MOV \<SRC\>, \<DST\>
  2. MOV \<SRC\>, 8-bit imm (sign extended)
  3. MOV \<ACC\>, 11-bit imm
  
  | 0001 | SEL | [10:0]              |
  |------|-----|---------------------|
  | MOV  |  0  | \<SRC\>, \<DST\>    |
  | MOV  |  0  | \<ACC\>, 11-bit imm |
  | MOV  |  1  | \<SRC\>, 8-bit imm  |
  
### **SWP**
  
  SWP swaps the ACC and BAK registers, this is one of two ways to access the BAK register.
  
  | 0010 | SEL | [10:0] |
  |------|-----|--------|
  | SWP  | N/A | N/A    |
  
### **SAV**

  SAV writes the ACC to the BAK, overwriting the contents of the BAK register. 
  
  | 0011 | SEL | [10:0] |
  |------|-----|--------|
  | SAV  | N/A | N/A    |
  
### **ADD**

  ADD adds the \<SRC\> or immedeate value to the ACC and stores the result in the ACC.
  
  | 0100 | SEL | [10:0]     |
  |------|-----|------------|
  | ADD  |  0  | \<SRC\>    |
  | ADD  |  1  | 11-bit imm |
  
### **SUB**
### **NEG**
### **JMP**
### **JEZ**
### **JNZ**
### **JGZ**
### **JLZ**
### **JRO**
### **OR**
### **AND**
### **SFT**
