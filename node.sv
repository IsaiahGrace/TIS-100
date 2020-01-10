// Isaiah Grace
// This is the node

include "direction_port.vh"
include "types_pkg.vh"
import types_pkg::*;

module node
  (
   input logic CLK, nRST,
   direction_port.dir up, down, left, right,
   input i_t idata,
   input pc_t iaddr,
   input logic iwen, halt
   );

   pc_t pc;
   
   // Submodules
   acc ACC (.CLK(CLK),
	    .nRST(nRST),
	    .new_acc(), // word_t
	    .wen(),
	    .sav(),
	    .swp(),
	    .acc_out() // word_t
	    );
   
   alu ALU (.aluop(), // aluop_t
	    .operand_a(), // word_t
	    .operand_b(), // word_t
	    .result() // word_t
	    );
   
   irom IROM (.CLK(CLK),
	      .nRST(nRST),
	      .pc(pc), // pc_t
	      .instr(), // i_t
	      .idata(idata), // i_t
	      .iaddr(iaddr), // pc_t
	      .iwen(iwen)
	      );
   
   pc PC (.CLK(CLK),
	  .nRST(nRST),
	  .jump_pc(), // pc_t
	  .jump_pc_en(),
	  .halt(),
	  .stall()
	  .pc(pc) // pc_t
	  );
   
   nodeio NODEIO (.CLK(CLK),
		  .nRST(nRST),
		  .out_data(), // word_t
		  .in_data(), // word_t
		  .direction(), // direction_t
		  .tx(),
		  .rx(),
		  .tx_complete(),
		  .rx_complete(),
		  .up(up),
		  .down(down),
		  .left(left),
		  .right(right)
		  );
   
endmodule // node
