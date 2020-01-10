// Isaiah Grace
// This is the program counter for the node

include "types_pkg.vh"
import types_pkg::*;

module pc
  (
   input logic CLK, nRST,
   input       pc_t jump_pc,
   input logic halt, stall, jump_pc_en
   output      pc_t pc
   );
   
   pc_t nxt_pc;
   
   assign nxt_pc = halt ? '0 : 
		   stall ? pc : 
		   jump_pc_en ? jump_pc : 
		   pc + 1;
   
   always_ff @(posedge CLK, negedge nRST)
     begin
	if (!nRST)
	  pc <= '0;
	else
	  pc <= nxt_pc;
     end
endmodule // pc
