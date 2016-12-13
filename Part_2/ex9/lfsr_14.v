//length=14 bits, generate maximum value 16,383
//primitve polynomial: 1 + X + X^6 + X^11 + X^14
module lfsr_14(clk, en, prbs);
	input clk, en;
	output reg [14:1] prbs;
	//250 is the initial value
	initial prbs=14'b11111010;

	always @(posedge clk) begin
		if(en==1'b1) begin
			prbs<={prbs[13:1], (prbs[1]^prbs[6]^prbs[11]^prbs[14])};
		end
	end
endmodule