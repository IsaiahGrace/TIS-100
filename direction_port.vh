// Isaiah Grace

`ifndef DIRECTION_PORT_VH
 `define DIRECTION_PORT_VH

 `include "types_pkg.vh"
import types_pkg::*;

interface direction_port;
   word_t rdata, wdata;
   logic ren, wen, rack, wack;

   modport dir (
		input rdata, ren, wack,
		output wdata, wen, rack
		);
endinterface // direction_port

`endif //  `ifndef DIRECTION_PORT_VH
