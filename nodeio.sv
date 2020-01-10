// Isaiah Grace
// This module contains the node IO logic as well as the ANY/LAST logic

include "direction_port.vh"

include "types_pkg.vh"
import types_pkg::*;

module nodeio
  (
   input logic CLK, nRST,
   input       word_t out_data,
   output      word_t in_data,
   input       direction_t direction,
   input logic tx, rx,
   output logic tx_complete, rx_complete,
	       direction_port.dir up, down, left, right
   );

   assign up.wdata = out_data;
   assign down.wdata = out_data;
   assign left.wdata = out_data;
   assign right.wdata = out_data;
   
   always_comb
     begin
	case(direction)
	  UP:
	    begin
	       in_data = up.rdata;
	       rx_complete = rx & up.ren;
	       up.rack = rx_complete;
	       up.wen = tx;
	       tx_complete = up.wack;
	    end
	  DOWN:
	    begin
	       in_data = down.rdata;
	       rx_complete = rx & down.ren;
	       down.rack = rx_complete;
	       down.wen = tx;
	       tx_complete = down.wack;
	    end
	  LEFT:
	    begin
	       in_data = left.rdata;
	       rx_complete = rx & left.ren;
	       left.rack = rx_complete;
	       left.wen = tx;
	       tx_complete = left.wack;
	    end
	  RIGHT:
	    begin
	       in_data = right.rdata;
	       rx_complete = rx & right.ren;
	       right.rack = rx_complete;
	       right.wen = tx;
	       tx_complete = right.wack;
	    end
	  ANY:
	    begin
	    end
	  LAST:
	    begin
	    end
	endcase // case (direction)
     end // always_comb

endmodule // nodeio
