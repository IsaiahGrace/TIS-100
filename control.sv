// Isaiah Grace
// This is the control module for the TIS-100 node

include "types_pkg.vh"
import types_pkg::*;

module control
  (
   input 	i_t instr,
   input 	word_t acc,
   input logic 	tx_complete, rx_complete,
   output 	aluop_t aluop,
   output logic tx, rx,
   output logic acc_ovwrt, acc_sav, acc_swp,
   output logic jump_pc_en, pc_stall
   );
   
   always_comb
     begin
	tx = '0;
	rx = '0;
	acc_ovwrt = '0;
	acc_sav = '0;
	acc_swp = '0;
	aluop = aluop_t('0);
	jump_pc_en ='0;
	pc_stall = '0;

	case(instr.opcode)
	  XOR:
	    begin
	       aluop = XOR;
	    end
	  MOV:
	    begin
	    end
	  SWP:
	    begin
	       acc_swp = 1'b1;
	    end
	  SAV:
	    begin
	    end
	  ADD:
	    begin
	       aluop = ADD;
	    end
	  SUB:
	    begin
	       aluop = SUB;
	    end
	  NEG:
	    begin
	       aluop = NEG;
	    end
	  JMP:
	    begin
	    end
	  JEZ:
	    begin
	    end
	  JNZ:
	    begin
	    end
	  JGZ:
	    begin
	    end
	  JLZ:
	    begin
	    end
	  JRO:
	    begin
	    end
	  OR:
	    begin
	       aluop = OR;
	    end
	  AND:
	    begin
	       aluop = AND;
	    end
	  SFT:
	    begin
	       aluop = SFT;
	    end
	endcase // case (instr.opcode)
     end // always_comb
endmodule // control

		
