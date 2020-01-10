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

   // Some internal registers to take care of the NEXT and LAST directions
   direction_t pseudo_direction;
   logic [1:0] 	any_direction;
   logic [1:0] 	nxt_any_direction;
   logic [1:0] 	last_direction;
   logic [1:0] 	nxt_last_direction;
   logic 	last_valid;
   logic 	nxt_last_valid;
   
      
   assign up.wdata = out_data;
   assign down.wdata = out_data;
   assign left.wdata = out_data;
   assign right.wdata = out_data;

   // ANY + LAST direction logic
   always_comb 
     begin
	// Defaults, ALWAYS be incrimenting the ANY direction
   	nxt_any_direction = any_direction + 1;
	nxt_last_direction = last_direction;
	nxt_last_valid = last_valid;
	
	// last direction
	if (direction == LAST && (tx_complete || rx_complete))
	  begin
	     nxt_last_direction = pseudo_direction[1:0];
	     nxt_last_valid = 1'b1;
	  end
     end


   // pseudo_direction logic
   always_comb
     begin
	pseudo_direction = direction;
	
	if (direction == ANY)
	  pseudo_direction = direction_t'({1'b0, any_direction});
	
	if (direction == LAST)
	  pseudo_direction = direction_t'({1'b0, last_direction});
     end

   // Output logic
   always_comb
     begin
	// Default outputs
	in_data = '0;
	rx_complete = '0;
	tx_complete = '0;
	up.rack = '0;
	up.wen = '0;
	down.rack = '0;
	down.wen = '0;
	left.rack = '0;
	left.wen = '0;
	right.rack = '0;
	right.rack = '0;
				  
	case(pseudo_direction)
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
	endcase // case (direction)
     end // always_comb
   
   always_ff @(posedge CLK, negedge nRST)
     begin
	if (!nRST)
	  begin
	     any_direction <= '0;
	     last_direction <= '0;
	     last_valid <= '0;
	  end
	else
	  begin	
	     any_direction <= nxt_any_direction;
	     last_direction <= nxt_last_direction;
	     last_valid <= nxt_last_valid;
	  end
     end // always_ff @ (posedge CLK, negedge nRST)
   
endmodule // nodeio
