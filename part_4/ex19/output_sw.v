module output_sw(SW, bcd0, bcd1, bcd2);

	input [8:0] SW;
	output [3:0] bcd0, bcd1, bcd2;
	
	wire [19:0] result_out;
	wire [3:0] bcd_res;
	
	assign bcd_res = 4'b0;
	
	mult_const multi(.dataa(SW), .result(result_out));
	
	bin2bcd_16 delay_result(
	.B(result_out[19:10]), 
	.BCD_0(bcd0),
	.BCD_1(bcd1),
	.BCD_2(bcd2),
	.BCD_3(bcd_res),
	.BCD_4(bcd_res));
	
	
endmodule
