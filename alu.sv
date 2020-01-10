// Isaiah Grace
// This module is the alu for the node

include "types_pkg.vh"
import types_pkg::*;

module alu
  (
   input aluop_t aluop,
   input word_t operand_a, operand_b,
   output word_t result
   );

   always_comb
     case (aluop)
       XOR: result = operand_a ^ operand_b;
       ADD: result = operand_a + operand_b;
       SUB: result = operand_a - operand_b;
       NEG: result = ~operand_a + 1;
     endcase // case (aluop)
endmodule // alu
