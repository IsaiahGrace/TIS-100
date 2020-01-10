// Isaiah Grace
// This is the node

include "direction_port.vh"
include "types_pkg.vh"
import types_pkg::*;

module node
  (
   input logic CLK, nRST,
   direction_port.dir up, down, left, right,
   input       i_t idata,
   input       pc_t iaddr,
   input logic iwen, halt
   );

   // Main signals
   pc_t   pc;
   word_t acc;
   word_t new_acc;
   i_t    instr;
   src_t  src, dst;
      
   // ACC related
   logic  acc_ovwrt;
   logic  acc_sav;
   logic  acc_swp;

   // ALU related
   aluop_t aluop;
   word_t  alu_operand_a, alu_operand_b, alu_result;

   // IROM related

   // PC related
   pc_t   jump_pc;
   logic  jump_pc_en;
   logic  pc_stall;

   // NODEIO related
   word_t out_data, in_data;
   direction_t direction;
   logic  tx, rx, tx_complete, rx_complete;
   
   
   // Assigns
   // NOTE:
   // bit 3 is unused, 
   // this is so HEX representations of the instructions will be easier to read
   assign src = instr.imm[2:0];
   assign dst = instr.imm[6:4]; 

   
   // Submodules
   acc ACC (.CLK(CLK),
	    .nRST(nRST),
	    .new_acc(new_acc), // word_t
	    .wen(acc_ovwrt),
	    .sav(acc_sav),
	    .swp(acc_swp),
	    .acc_out(acc) // word_t
	    );
   
   alu ALU (.aluop(aluop), // aluop_t
	    .operand_a(alu_operand_a), // word_t
	    .operand_b(alu_operand_b), // word_t
	    .result(alu_result) // word_t
	    );
   
   irom IROM (.CLK(CLK),
	      .nRST(nRST),
	      .pc(pc), // pc_t
	      .instr(instr), // i_t
	      .idata(idata), // i_t
	      .iaddr(iaddr), // pc_t
	      .iwen(iwen)
	      );
   
   pc PC (.CLK(CLK),
	  .nRST(nRST),
	  .jump_pc(jump_pc), // pc_t
	  .jump_pc_en(jump_pc_en),
	  .halt(halt),
	  .stall(pc_stall)
	  .pc(pc) // pc_t
	  );
   
   nodeio NODEIO (.CLK(CLK),
		  .nRST(nRST),
		  .out_data(out_data), // word_t
		  .in_data(in_data), // word_t
		  .direction(direction), // direction_t
		  .tx(tx),
		  .rx(rx),
		  .tx_complete(tx_complete),
		  .rx_complete(rx_complete),
		  .up(up),
		  .down(down),
		  .left(left),
		  .right(right)
		  );
   
endmodule // node
