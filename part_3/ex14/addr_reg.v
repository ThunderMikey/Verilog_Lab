module addr_reg(CLK, d_inp, q_outp);
	
	input CLK;
	input [9:0] d_inp;
	output [9:0] q_outp;
	
	reg [9:0] q_outp;
	
	always @ (posedge CLK)
		q_outp <= d_inp;
		
endmodule
