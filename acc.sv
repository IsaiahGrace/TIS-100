// Isaiah Grace
// ACC and BAK registers stored here

module acc
  (
   input logic 	       CLK,
   input logic 	       nRST,
   input logic [10:0]  new_acc,
   input logic 	       wen, sav, swp,
   output logic [10:0] acc_out
   );

   logic [10:0]        nxt_acc, acc;
   logic [10:0]        nxt_bak, bak;
   
   assign acc_out = acc;
   
   always_comb
     begin
	nxt_acc = acc;
	nxt_bak = bak;

	casez({wen,sav,swp})
	  3'b001:
	    begin
	       nxt_acc = bak;
	       next_bak = acc;
	    end
	  3'b01?: next_bak = acc;
	  3'b1??: next_acc = new_acc;
	endcase // casez ({wen,sav,swp})
     end // always_comb

   always_ff @(posedge CLK, negedge nRST)
     begin
	if (!nRST)
	  begin
	     acc <= '0;
	     bak <= '0;
	  end
	else
	  begin
	     acc <= nxt_acc;
	     bak <= nxt_bak;
	  end
     end // always_ff @ (posedge CLK, negedge nRST)
endmodule // acc
