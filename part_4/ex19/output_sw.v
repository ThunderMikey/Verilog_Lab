module output_sw(SW, HEX0, HEX1, HEX2);

	input [8:0] SW;
	output [6:0] HEX0, HEX1, HEX2;
	
	wire [19:0] result_out;
	wire [3:0] bcd_res0, bcd_res1, bcd_res2, bcd_res3, bcd_res4;
	
	mult_const multi(.dataa(SW), .result(result_out));
	
	bin2bcd delay_result(
	.B(result_out[19:10]), 
	.BCD0(bcd_res0),
	.BCD1(bcd_res1),
	.BCD2(bcd_res2),
	.BCD3(bcd_res3),
	.BCD4(bcd_res4));
	
	hex_to_7seg hexd0(.out(HEX0), .in(bcd_res0));
	hex_to_7seg hexd1(.out(HEX1), .in(bcd_res1));
	hex_to_7seg hexd2(.out(HEX2), .in(bcd_res2));
	
	
endmodule
