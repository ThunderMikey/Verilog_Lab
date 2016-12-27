module mult_pos_neg(clk, multiplicand, gain, result);
	input signed [9:0] multiplicand;
	input [6:0] gain;
	reg [16:0] interm_mult;
	reg [9:0] twos_multiplicand;
	input clk;
	output reg [9:0] result;
	
	always @ (posedge clk) begin
		if(multiplicand<0) begin 
			twos_multiplicand=(~multiplicand)+1;
			interm_mult=twos_multiplicand*gain;
			result=((~interm_mult[16:7])+1);
		end
		else begin
			interm_mult=multiplicand*gain;
			result=interm_mult[16:7];
		end
	end
	
endmodule
