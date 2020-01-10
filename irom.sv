// Isaiah Grace
// This is the Instruction Read Only Memory (IROM) that holds the micro-code for the node

include "types_pkg.vh"

import types_pkg::*;

module irom
  (
   input logic CLK, nRST,
   input       pc_t pc,
   output      i_t instr,
   input       i_t idata,
   input       pc_t iaddr,
   input logic iwen,
   );

   i_t irom_data [IROM_SIZE-1:0];
   i_t nxt_irom_data [IROM_SIZE-1:0];
   
   assign instr = irom_data[pc];

   always_comb
     begin
	nxt_irom_data = irom_data;
	
	if (iwen)
	  nxt_irom_data[iaddr] = idata;
     end
   
   always_ff @(posedge CLK, negedge nRST)
     begin
	if (!nRST)
	  irom_data <= '0;
	else
	  irom_data <= nxt_irom_data;
     end
endmodule // irom
