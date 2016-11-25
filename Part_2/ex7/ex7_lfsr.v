//7 bit LFSR with polynomial: 1 + X + X^7
module LFSR_7(clock, outnext);
	input clock;
	output [7:1] outnext;
	reg [7:1] outputnext;
	
	initial outputnext = 7'b1;
	
	always @ (posedge clock)
		begin
		outputnext <= {outputnext[6:1], (outputnext[7] ^ outputnext[1])};
		end
	assign outnext = outputnext;
endmodule
