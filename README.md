# TIS-100
This SystemVerilog implementation of the Zachtronics archetecture outlined in the TIS-100 game manual aims to be backwards compatable, and include *enough* features to be reasonably useful.

## 16-bit opcode format
4 bits for opcode. 1 bit to select immedeate value (1) or \<SRC\> (0). 11 bit data word or <SRC>.

## 11-bit word size
The TIS-100 game by Zachtronics supports numbers -999 to 999. This implimentation uses an 11-bit signed data word allowing values from -1024 to 1023.

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

  SUB subtracts the \<SRC\> or immedeate value from the ACC and stores the result in the ACC.
  
  | 0101 | SEL | [10:0]     |
  |------|-----|------------|
  | SUB  |  0  | \<SRC\>    |
  | SUB  |  1  | 11-bit imm |

### **NEG**

  NEG negates the signed value of the ACC.
    
### **JMP**

  JMP is an unconditional jump of the program counter. The lowest 4 bits of the immedeate value are the new program counter.
  `PC <= imm[3:0]`
    
### **JEZ**

  JEZ is a conditional jump which will take the lowest four bits of the immedeate value as the new program counter if the value of the ACC is zero.
  `PC <= (ACC == 0) ? imm[3:0] : PC + 1`  
  
### **JNZ**

  JNZ is a conditional jump which will take the lowest four bits of the immedeate value as the new program counter if the value of the ACC is not zero.
  `PC <= (ACC != 0) ? imm[3:0] : PC + 1`
  
### **JGZ**

  `PC <= (ACC > 0) ? imm[3:0] : PC + 1`
  
### **JLZ**

  `PC <= (ACC < 0) ? imm[3:0] : PC + 1`
  
### **JRO**

  JRO is a jump relative offset, which takes a signed 11-bit immedeate value and adds it to the current PC. Note, in this implimentation, JRO 0 will jump to the current instruction.
  
  `PC = PC + imm`
  
### **OR**

  This is a bitwise OR of the \<SRC\> or the immedeate value and the ACC. This opcode is not available in the video game version of the TIS-100.
  
  | 1101 | SEL | [10:0]     |
  |------|-----|------------|
  | OR   |  0  | \<SRC\>    |
  | OR   |  1  | 11-bit imm |
  
### **AND**

  This is a bitwise AND of the \<SRC\> or the immedeate value and the ACC. This opcode is not available in the video game version of the TIS-100.
  
  | 1110 | SEL | [10:0]     |
  |------|-----|------------|
  | AND  |  0  | \<SRC\>    |
  | AND  |  1  | 11-bit imm |

### **SFT**
  
  This is a signed shift of the ACC to the right. That is to say, positive values will behave like a signed shift to the right, and negative values will behave like a signed shift to the left. This opcode is not available in the video game verison of the TIS-100.
  
  | 1111 | SEL | [10:0]     |
  |------|-----|------------|
  | SFT  |  0  | \<SRC\>    |
  | SFT  |  1  | 11-bit imm |
  
