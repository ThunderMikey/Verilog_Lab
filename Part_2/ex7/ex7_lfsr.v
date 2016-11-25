//7 bit LFSR with polynomial: 1 + X + X^7
module LFSR_7(clock, outnext);
	input clock;
	output [6:0] outnext;
	reg [6:0] outnext;
	
	initial outnext = 7'b1;
	
	always @ (posedge clock)
		begin
		outnext <= {outnext[5:0], (outnext[6] ^ outnext[0])};
		end

endmodule
