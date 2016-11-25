module ex7_top(KEY, HEX0, HEX1, HEX2);
	input [3:0] KEY;
	output [6:0] HEX0, HEX1, HEX2;
	
	wire [6:0] prbsout;
	wire [3:0] seg7_0, seg7_1, seg7_2;
	
	LFSR_7 lfsr(KEY[0], prbsout);
	bin2bcd8 binstage({1'b0,prbsout}, seg7_0, seg7_1, seg7_2);
	hex_to_7seg hexstage0 (HEX0, seg7_0);
	hex_to_7seg hexstage1 (HEX1, seg7_1);
	hex_to_7seg hexstage2 (HEX2, seg7_2);
	
	endmodule
	