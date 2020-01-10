// Isaiah Grace
// This file defines the types used by the TIS-100 Node

`ifndef TYPES_PKG_VH
 `define TYPES_PKG_VH

package types_pkg;

   // The IROM_WIDTH specifies the number of bits for the PC and IADDR
   // The IROM_SIZE is the number of instructions each node can hold
   parameter IROM_WIDTH = 4;
   parameter IROM_SIZE = IROM_WIDTH ** 2;

   
   parameter WORD_SIZE = 11;   
   typedef logic [WORD_SIZE-1:0] word_t;

   typedef logic [IROM_WIDTH-1:0] pc_t;
   
   typedef struct packed {
      opcode_t     opcode;
      logic   	   sel;
      logic [10:0] imm;
   } i_t;

   typedef enum logic [1:0] {
			     XOR,
			     ADD,
			     SUB,
			     NEG
			     } aluop_t;

   typedef enum logic [2:0] {
			     UP,
			     DOWN,
			     LEFT,
			     RIGHT,
			     ANY,
			     LAST
			     } direction_t;
   
   
   // This enum defines the sources and destinations that can be used
   typedef enum logic [2:0] { 
			      NIL   = 3'b000, 
			      ACC   = 3'b001, 
			      LEFT  = 3'b010, 
			      RIGHT = 3'b011, 
			      UP    = 3'b100, 
			      DOWN  = 3'b101, 
			      ANY   = 3'b110,
			      LAST  = 3'b111 
			      } src_t;
   
   
   typedef enum logic [3:0] { 
			      XOR = 3'b0000, 
			      MOV = 3'b0001, 
			      SWP = 3'b0010, 
			      SAV = 3'b0011, 
			      ADD = 3'b0100, 
			      SUB = 3'b0101,
			      NEG = 3'b0110, 
			      JMP = 3'b0111, 
			      JEZ = 3'b1000, 
			      JNZ = 3'b1001, 
			      JGZ = 3'b1010, 
			      JLZ = 3'b1011, 
			      JRO = 3'b1100,
			      OR  = 3'b1101, 
			      AND = 3'b1110, 
			      SFT = 3'b1111 
			      } opcode_t;
   
endpackage // types_pkg
   
`endif
