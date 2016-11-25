//7 bit LFSR with polynomial: 1 + X + X^7
module LFSR_7(clock, outnext);
	input clock;
	output [6:0] outnext;
	reg [6:0] outputnext;
	
	initial outputnext = 7'b1;
	
	always @ (posedge clock)

		outputnext <= {outputnext[6:0], (outputnext[6] ^ outputnext[0])};
	
	assign outnext = outputnext;
endmodule
